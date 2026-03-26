extends Control

var agua_total = 0
var atividade_total = 0
var sono_total = 0
var pontos = 0


func _on_btn_agua_pressed():
	agua_total += 250
	adicionar_pontos(10)
	$VBoxContaineragua/AguaPanel/LabelAgua.text = "Água: " + str(agua_total) + " ml"
	salvar_dados()

func _on_btn_atividade_pressed():
	atividade_total += 10
	adicionar_pontos(10)
	$VBoxContaineratividade/AtividadePanel/LabelAtividade.text= "Atividade: " + str(atividade_total) + " min"
	salvar_dados()
	
func _on_btn_sono_pressed():
	sono_total += 1
	adicionar_pontos(10)
	$VBoxContainersono/SonoPanel/LabelSono.text = "Sono: " + str(sono_total) + "h"
	salvar_dados()

func adicionar_pontos(valor):
	pontos += valor
	$VBoxContainerpontos/PontosPanel/LabelPontos.text = "Pontos: " + str(pontos)
	salvar_dados()
	
func salvar_dados():
	var file = FileAccess.open("user://save.dat", FileAccess.WRITE)
	
	var dados = {
		"agua": agua_total,
		"atividade": atividade_total,
		"sono": sono_total,
		"pontos": pontos
	}
	
	file.store_var(dados)

func atualizar_ui():
	$VBoxContaineragua/AguaPanel/LabelAgua.text = "Água: " + str(agua_total) + " ml"
	$VBoxContaineratividade/AtividadePanel/LabelAtividade.text = "Atividade: " + str(atividade_total) + " min"
	$VBoxContainersono/SonoPanel/LabelSono.text = "Sono: " + str(sono_total) + "h"
	$VBoxContainerpontos/PontosPanel/LabelPontos.text = "Pontos: " + str(pontos)
	
func carregar_dados():
	if FileAccess.file_exists("user://save.dat"):
		var file = FileAccess.open("user://save.dat", FileAccess.READ)
		var dados = file.get_var()
		
		agua_total = dados["agua"]
		atividade_total = dados["atividade"]
		sono_total = dados["sono"]
		pontos = dados["pontos"]
		
		atualizar_ui()
		gerar_dica()
		
func _ready():
	carregar_dados()
	
func gerar_dica():
	var dica = ""
	
	if agua_total < 1000:
		dica = "Você precisa beber mais água hoje 💧"
	elif atividade_total < 20:
		dica = "Que tal se movimentar um pouco? 🏃"
	elif sono_total < 6:
		dica = "Tente descansar mais 😴"
	else:
		dica = "Você está indo muito bem! Continue assim 🔥"
		$ContainerPrincipal/LabelDica.text = dica
	
	
