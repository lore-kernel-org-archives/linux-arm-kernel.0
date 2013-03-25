From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 25 Mar 2013 13:22:20 +0100
Subject: [PATCH] ARM: at91: add Acme Systems Aria G25 board
In-Reply-To: <1364201369-12047-1-git-send-email-nicolas.ferre@atmel.com>
References: <1364201369-12047-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20130325122220.GF2001@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:49 Mon 25 Mar     , Nicolas Ferre wrote:
> From: Douglas Gilbert <dgilbert@interlog.com>
> 
> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  arch/arm/boot/dts/ariag25.dts | 168 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 168 insertions(+)
>  create mode 100644 arch/arm/boot/dts/ariag25.dts
> 
> diff --git a/arch/arm/boot/dts/ariag25.dts b/arch/arm/boot/dts/ariag25.dts
> new file mode 100644
> index 0000000..d18ef50
> --- /dev/null
> +++ b/arch/arm/boot/dts/ariag25.dts
> @@ -0,0 +1,168 @@
> +/*
> + * ariag25.dts - Device Tree file for Acme Systems Aria G25 (AT91SAM9G25 based)
> + *
> + * Copyright (C) 2013 Douglas Gilbert <dgilbert@interlog.com>,
> + *                    Robert Nelson <robertcnelson@gmail.com>
> + *
> + * Licensed under GPLv2 or later.
> + */
> +/dts-v1/;
> +/include/ "at91sam9g25.dtsi"
> +
> +/ {
> +	model = "Acme Systems Aria G25";
> +	compatible = "acme,ariag25", "atmel,at91sam9g25ek", "atmel,at91sam9x5ek",
> +		     "atmel,at91sam9x5", "atmel,at91sam9";
I doube the code is compatible with the 9g25ek

specially when you do not include it
> +
> +	aliases {
> +		serial4 = &usart3;
> +		serial5 = &uart0;
> +	};
you need to specify all
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootwait";
> +	};
> +
> +	memory {
> +		/* 128 MB, change this for 256 MB revision */
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
> +				/* N.B. Aria has no SD card detect (CD), assumed present */
> +
> +				pinctrl-0 = <
> +					&pinctrl_mmc0_slot0_clk_cmd_dat0
> +					&pinctrl_mmc0_slot0_dat1_3>;
> +				status = "okay";
> +				slot at 0 {
> +					reg = <0>;
> +					bus-width = <4>;
> +				};
> +			};
> +
> +			i2c0: i2c at f8010000 {
> +				status = "okay";
> +			};
> +
> +			i2c1: i2c at f8014000 {
> +				status = "okay";
> +			};
> +
> +			/* TWD2+TCLK2 hidden behind ethernet, so no i2c2 */
> +
> +			usart0: serial at f801c000 {
> +				pinctrl-0 = <&pinctrl_usart0
> +					     &pinctrl_usart0_rts
> +					     &pinctrl_usart0_cts>;
> +				status = "okay";
> +			};
> +
> +			usart1: serial at f8020000 {
> +				pinctrl-0 = <&pinctrl_usart1
> +					     /* &pinctrl_usart1_rts */
> +					     /* &pinctrl_usart1_cts */
> +					    >;
> +				status = "okay";
> +			};
> +
> +			usart2: serial at f8024000 {
> +				/* cannot activate RTS2+CTS2, clash with
> +				 * ethernet on PB0 and PB1 */
> +				pinctrl-0 = <&pinctrl_usart2>;
> +				status = "okay";
> +			};
> +
> +			usart3: serial at f8028000 {
> +				compatible = "atmel,at91sam9260-usart";
> +				reg = <0xf8028000 0x200>;
> +				interrupts = <8 4 5>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_usart3
> +					     /* &pinctrl_usart3_rts */
> +					     /* &pinctrl_usart3_cts */
> +					    >;
> +				status = "okay";
> +			};
> +
> +			macb0: ethernet at f802c000 {
> +				phy-mode = "rmii";
> +				/* following can be overwritten by uboot 'ftd set' command */
> +				local-mac-address = [00 04 25 dd 10 01];
drop this, this is board specific
> +				status = "okay";
> +			};
> +
> +			uart0: serial at f8040000 {
> +				compatible = "atmel,at91sam9260-usart";
> +				reg = <0xf8040000 0x200>;
> +				interrupts = <15 4 5>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart0>;
> +				status = "okay";
> +			};
> +
> +			adc0: adc at f804c000 {
> +				status = "okay";
> +				atmel,adc-channels-used = <0xf>;
> +				atmel,adc-num-channels = <4>;
> +			};
> +
> +			dbgu: serial at fffff200 {
> +				status = "okay";
> +			};
> +
> +			pinctrl at fffff400 {
> +				w1_0 {
> +					pinctrl_w1_0: w1_0-0 {
> +						atmel,pins = <0 21 0x0 0x1>; /* PA21 PIO, pull-up */
> +					};
> +				};
> +			};
> +
> +			rtc at fffffeb0 {
> +				status = "okay";
> +			};
> +		};
> +
> +		usb0: ohci at 00600000 {
> +			status = "okay";
> +			num-ports = <3>;
> +		};
> +
> +		usb1: ehci at 00700000 {
> +			status = "okay";
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		/* little green LED in middle of Aria G25 module */
> +		aria_led {
> +			label = "aria_led";
> +			gpios = <&pioB 8 0>; /* PB8 */
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +	};
> +
> +	onewire at 0 {
> +		compatible = "w1-gpio";
> +		gpios = <&pioA 21 1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_w1_0>;
> +	};
> +};
> -- 
> 1.8.0
> 
