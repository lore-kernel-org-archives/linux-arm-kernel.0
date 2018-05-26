From: akurz@blala.de (Alexander Kurz)
Date: Sat, 26 May 2018 18:30:52 +0000
Subject: [PATCH 2/3] ARM: dts: imx6qdl-wandboard: enable USB OTG
In-Reply-To: <20180526183053.14029-1-akurz@blala.de>
References: <20180526183053.14029-1-akurz@blala.de>
Message-ID: <20180526183053.14029-3-akurz@blala.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable USB OTG (dual-role) on the Wandboard.
Note, that the USB_OTG_VBUS current is quite limited due to a 22R resistor
in the power line. Hence, the overcurrent signal of 1A will never be
triggered on this board.

Signed-off-by: Alexander Kurz <akurz@blala.de>
---
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index ff7e824dfd28..4ac8ee355c42 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -48,6 +48,16 @@
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 	};
+
+	reg_usb_otg_vbus: fixedregulator at 2 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbotgvbus>;
+		gpio = <&gpio3 22 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &audmux {
@@ -162,6 +172,12 @@
 			>;
 		};
 
+		pinctrl_usbotgvbus: usbotgvbusgrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x130b0
+			>;
+		};
+
 		pinctrl_usdhc1: usdhc1grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD1_CMD__SD1_CMD		0x17059
@@ -236,10 +252,11 @@
 };
 
 &usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbotg>;
 	disable-over-current;
-	dr_mode = "peripheral";
+	dr_mode = "otg";
 	status = "okay";
 };
 
-- 
2.11.0
