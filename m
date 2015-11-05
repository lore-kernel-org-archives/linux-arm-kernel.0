From: info@lategoodbye.de (Stefan Wahren)
Date: Thu, 5 Nov 2015 08:15:35 +0100
Subject: [RFCv2 2/2] rpi: add support to enable usb power domain
In-Reply-To: <1446590711-18928-3-git-send-email-alex.aring@gmail.com>
References: <1446590711-18928-1-git-send-email-alex.aring@gmail.com>
 <1446590711-18928-3-git-send-email-alex.aring@gmail.com>
Message-ID: <563B0217.4030307@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

i think this subject should better start with "ARM:".

Am 03.11.2015 um 23:45 schrieb Alexander Aring:
> This patch adds support for RPi several Power Domains and enable support
> to enable the USB Power Domain when it's not enabled before.
>
> This patch based on Eric Anholt's patch to support Power Domains. He had
> an issue about -EPROBE_DEFER inside the power domain subsystem, this
> issue was solved by commit <311fa6a> ("PM / Domains: Return -EPROBE_DEFER
> if we fail to init or turn-on domain").
>
>[...]
> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
> new file mode 100644
> index 0000000..c3abc24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
> @@ -0,0 +1,25 @@
> +Raspberry Pi power domain driver
> +
> +Required properties:
> +
> +- compatible:		Should be "raspberrypi,bcm2835-power".
> +- firmware:		Reference to the RPi firmware device node.
> +- #power-domain-cells:	Should be <1>, we providing multiple power domains.
> +
> +The valid defines for power domain are:
> +
> + RPI_POWER_DOMAIN_USB
> +
> +Example:
> +
> +power: power {
> +	compatible = "raspberrypi,bcm2835-power";
> +	firmware = <&firmware>;
> +	#power-domain-cells = <1>;
> +};
> +
> +Example for using power domain:
> +
> +&usb {
> +       power-domains = <&power RPI_POWER_DOMAIN_USB>;
> +};

Refering to Documentation/devicetree/bindings/submitting-patches.txt 
binding doc should be a separate patch.

> diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> index ab5474e..d9b16d1 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
> +++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> @@ -1,3 +1,4 @@
> +#include <dt-bindings/arm/raspberrypi-power.h>
>   #include "bcm2835.dtsi"
>
>   / {
> @@ -20,6 +21,12 @@
>   			compatible = "raspberrypi,bcm2835-firmware";
>   			mboxes = <&mailbox>;
>   		};
> +
> +		power: power {
> +			compatible = "raspberrypi,bcm2835-power";
> +			firmware = <&firmware>;
> +			#power-domain-cells = <1>;
> +		};
>   	};
>   };
>
> @@ -56,3 +63,7 @@
>   	status = "okay";
>   	bus-width = <4>;
>   };
> +
> +&usb {
> +	power-domains = <&power RPI_POWER_DOMAIN_USB>;
> +};
> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
> index 301c73f..3c899b3 100644
> --- a/arch/arm/boot/dts/bcm2835.dtsi
> +++ b/arch/arm/boot/dts/bcm2835.dtsi
> @@ -149,7 +149,7 @@
>   			status = "disabled";
>   		};
>
> -		usb at 7e980000 {
> +		usb: usb at 7e980000 {
>   			compatible = "brcm,bcm2835-usb";
>   			reg = <0x7e980000 0x10000>;
>   			interrupts = <1 9>;
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 1319c3c..244475e5 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -120,6 +120,16 @@ config ARCH_BCM2835
>   	  This enables support for the Broadcom BCM2835 SoC. This SoC is
>   	  used in the Raspberry Pi and Roku 2 devices.
>
> +config RASPBERRY_POWER

RASPBERRYPI_POWER?

> +	bool "Raspberry Pi power domain driver"
> +	depends on ARCH_BCM2835
> +	depends on RASPBERRYPI_FIRMWARE
> +	select PM_GENERIC_DOMAINS if PM

Since PM_GENERIC_DOMAINS_OF depends on PM_GENERIC_DOMAINS this line 
should be redundant.

> +	select PM_GENERIC_DOMAINS_OF if PM
> +	help
> +	  This enables support for the RPi power domains which can be enabled
> +	  or disabled via the RPi firmware.
> +
>   config ARCH_BCM_63XX
>   	bool "Broadcom BCM63xx DSL SoC" if ARCH_MULTI_V7
>   	depends on MMU
> diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
> index 1780a3f..283295e 100644
> --- a/arch/arm/mach-bcm/Makefile
> +++ b/arch/arm/mach-bcm/Makefile
> @@ -33,6 +33,7 @@ endif
>
>   # BCM2835
>   obj-$(CONFIG_ARCH_BCM2835)	+= board_bcm2835.o
> +obj-$(CONFIG_RASPBERRY_POWER)	+= raspberrypi-power.o
>
>   # BCM5301X
>   obj-$(CONFIG_ARCH_BCM_5301X)	+= bcm_5301x.o
> diff --git a/arch/arm/mach-bcm/raspberrypi-power.c b/arch/arm/mach-bcm/raspberrypi-power.c
> new file mode 100644
> index 0000000..531300f
> --- /dev/null
> +++ b/arch/arm/mach-bcm/raspberrypi-power.c
> @@ -0,0 +1,180 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Authors:
> + * (C) 2015 Pengutronix, Alexander Aring <aar@pengutronix.de>
> + * Eric Anholt <eric@anholt.net>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/pm_domain.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>

Please sort alphabetical.

> +#include <dt-bindings/arm/raspberrypi-power.h>
> +#include <soc/bcm2835/raspberrypi-firmware.h>
> +
> +#define RPI_POWER_DOMAIN(_domain, _name)			\
> +	[_domain] = {						\
> +		.domain = _domain,				\
> +		.enabled = true,				\
> +		.base = {					\
> +			.name = _name,				\
> +			.power_off = raspberrypi_domain_off,	\
> +			.power_on = raspberrypi_domain_on,	\
> +		},						\
> +	}
> +
> +struct raspberrypi_power_domain {
> +	u32 domain;
> +	bool enabled;
> +	struct generic_pm_domain base;
> +};
> +
> +struct rpi_power_domain_packet {
> +	u32 domain;
> +	u32 on;
> +} __packet;

It would be nice to use consequently rpi_ as prefix instead of 
raspberrypi_ .

>  [...]
> diff --git a/include/dt-bindings/arm/raspberrypi-power.h b/include/dt-bindings/arm/raspberrypi-power.h
> new file mode 100644
> index 0000000..51f0772
> --- /dev/null
> +++ b/include/dt-bindings/arm/raspberrypi-power.h
> @@ -0,0 +1,14 @@
> +/*
> + *  Copyright ? 2015 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _DT_BINDINGS_ARM_BCM2835_MBOX_POWER_H
> +#define _DT_BINDINGS_ARM_BCM2835_MBOX_POWER_H

This needs renaming.

Thanks
Stefan

> +
> +#define RPI_POWER_DOMAIN_USB	3
> +
> +#endif /* _DT_BINDINGS_ARM_BCM2835_MBOX_POWER_H */
>
