From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 17 Dec 2015 11:19:19 +0100
Subject: [PATCH v3] ARM: at91/dt: Add Support for the L+G VInCo platform
Message-ID: <1450347559-16150-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Versatile Industrial Communication platform is a community oriented
board from Landis + Gyr. It comes with:
      - an RS-485 port
      - 2 Ethernet ports
      - a wireless M-BUS
      - a 4G modem
      - a 4MB SPI flash
      - a 4GB eMMC

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
Changelog

v2 -> v3:
- removed bootargs pointed by Alexandre Belloni
- removed leftovers clock definition pointed by Alexandre Belloni

v1 -> v2:
- Fixed rtc compatible name from "rx8900" to "epson,rx8900" as pointed
by Alexandre Belloni


 arch/arm/boot/dts/Makefile       |   3 +-
 arch/arm/boot/dts/at91-vinco.dts | 256 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 258 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/at91-vinco.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 30bbc37..75562ab 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -49,7 +49,8 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
 	sama5d35ek.dtb \
 	sama5d36ek.dtb \
 	at91-sama5d4_xplained.dtb \
-	at91-sama5d4ek.dtb
+	at91-sama5d4ek.dtb \
+	at91-vinco.dtb
 dtb-$(CONFIG_ARCH_ATLAS6) += \
 	atlas6-evb.dtb
 dtb-$(CONFIG_ARCH_ATLAS7) += \
diff --git a/arch/arm/boot/dts/at91-vinco.dts b/arch/arm/boot/dts/at91-vinco.dts
new file mode 100644
index 0000000..79aec55
--- /dev/null
+++ b/arch/arm/boot/dts/at91-vinco.dts
@@ -0,0 +1,256 @@
+/*
+ * Device Tree file for VInCo platform
+ *
+ *  Copyright (C) 2014 Atmel,
+ *                2014 Nicolas Ferre <nicolas.ferre@atmel.com>
+ *   2015 Gregory CLEMENT <gregory.clement@free-electrons.com>
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
+#include "sama5d4.dtsi"
+
+/ {
+	model = "L+G VInCo platform";
+	compatible = "l+g,vinco", "atmel,sama5d4", "atmel,sama5";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		reg = <0x20000000 0x4000000>;
+	};
+
+	clocks {
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
+		apb {
+
+			adc0: adc at fc034000 {
+				status = "okay"; /* Enable ADC IIO support */
+			};
+
+			mmc0: mmc at f8000000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_mmc0_clk_cmd_dat0
+					     &pinctrl_mmc0_dat1_3
+					     &pinctrl_mmc0_dat4_7>;
+				vqmmc-supply = <&vcc_3v3_reg>;
+				vmmc-supply = <&vcc_3v3_reg>;
+				no-1-8-v;
+				status = "okay";
+				slot at 0 {
+					reg = <0>;
+					bus-width = <8>;
+					non-removable;
+					broken-cd;
+					status = "okay";
+				};
+			};
+
+			spi0: spi at f8010000 {
+				cs-gpios = <&pioC 3 0>, <0>, <0>, <0>;
+				status = "okay";
+				m25p80 at 0 {
+					compatible = "n25q32b", "jedec,spi-nor";
+					spi-max-frequency = <50000000>;
+					reg = <0>;
+				};
+			};
+
+			i2c0: i2c at f8014000 {
+				status = "okay";
+			};
+
+			i2c1: i2c at f8018000 {
+				status = "okay";
+				/* kerkey security module */
+			};
+
+			macb0: ethernet at f8020000 {
+				phy-mode = "rmii";
+				status = "okay";
+
+				ethernet-phy at 1 {
+					reg = <0x1>;
+					reset-gpios = <&pioE 8 GPIO_ACTIVE_HIGH>;
+					interrupt-parent = <&pioB>;
+					interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
+				};
+
+			};
+
+			i2c2: i2c at f8024000 {
+				status = "okay";
+
+				rtc1: rtc at 64 {
+					compatible = "epson,rx8900";
+					reg = <0x32>;
+				};
+			};
+
+			usart2: serial at fc008000 {
+				/* MBUS */
+				status = "okay";
+			};
+
+			usart3: serial at fc00c000 {
+				/* debug */
+				status = "okay";
+			};
+
+			usart4: serial at fc010000 {
+				/* LMN */
+				pinctrl-0 = <&pinctrl_usart4 &pinctrl_usart4_rts>;
+				linux,rs485-enabled-at-boot-time;
+				status = "okay";
+			};
+
+			macb1: ethernet at fc028000 {
+				phy-mode = "rmii";
+				status = "okay";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "okay";
+
+				ethernet-phy at 1 {
+					reg = <0x1>;
+					interrupt-parent = <&pioB>;
+					interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
+					reset-gpios = <&pioE 6 GPIO_ACTIVE_HIGH>;
+				};
+			};
+
+			watchdog at fc068640 {
+				status = "okay";
+			};
+
+			pinctrl at fc06a000 {
+				board {
+					pinctrl_usba_vbus: usba_vbus {
+						atmel,pins =
+						<AT91_PIOE 31 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;
+					};
+				};
+			};
+		};
+
+		usb0: gadget at 00400000 {
+			atmel,vbus-gpio = <&pioE 31 GPIO_ACTIVE_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usba_vbus>;
+			status = "disable";
+		};
+
+		usb1: ohci at 00500000 {
+			num-ports = <3>;
+			atmel,vbus-gpio = <0
+					   &pioE 11 GPIO_ACTIVE_LOW
+					   &pioE 12 GPIO_ACTIVE_LOW
+					  >;
+			status = "disable";
+		};
+
+		usb2: ehci at 00600000 {
+			/* 4G Modem */
+			status = "okay";
+		};
+
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		status = "okay";
+
+		led_err {
+			label = "err";
+			gpios = <&pioA 7 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led_rssi {
+			label = "rssi";
+			gpios = <&pioA 9 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led_tls {
+			label = "tls";
+			gpios = <&pioA 24 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led_lmc {
+			label = "lmc";
+			gpios = <&pioA 25 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led_wmt {
+			label = "wmt";
+			gpios = <&pioA 29 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led_pwr {
+			label = "pwr";
+			gpios = <&pioA 26 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+	};
+
+	vcc_3v3_reg: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC 3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
-- 
2.5.0
