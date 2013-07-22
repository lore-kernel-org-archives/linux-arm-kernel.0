From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 22 Jul 2013 18:54:15 -0300
Subject: [PATCH v2 1/2] ARM: dts: mx6: Add support for mx6q nitrogen board
Message-ID: <1374530056-31335-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

mx6q sabrelite and nitrogen boards are hardware compatible.

Boundary Devices have a line of nitrogen boards based on quad/dual-lite and solo
variants.

Let's consolidate the common peripheral nodes into imx6qdl-nitrogen.dtsi and
add support for the mx6 quad nitrogen board.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/Makefile              |   1 +
 arch/arm/boot/dts/imx6q-nitrogen.dts    |  27 ++++++
 arch/arm/boot/dts/imx6q-sabrelite.dts   | 148 +----------------------------
 arch/arm/boot/dts/imx6qdl-nitrogen.dtsi | 161 ++++++++++++++++++++++++++++++++
 4 files changed, 190 insertions(+), 147 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6q-nitrogen.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-nitrogen.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index db510b3..d523340 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -128,6 +128,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx6dl-sabresd.dtb \
 	imx6dl-wandboard.dtb \
 	imx6q-arm2.dtb \
+	imx6q-nitrogen.dtb \
 	imx6q-phytec-pbab01.dtb \
 	imx6q-sabreauto.dtb \
 	imx6q-sabrelite.dtb \
