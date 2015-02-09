From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 9 Feb 2015 19:10:39 +0100
Subject: [PATCH v2] ARM: at91: dts: sama5d4: add dts for sama5d4 xplained
 board
In-Reply-To: <1423473423-17798-1-git-send-email-josh.wu@atmel.com>
References: <1423473423-17798-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20150209181039.GQ3715@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

On 09/02/2015 at 17:17:03 +0800, Josh Wu wrote :
> Add at91 sama5d4 xplained board support.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
> 
> Changes in v2:
> - to be sorted by memory address, put the adc dt node after usart4.
> 
>  arch/arm/boot/dts/Makefile                  |   1 +
>  arch/arm/boot/dts/at91-sama5d4_xplained.dts | 232 ++++++++++++++++++++++++++++
>  2 files changed, 233 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-sama5d4_xplained.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 91bd5bd..bbfbad6 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -49,6 +49,7 @@ dtb-$(CONFIG_ARCH_AT91)	+= sama5d34ek.dtb
>  dtb-$(CONFIG_ARCH_AT91)	+= sama5d35ek.dtb
>  dtb-$(CONFIG_ARCH_AT91)	+= sama5d36ek.dtb
>  # sama5d4
> +dtb-$(CONFIG_ARCH_AT91)	+= at91-sama5d4_xplained.dtb

That is changed in v3.20, have a look at:
http://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/tree/arch/arm/boot/dts/Makefile?h=for-next


>  dtb-$(CONFIG_ARCH_AT91)	+= at91-sama5d4ek.dtb
>  
>  dtb-$(CONFIG_ARCH_ATLAS6) += atlas6-evb.dtb
> diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> new file mode 100644
> index 0000000..a04c3c8
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> @@ -0,0 +1,232 @@
> +/*
> + * at91-sama5d4_xplained.dts - Device Tree file for SAMA5D4 Xplained board
> + *
> + *  Copyright (C) 2015 Atmel,
> + *                2015 Josh Wu <josh.wu@atmel.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +/dts-v1/;
> +#include "sama5d4.dtsi"
> +
> +/ {
> +	model = "Atmel SAMA5D4 Xplained";
> +	compatible = "atmel,sama5d4-xplained", "atmel,sama5d4", "atmel,sama5";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 ignore_loglevel earlyprintk";
> +	};
> +
> +	memory {
> +		reg = <0x20000000 0x20000000>;
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
> +
> +		slow_xtal {
> +			clock-frequency = <32768>;
> +		};
> +
> +		main_xtal {
> +			clock-frequency = <12000000>;
> +		};
> +	};
> +
> +	ahb {
> +		apb {
> +			spi0: spi at f8010000 {
> +				cs-gpios = <&pioC 3 0>, <0>, <0>, <0>;
> +				status = "okay";
> +				m25p80 at 0 {
> +					compatible = "atmel,at25df321a";
> +					spi-max-frequency = <50000000>;
> +					reg = <0>;
> +				};
> +			};
> +
> +			macb0: ethernet at f8020000 {
> +				phy-mode = "rmii";
> +				status = "okay";
> +			};
> +
> +			mmc1: mmc at fc000000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_mmc1_clk_cmd_dat0 &pinctrl_mmc1_dat1_3 &pinctrl_mmc1_cd>;
> +				status = "okay";
> +				slot at 0 {
> +					reg = <0>;
> +					bus-width = <4>;
> +					cd-gpios = <&pioE 3 0>;
> +				};
> +			};
> +
> +			usart3: serial at fc00c000 {
> +				status = "okay";
> +			};
> +
> +			usart4: serial at fc010000 {
> +				status = "okay";
> +			};
> +
> +			adc0: adc at fc034000 {
> +				atmel,adc-vref = <3300>;
> +				status = "okay";
> +			};
> +
> +			watchdog at fc068640 {
> +				status = "okay";
> +			};
> +
> +			pinctrl at fc06a000 {
> +				board {
> +					pinctrl_mmc1_cd: mmc1_cd {
> +						atmel,pins =
> +							<AT91_PIOE 3 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
> +					};
> +					pinctrl_usba_vbus: usba_vbus {
> +						atmel,pins =
> +							<AT91_PIOE 31 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;
> +					};
> +					pinctrl_key_gpio: key_gpio_0 {
> +						atmel,pins =
> +							<AT91_PIOE 8 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>; /* PE13 gpio */
> +					};
> +				};
> +			};
> +		};
> +
> +		usb0: gadget at 00400000 {
> +			atmel,vbus-gpio = <&pioE 31 GPIO_ACTIVE_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_usba_vbus>;
> +			status = "okay";
> +		};
> +
> +		usb1: ohci at 00500000 {
> +			num-ports = <3>;
> +			atmel,vbus-gpio = <0
> +					   &pioE 11 GPIO_ACTIVE_HIGH
> +					   &pioE 14 GPIO_ACTIVE_HIGH
> +					  >;
> +			status = "okay";
> +		};
> +
> +		usb2: ehci at 00600000 {
> +			status = "okay";
> +		};
> +
> +		nand0: nand at 80000000 {
> +			nand-bus-width = <8>;
> +			nand-ecc-mode = "hw";
> +			nand-on-flash-bbt;
> +			atmel,has-pmecc;
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
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_key_gpio>;
> +
> +		pb_user1 {
> +			label = "pb_user1";
> +			gpios = <&pioE 8 GPIO_ACTIVE_HIGH>;
> +			linux,code = <0x100>;
> +			gpio-key,wakeup;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		status = "okay";
> +
> +		d8 {
> +			label = "d8";
> +			gpios = <&pioE 15 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		d10 {
> +			label = "d10";
> +			gpios = <&pioD 30 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +};
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
