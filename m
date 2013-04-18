From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Apr 2013 18:34:41 +0200
Subject: [PATCH 5/5] ARM: at91: add Acme Systems Fox G20 board
In-Reply-To: <a647ac59d50fdee9a0e9e87f362febe1ad2b1264.1366289869.git.nicolas.ferre@atmel.com>
References: <cover.1366289869.git.nicolas.ferre@atmel.com>
 <a647ac59d50fdee9a0e9e87f362febe1ad2b1264.1366289869.git.nicolas.ferre@atmel.com>
Message-ID: <517020A1.3070504@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2013 03:01 PM, Nicolas Ferre :
> From: Douglas Gilbert <dgilbert@interlog.com>
> 
> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  arch/arm/boot/dts/Makefile        |   1 +
>  arch/arm/boot/dts/at91-foxg20.dts | 166 ++++++++++++++++++++++++++++++++++++++

FYI: I have to review this one: error while compiling.

>  2 files changed, 167 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-foxg20.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b07f162..914fe65 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -16,6 +16,7 @@ dtb-$(CONFIG_ARCH_AT91) += at91sam9263ek.dtb
>  dtb-$(CONFIG_ARCH_AT91) += tny_a9263.dtb
>  dtb-$(CONFIG_ARCH_AT91) += usb_a9263.dtb
>  # sam9g20
> +dtb-$(CONFIG_ARCH_AT91) += at91-foxg20.dtb
>  dtb-$(CONFIG_ARCH_AT91) += at91sam9g20ek.dtb
>  dtb-$(CONFIG_ARCH_AT91) += at91sam9g20ek_2mmc.dtb
>  dtb-$(CONFIG_ARCH_AT91) += kizbox.dtb
> diff --git a/arch/arm/boot/dts/at91-foxg20.dts b/arch/arm/boot/dts/at91-foxg20.dts
> new file mode 100644
> index 0000000..7d24ef7
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-foxg20.dts
> @@ -0,0 +1,166 @@
> +/*
> + * at91-foxg20.dts - Device Tree file for Acme Systems FoxG20 board
> + *
> + * Based on DT files for at91sam9g20ek evaluation board (AT91SAM9G20 SoC)
> + *
> + * Copyright (C) 2013 Douglas Gilbert <dgilbert@interlog.com>
> + *
> + * Licensed under GPLv2 or later.
> + */
> +/dts-v1/;
> +/include/ "at91sam9g20.dtsi"
> +
> +/ {
> +	model = "Acme Systems FoxG20";
> +	compatible = "acme,foxg20", "atmel,at91sam9g20", "atmel,at91sam9";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootwait";
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
> +		apb {
> +			usb1: gadget at fffa4000 {
> +				atmel,vbus-gpio = <&pioC 6 0>;
> +				status = "okay";
> +			};
> +
> +			mmc0: mmc at fffa8000 {
> +				pinctrl-0 = <
> +					&pinctrl_mmc0_clk
> +					&pinctrl_mmc0_slot1_cmd_dat0
> +					&pinctrl_mmc0_slot1_dat1_3>;
> +				status = "okay";
> +				slot at 1 {
> +					reg = <1>;
> +					bus-width = <4>;
> +				};
> +			};
> +
> +			usart0: serial at fffb0000 {
> +				pinctrl-0 =
> +					<&pinctrl_usart0
> +					 &pinctrl_usart0_rts
> +					 &pinctrl_usart0_cts
> +					>;
> +				status = "okay";
> +			};
> +
> +			usart1: serial at fffb4000 {
> +				status = "okay";
> +			};
> +
> +			usart2: serial at fffb8000 {
> +				status = "okay";
> +			};
> +
> +			macb0: ethernet at fffc4000 {
> +				phy-mode = "rmii";
> +				status = "okay";
> +			};
> +
> +			spi0: spi at fffc8000 {
> +				cs-gpios = <0>, <&pioC 11 0>, <0>, <0>;
> +				mtd_dataflash at 0 {
> +					compatible = "atmel,at45", "atmel,dataflash";
> +					spi-max-frequency = <50000000>;
> +					reg = <1>;
> +				};
> +				status = "disabled";
> +			};
> +
> +			usart3: serial at fffd0000 {
> +				status = "okay";
> +			};
> +
> +			uart0: serial at fffd4000 {
> +				status = "okay";
> +			};
> +
> +			uart1: serial at fffd8000 {
> +				status = "okay";
> +			};
> +
> +			dbgu: serial at fffff200 {
> +				status = "okay";
> +			};
> +
> +			pinctrl at fffff400 {
> +				board {
> +					pinctrl_pck0_as_mck: pck0_as_mck {
> +						atmel,pins =
> +							<2 1 0x2 0x0>;	/* PC1 periph B */
> +					};
> +				};
> +
> +				mmc0_slot1 {
> +					pinctrl_board_mmc0_slot1: mmc0_slot1-board {
> +						atmel,pins =
> +							<2 9 0x0 0x5>;	/* PC9 gpio CD pin pull up and deglitch */
> +					};
> +				};
> +
> +				i2c0 {
> +					pinctrl_i2c0: i2c0-0 {
> +						atmel,pins =
> +							<0 23 0x1 0x2	/* TWD (SDA) PA23 periph A, open drain */
> +							 0 24 0x1 0x2>;	/* TWCK (SCL) PA24 periph A, open drain */
> +					};
> +				};
> +			};
> +
> +			watchdog at fffffd40 {
> +				status = "okay";
> +			};
> +		};
> +
> +		usb0: ohci at 00500000 {
> +			num-ports = <2>;
> +			status = "okay";
> +		};
> +	};
> +
> +	i2c at 0 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_i2c0>;
> +		i2c-gpio,delay-us = <5>;	/* ~85 kHz */
> +		status = "okay";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		/* red LED marked "PC7" near mini USB (device) receptacle */
> +		user_led {
> +			label = "user_led";
> +			gpios = <&pioC 7 0>;	/* PC7 */
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +
> +		btn {
> +			label = "Button";
> +			gpios = <&pioC 4 1>;
> +			linux,code = <0x103>;
> +			gpio-key,wakeup;
> +		};
> +	};
> +};
> 


-- 
Nicolas Ferre
