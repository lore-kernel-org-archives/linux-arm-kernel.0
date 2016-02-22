From: ps.report@gmx.net (Peter Seiderer)
Date: Mon, 22 Feb 2016 21:03:41 +0100
Subject: [PATCH v1] ARM: dts: nitrogen6x: add USB host 1 support
Message-ID: <1456171421-10044-1-git-send-email-ps.report@gmx.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Regulator stuff and pin configuration copied from imx6qdl-nitrogen6_max.dtsi
and checked against Boundary Devices linux kernel tree ([1]).

[1] https://github.com/boundarydevices/linux-imx6/blob/boundary-imx_3.14.28_1.0.0_ga/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi

Signed-off-by: Peter Seiderer <ps.report@gmx.net>
---
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index c6c590d..81f8c5c 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -85,9 +85,21 @@
 			enable-active-high;
 		};
 
-		reg_can_xcvr: regulator at 3 {
+		reg_usb_h1_vbus: regulator at 3 {
 			compatible = "regulator-fixed";
 			reg = <3>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usbh1>;
+			regulator-name = "usb_h1_vbus";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+
+		reg_can_xcvr: regulator at 4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
 			regulator-name = "CAN XCVR";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
@@ -96,9 +108,9 @@
 			gpio = <&gpio1 2 GPIO_ACTIVE_LOW>;
 		};
 
-		reg_wlan_vmmc: regulator at 4 {
+		reg_wlan_vmmc: regulator at 5 {
 			compatible = "regulator-fixed";
-			reg = <4>;
+			reg = <5>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_wlan_vmmc>;
 			regulator-name = "reg_wlan_vmmc";
@@ -515,6 +527,12 @@
 			>;
 		};
 
+		pinctrl_usbh1: usbh1grp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12          0x0b0b0
+			>;
+		};
+
 		pinctrl_usbotg: usbotggrp {
 			fsl,pins = <
 				MX6QDL_PAD_GPIO_1__USB_OTG_ID	0x17059
@@ -632,6 +650,7 @@
 };
 
 &usbh1 {
+	vbus-supply = <&reg_usb_h1_vbus>;
 	status = "okay";
 };
 
-- 
2.1.4
