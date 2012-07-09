From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 9 Jul 2012 20:54:56 +0200
Subject: [PATCH] ARM: at91: Add support for board aks-cdu
In-Reply-To: <1341821118-8177-1-git-send-email-jiri.prchal@aksignal.cz>
References: <1341821118-8177-1-git-send-email-jiri.prchal@aksignal.cz>
Message-ID: <4FFB2900.6070404@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2012 10:05 AM, Jiri Prchal :
> Add support for our "aks-cdu" board based up on Telit's module GE863 Pro3.
> It has more uarts, leds, another nand partitioning.
> 
> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> ---
>  arch/arm/boot/dts/aks-cdu.dts    |  111 ++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-at91/Makefile.boot |    1 +
>  2 files changed, 112 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/aks-cdu.dts
> 
> diff --git a/arch/arm/boot/dts/aks-cdu.dts b/arch/arm/boot/dts/aks-cdu.dts
> new file mode 100644
> index 0000000..05590cc
> --- /dev/null
> +++ b/arch/arm/boot/dts/aks-cdu.dts
> @@ -0,0 +1,111 @@
> +/*
> + * aks-cdu.dts - Device Tree file for AK signal CDU
> + *
> + * Copyright (C) 2012 AK signal Brno a.s.
> + *               2012 Jiri Prchal <jiri.prchal@aksignal.cz>
> + *
> + * Licensed under GPLv2 or later.
> + */
> + 

This:

/dts-v1/;

is missing: I cannot compile the .dts


> +/include/ "ge863-pro3.dtsi"
> +
> +/ {
> +	chosen {
> +		bootargs = "console=ttyS0,115200 ubi.mtd=4 root=ubi0:rootfs rootfstype=ubifs";
> +	};
> +
> +	ahb {
> +		apb {
> +			usart0: serial at fffb0000 {
> +				status = "okay";
> +			};
> +
> +			usart1: serial at fffb4000 {
> +				status = "okay";
> +				linux,rs485-enabled-at-boot-time;
> +				rs485-rts-delay = <0 0>;
> +				};
> +
> +			usart2: serial at fffb8000 {
> +				status = "okay";
> +				linux,rs485-enabled-at-boot-time;
> +				rs485-rts-delay = <0 0>;
> +			};
> +
> +			usart3: serial at fffd0000 {
> +				status = "okay";
> +				linux,rs485-enabled-at-boot-time;
> +				rs485-rts-delay = <0 0>;
> +			};
> +
> +			macb0: ethernet at fffbc000 {

This is wrong: it can compile better with that:

                       macb0: ethernet at fffc4000 {

if you board is based on an at91sam9260, it is the proper address of the
EMAC.

> +				phy-mode = "rmii";
> +				status = "okay";
> +			};
> +
> +			usb1: gadget at fffa4000 {
> +				atmel,vbus-gpio = <&pioC 15 0>;
> +				status = "okay";
> +			};
> +		};
> +
> +		usb0: ohci at 00500000 {
> +			num-ports = <2>;
> +			status = "okay";
> +		};
> +
> +		nand0: nand at 40000000 {
> +			nand-bus-width = <8>;
> +			nand-ecc-mode = "soft";
> +			nand-on-flash-bbt;
> +			status = "okay";
> +
> +			bootstrap at 0 {
> +				label = "bootstrap";
> +				reg = <0x0 0x40000>;
> +			};
> +
> +			uboot at 40000 {
> +				label = "uboot";
> +				reg = <0x40000 0x80000>;
> +			};
> +			ubootenv at c0000 {
> +				label = "ubootenv";
> +				reg = <0xc0000 0x40000>;
> +			};
> +			kernel at 100000 {
> +				label = "kernel";
> +				reg = <0x100000 0x400000>;
> +			};
> +			rootfs at 500000 {
> +				label = "rootfs";
> +				reg = <0x500000 0x7b00000>;
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		red {
> +			gpios = <&pioC 10 0>;
> +			linux,default-trigger = "none";
> +		};
> +
> +		green {
> +			gpios = <&pioA 5 1>;
> +			linux,default-trigger = "none";
> +			default-state = "on";
> +		};
> +
> +		yellow {
> +			gpios = <&pioB 20 1>;
> +			linux,default-trigger = "none";
> +		};
> +
> +		blue {
> +			gpios = <&pioB 21 1>;
> +			linux,default-trigger = "none";
> +		};
> +	};
> +};
> diff --git a/arch/arm/mach-at91/Makefile.boot b/arch/arm/mach-at91/Makefile.boot
> index 11c3ca7..30bb733 100644
> --- a/arch/arm/mach-at91/Makefile.boot
> +++ b/arch/arm/mach-at91/Makefile.boot
> @@ -15,6 +15,7 @@ endif
>  
>  # Keep dtb files sorted alphabetically for each SoC
>  # sam9260
> +dtb-$(CONFIG_MACH_AT91SAM_DT) += aks-cdu.dtb
>  dtb-$(CONFIG_MACH_AT91SAM_DT) += ethernut5.dtb
>  dtb-$(CONFIG_MACH_AT91SAM_DT) += evk-pro3.dtb
>  dtb-$(CONFIG_MACH_AT91SAM_DT) += tny_a9260.dtb


Please use

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- aks-cdu.dtb
or
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- dtbs

So that you can check that your device tree file is correct.

Anyway, I have added the corrections and pushed this patch in the AT91
at91-3.6-dt branch.

Thanks, best regards,
-- 
Nicolas Ferre
