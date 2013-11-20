From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 20 Nov 2013 19:50:42 +0100
Subject: [RFC PATCH v2] ARM: at91: add support for Cosino board series by
 HCE Engineering
In-Reply-To: <20131120181841.GQ4578@enneenne.com>
References: <1383754767-5398-1-git-send-email-giometti@linux.it>
 <1384364070-32306-1-git-send-email-nicolas.ferre@atmel.com>
 <20131114162810.GJ28304@ns203013.ovh.net>
 <20131114185002.GM10964@enneenne.com>
 <20131115135256.GP28304@ns203013.ovh.net>
 <20131120181841.GQ4578@enneenne.com>
Message-ID: <20131120185042.GL14627@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19:18 Wed 20 Nov     , Rodolfo Giometti wrote:
> On Fri, Nov 15, 2013 at 02:52:56PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > > +#include "at91sam9g35.dtsi"
> > > > > +
> > > > > +/ {
> > > > > +	model = "HCE Cosino core module";
> > > > > +	compatible = "hce,cosino", "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
> > > > is this really sam9xek compatible?
> > > 
> > > Well, the board is derived from ATMEL dev board... maybe I can remove
> > > these lines... :-/
> > 
> > compatible means you board is an extension and that the kernel + dtb will run
> > on both without modification

this time look ok a small issue the file in the comment is missing the at91-

otherwise

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
> 
> Ok, at91sam9x5ek dropped.
> 
> > > +
> > > +			mmc1: mmc at f000c000 {
> > > +				pinctrl-0 = <
> > > +					&pinctrl_board_mmc0
> > this will failled you can not have the same pux on 2 device
> 
> Fixed.
> 
> Attached a new patch version (V3).
> 
> ### Changelog
> 
> V2 -> V3
> 
> [Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>]
> * Reference to at91sam9x5ek dropped.
> * Inavlid mmc1 pinctrl-0 setting fixed
> 
> V1 -> V2
> 
> [Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>]
> * prefix "at91-" added
> * atmel,mux-mask stuff removed
> * "compatible" stuff is now on the same line for easy-grep(TM)
> * lcd binding dropped
> 
> Ciao,
> 
> Rodolfo
> 
> -- 
> 
> GNU/Linux Solutions                  e-mail: giometti at enneenne.com
> Linux Device Driver                          giometti at linux.it
> Embedded Systems                     phone:  +39 349 2432127
> UNIX programming                     skype:  rodolfo.giometti
> Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it

> From 16882a9f85faa21bcd7102894b7829eb4d77f97d Mon Sep 17 00:00:00 2001
> From: Rodolfo Giometti <giometti@linux.it>
> Date: Wed, 6 Nov 2013 16:31:50 +0100
> Subject: [PATCH] arm mach-at91: add support for Cosino board series by HCE
>  Engineering
> 
> This patch adds the Cosino at91sam9g35 based CPU module and the
> Cosino Mega 2560 extension board.
> 
> Web site: http://www.cosino.it
> 
> Signed-off-by: Rodolfo Giometti <giometti@linux.it>
> [nicolas.ferre at atmel.com: adapted to newer kernel, modified commit message]
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  arch/arm/boot/dts/Makefile                 |   1 +
>  arch/arm/boot/dts/at91-cosino.dtsi         | 121 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/at91-cosino_mega2560.dts |  84 ++++++++++++++++++++
>  3 files changed, 206 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-cosino.dtsi
>  create mode 100644 arch/arm/boot/dts/at91-cosino_mega2560.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ab6a9f5..b05f5e6 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -35,6 +35,7 @@ dtb-$(CONFIG_ARCH_AT91) += at91sam9g25ek.dtb
>  dtb-$(CONFIG_ARCH_AT91) += at91sam9g35ek.dtb
>  dtb-$(CONFIG_ARCH_AT91) += at91sam9x25ek.dtb
>  dtb-$(CONFIG_ARCH_AT91) += at91sam9x35ek.dtb
> +dtb-$(CONFIG_ARCH_AT91) += at91-cosino_mega2560.dtb
>  # sama5d3
>  dtb-$(CONFIG_ARCH_AT91)	+= sama5d31ek.dtb
>  dtb-$(CONFIG_ARCH_AT91)	+= sama5d33ek.dtb
> diff --git a/arch/arm/boot/dts/at91-cosino.dtsi b/arch/arm/boot/dts/at91-cosino.dtsi
> new file mode 100644
> index 0000000..00e2112
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-cosino.dtsi
> @@ -0,0 +1,121 @@
> +/*
> + * cosino.dtsi - Device Tree file for Cosino core module
> + *
> + * Copyright (C) 2013 - Rodolfo Giometti <giometti@linux.it>
> + *			HCE Engineering
> + *
> + * Derived from at91sam9x5ek.dtsi by:
> + *	Copyright (C) 2012 Atmel,
> + *	2012 Nicolas Ferre <nicolas.ferre@atmel.com>
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +#include "at91sam9g35.dtsi"
> +
> +/ {
> +	model = "HCE Cosino core module";
> +	compatible = "hce,cosino", "atmel,at91sam9x5", "atmel,at91sam9";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait";
> +	};
> +
> +	memory {
> +		reg = <0x20000000 0x8000000>;
> +	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		main_clock: clock at 0 {
> +			compatible = "atmel,osc", "fixed-clock";
> +			clock-frequency = <12000000>;
> +		};
> +	};
> +
> +	ahb {
> +		apb {
> +			mmc0: mmc at f0008000 {
> +				pinctrl-0 = <
> +					&pinctrl_board_mmc0
> +					&pinctrl_mmc0_slot0_clk_cmd_dat0
> +					&pinctrl_mmc0_slot0_dat1_3>;
> +				status = "okay";
> +				slot at 0 {
> +					reg = <0>;
> +					bus-width = <4>;
> +					cd-gpios = <&pioD 15 GPIO_ACTIVE_HIGH>;
> +				};
> +			};
> +
> +			dbgu: serial at fffff200 {
> +				status = "okay";
> +			};
> +
> +			usart0: serial at f801c000 {
> +				status = "okay";
> +			};
> +
> +			i2c0: i2c at f8010000 {
> +				status = "okay";
> +			};
> +
> +			adc0: adc at f804c000 {
> +				atmel,adc-clock-rate = <1000000>;
> +				atmel,adc-ts-wires = <4>;
> +				atmel,adc-ts-pressure-threshold = <10000>;
> +				status = "okay";
> +			};
> +
> +			pinctrl at fffff400 {
> +				mmc0 {
> +					pinctrl_board_mmc0: mmc0-board {
> +						atmel,pins =
> +							<AT91_PIOD 15 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;	/* PD15 gpio CD pin pull up and deglitch */
> +					};
> +				};
> +			};
> +
> +			watchdog at fffffe40 {
> +				status = "okay";
> +			};
> +		};
> +
> +		nand0: nand at 40000000 {
> +			nand-bus-width = <8>;
> +			nand-ecc-mode = "hw";
> +			atmel,has-pmecc;	/* Enable PMECC */
> +			atmel,pmecc-cap = <4>;
> +			atmel,pmecc-sector-size = <512>;
> +			status = "okay";
> +
> +			at91bootstrap at 0 {
> +				label = "at91bootstrap";
> +				reg = <0x0 0x40000>;
> +			};
> +
> +			uboot at 40000 {
> +				label = "u-boot";
> +				reg = <0x40000 0x80000>;
> +			};
> +
> +			ubootenv at c0000 {
> +				label = "U-Boot Env";
> +				reg = <0xc0000 0x140000>;
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
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/at91-cosino_mega2560.dts b/arch/arm/boot/dts/at91-cosino_mega2560.dts
> new file mode 100644
> index 0000000..c29c53c
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-cosino_mega2560.dts
> @@ -0,0 +1,84 @@
> +/*
> + * cosino_mega2560.dts - Device Tree file for Cosino board with Mega 2560
> + *			 extension
> + *
> + * Copyright (C) 2013 - Rodolfo Giometti <giometti@linux.it>
> + *			HCE Engineering
> + *
> + * Derived from at91sam9g35ek.dts by:
> + * 	Copyright (C) 2012 Atmel,
> + *      2012 Nicolas Ferre <nicolas.ferre@atmel.com>
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +/dts-v1/;
> +#include "at91-cosino.dtsi"
> +
> +/ {
> +	model = "HCE Cosino Mega 2560";
> +	compatible = "hce,cosino_mega2560", "atmel,at91sam9x5", "atmel,at91sam9";
> +
> +	ahb {
> +		apb {
> +			macb0: ethernet at f802c000 {
> +				phy-mode = "rmii";
> +				status = "okay";
> +			};
> +
> +			adc0: adc at f804c000 {
> +				atmel,adc-clock-rate = <1000000>;
> +				atmel,adc-ts-wires = <4>;
> +				atmel,adc-ts-pressure-threshold = <10000>;
> +				status = "okay";
> +			};
> +
> +
> +			tsadcc: tsadcc at f804c000 {
> +				status = "okay";
> +			};
> +
> +			rtc at fffffeb0 {
> +				status = "okay";
> +			};
> +
> +			usart1: serial at f8020000 {
> +				status = "okay";
> +			};
> +
> +			usart2: serial at f8024000 {
> +				status = "okay";
> +			};
> +
> +			usb2: gadget at f803c000 {
> +				atmel,vbus-gpio = <&pioB 16 GPIO_ACTIVE_HIGH>;
> +				status = "okay";
> +			};
> +
> +			mmc1: mmc at f000c000 {
> +				pinctrl-0 = <
> +					&pinctrl_mmc1_slot0_clk_cmd_dat0
> +					&pinctrl_mmc1_slot0_dat1_3>;
> +				status = "okay";
> +				slot at 0 {
> +					reg = <0>;
> +					bus-width = <4>;
> +					non-removable;
> +				};
> +			};
> +		};
> +
> +		usb0: ohci at 00600000 {
> +			status = "okay";
> +			num-ports = <3>;
> +			atmel,vbus-gpio = <0 /* &pioD 18 GPIO_ACTIVE_LOW */
> +					   &pioD 19 GPIO_ACTIVE_LOW
> +					   &pioD 20 GPIO_ACTIVE_LOW
> +					  >;
> +		};
> +
> +		usb1: ehci at 00700000 {
> +			status = "okay";
> +		};
> +	};
> +};
> -- 
> 1.8.1.2
> 

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
