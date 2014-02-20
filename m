From: ashutosh.s@phytec.in (Ashutosh singh)
Date: Thu, 20 Feb 2014 11:20:15 +0530
Subject: [PATCH v4 1/4] ARM: dts: imx6q-phytec: Added USB_OTG Support
Message-ID: <1392875418-9034-1-git-send-email-ashutosh.s@phytec.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for USB_OTG on Phytec phyFLEX-i.MX6 Quad module.

Signed-off-by: Ashutosh singh <ashutosh.s@phytec.in>
---
 arch/arm/boot/dts/imx6q-phytec-pbab01.dts  |    4 ++++
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi |   31 ++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
index 7d37ec6..87c3702 100644
--- a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
+++ b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
@@ -25,6 +25,10 @@
 	status = "okay";
 };
 
+&usbotg {
+	status = "okay";
+};
+
 &usdhc2 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
index 0dd5d3b..ee07896 100644
--- a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
@@ -18,6 +18,21 @@
 	memory {
 		reg = <0x10000000 0x80000000>;
 	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_usb_otg_vbus: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "usb_otg_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio4 15 0>;
+		};
+	};
 };
 
 &ecspi3 {
@@ -180,6 +195,14 @@
 			>;
 		};
 
+		pinctrl_usbotg: usbotggrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
+				MX6QDL_PAD_KEY_COL4__USB_OTG_OC		0x1b0b0
+				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x80000000
+			>;
+		};
+
 		pinctrl_usdhc2: usdhc2grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17059
@@ -225,6 +248,14 @@
 	status = "disabled";
 };
 
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	disable-over-current;
+	status = "disabled";
+};
+
 &usdhc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2>;
-- 
1.7.9.5
