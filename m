From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 7 Feb 2014 09:01:42 +0100
Subject: [PATCH v2] ARM: at91: add Atmel's SAMA5D3 Xplained board
In-Reply-To: <1391589347-26019-1-git-send-email-nicolas.ferre@atmel.com>
References: <20140204203054.GA21958@ldesroches-Latitude-E6320>
 <1391589347-26019-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20140207080142.GR9558@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:35 Wed 05 Feb     , Nicolas Ferre wrote:
> Add DT file for new SAMA5D3 Xpained board.
> This board is based on Atmel's SAMA5D36 Cortex-A5 SoC.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  arch/arm/boot/dts/Makefile                  |   1 +
>  arch/arm/boot/dts/at91-sama5d3_xplained.dts | 233 ++++++++++++++++++++++++++++
>  2 files changed, 234 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-sama5d3_xplained.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b9d6a8b485e0..6d1e43d46187 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -38,6 +38,7 @@ dtb-$(CONFIG_ARCH_AT91) += at91sam9g35ek.dtb
>  dtb-$(CONFIG_ARCH_AT91) += at91sam9x25ek.dtb
>  dtb-$(CONFIG_ARCH_AT91) += at91sam9x35ek.dtb
>  # sama5d3
> +dtb-$(CONFIG_ARCH_AT91)	+= at91-sama5d3_xplained.dtb
>  dtb-$(CONFIG_ARCH_AT91)	+= sama5d31ek.dtb
>  dtb-$(CONFIG_ARCH_AT91)	+= sama5d33ek.dtb
>  dtb-$(CONFIG_ARCH_AT91)	+= sama5d34ek.dtb
> diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> new file mode 100644
> index 000000000000..fb1349ca60a4
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> @@ -0,0 +1,233 @@
> +/*
> + * at91-sama5d3_xplained.dts - Device Tree file for the SAMA5D3 Xplained board
> + *
> + *  Copyright (C) 2014 Atmel,
> + *		  2014 Nicolas Ferre <nicolas.ferre@atmel.com>
> + *
> + * Licensed under GPLv2 or later.
> + */
> +/dts-v1/;
> +#include "sama5d36.dtsi"
> +
> +/ {
> +	model = "SAMA5D3 Xplained";
> +	compatible = "atmel,sama5d3-xplained", "atmel,sama5d3", "atmel,sama5";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200";
can you describe it via linux,stdout
> +	};
> +
> +	memory {
> +		reg = <0x20000000 0x10000000>;
> +	};
> +
> +	ahb {
> +		apb {
> +			mmc0: mmc at f0000000 {
> +				pinc?trl-names = "default";
?? this is SoC should never been seen here
> +				pinctrl-0 = <&pinctrl_mmc0_clk_cmd_dat0 &pinctrl_mmc0_dat1_3 &pinctrl_mmc0_dat4_7 &pinctrl_mmc0_cd>;
> +				status = "okay";
> +				slot at 0 {
> +					reg = <0>;
> +					bus-width = <8>;
> +					cd-gpios = <&pioE 0 GPIO_ACTIVE_LOW>;
> +				};
> +			};
> +
> +			spi0: spi at f0004000 {
> +				cs-gpios = <&pioD 13 0>, <0>, <0>, <0>;
if you use only one CS no need to specified all

we need to add macro per SoC for the hw CS used as GPIO so it's more clear
> +				status = "okay";
> +			};
> +
> +			can0: can at f000c000 {
> +				status = "okay";
> +			};
> +
> +			i2c0: i2c at f0014000 {
> +				status = "okay";
> +			};
> +
> +			i2c1: i2c at f0018000 {
> +				status = "okay";
> +			};
> +
> +			macb0: ethernet at f0028000 {
> +				phy-mode = "rgmii";
> +				status = "okay";
> +			};
> +
> +			usart0: serial at f001c000 {
> +				status = "okay";
> +			};
> +
> +			usart1: serial at f0020000 {
> +				pinctrl-names = "default";
same as mmc
> +				pinctrl-0 = <&pinctrl_usart1 &pinctrl_usart1_rts_cts>;
> +				status = "okay";
> +			};
> +
> +			uart0: serial at f0024000 {
> +				status = "okay";
> +			};
> +
> +			mmc1: mmc at f8000000 {
> +				pinctrl-names = "default";
ditto
> +				pinctrl-0 = <&pinctrl_mmc1_clk_cmd_dat0 &pinctrl_mmc1_dat1_3 &pinctrl_mmc1_cd>;
> +				status = "okay";
> +				slot at 0 {
> +					reg = <0>;
> +					bus-width = <4>;
> +					cd-gpios = <&pioE 1 GPIO_ACTIVE_HIGH>;
> +				};
> +			};
> +
> +			spi1: spi at f8008000 {
> +				cs-gpios = <&pioC 25 0>, <0>, <0>, <&pioD 16 0>;
> +				status = "okay";
> +			};
> +
> +			adc0: adc at f8018000 {
> +				pinctrl-names = "default";
ditto
> +				pinctrl-0 = <
> +					&pinctrl_adc0_adtrg
> +					&pinctrl_adc0_ad0
> +					&pinctrl_adc0_ad1
> +					&pinctrl_adc0_ad2
> +					&pinctrl_adc0_ad3
> +					&pinctrl_adc0_ad4
> +					&pinctrl_adc0_ad5
> +					&pinctrl_adc0_ad6
> +					&pinctrl_adc0_ad7
> +					&pinctrl_adc0_ad8
> +					&pinctrl_adc0_ad9
> +					>;
> +				status = "okay";
> +			};
> +
> +			i2c2: i2c at f801c000 {
> +				dmas = <0>, <0>;	/* Do not use DMA for i2c2 */
why?
> +				status = "okay";
> +			};
> +
> +			macb1: ethernet at f802c000 {
> +				phy-mode = "rmii";
> +				status = "okay";
> +			};
> +
> +			dbgu: serial at ffffee00 {
> +				status = "okay";
> +			};
> +
> +			pinctrl at fffff200 {
> +				board {
> +					pinctrl_mmc0_cd: mmc0_cd {
> +						atmel,pins =
> +							<AT91_PIOE 0 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
> +					};
> +
> +					pinctrl_mmc1_cd: mmc1_cd {
> +						atmel,pins =
> +							<AT91_PIOE 1 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
> +					};
> +
> +					pinctrl_usba_vbus: usba_vbus {
> +						atmel,pins =
> +							<AT91_PIOE 9 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;	/* PE9, conflicts with A9 */
in this case we should have ifdef so we could choose what we want via make
file
> +					};
> +				};
> +			};
> +
> +			pmc: pmc at fffffc00 {
> +				main: mainck {
> +					clock-frequency = <12000000>;
> +				};
> +			};
> +		};
> +
> +		nand0: nand at 60000000 {
> +			nand-bus-width = <8>;
> +			nand-ecc-mode = "hw";
> +			atmel,has-pmecc;
> +			atmel,pmecc-cap = <4>;
> +			atmel,pmecc-sector-size = <512>;
> +			nand-on-flash-bbt;
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
more I read this partition more it's seems wrong those days

we really need to switch to UBI
> +		};
> +
> +		usb0: gadget at 00500000 {
> +			atmel,vbus-gpio = <&pioE 9 GPIO_ACTIVE_HIGH>;	/* PE9, conflicts with A9 */
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_usba_vbus>;
> +			status = "okay";
> +		};
> +
> +		usb1: ohci at 00600000 {
> +			num-ports = <3>;
> +			atmel,vbus-gpio = <0
> +					   &pioE 3 GPIO_ACTIVE_LOW
> +					   &pioE 4 GPIO_ACTIVE_LOW
> +					  >;
> +			status = "okay";
> +		};
> +
> +		usb2: ehci at 00700000 {
> +			status = "okay";
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +
> +		bp3 {
> +			label = "PB_USER";
> +			gpios = <&pioE 29 GPIO_ACTIVE_LOW>;
> +			linux,code = <0x104>;
> +			gpio-key,wakeup;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		d2 {
> +			label = "d2";
> +			gpios = <&pioE 23 GPIO_ACTIVE_LOW>;	/* PE23, conflicts with A23, CTS2 */
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		d3 {
> +			label = "d3";
> +			gpios = <&pioE 24 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +};
> -- 
> 1.8.2.2
> 
