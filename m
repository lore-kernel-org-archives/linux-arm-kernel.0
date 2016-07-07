From: peter.chen@nxp.com (Peter Chen)
Date: Thu, 7 Jul 2016 17:14:52 +0800
Subject: [PATCH 6/6] ARM: dts: imx6qdl-udoo.dtsi: fix onboard USB HUB property
In-Reply-To: <1467882892-27589-1-git-send-email-peter.chen@nxp.com>
References: <1467882892-27589-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1467882892-27589-7-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Chen <peter.chen@freescale.com>

The current dts describes USB HUB's property at USB controller's
entry, it is improper. The USB HUB should be the child node
under USB controller, and power sequence properties are under
it.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/arm/boot/dts/imx6qdl-udoo.dtsi | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
index 3bee2f9..e6c4e8c 100644
--- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
@@ -9,6 +9,8 @@
  *
  */
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	aliases {
 		backlight = &backlight;
@@ -58,17 +60,6 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		reg_usb_h1_vbus: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "usb_h1_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			enable-active-high;
-			startup-delay-us = <2>; /* USB2415 requires a POR of 1 us minimum */
-			gpio = <&gpio7 12 0>;
-		};
-
 		reg_panel: regulator at 1 {
 			compatible = "regulator-fixed";
 			reg = <1>;
@@ -259,9 +250,20 @@
 &usbh1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbh>;
-	vbus-supply = <&reg_usb_h1_vbus>;
-	clocks = <&clks IMX6QDL_CLK_CKO>;
 	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	hub: usb2415 at 1 {
+		compatible = "usb424,2514";
+		reg = <1>;
+
+		power-sequence;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		clock-names = "pwrseq-clk";
+		pwrseq-reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+		pwrseq-reset-duration-us = <3000>;
+	};
 };
 
 &usdhc3 {
-- 
1.9.1
