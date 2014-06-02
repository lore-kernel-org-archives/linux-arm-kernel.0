From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  2 Jun 2014 19:56:21 -0300
Subject: [PATCH] ARM: dts: imx6q-udoo: Add USB Host support
Message-ID: <1401749781-4572-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6q-udoo.dts | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-udoo.dts b/arch/arm/boot/dts/imx6q-udoo.dts
index 6c56106..e3bff2a 100644
--- a/arch/arm/boot/dts/imx6q-udoo.dts
+++ b/arch/arm/boot/dts/imx6q-udoo.dts
@@ -23,6 +23,23 @@
 	memory {
 		reg = <0x10000000 0x40000000>;
 	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_usb_h1_vbus: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "usb_h1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			startup-delay-us = <2>; /* USB2415 requires a POR of 1 us minimum */
+			gpio = <&gpio7 12 0>;
+		};
+	};
 };
 
 &fec {
@@ -81,6 +98,13 @@
 			>;
 		};
 
+		pinctrl_usbh: usbhgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12 0x80000000
+				MX6QDL_PAD_NANDF_CS2__CCM_CLKO2 0x130b0
+			>;
+		};
+
 		pinctrl_usdhc3: usdhc3grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
@@ -104,6 +128,14 @@
 	status = "okay";
 };
 
+&usbh1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbh>;
+	vbus-supply = <&reg_usb_h1_vbus>;
+	clocks = <&clks 201>;
+	status = "okay";
+};
+
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3>;
-- 
1.8.3.2
