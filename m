From: utx@penguin.cz (Stanislav Brabec)
Date: Tue, 13 Jul 2010 18:47:06 +0200
Subject: usb gadget on zaurus and kexec
In-Reply-To: <20100713112649.GA17065@atrey.karlin.mff.cuni.cz>
References: <20100519154618.GA26381@atrey.karlin.mff.cuni.cz>
	<AANLkTim49akRJK0BN_Qk1wL6e5mrdjZioDjGNWlrjUVQ@mail.gmail.com>
	<AANLkTilCvgvf9Ch55f878nTNTue8tHYmcrLEywsjnylY@mail.gmail.com>
	<201006100900.23981.marek.vasut@gmail.com> <87wru7xc4z.fsf@free.fr>
	<20100713112649.GA17065@atrey.karlin.mff.cuni.cz>
Message-ID: <1279039626.9908.50.camel@hammer.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cyril Hrubis wrote:

> Would be great. So far the GPIO for usb host/slave cable detection is not used
> on spitz so there is no way to switch to USB slave for gadgets to work if you
> don't want to play with devmem2.

Well, just the driver is missing, the hardware is there. See attached
usb-auto script using pxaregs utility.

There is another issue in the gadget mode (probably including the latest
kernels): If host mode is not active, it should turn USB power off. It
does not, and it causes soft short circuit in client mode. It also makes
impossible to differentiate between no cable and client cable.

Here are GPIOs to control OTG:
SPITZ_GPIO_USB_DEVICE	GPIO35	USB Client power is present
SPITZ_GPIO_USB_HOST	GPIO37	USB OTG 5V Host power supply control
SPITZ_GPIO_USB_CONNECT	GPIO41	USB Host Cable is connected

----------- usb-auto ----------
#!/bin/sh

if test -z "$CLIENT_MODULE" ; then
# Uncomment client module you want by default (only one at a time is possible in 2.6.26RP):
	CLIENT_MODULE=g_ether
	#CLIENT_MODULE=g_file_storage
fi

if test `pxaregs GPLR1_41 | sed -n 's/.*\(.\)  GPIO.*/\1/p'` = 0 ; then
	echo "Host cable is present."
	pxaregs GPSR1_37 1 # Turn on USB power
	rmmod g_file_storage g_ether pxa27x_udc 2>/dev/null
	sleep 1
	modprobe ohci-hcd 2>/dev/null
else
	pxaregs GPCR1_37 1 # Turn off USB power
	sleep 1 # Wait a bit to discharge capacitors
	if test `pxaregs GPLR1_35 | sed -n 's/.*\(.\)  GPIO.*/\1/p'` = 0 ; then
		echo "No cable in USB."
		ifdown usb0 2>/dev/null
		sleep 1
		rmmod g_file_storage g_ether pxa27x_udc 2>/dev/null
		sleep 1
		rmmod ohci-hcd 2>/dev/null
	else
		echo "Client cable is present."
		rmmod ohci-hcd 2>/dev/null
		sleep 1
		modprobe pxa27x_udc
		modprobe $CLIENT_MODULE
		ifup usb0 2>/dev/null
	fi
fi
-------------------------------

-- 
Stanislav Brabec
http://www.penguin.cz/~utx/zaurus
