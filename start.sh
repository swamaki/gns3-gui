#!/usr/bin/env bash
GNS3="/Applications/GNS3.app"
PYTHON3=$(whereis python3)
REQUIREMENTS="requirements.txt"
VENV=".venv"
check_gns3() {
	if [ ! -d $GNS3 ]; then
		echo "ERROR: GNS3.app not installed!"
		exit 1
	fi
}
check_python() {
	if [ -z $PYTHON3 ]; then
		echo "ERROR: Python3 not found!"
		exit 1
	fi
}
check_requirements() {
	if [ ! -f  $REQUIREMENTS ]; then
		echo "ERROR: Requirements.txt not found!"
		exit 1
	fi
}
create_env() {
	echo ":: Creating virtual environment..."
	$PYTHON3 -m venv $VENV
	echo ":: done."
	echo ":: Activating virtual environment..."
}
activate_env() {
	source .venv/bin/activate
	echo ":: done."
	if [ ! -z $VIRTUAL_ENV ]; then
		echo ":: VirtualEnv is activated at $VIRTUAL_ENV"
	else
		echo ":: VirtualEnv not activated!"
		exit 1
	fi
}

install_requirements() {
	echo ":: Installing requirements..."
	python -m pip install -r $REQUIREMENTS
	echo ":: done."
}

start_gns() {
	python -m gns3
}

check_python
check_requirements

if [ ! -d $VENV ]; then
	create_env
	activate_env
	install_requirements
	start_gns
else
	activate_env
	start_gns
fi
exit 0


