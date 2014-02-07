From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 7 Feb 2014 09:30:07 +0100
Subject: [PATCH v3 03/15] at91: dt: sam9261: Basic Device Tree support
 for the at91sam9261ek
In-Reply-To: <1390492639-7299-4-git-send-email-jjhiblot@traphandler.com>
References: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
 <1390492639-7299-4-git-send-email-jjhiblot@traphandler.com>
Message-ID: <20140207083007.GW9558@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:57 Thu 23 Jan     , Jean-Jacques Hiblot wrote:
> This patch implements a simple DTS to boot a at91sam9261ek with a dt-enabled
> kernel (at91_dt_defconfig).
> Only dbgu, nand and watchdog are described in the DT.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>  arch/arm/boot/dts/Makefile          |   2 +
>  arch/arm/boot/dts/at91sam9261ek.dts | 112 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 114 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91sam9261ek.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 772a30e..ece523d 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -11,6 +11,8 @@ dtb-$(CONFIG_ARCH_AT91) += ethernut5.dtb
>  dtb-$(CONFIG_ARCH_AT91) += evk-pro3.dtb
>  dtb-$(CONFIG_ARCH_AT91) += tny_a9260.dtb
>  dtb-$(CONFIG_ARCH_AT91) += usb_a9260.dtb
> +# sam9261
> +dtb-$(CONFIG_ARCH_AT91) += at91sam9261ek.dtb
>  # sam9263
>  dtb-$(CONFIG_ARCH_AT91) += at91sam9263ek.dtb
>  dtb-$(CONFIG_ARCH_AT91) += tny_a9263.dtb
> diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
> new file mode 100644
> index 0000000..8909217
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91sam9261ek.dts
> @@ -0,0 +1,112 @@
> +/*
> + * at91sam9261ek.dts - Device Tree file for Atmel at91sam9261 reference board
> + *
> + *  Copyright (C) 2013 Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> + *
> + * Licensed under GPLv2 only.
> + */
> +/dts-v1/;
> +#include "at91sam9261.dtsi"
> +
> +/ {
> +	model = "Atmel at91sam9261ek";
> +	compatible = "atmel,at91sam9261ek", "atmel,at91sam9261", "atmel,at91sam9";
> +
> +	chosen {
> +		bootargs = "mem=64M console=ttyS0,115200";
drop the mem=64M

and use linux,stdout for the console
> +	};
> +
> +	memory {
> +		reg = <0x20000000 0x4000000>;
> +	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		main_clock: clock at 0 {
> +			compatible = "atmel,osc", "fixed-clock";
> +			clock-frequency = <18432000>;
> +		};
> +	};
> +
> +	ahb {
> +
> +		nand0: nand at 40000000 {
> +			nand-bus-width = <8>;
> +			nand-ecc-mode = "soft";
> +			nand-on-flash-bbt = <1>;
it's a boolean just
			nand-on-flash-bbt;
> +			status = "okay";
> +
> +			at91bootstrap at 0 {
> +				label = "at91bootstrap";
> +				reg = <0x0 0x40000>;
> +			};
> +
> +			bootloader at 40000 {
> +				label = "bootloader";
> +				reg = <0x40000 0x80000>;
> +			};
> +
> +			bootloaderenv at c0000 {
> +				label = "bootloader env";
> +				reg = <0xc0000 0xc0000>;
> +			};
> +
> +			dtb at 180000 {
> +				label = "device tree";
> +				reg = <0x180000 0x80000>;
> +			};
> +
> +			kernel at 200000 {
> +				label = "kernel";
> +				reg = <0x200000 0x600000>;
> +			};
> +
> +			rootfs at 800000 {
> +				label = "rootfs";
> +				reg = <0x800000 0x0f800000>;
> +			};

we really need to switch to UBI
> +		};
> +
> +		apb {
> +			dbgu: serial at fffff200 {
> +				status = "okay";
> +			};
> +
> +			pinctrl at fffff400 {
> +				leds {
> +					pinctrl_leds: leds-0 {
> +						atmel,pins = <AT91_PIOA 13  AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> +						AT91_PIOA 14  AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> +						AT91_PIOA 23  AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +					};
> +				};
> +			};

no need this drop it

you need to only describe the GPIO if you have specific pinctrl property such
as pull up & co
> +
> +			watchdog at fffffd40 {
> +				status = "okay";
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		ds8 {
> +			label = "ds8";
> +			gpios = <&pioA 13 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "none";
> +		};
> +		ds7 {
> +			label = "ds7";
> +			gpios = <&pioA 14 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "nand-disk";
> +		};
> +		ds1 {
> +			label = "ds1";
> +			gpios = <&pioA 23 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +};
> -- 
> 1.8.5.2
> 
