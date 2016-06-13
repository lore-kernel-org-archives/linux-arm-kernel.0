From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Jun 2016 02:58:18 +0200
Subject: [PATCH 3/3] ARM: dts: add Qualcomm APQ8060-based Dragonboard
In-Reply-To: <1465779498-11339-1-git-send-email-linus.walleij@linaro.org>
References: <1465779498-11339-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1465779498-11339-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the first Dragonboard based on APQ8060 and PM8058. It
was produced in 2011 in cooperation between Qualcomm and
BSQUARE.

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts | 252 +++++++++++++++++++++++++
 2 files changed, 253 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 06b6c2d695bf..793bb14c1329 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -572,6 +572,7 @@ dtb-$(CONFIG_ARCH_PRIMA2) += \
 dtb-$(CONFIG_ARCH_OXNAS) += \
 	wd-mbwe.dtb
 dtb-$(CONFIG_ARCH_QCOM) += \
+	qcom-apq8060-dragonboard.dtb \
 	qcom-apq8064-arrow-db600c.dtb \
 	qcom-apq8064-cm-qs600.dtb \
 	qcom-apq8064-ifc6410.dtb \
diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
new file mode 100644
index 000000000000..c91af85d9ebe
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
@@ -0,0 +1,252 @@
+/*
+ * Copyright 2016 Linaro Ltd
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include "qcom-msm8660.dtsi"
+
+/ {
+	model = "Qualcomm APQ8060 Dragonboard";
+	compatible = "qcom,apq8060-dragonboard", "qcom,msm8660";
+
+	aliases {
+		serial0 = &gsbi12_serial;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+
+	/* The Fragonboard has a fixed 2.85V regulator for all SDCCs */
+	dragon_vsdcc: vsdcc-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "Dragon SDCC Power";
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+		regulator-always-on;
+	};
+
+	/* This is a levelshifter for SDCC5 */
+	dragon_vio_txb: txb0104rgyr {
+		compatible = "regulator-fixed";
+		regulator-name = "Dragon SDCC levelshifter";
+		vin-supply = <&dragon_vsdcc>;
+		regulator-always-on;
+	};
+
+	soc {
+		gsbi at 19c00000 {
+			status = "ok";
+			pinctrl-names = "default";
+			pinctrl-0 = <&dragon_serial0_pins>;
+			qcom,mode = <GSBI_PROT_I2C_UART>;
+			serial at 19c40000 {
+				status = "ok";
+			};
+		};
+	};
+};
+
+/* Intenal 3.69 GiB eMMC */
+&sdcc1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dragon_sdcc1_pins>;
+	vmmc-supply = <&dragon_vsdcc>;
+};
+
+/* External micro SD card, directly connected, pulled up to 2.85 V */
+&sdcc3 {
+	status = "okay";
+	/* Enable SSBI GPIO 22 as input, use for card detect */
+	pinctrl-names = "default";
+	pinctrl-0 = <&dragon_sdcc3_pins>, <&dragon_sdcc3_gpios>;
+	cd-gpios = <&pm8058_gpio 22 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&tlmm 110 GPIO_ACTIVE_HIGH>;
+	vmmc-supply = <&dragon_vsdcc>;
+};
+
+/*
+ * Second external micro SD card, using two TXB104RGYR levelshifters
+ * to lift from 1.8 V to 2.85 V
+ */
+&sdcc5 {
+	status = "okay";
+	/* Enable SSBI GPIO 26 as input, use for card detect */
+	pinctrl-names = "default";
+	pinctrl-0 = <&dragon_sdcc5_pins>, <&dragon_sdcc5_gpios>;
+	cd-gpios = <&pm8058_gpio 26 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&tlmm 106 GPIO_ACTIVE_HIGH>;
+	vmmc-supply = <&dragon_vsdcc>;
+	vqmmc-supply = <&dragon_vio_txb>;
+};
+
+&tlmm {
+	/* eMMMC pins, all 8 data lines connected */
+	dragon_sdcc1_pins: sdcc1 {
+		mux {
+			pins = "gpio159", "gpio160", "gpio161",
+			     "gpio162", "gpio163", "gpio164",
+			     "gpio165", "gpio166", "gpio167",
+			     "gpio168";
+			function = "sdc1";
+		};
+		clk {
+			pins = "gpio167"; /* SDC5 CLK */
+			drive-strengh = <16>;
+			bias-disable;
+		};
+		cmd {
+			pins = "gpio168"; /* SDC5 CMD */
+			drive-strengh = <10>;
+			bias-pull-up;
+		};
+		data {
+			/* SDC5 D0 to D7 */
+			pins = "gpio159", "gpio160", "gpio161", "gpio162",
+			     "gpio163", "gpio164", "gpio165", "gpio166";
+			drive-strengh = <10>;
+			bias-pull-up;
+		};
+	};
+
+	/*
+	 * The SDCC3 pins are hardcoded (non-muxable) but need some pin
+	 * configuration.
+	 */
+	dragon_sdcc3_pins: sdcc3 {
+		clk {
+			pins = "sdc3_clk";
+			drive-strengh = <8>;
+			bias-disable;
+		};
+		cmd {
+			pins = "sdc3_cmd";
+			drive-strengh = <8>;
+			bias-pull-up;
+		};
+		data {
+			pins = "sdc3_data";
+			drive-strengh = <8>;
+			bias-pull-up;
+		};
+	};
+
+	/* Second SD card slot pins */
+	dragon_sdcc5_pins: sdcc5 {
+		mux {
+			pins = "gpio95", "gpio96", "gpio97",
+			     "gpio98", "gpio99", "gpio100";
+			function = "sdc5";
+		};
+		clk {
+			pins = "gpio97"; /* SDC5 CLK */
+			drive-strengh = <16>;
+			bias-disable;
+		};
+		cmd {
+			pins = "gpio95"; /* SDC5 CMD */
+			drive-strengh = <10>;
+			bias-pull-up;
+		};
+		data {
+			/* SDC5 D0 to D3 */
+			pins = "gpio96", "gpio98", "gpio99", "gpio100";
+			drive-strengh = <10>;
+			bias-pull-up;
+		};
+	};
+
+	/* Primary serial port uart 0 pins */
+	dragon_serial0_pins: gsbi12 {
+		mux {
+			pins = "gpio117", "gpio118";
+			function = "gsbi12";
+		};
+		tx {
+			pins = "gpio117";
+			drive-strength = <8>;
+			bias-disable;
+		};
+		rx {
+			pins = "gpio118";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+};
+
+&pmicintc {
+	keypad at 148 {
+		linux,keymap = <
+			MATRIX_KEY(0, 0, KEY_MENU)
+			MATRIX_KEY(0, 2, KEY_1)
+			MATRIX_KEY(0, 3, KEY_4)
+			MATRIX_KEY(0, 4, KEY_7)
+			MATRIX_KEY(1, 0, KEY_UP)
+			MATRIX_KEY(1, 1, KEY_LEFT)
+			MATRIX_KEY(1, 2, KEY_DOWN)
+			MATRIX_KEY(1, 3, KEY_5)
+			MATRIX_KEY(1, 3, KEY_8)
+			MATRIX_KEY(2, 0, KEY_HOME)
+			MATRIX_KEY(2, 1, KEY_REPLY)
+			MATRIX_KEY(2, 2, KEY_2)
+			MATRIX_KEY(2, 3, KEY_6)
+			MATRIX_KEY(3, 0, KEY_VOLUMEUP)
+			MATRIX_KEY(3, 1, KEY_RIGHT)
+			MATRIX_KEY(3, 2, KEY_3)
+			MATRIX_KEY(3, 3, KEY_9)
+			MATRIX_KEY(3, 4, KEY_SWITCHVIDEOMODE)
+			MATRIX_KEY(4, 0, KEY_VOLUMEDOWN)
+			MATRIX_KEY(4, 1, KEY_BACK)
+			MATRIX_KEY(4, 2, KEY_CAMERA)
+			MATRIX_KEY(4, 3, KEY_KBDILLUMTOGGLE)
+			>;
+		keypad,num-rows = <6>;
+		keypad,num-columns = <5>;
+	};
+};
+
+&pm8058_gpio {
+	dragon_sdcc3_gpios: sdcc3-gpios {
+		pinconf {
+			pins = "gpio22";
+			function = "normal";
+			input-enable;
+			bias-pull-up;
+			qcom,pull-up-strength = <PMIC_GPIO_PULL_UP_30>;
+			power-source = <PM8058_GPIO_S3>;
+		};
+	};
+	dragon_sdcc5_gpios: sdcc5-gpios {
+		pinconf {
+			pins = "gpio26";
+			function = "normal";
+			input-enable;
+			bias-pull-up;
+			qcom,pull-up-strength = <PMIC_GPIO_PULL_UP_30>;
+			power-source = <PM8058_GPIO_S3>;
+		};
+	};
+};
-- 
2.4.11
