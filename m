From: stillcompiling@gmail.com (Joshua Clayton)
Date: Thu, 11 Aug 2016 09:40:31 -0700
Subject: [PATCH 2/3] ARM: dts: imx6qdl-udoo.dtsi: fix onboard USB HUB property
In-Reply-To: <1470933632-22133-1-git-send-email-stillcompiling@gmail.com>
References: <20160810030254.GD1879@shlinux2>
 <1470933632-22133-1-git-send-email-stillcompiling@gmail.com>
Message-ID: <1470933632-22133-3-git-send-email-stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Chen <peter.chen@nxp.com>

The current dts describes USB HUB's property at USB controller's
entry, it is improper. The USB HUB should be the child node
under USB controller, and power sequence properties are under
it.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-udoo.dtsi | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
index 3bee2f9..44b2a24 100644
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
@@ -259,9 +250,16 @@
 &usbh1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbh>;
-	vbus-supply = <&reg_usb_h1_vbus>;
-	clocks = <&clks IMX6QDL_CLK_CKO>;
 	status = "okay";
+
+	usb2415: hub at 1 {
+		compatible = "usb424,2514";
+		reg = <1>;
+
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+		reset-duration-us = <3000>;
+	};
 };
 
 &usdhc3 {
-- 
2.7.4
