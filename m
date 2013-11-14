From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 14 Nov 2013 00:09:47 -0200
Subject: [PATCH 2/2] ARM: dts: imx6q-udoo: Add USB host support
In-Reply-To: <1384394987-15134-1-git-send-email-festevam@gmail.com>
References: <1384394987-15134-1-git-send-email-festevam@gmail.com>
Message-ID: <1384394987-15134-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Udoo board has USBH1 port connected to a USB2514 hub.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6q-udoo.dts | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-udoo.dts b/arch/arm/boot/dts/imx6q-udoo.dts
index 1c7f7a1..109b997 100644
--- a/arch/arm/boot/dts/imx6q-udoo.dts
+++ b/arch/arm/boot/dts/imx6q-udoo.dts
@@ -19,6 +19,23 @@
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
@@ -29,7 +46,17 @@
 };
 
 &iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
 	imx6q-udoo {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12 0x80000000
+				MX6QDL_PAD_NANDF_CS2__CCM_CLKO2 0x130b0
+			>;
+		};
+
 		pinctrl_enet: enetgrp {
 			fsl,pins = <MX6QDL_ENET_PINGRP1>;
 		};
@@ -54,6 +81,13 @@
 	status = "okay";
 };
 
+&usbh1 {
+	vbus-supply = <&reg_usb_h1_vbus>;
+	clocks = <&clks 201>;
+	clock-names = "phy";
+	status = "okay";
+};
+
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3>;
-- 
1.8.1.2
