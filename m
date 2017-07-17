From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Mon, 17 Jul 2017 17:18:20 +0200 (CEST)
Subject: [PATCH 5/5] ARM: dts: gemini: add pin control set-up for the SoC
In-Reply-To: <20170715175056.13040-5-linus.walleij@linaro.org>
References: <20170715175056.13040-1-linus.walleij@linaro.org>
 <20170715175056.13040-5-linus.walleij@linaro.org>
Message-ID: <alpine.LNX.2.00.1707171718040.3934@T420s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus

On Sat, 15 Jul 2017, Linus Walleij wrote:

> This adds the basic pin control muliplexing settings for the
> Gemini SoC: parallel (NOR) flash, SATA, optional IDE, PCI and
> UART.
> 
> We also select the right GPIO groups on all applicable systems
> so that GPIO keys/LEDs work smoothly.
> 
> We can then build upon this for more complex systems.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/boot/dts/gemini-dlink-dir-685.dts |  55 ++++++++++++++
>  arch/arm/boot/dts/gemini-nas4220b.dts      |  24 ++++++
>  arch/arm/boot/dts/gemini-rut1xx.dts        |  39 ++++++++++
>  arch/arm/boot/dts/gemini-sq201.dts         |  36 ++++++++-
>  arch/arm/boot/dts/gemini-wbd111.dts        |  26 +++++++
>  arch/arm/boot/dts/gemini-wbd222.dts        |  26 +++++++
>  arch/arm/boot/dts/gemini.dtsi              | 117 +++++++++++++++++++++++++++++
>  7 files changed, 322 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/gemini-dlink-dir-685.dts b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
> index f59dada28f6a..094a29624b8d 100644
> --- a/arch/arm/boot/dts/gemini-dlink-dir-685.dts
> +++ b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
> @@ -33,6 +33,7 @@
>  			wakeup-source;
>  			linux,code = <KEY_ESC>;
>  			label = "reset";
> +			/* Collides with LPC_LAD[0], UART DCD, SSP 97RST */
>  			gpios = <&gpio0 8 GPIO_ACTIVE_LOW>;
>  		};
>  		button at 13 {
> @@ -40,6 +41,7 @@
>  			wakeup-source;
>  			linux,code = <KEY_EJECTCD>;
>  			label = "unmount";
> +			/* Collides with LPC LFRAME, UART RTS, SSP TXD */
>  			gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
>  		};
>  	};
> @@ -48,6 +50,7 @@
>  		compatible = "gpio-leds";
>  		led at 7 {
>  			label = "dir685:blue:WPS";
> +			/* Collides with ICE */
>  			gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
>  			default-state = "on";
>  			linux,default-trigger = "heartbeat";
> @@ -60,11 +63,13 @@
>  		 */
>  		led at 11 {
>  			label = "dir685:blue:HD";
> +			/* Collides with LPC_SERIRQ, UART DTR, SSP FSC pins */
>  			gpios = <&gpio0 11 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  		led at 12 {
>  			label = "dir685:orange:HD";
> +			/* Collides with LPC_LAD[2], UART DSR, SSP ECLK pins */
>  			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
> @@ -80,6 +85,7 @@
>  	 */
>  	gpio-fan {
>  		compatible = "gpio-fan";
> +		/* Collides with IDE */
>  		gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
>  		gpio-fan,speed-map = <0 0>, <10000 1>;
>  		#cooling-cells = <2>;
> @@ -91,6 +97,7 @@
>  	 */
>  	gpio-i2c {
>  		compatible = "i2c-gpio";
> +		/* Collides with ICE */
>  		gpios = <&gpio0 5 0>, /* SDA */
>  			<&gpio0 6 0>; /* SCL */
>  		#address-cells = <1>;
> @@ -100,6 +107,7 @@
>  			compatible = "dlink,dir685-touchkeys";
>  			reg = <0x26>;
>  			interrupt-parent = <&gpio0>;
> +			/* Collides with NAND flash */
>  			interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
>  		};
>  	};
> @@ -155,12 +163,59 @@
>  			};
>  		};
>  
> +		syscon: syscon at 40000000 {
> +			pinctrl {
> +				/*
> +				 * gpio0bgrp cover line 5, 6 used by TK I2C
> +				 * gpio0bgrp cover line 7 used by WPS LED
> +				 * gpio0cgrp cover line 8, 13 used by keys
> +				 *           and 11, 12 used by the HD LEDs
> +				 * gpio0egrp cover line 16 used by VDISP
> +				 * gpio0fgrp cover line 17 used by TK IRQ
> +				 * gpio0ggrp cover line 20 used by panel CS
> +				 * gpio0hgrp cover line 21,22 used by RTL8366RB
> +				 */
> +				gpio0_default_pins: pinctrl-gpio0 {
> +					mux {
> +						function = "gpio0";
> +						groups = "gpio0bgrp",
> +						"gpio0cgrp",
> +						"gpio0egrp",
> +						"gpio0fgrp",
> +						"gpio0ggrp",
> +						"gpio0hgrp";
> +					};
> +				};
> +				/*
> +				 * gpio1bgrp cover line 5,8,7 used by panel SPI
> +				 * also line 6 used by the fan
> +				 *
> +				 */
> +				gpio1_default_pins: pinctrl-gpio1 {
> +					mux {
> +						function = "gpio1";
> +						groups = "gpio1bgrp";
> +					};
> +				};
> +			};
> +		};
> +
>  		sata: sata at 46000000 {
>  			cortina,gemini-ata-muxmode = <0>;
>  			cortina,gemini-enable-sata-bridge;
>  			status = "okay";
>  		};
>  
> +		gpio0: gpio at 4d000000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&gpio0_default_pins>;
> +		};
> +
> +		gpio1: gpio at 4e000000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&gpio1_default_pins>;
> +		};
> +
>  		pci at 50000000 {
>  			status = "okay";
>  			interrupt-map-mask = <0xf800 0 0 7>;
> diff --git a/arch/arm/boot/dts/gemini-nas4220b.dts b/arch/arm/boot/dts/gemini-nas4220b.dts
> index 55f6a4f1f801..b4fc58c8cf8d 100644
> --- a/arch/arm/boot/dts/gemini-nas4220b.dts
> +++ b/arch/arm/boot/dts/gemini-nas4220b.dts
> @@ -33,6 +33,7 @@
>  			wakeup-source;
>  			linux,code = <KEY_SETUP>;
>  			label = "Backup button";
> +			/* Conflict with TVC */
>  			gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
>  		};
>  		button at 31 {
> @@ -40,6 +41,7 @@
>  			wakeup-source;
>  			linux,code = <KEY_RESTART>;
>  			label = "Softreset button";
> +			/* Conflict with TVC */
>  			gpios = <&gpio1 31 GPIO_ACTIVE_LOW>;
>  		};
>  	};
> @@ -48,11 +50,13 @@
>  		compatible = "gpio-leds";
>  		led at 28 {
>  			label = "nas4220b:orange:hdd";
> +			/* Conflict with TVC */
>  			gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>  			default-state = "on";
>  		};
>  		led at 30 {
>  			label = "nas4220b:green:os";
> +			/* Conflict with TVC */
>  			gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
>  			default-state = "on";
>  			linux,default-trigger = "heartbeat";
> @@ -99,12 +103,32 @@
>  			};
>  		};
>  
> +		syscon: syscon at 40000000 {
> +			pinctrl {
> +				/*
> +				 * gpio1dgrp cover line 28-31 otherwise used
> +				 * by TVC.
> +				 */
> +				gpio1_default_pins: pinctrl-gpio1 {
> +					mux {
> +						function = "gpio1";
> +						groups = "gpio1dgrp";
> +					};
> +				};
> +			};
> +		};
> +
>  		sata: sata at 46000000 {
>  			cortina,gemini-ata-muxmode = <0>;
>  			cortina,gemini-enable-sata-bridge;
>  			status = "okay";
>  		};
>  
> +		gpio1: gpio at 4e000000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&gpio1_default_pins>;
> +		};
> +
>  		ata at 63000000 {
>  			status = "okay";
>  		};
> diff --git a/arch/arm/boot/dts/gemini-rut1xx.dts b/arch/arm/boot/dts/gemini-rut1xx.dts
> index 7b920bfbda32..3613b264f45f 100644
> --- a/arch/arm/boot/dts/gemini-rut1xx.dts
> +++ b/arch/arm/boot/dts/gemini-rut1xx.dts
> @@ -33,6 +33,7 @@
>  			wakeup-source;
>  			linux,code = <KEY_SETUP>;
>  			label = "Reset to defaults";
> +			/* Conflict with TVC */
>  			gpios = <&gpio1 28 GPIO_ACTIVE_LOW>;
>  		};
>  	};
> @@ -42,12 +43,14 @@
>  		led at 7 {
>  			/* FIXME: add the LED color */
>  			label = "rut1xx::gsm";
> +			/* Conflict with ICE */
>  			gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
>  			default-state = "on";
>  		};
>  		led at 31 {
>  			/* FIXME: add the LED color */
>  			label = "rut1xx::power";
> +			/* Conflict with NAND CE0 */
>  			gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  			linux,default-trigger = "heartbeat";
> @@ -61,5 +64,41 @@
>  			reg = <0x30000000 0x00800000>;
>  			/* TODO: add flash partitions here */
>  		};
> +
> +		syscon: syscon at 40000000 {
> +			pinctrl {
> +				/*
> +				 * gpio0bgrp cover line 7 used by GSM LED
> +				 * gpio0fgrp cover line 17 used by power LED
> +				 */
> +				gpio0_default_pins: pinctrl-gpio0 {
> +					mux {
> +						function = "gpio0";
> +						groups = "gpio0bgrp",
> +						"gpio0fgrp";
> +					};
> +				};
> +				/*
> +				 * gpio1dgrp cover line 28-31 otherwise used
> +				 * by TVC.
> +				 */
> +				gpio1_default_pins: pinctrl-gpio1 {
> +					mux {
> +						function = "gpio1";
> +						groups = "gpio1dgrp";
> +					};
> +				};
> +			};
> +		};
> +
> +		gpio0: gpio at 4d000000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&gpio0_default_pins>;
> +		};
> +
> +		gpio1: gpio at 4e000000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&gpio1_default_pins>;
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/gemini-sq201.dts b/arch/arm/boot/dts/gemini-sq201.dts
> index 4d200f0bcd45..7cfa9caf47d4 100644
> --- a/arch/arm/boot/dts/gemini-sq201.dts
> +++ b/arch/arm/boot/dts/gemini-sq201.dts
> @@ -33,6 +33,7 @@
>  			wakeup-source;
>  			linux,code = <KEY_SETUP>;
>  			label = "factory reset";
> +			/* Conflict with NAND flash */
>  			gpios = <&gpio0 18 GPIO_ACTIVE_LOW>;
>  		};
>  	};
> @@ -41,12 +42,14 @@
>  		compatible = "gpio-leds";
>  		led at 20 {
>  			label = "sq201:green:info";
> +			/* Conflict with parallel flash */
>  			gpios = <&gpio0 20 GPIO_ACTIVE_HIGH>;
>  			default-state = "on";
>  			linux,default-trigger = "heartbeat";
>  		};
>  		led at 31 {
>  			label = "sq201:green:usb";
> +			/* Conflict with parallel and NAND flash */
>  			gpios = <&gpio0 31 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  			linux,default-trigger = "usb-host";
> @@ -55,7 +58,15 @@
>  
>  	soc {
>  		flash at 30000000 {
> -			status = "okay";
> +			/*
> +			 * Flash access can be enabled, with the side effect
> +			 * of disabling access to GPIO LED on GPIO0[20] which
> +			 * reuse one of the parallel flash chip select lines.
> +			 * Also the default firmware on the machine has the
> +			 * problem that since it uses the flash, the two LEDS
> +			 * on the right become numb.
> +			 */
> +			/* status = "okay"; */
>  			/* 16MB of flash */
>  			reg = <0x30000000 0x01000000>;
>  
> @@ -93,12 +104,35 @@
>  			};
>  		};
>  
> +		syscon: syscon at 40000000 {
> +			pinctrl {
> +				/*
> +				 * gpio0fgrp cover line 18 used by reset button
> +				 * gpio0ggrp cover line 20 used by info LED
> +				 * gpio0kgrp cover line 31 used by USB LED
> +				 */
> +				gpio0_default_pins: pinctrl-gpio0 {
> +					mux {
> +						function = "gpio0";
> +						groups = "gpio0fgrp",
> +						"gpio0ggrp",
> +						"gpio0kgrp";
> +					};
> +				};
> +			};
> +		};
> +
>  		sata: sata at 46000000 {
>  			cortina,gemini-ata-muxmode = <0>;
>  			cortina,gemini-enable-sata-bridge;
>  			status = "okay";
>  		};
>  
> +		gpio0: gpio at 4d000000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&gpio0_default_pins>;
> +		};
> +
>  		pci at 50000000 {
>  			status = "okay";
>  			interrupt-map-mask = <0xf800 0 0 7>;
> diff --git a/arch/arm/boot/dts/gemini-wbd111.dts b/arch/arm/boot/dts/gemini-wbd111.dts
> index 63b756e3bf5a..38a49e750478 100644
> --- a/arch/arm/boot/dts/gemini-wbd111.dts
> +++ b/arch/arm/boot/dts/gemini-wbd111.dts
> @@ -33,6 +33,7 @@
>  			wakeup-source;
>  			linux,code = <KEY_SETUP>;
>  			label = "reset";
> +			/* Conflict with ICE */
>  			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
>  		};
>  	};
> @@ -42,21 +43,25 @@
>  
>  		led at 1 {
>  			label = "wbd111:red:L3";
> +			/* Conflict with TVC and extended parallel flash */
>  			gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  		led at 2 {
>  			label = "wbd111:green:L4";
> +			/* Conflict with TVC and extended parallel flash */
>  			gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  		led at 3 {
>  			label = "wbd111:red:L4";
> +			/* Conflict with TVC and extended parallel flash */
>  			gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  		led at 5 {
>  			label = "wbd111:green:L3";
> +			/* Conflict with TVC and extended parallel flash */
>  			gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
>  			default-state = "on";
>  			linux,default-trigger = "heartbeat";
> @@ -98,5 +103,26 @@
>  				read-only;
>  			};
>  		};
> +
> +		syscon: syscon at 40000000 {
> +			pinctrl {
> +				/*
> +				 * gpio0agrp cover line 0-4
> +				 * gpio0bgrp cover line 5
> +				 */
> +				gpio0_default_pins: pinctrl-gpio0 {
> +					mux {
> +						function = "gpio0";
> +						groups = "gpio0agrp",
> +						"gpio0bgrp";
> +					};
> +				};
> +			};
> +		};
> +
> +		gpio0: gpio at 4d000000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&gpio0_default_pins>;
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/gemini-wbd222.dts b/arch/arm/boot/dts/gemini-wbd222.dts
> index 9747f5a47807..f77e34e0df0b 100644
> --- a/arch/arm/boot/dts/gemini-wbd222.dts
> +++ b/arch/arm/boot/dts/gemini-wbd222.dts
> @@ -33,6 +33,7 @@
>  			wakeup-source;
>  			linux,code = <KEY_SETUP>;
>  			label = "reset";
> +			/* Conflict with ICE */
>  			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
>  		};
>  	};
> @@ -42,21 +43,25 @@
>  
>  		led at 1 {
>  			label = "wbd111:red:L3";
> +			/* Conflict with TVC and extended parallel flash */
>  			gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  		led at 2 {
>  			label = "wbd111:green:L4";
> +			/* Conflict with TVC and extended parallel flash */
>  			gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  		led at 3 {
>  			label = "wbd111:red:L4";
> +			/* Conflict with TVC and extended parallel flash */
>  			gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  		led at 5 {
>  			label = "wbd111:green:L3";
> +			/* Conflict with TVC and extended parallel flash */
>  			gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
>  			default-state = "on";
>  			linux,default-trigger = "heartbeat";
> @@ -98,5 +103,26 @@
>  				read-only;
>  			};
>  		};
> +
> +		syscon: syscon at 40000000 {
> +			pinctrl {
> +				/*
> +				 * gpio0agrp cover line 0-4
> +				 * gpio0bgrp cover line 5
> +				 */
> +				gpio0_default_pins: pinctrl-gpio0 {
> +					mux {
> +						function = "gpio0";
> +						groups = "gpio0agrp",
> +						"gpio0bgrp";
> +					};
> +				};
> +			};
> +		};
> +
> +		gpio0: gpio at 4d000000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&gpio0_default_pins>;
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
> index 49cce9e9d51f..c68e8d430234 100644
> --- a/arch/arm/boot/dts/gemini.dtsi
> +++ b/arch/arm/boot/dts/gemini.dtsi
> @@ -20,6 +20,8 @@
>  		flash at 30000000 {
>  			compatible = "cortina,gemini-flash", "cfi-flash";
>  			syscon = <&syscon>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pflash_default_pins>;
>  			bank-width = <2>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> @@ -41,6 +43,105 @@
>  				/* RESET_GLOBAL | RESET_CPU1 */
>  				mask = <0xC0000000>;
>  			};
> +
> +			pinctrl {
> +				compatible = "cortina,gemini-pinctrl";
> +				regmap = <&syscon>;
> +				/* Hog the DRAM pins */
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&dram_default_pins>, <&system_default_pins>,
> +					    <&vcontrol_default_pins>;
> +
> +				dram_default_pins: pinctrl-dram {
> +					mux {
> +						function = "dram";
> +						groups = "dramgrp";
> +					};
> +				};
> +				rtc_default_pins: pinctrl-rtc {
> +					mux {
> +						function = "rtc";
> +						groups = "rtcgrp";
> +					};
> +				};
> +				power_default_pins: pinctrl-power {
> +					mux {
> +						function = "power";
> +						groups = "powergrp";
> +					};
> +				};
> +				cir_default_pins: pinctrl-cir {
> +					mux {
> +						function = "cir";
> +						groups = "cirgrp";
> +					};
> +				};
> +				system_default_pins: pinctrl-system {
> +					mux {
> +						function = "system";
> +						groups = "systemgrp";
> +					};
> +				};
> +				vcontrol_default_pins: pinctrl-vcontrol {
> +					mux {
> +						function = "vcontrol";
> +						groups = "vcontrolgrp";
> +					};
> +				};
> +				ice_default_pins: pinctrl-ice {
> +					mux {
> +						function = "ice";
> +						groups = "icegrp";
> +					};
> +				};
> +				uart_default_pins: pinctrl-uart {
> +					mux {
> +						function = "uart";
> +						groups = "uartrxtxgrp";
> +					};
> +				};
> +				pflash_default_pins: pinctrl-pflash {
> +					mux {
> +						function = "pflash";
> +						groups = "pflashgrp";
> +					};
> +				};
> +				usb_default_pins: pinctrl-usb {
> +					mux {
> +						function = "usb";
> +						groups = "usbgrp";
> +					};
> +				};
> +				gmii_default_pins: pinctrl-gmii {
> +					mux {
> +						function = "gmii";
> +						groups = "gmiigrp";
> +					};
> +				};
> +				pci_default_pins: pinctrl-pci {
> +					mux {
> +						function = "pci";
> +						groups = "pcigrp";
> +					};
> +				};
> +				sata_default_pins: pinctrl-sata {
> +					mux {
> +						function = "sata";
> +						groups = "satagrp";
> +					};
> +				};
> +				/* Activate both groups of pins for this state */
> +				sata_and_ide_pins: pinctrl-sata-ide {
> +					mux0 {
> +						function = "sata";
> +						groups = "satagrp";
> +					};
> +					mux1 {
> +						function = "ide";
> +						groups = "idegrp";
> +					};
> +				};
> +			};
>  		};
>  
>  		watchdog at 41000000 {
> @@ -57,6 +158,8 @@
>  			resets = <&syscon GEMINI_RESET_UART>;
>  			clocks = <&syscon GEMINI_CLK_UART>;
>  			interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&uart_default_pins>;
>  			reg-shift = <2>;
>  		};
>  
> @@ -81,6 +184,8 @@
>  			resets = <&syscon GEMINI_RESET_RTC>;
>  			clocks = <&syscon GEMINI_CLK_APB>, <&syscon GEMINI_CLK_RTC>;
>  			clock-names = "PCLK", "EXTCLK";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&rtc_default_pins>;
>  		};
>  
>  		sata: sata at 46000000 {
> @@ -92,6 +197,14 @@
>  			clocks = <&syscon GEMINI_CLK_GATE_SATA0>,
>  				 <&syscon GEMINI_CLK_GATE_SATA1>;
>  			clock-names = "SATA0_PCLK", "SATA1_PCLK";
> +			/*
> +			 * This defines the special "ide" state that needs
> +			 * to be explicitly enabled to enable the IDE pins,
> +			 * as these pins are normally used for other things.
> +			 */
> +			pinctrl-names = "default", "ide";
> +			pinctrl-0 = <&sata_default_pins>;
> +			pinctrl-1 = <&sata_and_ide_pins>;
>  			syscon = <&syscon>;
>  			status = "disabled";
>  		};
> @@ -108,6 +221,8 @@
>  			compatible = "cortina,gemini-power-controller";
>  			reg = <0x4b000000 0x100>;
>  			interrupts = <26 IRQ_TYPE_EDGE_RISING>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&power_default_pins>;
>  		};
>  
>  		gpio0: gpio at 4d000000 {
> @@ -156,6 +271,8 @@
>  			resets = <&syscon GEMINI_RESET_PCI>;
>  			clocks = <&syscon GEMINI_CLK_GATE_PCI>, <&syscon GEMINI_CLK_PCI>;
>  			clock-names = "PCLK", "PCICLK";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pci_default_pins>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			#interrupt-cells = <1>;
> -- 
> 2.9.4
> 
> 

Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
