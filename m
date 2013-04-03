From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  3 Apr 2013 20:30:39 -0300
Subject: [PATCH v2 1/3] ARM: dts: mxs: Use the standard gpio reset binding
Message-ID: <1365031841-3864-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Instead of using a custom binding for turning on a GPIO that activates the 
panel, use the standard one.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Adjust Subject, since the change is not specific to mx28evk

 Documentation/devicetree/bindings/fb/mxsfb.txt |    5 +----
 arch/arm/boot/dts/imx23-evk.dts                |    8 +++++++-
 arch/arm/boot/dts/imx28-evk.dts                |    8 +++++++-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/fb/mxsfb.txt b/Documentation/devicetree/bindings/fb/mxsfb.txt
index 7ba3b76..b15230c 100644
--- a/Documentation/devicetree/bindings/fb/mxsfb.txt
+++ b/Documentation/devicetree/bindings/fb/mxsfb.txt
@@ -8,9 +8,7 @@ Required properties:
 - display : phandle to display node (see below for details)
 
 Optional properties:
-- panel-enable-gpios : Should specify the gpio for panel enable
-
-* display node
+- display node
 
 Required properties:
 - bits-per-pixel : <16> for RGB565, <32> for RGB888/666.
@@ -25,7 +23,6 @@ lcdif at 80030000 {
 	compatible = "fsl,imx28-lcdif";
 	reg = <0x80030000 2000>;
 	interrupts = <38 86>;
-	panel-enable-gpios = <&gpio3 30 0>;
 
 	display: display {
 		bits-per-pixel = <32>;
diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 7880e17..28f9766 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -59,7 +59,7 @@
 			lcdif at 80030000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&lcdif_24bit_pins_a>;
-				panel-enable-gpios = <&gpio1 18 0>;
+				resets = <&gpio_reset 0>;
 				display = <&display>;
 				status = "okay";
 
@@ -89,6 +89,12 @@
 			};
 		};
 
+		gpio_reset: gpio-reset {
+			compatible = "gpio-reset";
+			reset-gpios = <&gpio1 18 1>;
+			#reset-cells = <1>;
+		};
+
 		apbx at 80040000 {
 			pwm: pwm at 80064000 {
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 2d4ea3b..e373dd6 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -123,7 +123,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&lcdif_24bit_pins_a
 					     &lcdif_pins_evk>;
-				panel-enable-gpios = <&gpio3 30 0>;
+				resets = <&gpio_reset 0>;
 				display = <&display>;
 				status = "okay";
 
@@ -152,6 +152,12 @@
 				};
 			};
 
+			gpio_reset: gpio-reset {
+				compatible = "gpio-reset";
+				reset-gpios = <&gpio3 30 1>;
+				#reset-cells = <1>;
+			};
+
 			can0: can at 80032000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&can0_pins_a>;
-- 
1.7.9.5
