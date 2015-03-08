From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Sun,  8 Mar 2015 17:26:00 +0100
Subject: [PATCH v2 2/2] ARM: dts: imx6: add support for technexion toucan board
In-Reply-To: <1425831960-10259-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1425831960-10259-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1425831960-10259-2-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the second user of the edm1 module.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
- fixed alphabetical oder of the Makefile
- fixed order and numbering of regulator nodes
- fixed alphabetical oder of device nodes

 arch/arm/boot/dts/Makefile          |   1 +
 arch/arm/boot/dts/imx6dl-toucan.dts | 203 ++++++++++++++++++++++++++++++++++++
 2 files changed, 204 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-toucan.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a1c776b..feeb350 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -263,6 +263,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-sabreauto.dtb \
 	imx6dl-sabrelite.dtb \
 	imx6dl-sabresd.dtb \
+	imx6dl-toucan.dtb \
 	imx6dl-tx6dl-comtft.dtb \
 	imx6dl-tx6u-801x.dtb \
 	imx6dl-tx6u-811x.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-toucan.dts b/arch/arm/boot/dts/imx6dl-toucan.dts
new file mode 100644
index 0000000..c57332c
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-toucan.dts
@@ -0,0 +1,203 @@
+/*
+ * Copyright 2015 Michael Grzeschik <mgr@pengutronix.de>, Pengutronix
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+/dts-v1/;
+
+#include "imx6dl.dtsi"
+#include "imx6qdl-edm1.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Technexion Toucan";
+	compatible = "technexion,toucan", "fsl,imx6dl";
+
+	memory {
+		reg = <0x10000000 0x40000000>;
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_2p5v: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "2P5V";
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <2500000>;
+			regulator-always-on;
+		};
+
+		reg_3p3v: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		reg_usbotg_vbus: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "usbotg_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			pinctrl-names = "default";
+			gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+	};
+
+	sound {
+		compatible = "fsl,imx6-toucan-sgtl5000",
+			     "fsl,imx-audio-sgtl5000";
+		model = "imx6-toucan-sgtl5000";
+		ssi-controller = <&ssi1>;
+		audio-codec = <&codec>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+		mux-int-port = <1>;
+		mux-ext-port = <3>;
+	};
+};
+
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux>;
+	status = "okay";
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	status = "okay";
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	status = "okay";
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-mode = "rgmii";
+	phy-reset-gpios = <&gpio3 29 GPIO_ACTIVE_LOW>;
+	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
+			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
+	status = "okay";
+};
+
+&hdmi {
+	ddc-i2c-bus = <&i2c1>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	codec: sgtl5000 at 0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&clks 201>;
+		VDDA-supply = <&reg_2p5v>;
+		VDDIO-supply = <&reg_3p3v>;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	imx6qdl-toucan {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT19__GPIO6_IO05	0x0b0b0
+				MX6QDL_PAD_CSI0_DAT16__GPIO6_IO02	0x0b0b0
+				MX6QDL_PAD_CSI0_DAT18__GPIO6_IO04	0x0b0b0
+				MX6QDL_PAD_EIM_D27__GPIO3_IO27		0x0b0b0
+				MX6QDL_PAD_EIM_D26__GPIO3_IO26		0x0b0b0
+				MX6QDL_PAD_EIM_BCLK__GPIO6_IO31		0x0b0b0
+				MX6QDL_PAD_CSI0_DAT17__GPIO6_IO03	0x0b0b0
+				MX6QDL_PAD_ENET_RX_ER__GPIO1_IO24	0x0b0b0
+				MX6QDL_PAD_SD3_RST__GPIO7_IO08		0x0b0b0
+				MX6QDL_PAD_GPIO_19__GPIO4_IO05		0x0b0b0
+				MX6QDL_PAD_SD4_DAT0__GPIO2_IO08         0x17059
+			>;
+		};
+	};
+};
+
+&ssi1 {
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1 &pinctrl_uart1_rtscts>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2 &pinctrl_uart2_rtscts>;
+	status = "okay";
+};
+
+&usbh1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbh1>;
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+&usbotg {
+	vbus-supply = <&reg_usbotg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	dr_mode = "peripheral";
+	disable-over-current;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	bus-width = <4>;
+	no-1-8-v;
+	cd-gpios = <&gpio1 2 0>;
+	fsl,wp-controller;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	bus-width = <4>;
+	no-1-8-v;
+	fsl,wp-controller;
+	status = "okay";
+};
-- 
2.1.4
