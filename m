From: marex@denx.de (Marek Vasut)
Date: Sun,  8 May 2016 22:50:21 +0200
Subject: [PATCH V2 4/4] ARM: mxs: dts: Add SanDisk Sansa Fuze+ support
In-Reply-To: <1462740621-7557-1-git-send-email-marex@denx.de>
References: <1462740621-7557-1-git-send-email-marex@denx.de>
Message-ID: <1462740621-7557-4-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Vasut <marek.vasut@gmail.com>

Add support for this small MP3 player based on STMP3780 (rev.3).
Currently supported are both external microSD and internal SD-NAND
bridge, PWM and USB gadget.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
---
V2: - Drop the address part from the license
---
 arch/arm/boot/dts/Makefile        |   1 +
 arch/arm/boot/dts/imx23-sansa.dts | 211 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 212 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx23-sansa.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7a79d37..eaa8048 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -416,6 +416,7 @@ dtb-$(CONFIG_SOC_VF610) += \
 dtb-$(CONFIG_ARCH_MXS) += \
 	imx23-evk.dtb \
 	imx23-olinuxino.dtb \
+	imx23-sansa.dtb \
 	imx23-stmp378x_devb.dtb \
 	imx23-xfi3.dtb \
 	imx28-apf28.dtb \
diff --git a/arch/arm/boot/dts/imx23-sansa.dts b/arch/arm/boot/dts/imx23-sansa.dts
new file mode 100644
index 0000000..c7b0ff4
--- /dev/null
+++ b/arch/arm/boot/dts/imx23-sansa.dts
@@ -0,0 +1,211 @@
+/*
+ * Copyright (C) 2013-2016 Marek Vasut <marek.vasut@gmail.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
+ *     the License, or (at your option) any later version.
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
+ *
+ */
+
+/dts-v1/;
+#include "imx23.dtsi"
+
+/ {
+	model = "SanDisk Sansa Fuze+";
+	compatible = "sandisk,sansa_fuze_plus", "fsl,imx23";
+
+	memory {
+		reg = <0x40000000 0x04000000>;
+	};
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			ssp0: ssp at 80010000 {
+				compatible = "fsl,imx23-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc0_4bit_pins_a &mmc0_pins_fixup>;
+				bus-width = <4>;
+				vmmc-supply = <&reg_vddio_sd0>;
+				cd-inverted;
+				status = "okay";
+			};
+
+			ssp1: ssp at 80034000 {
+				compatible = "fsl,imx23-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc1_8bit_pins_a>;
+				bus-width = <8>;
+				vmmc-supply = <&reg_vddio_sd1>;
+				non-removable;
+				status = "okay";
+			};
+
+			pinctrl at 80018000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&hog_pins_a>;
+
+				hog_pins_a: hog at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX23_PAD_GPMI_D08__GPIO_0_8
+						MX23_PAD_PWM3__GPIO_1_29
+						MX23_PAD_AUART1_RTS__GPIO_0_27
+						MX23_PAD_AUART1_CTS__GPIO_0_26
+						MX23_PAD_I2C_SCL__I2C_SCL
+						MX23_PAD_I2C_SDA__I2C_SDA
+						MX23_PAD_LCD_DOTCK__GPIO_1_22
+						MX23_PAD_LCD_HSYNC__GPIO_1_24
+						MX23_PAD_PWM3__GPIO_1_29
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+			};
+		};
+
+		apbx at 80040000 {
+			pwm: pwm at 80064000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pwm2_pins_a>;
+				status = "okay";
+			};
+
+			duart: serial at 80070000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&duart_pins_a>;
+				status = "okay";
+			};
+
+			usbphy0: usbphy at 8007c000 {
+				status = "okay";
+			};
+
+			lradc at 80050000 {
+				status = "okay";
+			};
+		};
+	};
+
+	ahb at 80080000 {
+		usb0: usb at 80080000 {
+			dr_mode = "peripheral";
+			status = "okay";
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_vddio_sd0: vddio-sd0 {
+			compatible = "regulator-fixed";
+			regulator-name = "vddio-sd0";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio0 8 0>;
+		};
+
+		reg_vddio_sd1: vddio-sd1 {
+			compatible = "regulator-fixed";
+			regulator-name = "vddio-sd1";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio1 29 0>;
+		};
+
+		reg_vdd_touchpad: vdd-touchpad0 {
+			compatible = "regulator-fixed";
+			regulator-name = "vdd-touchpad0";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio0 26 0>;
+			regulator-always-on;
+			enable-active-low;
+		};
+
+		reg_vdd_tuner: vdd-tuner0 {
+			compatible = "regulator-fixed";
+			regulator-name = "vdd-tuner0";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio0 29 0>;
+			regulator-always-on;
+			enable-active-low;
+		};
+	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 2 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
+
+	i2c at 0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "i2c-gpio";
+		gpios = <
+			&gpio1 24 0		/* SDA */
+			&gpio1 22 0		/* SCL */
+		>;
+		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
+	};
+
+	i2c at 1 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "i2c-gpio";
+		gpios = <
+			&gpio0 31 0		/* SDA */
+			&gpio0 30 0		/* SCL */
+		>;
+		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
+
+		touch: touch at 20 {
+			compatible = "synaptics,synaptics_i2c";
+			reg = <0x20>;
+		};
+
+		eeprom: eeprom at 50 {
+			compatible = "atmel,24c64";
+			reg = <0x50>;
+			pagesize = <32>;
+		};
+	};
+
+};
-- 
2.7.0
