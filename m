From: akurz@blala.de (Alexander Kurz)
Date: Thu, 15 Jun 2017 08:41:10 +0200
Subject: [PATCH] ARM: dts: imx6qdl-wandboard: enable USB OTG
Message-ID: <1497508870-4028-1-git-send-email-akurz@blala.de>
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
index 82dc5744..cbf69ae 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -34,6 +34,16 @@
 			regulator-max-microvolt = <3300000>;
 			regulator-always-on;
 		};
+
+		reg_usb_otg_vbus: usb_otg_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb_otg_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usbotgvbus>;
+			gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+		};
 	};
 
 	sound {
@@ -169,6 +179,12 @@
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
@@ -243,10 +259,11 @@
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
2.1.4
