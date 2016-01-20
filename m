From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 20 Jan 2016 13:35:37 +0100
Subject: [PATCH 3/3] ARM: dts: sama5d4: add support for Ka-Ro electronics TXA5
 modules
In-Reply-To: <1453293337-16078-1-git-send-email-LW@KARO-electronics.de>
References: <1453293337-16078-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1453293337-16078-4-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TXA5-5010/-5011 are Computers On Module manufactured by
  Ka-Ro electronics GmbH with the following characteristics:
  Processor    Atmel SAMA5D42, 528 MHz
  RAM          256MB 32-bit DDR2 SDRAM
  ROM          128MB NAND Flash (TXA5-5010) / 4GB eMMC (TXA5-5011)
  Power supply Single 3.1V to 5.5V
  Size         26mm SO-DIMM
  Temp. Range  -40?C/-25?C to 85?C

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/Makefile                   |   1 +
 arch/arm/boot/dts/at91-sama5d4-txa5-5010.dts | 217 +++++++++++++++++++++++++++
 2 files changed, 218 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-sama5d4-txa5-5010.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a4a6d70..8fbc0cb 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -49,6 +49,7 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
 	sama5d35ek.dtb \
 	sama5d36ek.dtb \
 	at91-sama5d4_ma5d4evk.dtb \
+	at91-sama5d4-txa5-5010.dtb \
 	at91-sama5d4_xplained.dtb \
 	at91-sama5d4ek.dtb \
 	at91-vinco.dtb
diff --git a/arch/arm/boot/dts/at91-sama5d4-txa5-5010.dts b/arch/arm/boot/dts/at91-sama5d4-txa5-5010.dts
new file mode 100644
index 0000000..fb4a253
--- /dev/null
+++ b/arch/arm/boot/dts/at91-sama5d4-txa5-5010.dts
@@ -0,0 +1,217 @@
+/*
+ * at91-sama5d4-txa5.dts - Device Tree file for Ka-Ro electronics TXA5 module
+ *
+ *  Copyright (C) 2015 Lothar Wa?mann <LW@KARO-electronics.de>
+ *  based on: at91-sama5d4_xplained.dts
+ *            Copyright (C) 2015 Atmel,
+ *                          2015 Josh Wu <josh.wu@atmel.com>
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
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/pwm/pwm.h>
+
+/ {
+	model = "Ka-Ro SAMA5D4 TXA5";
+	compatible = "atmel,sama5d4-txa5", "atmel,sama5d4", "atmel,sama5";
+
+	aliases {
+		display = &display;
+		ethernet0 = &macb0;
+		serial0 = &usart0;
+		serial1 = &usart1;
+		serial2 = &usart3;
+		spi0 = &spi0;
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
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&hlcdc_pwm 0 500000 PWM_POLARITY_INVERTED>;
+	};
+
+	display: display {
+		display-timings {
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		status = "okay";
+
+		heartbeat {
+			label = "heartbeat";
+			gpios = <&pioD 29 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&adc0 {
+	atmel,adc-vref = <3300>;
+	status = "okay";
+};
+
+&hlcdc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcd_rgb888>;
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&macb0 {
+	phy-mode = "rmii";
+	status = "okay";
+
+	phy0: ethernet-phy at 1 {
+		interrupt-parent = <&pioE>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		reg = <1>;
+	};
+};
+
+&main_xtal {
+	clock-frequency = <12000000>;
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mmc1_clk_cmd_dat0 &pinctrl_mmc1_dat1_3 &pinctrl_mmc1_cd>;
+	status = "okay";
+	slot at 0 {
+		reg = <0>;
+		bus-width = <4>;
+		cd-gpios = <&pioE 3 0>;
+	};
+};
+
+&nand0 {
+	nand-bus-width = <8>;
+	nand-ecc-mode = "hw";
+	nand-on-flash-bbt;
+	atmel,has-pmecc;
+	status = "okay";
+};
+
+&pinctrl {
+	sama5d4-txa5 {
+		pinctrl_mmc1_cd: mmc1-cd {
+			atmel,pins = <AT91_PIOE 6 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
+		};
+
+		pinctrl_spi0_cs: spi0 {
+			atmel,pins = <
+				AT91_PIOB 21 AT91_PERIPH_GPIO 0					/* CSPI_SS0 */
+				AT91_PIOB 22 AT91_PERIPH_GPIO 0					/* CSPI_SS1 */
+				AT91_PIOB 23 AT91_PERIPH_GPIO 0					/* CSPI_RDY */
+			>;
+		};
+
+		pinctrl_usba_vbus: usba-vbus {
+			atmel,pins = <
+				AT91_PIOE 10 AT91_PERIPH_GPIO 0					/* USBOTG_VBUSEN */
+				AT91_PIOD 8 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH	/* USBOTG_OC */
+			>;
+		};
+
+		pinctrl_usbb_vbus: usbb-vbus {
+			atmel,pins = <
+				AT91_PIOE 11 AT91_PERIPH_GPIO 0					/* USBH_VBUSEN */
+				AT91_PIOD 9 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH	/* USBH_OC */
+			>;
+		};
+	};
+};
+
+&slow_xtal {
+	clock-frequency = <32768>;
+};
+
+&spi0 {
+	cs-gpios = <&pioB 21 0>, <&pioB 22 0>, <0>, <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi0 &pinctrl_spi0_cs>;
+	status = "okay";
+};
+
+&usart0 {
+	status = "okay";
+};
+
+&usart1 {
+	status = "okay";
+};
+
+&usart3 {
+	status = "okay";
+};
+
+&usb0 {
+	atmel,vbus-gpio = <&pioE 10 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usba_vbus>;
+	status = "okay";
+};
+
+&usb1 {
+	num-ports = <1>;
+	atmel,vbus-gpio = <&pioE 11 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbb_vbus>;
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
+};
-- 
2.1.4