diff --git a/arch/arm/boot/dts/imx6q-nitrogen.dts b/arch/arm/boot/dts/imx6q-nitrogen.dts
new file mode 100644
index 0000000..0ac5c59
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-nitrogen.dts
@@ -0,0 +1,27 @@
+/*
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * Author: Fabio Estevam <fabio.estevam@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+/dts-v1/;
+#include "imx6q.dtsi"
+#include "imx6qdl-nitrogen.dtsi"
+
+/ {
+	model = "Boundary Devices i.MX6 Quad Nitrogen Board";
+	compatible = "boundary,imx6q-nitrogen", "fsl,imx6q";
+
+	memory {
+		reg = <0x10000000 0x40000000>;
+	};
+};
+
+&sata {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index e0f4cd0..fc09c59 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -12,6 +12,7 @@
 
 /dts-v1/;
 #include "imx6q.dtsi"
+#include "imx6qdl-nitrogen.dtsi"
 
 / {
 	model = "Freescale i.MX6 Quad SABRE Lite Board";
@@ -20,155 +21,8 @@
 	memory {
 		reg = <0x10000000 0x40000000>;
 	};
-
-	regulators {
-		compatible = "simple-bus";
-
-		reg_2p5v: 2p5v {
-			compatible = "regulator-fixed";
-			regulator-name = "2P5V";
-			regulator-min-microvolt = <2500000>;
-			regulator-max-microvolt = <2500000>;
-			regulator-always-on;
-		};
-
-		reg_3p3v: 3p3v {
-			compatible = "regulator-fixed";
-			regulator-name = "3P3V";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
-
-		reg_usb_otg_vbus: usb_otg_vbus {
-			compatible = "regulator-fixed";
-			regulator-name = "usb_otg_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 22 0>;
-			enable-active-high;
-		};
-	};
-
-	sound {
-		compatible = "fsl,imx6q-sabrelite-sgtl5000",
-			     "fsl,imx-audio-sgtl5000";
-		model = "imx6q-sabrelite-sgtl5000";
-		ssi-controller = <&ssi1>;
-		audio-codec = <&codec>;
-		audio-routing =
-			"MIC_IN", "Mic Jack",
-			"Mic Jack", "Mic Bias",
-			"Headphone Jack", "HP_OUT";
-		mux-int-port = <1>;
-		mux-ext-port = <4>;
-	};
 };
 
 &sata {
 	status = "okay";
 };
-
-&ecspi1 {
-	fsl,spi-num-chipselects = <1>;
-	cs-gpios = <&gpio3 19 0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi1_1>;
-	status = "okay";
-
-	flash: m25p80 at 0 {
-		compatible = "sst,sst25vf016b";
-		spi-max-frequency = <20000000>;
-		reg = <0>;
-	};
-};
-
-&ssi1 {
-	fsl,mode = "i2s-slave";
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hog>;
-
-	hog {
-		pinctrl_hog: hoggrp {
-			fsl,pins = <
-				MX6QDL_PAD_NANDF_D6__GPIO2_IO06 0x80000000
-				MX6QDL_PAD_NANDF_D7__GPIO2_IO07 0x80000000
-				MX6QDL_PAD_EIM_D19__GPIO3_IO19  0x80000000
-				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x80000000
-				MX6QDL_PAD_EIM_D23__GPIO3_IO23  0x80000000
-				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00 0x80000000
-				MX6QDL_PAD_SD3_DAT4__GPIO7_IO01 0x1f0b0
-				MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x80000000
-			>;
-		};
-	};
-};
-
-&usbotg {
-	vbus-supply = <&reg_usb_otg_vbus>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbotg_1>;
-	disable-over-current;
-	status = "okay";
-};
-
-&usbh1 {
-	status = "okay";
-};
-
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet_1>;
-	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio3 23 0>;
-	status = "okay";
-};
-
-&usdhc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc3_2>;
-	cd-gpios = <&gpio7 0 0>;
-	wp-gpios = <&gpio7 1 0>;
-	vmmc-supply = <&reg_3p3v>;
-	status = "okay";
-};
-
-&usdhc4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc4_2>;
-	cd-gpios = <&gpio2 6 0>;
-	wp-gpios = <&gpio2 7 0>;
-	vmmc-supply = <&reg_3p3v>;
-	status = "okay";
-};
-
-&audmux {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_audmux_1>;
-};
-
-&uart2 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2_1>;
-};
-
-&i2c1 {
-	status = "okay";
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1_1>;
-
-	codec: sgtl5000 at 0a {
-		compatible = "fsl,sgtl5000";
-		reg = <0x0a>;
-		clocks = <&clks 169>;
-		VDDA-supply = <&reg_2p5v>;
-		VDDIO-supply = <&reg_3p3v>;
-	};
-};
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen.dtsi
new file mode 100644
index 0000000..948063e
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen.dtsi
@@ -0,0 +1,161 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/ {
+	regulators {
+		compatible = "simple-bus";
+
+		reg_2p5v: 2p5v {
+			compatible = "regulator-fixed";
+			regulator-name = "2P5V";
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <2500000>;
+			regulator-always-on;
+		};
+
+		reg_3p3v: 3p3v {
+			compatible = "regulator-fixed";
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		reg_usb_otg_vbus: usb_otg_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb_otg_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 22 0>;
+			enable-active-high;
+		};
+	};
+
+	sound {
+		compatible = "fsl,imx6q-sabrelite-sgtl5000",
+			     "fsl,imx-audio-sgtl5000";
+		model = "imx6q-sabrelite-sgtl5000";
+		ssi-controller = <&ssi1>;
+		audio-codec = <&codec>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+		mux-int-port = <1>;
+		mux-ext-port = <4>;
+	};
+};
+
+&audmux {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux_1>;
+};
+
+&ecspi1 {
+	fsl,spi-num-chipselects = <1>;
+	cs-gpios = <&gpio3 19 0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1_1>;
+	status = "okay";
+
+	flash: m25p80 at 0 {
+		compatible = "sst,sst25vf016b";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1_1>;
+
+	codec: sgtl5000 at 0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&clks 169>;
+		VDDA-supply = <&reg_2p5v>;
+		VDDIO-supply = <&reg_3p3v>;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	hog {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_NANDF_D6__GPIO2_IO06 0x80000000
+				MX6QDL_PAD_NANDF_D7__GPIO2_IO07 0x80000000
+				MX6QDL_PAD_EIM_D19__GPIO3_IO19  0x80000000
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x80000000
+				MX6QDL_PAD_EIM_D23__GPIO3_IO23  0x80000000
+				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00 0x80000000
+				MX6QDL_PAD_SD3_DAT4__GPIO7_IO01 0x1f0b0
+				MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x80000000
+			>;
+		};
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet_1>;
+	phy-mode = "rgmii";
+	phy-reset-gpios = <&gpio3 23 0>;
+	status = "okay";
+};
+
+&ssi1 {
+	fsl,mode = "i2s-slave";
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2_1>;
+};
+
+
+&usbh1 {
+	status = "okay";
+};
+
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg_1>;
+	disable-over-current;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3_2>;
+	cd-gpios = <&gpio7 0 0>;
+	wp-gpios = <&gpio7 1 0>;
+	vmmc-supply = <&reg_3p3v>;
+	status = "okay";
+};
+
+&usdhc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4_2>;
+	cd-gpios = <&gpio2 6 0>;
+	wp-gpios = <&gpio2 7 0>;
+	vmmc-supply = <&reg_3p3v>;
+	status = "okay";
+};
-- 
1.8.1.2
