From: peter.chen@nxp.com (Peter Chen)
Date: Fri, 17 Jun 2016 18:09:25 +0800
Subject: [PATCH 12/12] ARM: dts: imx6qdl-udoo.dtsi: fix onboard USB HUB
 property
In-Reply-To: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1466158165-9380-13-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Chen <peter.chen@freescale.com>

The current dts describes USB HUB's property at USB controller's
entry, it is improper. The USB HUB should be the child node
under USB controller, with "usb-pwrseq" phandle to handle power
sequence stuffs.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/arm/boot/dts/imx6qdl-udoo.dtsi | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
index 3bee2f9..f921174 100644
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
@@ -89,6 +80,13 @@
 		mux-int-port = <1>;
 		mux-ext-port = <6>;
 	};
+
+	usb2415_pwrseq: usb2415_pwrseq {
+		compatible = "usb-pwrseq-generic";
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+		reset-duration-us = <3000>;
+	};
 };
 
 &fec {
@@ -259,9 +257,15 @@
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
+		usb-pwrseq = <&usb2415_pwrseq>;
+	};
 };
 
 &usdhc3 {
-- 
1.9.1
