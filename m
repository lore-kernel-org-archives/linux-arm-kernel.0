From: sven.eckelmann@openmesh.com (Sven Eckelmann)
Date: Mon, 16 Apr 2018 13:50:26 +0200
Subject: [PATCH v4] pinctrl: msm: fix gpio-hog related boot issues
In-Reply-To: <20180412190138.12372-1-chunkeey@gmail.com>
References: <20180412190138.12372-1-chunkeey@gmail.com>
Message-ID: <1662515.4UeQ9r5Xdv@bentobox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Donnerstag, 12. April 2018 21:01:38 CEST Christian Lamparter wrote:
> Sven Eckelmann reported an issue with the current IPQ4019 pinctrl.
> Setting up any gpio-hog in the device-tree for his device would
> "kill the bootup completely":
> 
> | [    0.477838] msm_serial 78af000.serial: could not find pctldev for node /soc/pinctrl at 1000000/serial_pinmux, deferring probe
> | [    0.499828] spi_qup 78b5000.spi: could not find pctldev for node /soc/pinctrl at 1000000/spi_0_pinmux, deferring probe
> | [    1.298883] requesting hog GPIO enable USB2 power (chip 1000000.pinctrl, offset 58) failed, -517
> | [    1.299609] gpiochip_add_data: GPIOs 0..99 (1000000.pinctrl) failed to register
> | [    1.308589] ipq4019-pinctrl 1000000.pinctrl: Failed register gpiochip
> | [    1.316586] msm_serial 78af000.serial: could not find pctldev for node /soc/pinctrl at 1000000/serial_pinmux, deferring probe
> | [    1.322415] spi_qup 78b5000.spi: could not find pctldev for node /soc/pinctrl at 1000000/spi_0_pinmux, deferri
> 
> This was also verified on a RT-AC58U (IPQ4018) which would
> no longer boot, if a gpio-hog was specified. (Tried forcing
> the USB LED PIN (GPIO0) to high.).
[...]

Sorry that I was so silent while you did all the work. I have applied your 
patch and now I see a 

   [    0.020619] GPIO line 58 (enable USB2 power) hogged as output/low

when adding following node directly to the pinctrl

	enable-usb-power {
		gpio-hog;
		gpios = <58 GPIO_ACTIVE_HIGH>;
		output-low;
		line-name = "enable USB2 power";
	};

(this looks at the first glance like it is deactivating USB by setting it to 
low but GPIO_ACTIVE_LOW would switch the meaning of output-low for gpio-hogs 
and the GPIO must really set to signal level low to enable USB)

Tested-by: Sven Eckelmann <sven.eckelmann@openmesh.com>

Thanks,
	Sven
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180416/f564870f/attachment.sig>
