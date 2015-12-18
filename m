From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 18 Dec 2015 17:33:59 +0800
Subject: [RFC PATCH 5/5] ARM: dts: imx6qdl-udoo.dtsi: fix onboard USB HUB
 property
In-Reply-To: <1450431239-16439-1-git-send-email-peter.chen@freescale.com>
References: <1450431239-16439-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1450431239-16439-6-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current dts describes USB HUB's property at USB controller's
entry, it is improper. The USB HUB should be the child node
under USB controller.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-udoo.dtsi | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
index 1211da8..7155afb 100644
--- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
@@ -9,6 +9,8 @@
  *
  */
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	chosen {
 		stdout-path = &uart2;
@@ -17,23 +19,6 @@
 	memory {
 		reg = <0x10000000 0x40000000>;
 	};
-
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
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
-	};
 };
 
 &fec {
@@ -119,11 +104,19 @@
 };
 
 &usbh1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbh>;
-	vbus-supply = <&reg_usb_h1_vbus>;
-	clocks = <&clks 201>;
 	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	hub: usb2415 at 01 {
+		compatible = "generic-onboard-device";
+		reg = <0x01>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbh>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+		reset-duration-us = <2>;
+	};
 };
 
 &usdhc3 {
-- 
1.9.1
