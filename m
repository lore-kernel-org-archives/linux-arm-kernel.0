From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 31 Jul 2015 17:08:10 +0200
Subject: [RFC PATCH 3/3] ARM: at91/dt: add pinctrl
In-Reply-To: <1438355290-28255-1-git-send-email-ludovic.desroches@atmel.com>
References: <1438355290-28255-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1438355290-28255-4-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts |  386 ++++++++++
 arch/arm/boot/dts/sama5d2.dtsi              | 1076 +++++++++++++++++++++++++++
 2 files changed, 1462 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-sama5d2_xplained.dts
 create mode 100644 arch/arm/boot/dts/sama5d2.dtsi

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
new file mode 100644
index 0000000..4ee6f6a
--- /dev/null
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -0,0 +1,386 @@
+/*
+ * at91-sama5d2_xplained.dts - Device Tree file for SAMA5D2 Xplained board
+ *
+ *  Copyright (C) 2015 Atmel,
+ *                2015 Nicolas Ferre <nicolas.ferre@atmel.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+/dts-v1/;
+#include "sama5d2.dtsi"
+#include "sama5d2-pinfunc.h"
+
+/ {
+	model = "Atmel SAMA5D2 Xplained";
+	compatible = "atmel,sama5d2-xplained", "atmel,sama5d2", "atmel,sama5";
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+	};
+
+	memory {
+		reg = <0x20000000 0x80000>;
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		main_clock: clock at 0 {
+			compatible = "atmel,osc", "fixed-clock";
+			clock-frequency = <12000000>;
+		};
+
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
+			clock-frequency = <12000000>;
+		};
+	};
+
+	ahb {
+		usb0: gadget at 00300000 {
+			atmel,vbus-gpio = <&pioA 31 GPIO_ACTIVE_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usba_vbus>;
+			status = "okay";
+		};
+
+		usb1: ohci at 00400000 {
+			num-ports = <3>;
+			atmel,vbus-gpio = <0 /* &pioA 41 GPIO_ACTIVE_HIGH */
+					   &pioA 42 GPIO_ACTIVE_HIGH
+					   0
+					  >;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb_default>;
+			status = "okay";
+		};
+
+		usb2: ehci at 00500000 {
+			status = "okay";
+		};
+
+		sdmmc0: sdio-host at a0000000 {
+			bus-width = <8>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_sdmmc0_default>;
+			non-removable;
+			status = "okay";
+		};
+
+		sdmmc1: sdio-host at b0000000 {
+			bus-width = <4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_sdmmc1_default>;
+			status = "okay";
+		};
+
+		apb {
+			spi0: spi at f8000000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_spi0_default>;
+				status = "okay";
+
+				m25p80 at 0 {
+					compatible = "atmel,at25df321a";
+					reg = <0>;
+					spi-max-frequency = <50000000>;
+				};
+			};
+
+			macb0: ethernet at f8008000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_macb0_rmii>;
+				phy-mode = "rmii";
+				status = "okay";
+			};
+
+			uart1: serial at f8020000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart1_default>;
+				status = "okay";
+			};
+
+			i2c0: i2c at f8028000 {
+				dmas = <0>, <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c0_default>;
+				status = "okay";
+			};
+
+			flx0: flexcom at f8034000 {
+				atmel,flexcom-mode = "usart";
+				status = "okay";
+
+				uart5: serial at f8034200 {
+					compatible = "atmel,at91sam9260-usart";
+					reg = <0x200 0x200>;
+					interrupts = <19 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&flx0_clk>;
+					clock-names = "usart";
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_flx0_default>;
+					atmel,fifo-size = <32>;
+					status = "okay";
+				};
+			};
+
+			shdwc at f8048010 {
+				atmel,shdwc-debouncer = <976>;
+
+				input at 0 {
+					reg = <0>;
+					atmel,wakeup-type = "low";
+				};
+			};
+
+			watchdog at f8048040 {
+				status = "okay";
+			};
+
+			uart3: serial at fc008000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart3_default>;
+				status = "okay";
+			};
+
+			flx4: flexcom at fc018000 {
+				atmel,flexcom-mode = "i2c";
+				status = "okay";
+
+				i2c2: i2c at fc018600 {
+					compatible = "atmel,sama5d2-i2c";
+					reg = <0x600 0x200>;
+					interrupts = <23 IRQ_TYPE_LEVEL_HIGH 7>;
+					dmas = <0>, <0>;
+					dma-names = "tx", "rx";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					clocks = <&flx4_clk>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_flx4_default>;
+					atmel,fifo-size = <16>;
+					status = "okay";
+				};
+			};
+
+			i2c1: i2c at fc028000 {
+				dmas = <0>, <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c1_default>;
+				status = "okay";
+
+				at24 at 54 {
+					compatible = "atmel,24c02";
+					reg = <0x54>;
+					pagesize = <16>;
+				};
+			};
+
+			pinctrl at fc038000 {
+				pinctrl_flx0_default: flx0_default {
+					pinmux = <PIN_PB28__FLEXCOM0_IO0>,
+						 <PIN_PB29__FLEXCOM0_IO1>;
+					bias-disable;
+				};
+
+				pinctrl_flx4_default: flx4_default {
+					pinmux = <PIN_PD12__FLEXCOM4_IO0>,
+						 <PIN_PD13__FLEXCOM4_IO1>;
+					bias-disable;
+				};
+
+				pinctrl_i2c0_default: i2c0_default {
+					pinmux = <PIN_PD21__TWD0>,
+						 <PIN_PD22__TWCK0>;
+					bias-disable;
+				};
+
+				pinctrl_i2c1_default: i2c1_default {
+					pinmux = <PIN_PD4__TWD1>,
+						 <PIN_PD5__TWCK1>;
+					bias-disable;
+				};
+
+				pinctrl_key_gpio_default: key_gpio_default {
+					pinmux = <PIN_PB6>;
+					bias-pull-up;
+				};
+
+				pinctrl_led_gpio_default: led_gpio_default {
+					pinmux = <PIN_PB0>,
+						 <PIN_PB5>;
+					bias-pull-up;
+				};
+
+				pinctrl_macb0_rmii: macb0_rmii {
+					pinmux = <PIN_PB14__GTXCK>,
+						 <PIN_PB15__GTXEN>,
+						 <PIN_PB16__GRXDV>,
+						 <PIN_PB17__GRXER>,
+						 <PIN_PB18__GRX0>,
+						 <PIN_PB19__GRX1>,
+						 <PIN_PB20__GTX0>,
+						 <PIN_PB21__GTX1>,
+						 <PIN_PB22__GMDC>,
+						 <PIN_PB23__GMDIO>;
+					bias-disable;
+				};
+
+				pinctrl_sdmmc0_default: sdmmc0_default {
+					data {
+						pinmux = <PIN_PA2__SDMMC0_DAT0>,
+							 <PIN_PA3__SDMMC0_DAT1>,
+							 <PIN_PA4__SDMMC0_DAT2>,
+							 <PIN_PA5__SDMMC0_DAT3>,
+							 <PIN_PA6__SDMMC0_DAT4>,
+							 <PIN_PA7__SDMMC0_DAT5>,
+							 <PIN_PA8__SDMMC0_DAT6>,
+							 <PIN_PA9__SDMMC0_DAT7>;
+						bias-pull-up;
+					};
+
+					cmd_ck_cd_rstn_vddsel {
+						pinmux = <PIN_PA1__SDMMC0_CMD>,
+							 <PIN_PA0__SDMMC0_CK>,
+							 <PIN_PA10__SDMMC0_RSTN>,
+							 <PIN_PA11__SDMMC0_VDDSEL>;
+						bias-disable;
+					};
+				};
+
+				pinctrl_sdmmc1_default: sdmmc1_default {
+					cmd_data {
+						pinmux = <PIN_PA28__SDMMC1_CMD>,
+							 <PIN_PA18__SDMMC1_DAT0>,
+							 <PIN_PA19__SDMMC1_DAT1>,
+							 <PIN_PA20__SDMMC1_DAT2>,
+							 <PIN_PA21__SDMMC1_DAT3>;
+						bias-pull-up;
+					};
+
+					ck_cd {
+						pinmux = <PIN_PA22__SDMMC1_CK>,
+							 <PIN_PA30__SDMMC1_CD>;
+						bias-disable;
+					};
+				};
+
+				pinctrl_spi0_default: spi0_default {
+					pinmux = <PIN_PA14__SPI0_SPCK>,
+						 <PIN_PA15__SPI0_MOSI>,
+						 <PIN_PA16__SPI0_MISO>,
+						 <PIN_PA17__SPI0_NPCS0>;
+					bias-disable;
+				};
+
+				pinctrl_uart1_default: uart1_default {
+					pinmux = <PIN_PD2__URXD1>,
+						 <PIN_PD3__UTXD1>;
+					bias-disable;
+				};
+
+				pinctrl_uart3_default: uart3_default {
+					pinmux = <PIN_PB11__URXD3>,
+						 <PIN_PB12__UTXD3>;
+					bias-disable;
+				};
+
+				pinctrl_usb_default: usb_default {
+					pinmux = <PIN_PB10>;
+					bias-disable;
+				};
+
+				pinctrl_usba_vbus: usba_vbus {
+					conf-vbus_input {
+						pinmux = <PIN_PB9>;
+						bias-disable;
+						output-low;
+					};
+
+					conf-vbus_irq {
+						pinmux = <PIN_PA31>;
+						bias-disable;
+					};
+				};
+
+				pinctrl_i2c1_default: i2c1_default {
+					pinmux = <PIN_PD4__TWD1>,
+						 <PIN_PD5__TWCK1>;
+					bias-disable;
+				};
+			};
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_key_gpio_default>;
+
+		bp1 {
+			label = "PB_USER";
+			gpios = <&pioA 38 GPIO_ACTIVE_LOW>;
+			linux,code = <0x104>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_led_gpio_default>;
+		status = "okay";
+
+		green {
+			label = "green";
+			gpios = <&pioA 37 GPIO_ACTIVE_LOW>;
+		};
+
+		blue {
+			label = "blue";
+			gpios = <&pioA 32 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
new file mode 100644
index 0000000..710b3e4
--- /dev/null
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -0,0 +1,1076 @@
+/*
+ * sama5d2.dtsi - Device Tree Include file for SAMA5D2 family SoC
+ *
+ *  Copyright (C) 2015 Atmel,
+ *                2015 Ludovic Desroches <ludovic.desroches@atmel.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "skeleton.dtsi"
+#include <dt-bindings/dma/at91.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/at91.h>
+
+/ {
+	model = "Atmel SAMA5D2 family SoC";
+	compatible = "atmel,sama5d2";
+	interrupt-parent = <&aic>;
+
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart3;
+		tcb0 = &tcb0;
+		tcb1 = &tcb1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a5";
+			reg = <0>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	memory {
+		reg = <0x20000000 0x20000000>;
+	};
+
+	clocks {
+		slow_xtal: slow_xtal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+		};
+
+		main_xtal: main_xtal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+		};
+
+		adc_op_clk: adc_op_clk{
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <1000000>;
+		};
+	};
+
+	ns_sram: sram at 00200000 {
+		compatible = "mmio-sram";
+		reg = <0x00200000 0x20000>;
+	};
+
+	ahb {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		usb0: gadget at 00300000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "atmel,sama5d3-udc";
+			reg = <0x00300000 0x100000
+			       0xfc02c000 0x400>;
+			interrupts = <42 IRQ_TYPE_LEVEL_HIGH 2>;
+			clocks = <&udphs_clk>, <&utmi>;
+			clock-names = "pclk", "hclk";
+			status = "disabled";
+
+			ep0 {
+				reg = <0>;
+				atmel,fifo-size = <64>;
+				atmel,nb-banks = <1>;
+			};
+
+			ep1 {
+				reg = <1>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <3>;
+				atmel,can-dma;
+				atmel,can-isoc;
+			};
+
+			ep2 {
+				reg = <2>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <3>;
+				atmel,can-dma;
+				atmel,can-isoc;
+			};
+
+			ep3 {
+				reg = <3>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <2>;
+				atmel,can-dma;
+				atmel,can-isoc;
+			};
+
+			ep4 {
+				reg = <4>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <2>;
+				atmel,can-dma;
+				atmel,can-isoc;
+			};
+
+			ep5 {
+				reg = <5>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <2>;
+				atmel,can-dma;
+				atmel,can-isoc;
+			};
+
+			ep6 {
+				reg = <6>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <2>;
+				atmel,can-dma;
+				atmel,can-isoc;
+			};
+
+			ep7 {
+				reg = <7>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <2>;
+				atmel,can-dma;
+				atmel,can-isoc;
+			};
+
+			ep8 {
+				reg = <8>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <2>;
+				atmel,can-isoc;
+			};
+
+			ep9 {
+				reg = <9>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <2>;
+				atmel,can-isoc;
+			};
+
+			ep10 {
+				reg = <10>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <2>;
+				atmel,can-isoc;
+			};
+
+			ep11 {
+				reg = <11>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <2>;
+				atmel,can-isoc;
+			};
+
+			ep12 {
+				reg = <12>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <2>;
+				atmel,can-isoc;
+			};
+
+			ep13 {
+				reg = <13>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <2>;
+				atmel,can-isoc;
+			};
+
+			ep14 {
+				reg = <14>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <2>;
+				atmel,can-isoc;
+			};
+
+			ep15 {
+				reg = <15>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <2>;
+				atmel,can-isoc;
+			};
+		};
+
+		usb1: ohci at 00400000 {
+			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
+			reg = <0x00400000 0x100000>;
+			interrupts = <41 IRQ_TYPE_LEVEL_HIGH 2>;
+			clocks = <&uhphs_clk>, <&uhphs_clk>, <&uhpck>;
+			clock-names = "ohci_clk", "hclk", "uhpck";
+			status = "disabled";
+		};
+
+		usb2: ehci at 00500000 {
+			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
+			reg = <0x00500000 0x100000>;
+			interrupts = <41 IRQ_TYPE_LEVEL_HIGH 2>;
+			clocks = <&utmi>, <&uhphs_clk>;
+			clock-names = "usb_clk", "ehci_clk";
+			status = "disabled";
+		};
+
+		L2: cache-controller at 00a00000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x00a00000 0x1000>;
+			interrupts = <63 IRQ_TYPE_LEVEL_HIGH 4>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		sdmmc0: sdio-host at a0000000 {
+			compatible = "atmel,sama5d2-sdhci";
+			reg = <0xa0000000 0x300>;
+			interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&sdmmc0_hclk>, <&sdmmc0_gclk>, <&main>;
+			clock-names = "hclock", "multclk", "baseclk";
+			status = "disabled";
+		};
+
+		sdmmc1: sdio-host at b0000000 {
+			compatible = "atmel,sama5d2-sdhci";
+			reg = <0xb0000000 0x300>;
+			interrupts = <32 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&sdmmc1_hclk>, <&sdmmc1_gclk>, <&main>;
+			clock-names = "hclock", "multclk", "baseclk";
+			status = "disabled";
+		};
+
+		apb {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			hlcdc: hlcdc at f0000000 {
+				compatible = "atmel,sama5d2-hlcdc";
+				reg = <0xf0000000 0x2000>;
+				interrupts = <45 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
+				clock-names = "periph_clk","sys_clk", "slow_clk";
+				status = "disabled";
+
+				hlcdc-display-controller {
+					compatible = "atmel,hlcdc-display-controller";
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port at 0 {
+						#address-cells = <1>;
+						#size-cells = <0>;
+						reg = <0>;
+					};
+				};
+
+				hlcdc_pwm: hlcdc-pwm {
+					compatible = "atmel,hlcdc-pwm";
+					#pwm-cells = <3>;
+				};
+			};
+
+			ramc0: ramc at f000c000 {
+				compatible = "atmel,sama5d3-ddramc";
+				reg = <0xf000c000 0x200>;
+				clocks = <&ddrck>, <&mpddr_clk>;
+				clock-names = "ddrck", "mpddr";
+			};
+
+			dma0: dma-controller at f0010000 {
+				compatible = "atmel,sama5d4-dma";
+				reg = <0xf0010000 0x1000>;
+				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 0>;
+				#dma-cells = <1>;
+				clocks = <&dma0_clk>;
+				clock-names = "dma_clk";
+			};
+
+			pmc: pmc at f0014000 {
+				compatible = "atmel,sama5d2-pmc";
+				reg = <0xf0014000 0x160>;
+				interrupts = <74 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupt-controller;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#interrupt-cells = <1>;
+
+				main_rc_osc: main_rc_osc {
+					compatible = "atmel,at91sam9x5-clk-main-rc-osc";
+					#clock-cells = <0>;
+					interrupt-parent = <&pmc>;
+					interrupts = <AT91_PMC_MOSCRCS>;
+					clock-frequency = <12000000>;
+					clock-accuracy = <100000000>;
+				};
+
+				main_osc: main_osc {
+					compatible = "atmel,at91rm9200-clk-main-osc";
+					#clock-cells = <0>;
+					interrupt-parent = <&pmc>;
+					interrupts = <AT91_PMC_MOSCS>;
+					clocks = <&main_xtal>;
+				};
+
+				main: mainck {
+					compatible = "atmel,at91sam9x5-clk-main";
+					#clock-cells = <0>;
+					interrupt-parent = <&pmc>;
+					interrupts = <AT91_PMC_MOSCSELS>;
+					clocks = <&main_rc_osc &main_osc>;
+				};
+
+				plla: pllack {
+					compatible = "atmel,sama5d3-clk-pll";
+					#clock-cells = <0>;
+					interrupt-parent = <&pmc>;
+					interrupts = <AT91_PMC_LOCKA>;
+					clocks = <&main>;
+					reg = <0>;
+					atmel,clk-input-range = <12000000 12000000>;
+					#atmel,pll-clk-output-range-cells = <4>;
+					atmel,pll-clk-output-ranges = <600000000 1200000000 0 0>;
+				};
+
+				plladiv: plladivck {
+					compatible = "atmel,at91sam9x5-clk-plldiv";
+					#clock-cells = <0>;
+					clocks = <&plla>;
+				};
+
+				utmi: utmick {
+					compatible = "atmel,at91sam9x5-clk-utmi";
+					#clock-cells = <0>;
+					interrupt-parent = <&pmc>;
+					interrupts = <AT91_PMC_LOCKU>;
+					clocks = <&main>;
+				};
+
+				mck: masterck {
+					compatible = "atmel,at91sam9x5-clk-master";
+					#clock-cells = <0>;
+					interrupt-parent = <&pmc>;
+					interrupts = <AT91_PMC_MCKRDY>;
+					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>;
+					atmel,clk-output-range = <124000000 166000000>;
+					atmel,clk-divisors = <1 2 4 3>;
+				};
+
+				h32ck: h32mxck {
+					#clock-cells = <0>;
+					compatible = "atmel,sama5d4-clk-h32mx";
+					clocks = <&mck>;
+				};
+
+				usb: usbck {
+					compatible = "atmel,at91sam9x5-clk-usb";
+					#clock-cells = <0>;
+					clocks = <&plladiv>, <&utmi>;
+				};
+
+				prog: progck {
+					compatible = "atmel,at91sam9x5-clk-programmable";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					interrupt-parent = <&pmc>;
+					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>;
+
+					prog0: prog0 {
+						#clock-cells = <0>;
+						reg = <0>;
+						interrupts = <AT91_PMC_PCKRDY(0)>;
+					};
+
+					prog1: prog1 {
+						#clock-cells = <0>;
+						reg = <1>;
+						interrupts = <AT91_PMC_PCKRDY(1)>;
+					};
+
+					prog2: prog2 {
+						#clock-cells = <0>;
+						reg = <2>;
+						interrupts = <AT91_PMC_PCKRDY(2)>;
+					};
+				};
+
+				systemck {
+					compatible = "atmel,at91rm9200-clk-system";
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					ddrck: ddrck {
+						#clock-cells = <0>;
+						reg = <2>;
+						clocks = <&mck>;
+					};
+
+					lcdck: lcdck {
+						#clock-cells = <0>;
+						reg = <3>;
+						clocks = <&mck>;
+					};
+
+					uhpck: uhpck {
+						#clock-cells = <0>;
+						reg = <6>;
+						clocks = <&usb>;
+					};
+
+					udpck: udpck {
+						#clock-cells = <0>;
+						reg = <7>;
+						clocks = <&usb>;
+					};
+
+					pck0: pck0 {
+						#clock-cells = <0>;
+						reg = <8>;
+						clocks = <&prog0>;
+					};
+
+					pck1: pck1 {
+						#clock-cells = <0>;
+						reg = <9>;
+						clocks = <&prog1>;
+					};
+
+					pck2: pck2 {
+						#clock-cells = <0>;
+						reg = <10>;
+						clocks = <&prog2>;
+					};
+
+					iscck: iscck {
+						#clock-cells = <0>;
+						reg = <18>;
+						clocks = <&mck>;
+					};
+				};
+
+				periph32ck {
+					compatible = "atmel,at91sam9x5-clk-peripheral";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					clocks = <&h32ck>;
+
+					macb0_clk: macb0_clk {
+						#clock-cells = <0>;
+						reg = <5>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					tdes_clk: tdes_clk {
+						#clock-cells = <0>;
+						reg = <11>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					matrix1_clk: matrix1_clk {
+						#clock-cells = <0>;
+						reg = <14>;
+					};
+
+					hsmc_clk: hsmc_clk {
+						#clock-cells = <0>;
+						reg = <17>;
+					};
+
+					pioA_clk: pioA_clk {
+						#clock-cells = <0>;
+						reg = <18>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					flx0_clk: flx0_clk {
+						#clock-cells = <0>;
+						reg = <19>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					flx1_clk: flx1_clk {
+						#clock-cells = <0>;
+						reg = <20>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					flx2_clk: flx2_clk {
+						#clock-cells = <0>;
+						reg = <21>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					flx3_clk: flx3_clk {
+						#clock-cells = <0>;
+						reg = <22>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					flx4_clk: flx4_clk {
+						#clock-cells = <0>;
+						reg = <23>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					uart0_clk: uart0_clk {
+						#clock-cells = <0>;
+						reg = <24>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					uart1_clk: uart1_clk {
+						#clock-cells = <0>;
+						reg = <25>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					uart2_clk: uart2_clk {
+						#clock-cells = <0>;
+						reg = <26>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					uart3_clk: uart3_clk {
+						#clock-cells = <0>;
+						reg = <27>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					uart4_clk: uart4_clk {
+						#clock-cells = <0>;
+						reg = <28>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					twi0_clk: twi0_clk {
+						reg = <29>;
+						#clock-cells = <0>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					twi1_clk: twi1_clk {
+						#clock-cells = <0>;
+						reg = <30>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					spi0_clk: spi0_clk {
+						#clock-cells = <0>;
+						reg = <33>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					spi1_clk: spi1_clk {
+						#clock-cells = <0>;
+						reg = <34>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					tcb0_clk: tcb0_clk {
+						#clock-cells = <0>;
+						reg = <35>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					tcb1_clk: tcb1_clk {
+						#clock-cells = <0>;
+						reg = <36>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					pwm_clk: pwm_clk {
+						#clock-cells = <0>;
+						reg = <38>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					adc_clk: adc_clk {
+						#clock-cells = <0>;
+						reg = <40>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					uhphs_clk: uhphs_clk {
+						#clock-cells = <0>;
+						reg = <41>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					udphs_clk: udphs_clk {
+						#clock-cells = <0>;
+						reg = <42>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					ssc0_clk: ssc0_clk {
+						#clock-cells = <0>;
+						reg = <43>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					ssc1_clk: ssc1_clk {
+						#clock-cells = <0>;
+						reg = <44>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					trng_clk: trng_clk {
+						#clock-cells = <0>;
+						reg = <47>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+				};
+
+				periph64ck {
+					compatible = "atmel,at91sam9x5-clk-peripheral";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					clocks = <&mck>;
+
+					dma0_clk: dma0_clk {
+						#clock-cells = <0>;
+						reg = <6>;
+					};
+
+					dma1_clk: dma1_clk {
+						#clock-cells = <0>;
+						reg = <7>;
+					};
+
+					aes_clk: aes_clk {
+						#clock-cells = <0>;
+						reg = <9>;
+					};
+
+					aesb_clk: aesb_clk {
+						#clock-cells = <0>;
+						reg = <10>;
+					};
+
+					sha_clk: sha_clk {
+						#clock-cells = <0>;
+						reg = <12>;
+					};
+
+					mpddr_clk: mpddr_clk {
+						#clock-cells = <0>;
+						reg = <13>;
+					};
+
+					matrix0_clk: matrix0_clk {
+						#clock-cells = <0>;
+						reg = <15>;
+					};
+
+					sdmmc0_hclk: sdmmc0_hclk {
+						#clock-cells = <0>;
+						reg = <31>;
+					};
+
+					sdmmc1_hclk: sdmmc1_hclk {
+						#clock-cells = <0>;
+						reg = <32>;
+					};
+
+					lcdc_clk: lcdc_clk {
+						#clock-cells = <0>;
+						reg = <45>;
+					};
+
+					isc_clk: isc_clk {
+						#clock-cells = <0>;
+						reg = <46>;
+					};
+				};
+
+				gck {
+					compatible = "atmel,sama5d2-clk-generated";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					interrupt-parent = <&pmc>;
+					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>;
+
+					sdmmc0_gclk: sdmmc0_gclk {
+						#clock-cells = <0>;
+						reg = <31>;
+					};
+
+					sdmmc1_gclk: sdmmc1_gclk {
+						#clock-cells = <0>;
+						reg = <32>;
+					};
+
+					tcb0_gclk: tcb0_gclk {
+						#clock-cells = <0>;
+						reg = <35>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					tcb1_gclk: tcb1_gclk {
+						#clock-cells = <0>;
+						reg = <36>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					pwm_gclk: pwm_gclk {
+						#clock-cells = <0>;
+						reg = <38>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+				};
+			};
+
+			sha at f0028000 {
+				compatible = "atmel,at91sam9g46-sha";
+				reg = <0xf0028000 0x100>;
+				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(31))>;
+				dma-names = "tx";
+				clocks = <&sha_clk>;
+				clock-names = "sha_clk";
+				status = "disabled";
+			};
+
+			aes at f002c000 {
+				compatible = "atmel,at91sam9g46-aes";
+				reg = <0xf002c000 0x100>;
+				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 0>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(27))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(28))>;
+				dma-names = "tx", "rx";
+				clocks = <&aes_clk>;
+				clock-names = "aes_clk";
+				status = "disabled";
+			};
+
+			spi0: spi at f8000000 {
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xf8000000 0x100>;
+				interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(6))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(7))>;
+				dma-names = "tx", "rx";
+				clocks = <&spi0_clk>;
+				clock-names = "spi_clk";
+				atmel,fifo-size = <16>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			macb0: ethernet at f8008000 {
+				compatible = "atmel,sama5d2-gem";
+				reg = <0xf8008000 0x1000>;
+				interrupts = <5  IRQ_TYPE_LEVEL_HIGH 3		/* Queue 0 */
+					      66 IRQ_TYPE_LEVEL_HIGH 3          /* Queue 1 */
+					      67 IRQ_TYPE_LEVEL_HIGH 3>;        /* Queue 2 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&macb0_clk>, <&macb0_clk>;
+				clock-names = "hclk", "pclk";
+				status = "disabled";
+			};
+
+			tcb0: timer at f800c000 {
+				compatible = "atmel,at91sam9x5-tcb";
+				reg = <0xf800c000 0x100>;
+				interrupts = <35 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&tcb0_clk>;
+				clock-names = "t0_clk";
+			};
+
+			tcb1: timer at f8010000 {
+				compatible = "atmel,at91sam9x5-tcb";
+				reg = <0xf8010000 0x100>;
+				interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&tcb1_clk>;
+				clock-names = "t0_clk";
+			};
+
+			uart0: serial at f801c000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xf801c000 0x100>;
+				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&uart0_clk>;
+				clock-names = "usart";
+				status = "disabled";
+			};
+
+			uart1: serial at f8020000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xf8020000 0x100>;
+				interrupts = <25 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&uart1_clk>;
+				clock-names = "usart";
+				status = "disabled";
+			};
+
+			uart2: serial at f8024000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xf8024000 0x100>;
+				interrupts = <26 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&uart2_clk>;
+				clock-names = "usart";
+				status = "disabled";
+			};
+
+			i2c0: i2c at f8028000 {
+				compatible = "atmel,sama5d2-i2c";
+				reg = <0xf8028000 0x100>;
+				interrupts = <29 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(0))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(1))>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&twi0_clk>;
+				status = "disabled";
+			};
+
+			flx0: flexcom at f8034000 {
+				compatible = "atmel,sama5d2-flexcom";
+				reg = <0xf8034000 0x200>;
+				clocks = <&flx0_clk>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0xf8034000 0x800>;
+				status = "disabled";
+			};
+
+			flx1: flexcom at f8038000 {
+				compatible = "atmel,sama5d2-flexcom";
+				reg = <0xf8038000 0x200>;
+				clocks = <&flx1_clk>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0xf8038000 0x800>;
+				status = "disabled";
+			};
+
+			rstc at f8048000 {
+				compatible = "atmel,sama5d3-rstc";
+				reg = <0xf8048000 0x10>;
+			};
+
+			shdwc at f8048010 {
+				compatible = "atmel,sama5d2-shdwc";
+				reg = <0xf8048010 0x10>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				atmel,wakeup-rtc-timer;
+			};
+
+			pit: timer at f8048030 {
+				compatible = "atmel,at91sam9260-pit";
+				reg = <0xf8048030 0x10>;
+				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 5>;
+				clocks = <&h32ck>;
+			};
+
+			watchdog at f8048040 {
+				compatible = "atmel,at91sam9260-wdt";
+				reg = <0xf8048040 0x10>;
+				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 7>;
+				status = "disabled";
+			};
+
+			sckc at f8048050 {
+				compatible = "atmel,at91sam9x5-sckc";
+				reg = <0xf8048050 0x4>;
+
+				slow_rc_osc: slow_rc_osc {
+					compatible = "atmel,at91sam9x5-clk-slow-rc-osc";
+					#clock-cells = <0>;
+					clock-frequency = <32768>;
+					clock-accuracy = <250000000>;
+					atmel,startup-time-usec = <75>;
+				};
+
+				slow_osc: slow_osc {
+					compatible = "atmel,at91sam9x5-clk-slow-osc";
+					#clock-cells = <0>;
+					clocks = <&slow_xtal>;
+					atmel,startup-time-usec = <1200000>;
+				};
+
+				clk32k: slowck {
+					compatible = "atmel,at91sam9x5-clk-slow";
+					#clock-cells = <0>;
+					clocks = <&slow_rc_osc &slow_osc>;
+				};
+			};
+
+			rtc at f80480b0 {
+				compatible = "atmel,at91rm9200-rtc";
+				reg = <0xf80480b0 0x30>;
+				interrupts = <74 IRQ_TYPE_LEVEL_HIGH 7>;
+			};
+
+			spi1: spi at fc000000 {
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfc000000 0x100>;
+				interrupts = <34 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(8))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(9))>;
+				dma-names = "tx", "rx";
+				clocks = <&spi1_clk>;
+				clock-names = "spi_clk";
+				atmel,fifo-size = <16>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart3: serial at fc008000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xfc008000 0x100>;
+				interrupts = <27 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&uart3_clk>;
+				clock-names = "usart";
+				status = "disabled";
+			};
+
+			uart4: serial at fc00c000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xfc00c000 0x100>;
+				interrupts = <28 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&uart4_clk>;
+				clock-names = "usart";
+				status = "disabled";
+			};
+
+			flx2: flexcom at fc010000 {
+				compatible = "atmel,sama5d2-flexcom";
+				reg = <0xfc010000 0x200>;
+				clocks = <&flx2_clk>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0xfc010000 0x800>;
+				status = "disabled";
+			};
+
+			flx3: flexcom at fc014000 {
+				compatible = "atmel,sama5d2-flexcom";
+				reg = <0xfc014000 0x200>;
+				clocks = <&flx3_clk>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0xfc014000 0x800>;
+				status = "disabled";
+			};
+
+			flx4: flexcom at fc018000 {
+				compatible = "atmel,sama5d2-flexcom";
+				reg = <0xfc018000 0x200>;
+				clocks = <&flx4_clk>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0xfc018000 0x800>;
+				status = "disabled";
+			};
+
+			aic: interrupt-controller at fc020000 {
+				#interrupt-cells = <3>;
+				compatible = "atmel,sama5d4-aic";
+				interrupt-controller;
+				reg = <0xfc020000 0x200>;
+				atmel,external-irqs = <49>;
+			};
+
+			i2c1: i2c at fc028000 {
+				compatible = "atmel,sama5d2-i2c";
+				reg = <0xfc028000 0x100>;
+				interrupts = <30 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(2))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(3))>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&twi1_clk>;
+				status = "disabled";
+			};
+
+			pioA: pinctrl at fc038000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "atmel,sama5d2-pinctrl", "simple-bus";
+				reg = <0xfc038000 0x600>;
+				interrupts = <18 IRQ_TYPE_LEVEL_HIGH 7>,
+					     <68 IRQ_TYPE_LEVEL_HIGH 7>,
+					     <69 IRQ_TYPE_LEVEL_HIGH 7>,
+					     <70 IRQ_TYPE_LEVEL_HIGH 7>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				clocks = <&pioA_clk>;
+			};
+		};
+	};
+};
-- 
2.5.0
