From: mc5686@mclink.it (Mauro Condarelli)
Date: Thu, 13 Aug 2015 00:12:58 +0200
Subject: Debugging "of_get_named_gpiod_flags: can't parse gpios property of
 node" warnings in kinux-3.16.1
Message-ID: <55CBC4EA.8040309@mclink.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, I am working with a custom board based on ACME ariag25 which is, in turn, based on Atmel AT91SAM9G25 SoC.
I have a quite simple .dts file, mostly based on defaults (see attachments), bu I nevertheless get a bunch of "of_get_named_gpiod_flags: can't parse gpios property of node" warnings.
I tried to debug inserting a few pr_debug() in gpiolib-of.c, but I do not really understand .dts intricacies (this is the first time I work with it).
Can someone suggest me what I should check (or plainly tell me where and how I'm making a fool of myself)?

Thanks in advance.
Mauro
-------------- next part --------------
/*
 * at91-ariag25.dts - Device Tree file for Acme Systems Aria G25
 *
 * Copyright (C) 2013 Douglas Gilbert <dgilbert@interlog.com>,
 *                    Robert Nelson <robertcnelson@gmail.com>
 * Copyright (C) 2014 Sergio Tanzilli <sergio@tanzilli.com>
 *
 * Licensed under GPLv2 or later. 
 */
/dts-v1/;
#include "at91-ariag25-base.dtsi"

/ {
	memory {
		/* 128 MB Aria G25 version */
		reg = <0x20000000 0x8000000>;
		/* 256 MB Aria G25 version */
		/* reg = <0x20000000 0x10000000>; */
	};
};

-------------- next part --------------
/*
 * at91-ariag25.dts - Device Tree file for Acme Systems Aria G25
 *
 * Copyright (C) 2013 Douglas Gilbert <dgilbert@interlog.com>,
 *                    Robert Nelson <robertcnelson@gmail.com>
 * Copyright (C) 2014 Sergio Tanzilli <sergio@tanzilli.com>
 *
 * Licensed under GPLv2 or later. 
 */
#include "at91sam9g25.dtsi"

/ {
	model = "Acme Systems Aria G25";
	compatible = "acme,ariag25", "atmel,at91sam9x5ek",
				"atmel,at91sam9x5", "atmel,at91sam9";

	aliases {
		serial0 = &dbgu;
		serial1 = &usart0;
		serial2 = &usart1;
		serial3 = &usart2;
		serial4 = &usart3;
		serial5 = &uart0;
		serial6 = &uart1;
	};

	chosen {
		bootargs = "console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootwait";
	};

	memory {
		/* 128 MB Aria G25 version */
		reg = <0x20000000 0x8000000>;
		/* 256 MB Aria G25 version */
		/* reg = <0x20000000 0x10000000>; */
	};


	clocks {
		#address-cells = <1>;
		#size-cells = <1>;
		ranges;

		main_clock: clock at 0 {
			compatible = "atmel,osc", "fixed-clock";
				clock-frequency = <12000000>;
		};
	};

	ahb {
		apb {
			mmc0: mmc at f0008000 {
				status = "okay";
				pinctrl-0 = <
				&pinctrl_mmc0_slot0_clk_cmd_dat0
				&pinctrl_mmc0_slot0_dat1_3>;
				slot at 0 {
					reg = <0>;
					bus-width = <4>;
					cd-gpios = <&pioA 1 GPIO_ACTIVE_LOW>;
					wp-gpios = <>;
				};
			};

			mmc1: mmc at f000c000 {
				status = "okay";
				pinctrl-0 = <
				&pinctrl_mmc1_slot0_clk_cmd_dat0
				&pinctrl_mmc1_slot0_dat1_3>;
				slot at 0 {
					reg = <0>;
					bus-width = <4>;
					cd-gpios = <&pioA 0 GPIO_ACTIVE_LOW>;
					wp-gpios = <>;
				};
			};

			i2c0: i2c at f8010000 {
				status = "disabled";
			};

			i2c1: i2c at f8014000 {
				status = "disabled";
			};

			/* /dev/ttyS1 */
			usart0: serial at f801c000 {
				pinctrl-0 = <&pinctrl_usart0 &pinctrl_usart0_rts &pinctrl_usart0_cts>;
				status = "disabled";
			};

			/* /dev/ttyS2 */
			usart1: serial at f8020000 {
				pinctrl-0 = <&pinctrl_usart1>;
				status = "okay";
			};

			/* /dev/ttyS3 */
			usart2: serial at f8024000 {
				pinctrl-0 = <&pinctrl_usart2>;
				status = "disabled";
			};

			/* /dev/ttyS4 */
			usart3: serial at f8028000 {
				compatible = "atmel,at91sam9260-usart";
				reg = <0xf8028000 0x200>;
				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
				pinctrl-names = "default";
				pinctrl-0 = <&pinctrl_usart3
						&pinctrl_usart3_rts
						&pinctrl_usart3_cts
						>;
				status = "okay";
			};

			/* /dev/ttyS5 */
			uart0: serial at f8040000 {
				status = "disabled";
			};

			/* /dev/ttyS6 */
			uart1: serial at f8044000 {
				status = "disabled";
			};

			spi1: spi at f0004000 {
				status = "okay";
				cs-gpios = <&pioA 8 0>;

				device at 0 {
					compatible = "spidev";
					// spi-max-frequency = <50000000>;  // 50 MHz
					spi-max-frequency = <5000000>;	    // 5 MHz
					reg = <0>;
				};
			};

			macb0: ethernet at f802c000 {
				status = "okay";
				phy-mode = "rmii";

			};

			adc0: adc at f804c000 {
				status = "okay";
				atmel,adc-channels-used = <0x1>;
				atmel,adc-num-channels = <1>;
				compatible = "atmel,at91sam9x5-adc";
				atmel,adc-startup-time = <40>;
				atmel,adc-status-register = <0x1c>;
				atmel,adc-trigger-register = <0x08>;
				atmel,adc-use-external;
				atmel,adc-vref = <3300>;
				atmel,adc-res = <8 10>;
				atmel,adc-res-names = "lowres", "highres";
				atmel,adc-use-res = "highres";

				trigger at 0 {
					trigger-name = "continuous";
					trigger-value = <0x6>;
				};
			};

			dbgu: serial at fffff200 {
				status = "okay";
			};

			pinctrl at fffff400 {
				w1_0 {
					pinctrl_w1_0: w1_0-0 {
						atmel,pins = <0 21 0x0 0x1>; /* PA21 PIO, pull-up */
					};
				};

				pwm0 {
					pinctrl_pwm0: pwm0-0 {
						atmel,pins =
						< AT91_PIOC 18 AT91_PERIPH_C AT91_PINCTRL_NONE
						AT91_PIOC 19 AT91_PERIPH_C AT91_PINCTRL_NONE
						AT91_PIOC 20 AT91_PERIPH_C AT91_PINCTRL_NONE
						AT91_PIOC 21 AT91_PERIPH_C AT91_PINCTRL_NONE >;
					};
				};
			};

			pwm0: pwm at f8034000 {
				pinctrl-names = "default";
				pinctrl-0 = <&pinctrl_pwm0>;
				status = "okay";
			};

			rtc at fffffeb0 {
				status = "okay";
			};

			usb2: gadget at f803c000 {
				atmel,vbus-gpio = <&pioC 27 GPIO_ACTIVE_HIGH>;
/*
				compatible = "atmel,at91rm9200-udc";
				clocks = <&usb>, <&udphs_clk>;
				clock-names = "hclk", "pclk";
*/
				status = "okay";
			};

		};

		usb0: ohci at 00600000 {
			status = "okay";
			num-ports = <3>;
			atmel,vbus-gpio = <&pioC 30 GPIO_ACTIVE_HIGH>;
			atmel,oc-gpio = <&pioC 28 GPIO_ACTIVE_LOW>;

		};

		usb1: ehci at 00700000 {
			status = "okay";
			num-ports = <3>;
			atmel,vbus-gpio = <&pioC 31 GPIO_ACTIVE_HIGH>;
			atmel,oc-gpio = <&pioC 29 GPIO_ACTIVE_LOW>;
		};

	};

	leds {
		compatible = "gpio-leds";

		aria_led {
			label = "aria_led";
			gpios = <&pioB 8 GPIO_ACTIVE_HIGH>; /* PB8 */
			linux,default-trigger = "heartbeat";
		};

/*
pioB  8 led si schedino
pioA 29 abilitazione misura batteria (set HIGH)
pioC 14 abilitazione stampante (attivo basso, nasce alto)
*/
	};

	gpio_keys {
		compatible = "gpio-keys";
		powfail {
			label = "PowerFail";
			gpios = <&pioA 31 GPIO_ACTIVE_LOW>;
			linux,code = <117>;
			gpio-key,wakeup;
		};
		shutdown {
			label = "Shutdown";
			gpios = <&pioC 15 GPIO_ACTIVE_LOW>;
			linux,code = <116>;
			gpio-key,wakeup;
		};
		paperfeed {
			label = "PaperFeed";
			gpios = <&pioC 17 GPIO_ACTIVE_LOW>;
			linux,code = <115>;
			gpio-key,wakeup;
		};
		batteryon {
			label = "BatteryConnected";
			gpios = <&pioC 16 GPIO_ACTIVE_HIGH>;
			linux,code = <114>;
			gpio-key,wakeup;
		};
		initservice {
			label = "InitService";
			gpios = <&pioC 26 GPIO_ACTIVE_LOW>;
			linux,code = <113>;
			gpio-key,wakeup;
		};
	};

};
