From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 13 Apr 2014 09:19:10 +0400
Subject: [PATCH 07/10] ARM: dts: imx51-babbage: Add USB OTG regulator node
In-Reply-To: <1397366353-29395-1-git-send-email-shc_work@mail.ru>
References: <1397366353-29395-1-git-send-email-shc_work@mail.ru>
Message-ID: <1397366353-29395-7-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a regulator node and pinctrl group for USB OTG.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-babbage.dts | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 57daa06..bd375fe 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -139,17 +139,29 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		reg_usb_vbus: regulator at 0 {
+		reg_usbh1_vbus: regulator at 0 {
 			compatible = "regulator-fixed";
 			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_usbreg>;
+			pinctrl-0 = <&pinctrl_usbh1reg>;
 			reg = <0>;
-			regulator-name = "usb_vbus";
+			regulator-name = "usbh1_vbus";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			gpio = <&gpio2 5 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
+
+		reg_usbotg_vbus: regulator at 1 {
+			compatible = "regulator-fixed";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usbotgreg>;
+			reg = <1>;
+			regulator-name = "usbotg_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
 	};
 
 	usbphy {
@@ -541,11 +553,17 @@
 			>;
 		};
 
-		pinctrl_usbreg: usbreggrp {
+		pinctrl_usbh1reg: usbh1reggrp {
 			fsl,pins = <
 				MX51_PAD_EIM_D21__GPIO2_5		0x85
 			>;
 		};
+
+		pinctrl_usbotgreg: usbotgreggrp {
+			fsl,pins = <
+				MX51_PAD_GPIO1_7__GPIO1_7		0x85
+			>;
+		};
 	};
 };
 
@@ -618,7 +636,7 @@
 &usbh1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbh1>;
-	vbus-supply = <&reg_usb_vbus>;
+	vbus-supply = <&reg_usbh1_vbus>;
 	fsl,usbphy = <&usbh1phy>;
 	phy_type = "ulpi";
 	status = "okay";
@@ -628,5 +646,6 @@
 	dr_mode = "otg";
 	disable-over-current;
 	phy_type = "utmi_wide";
+	vbus-supply = <&reg_usbotg_vbus>;
 	status = "okay";
 };
-- 
1.8.3.2
