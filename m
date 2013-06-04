From: gmbnomis@gmail.com (Simon Baatz)
Date: Tue,  4 Jun 2013 23:32:32 +0200
Subject: [PATCH] arm: kirkwood: sheevaplug: move pinmux configs to the right
 devices
Message-ID: <1370381552-9498-1-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the pinmux mechanism was added in Kirkwood, the device driver
core was not yet providing the possibility of attaching pinmux
configurations to all devices, drivers had to do it explicitly, and
not all drivers were doing this.

Now that the driver core does that in a generic way, it makes sense to
attach the pinmux configuration to their corresponding devices.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---

Hi,

the patch series by Thomas to move the pinmux configs was prepared in
parallel to the dts files for Sheevaplug.  Here is the corresponding
patch in order to adapt these files as well.

- Simon

 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi |   16 ++++++----------
 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts   |   21 ++++++++++++---------
 arch/arm/boot/dts/kirkwood-sheevaplug.dts         |   18 ++++++++----------
 3 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi b/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
index 9d59475..f7143f1 100644
--- a/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
@@ -44,10 +44,14 @@
 			};
 		};
 		serial at 12000 {
+			pinctrl-0 = <&pmx_uart0>;
+			pinctrl-names = "default";
 			status = "okay";
 		};
 
 		nand at 3000000 {
+			pinctrl-0 = <&pmx_nand>;
+			pinctrl-names = "default";
 			status = "okay";
 
 			partition at 0 {
@@ -71,6 +75,8 @@
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-0 = <&pmx_usb_power_enable>;
+		pinctrl-names = "default";
 
 		usb_power: regulator at 1 {
 			compatible = "regulator-fixed";
@@ -84,14 +90,4 @@
 			gpio = <&gpio0 29 0>;
 		};
 	};
-
-	gpio-leds {
-		compatible = "gpio-leds";
-
-		health {
-			label = "sheevaplug:blue:health";
-			gpios = <&gpio1 17 1>;
-			linux,default-trigger = "default-on";
-		};
-	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts b/arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts
index 1c6946a..f620ce4 100644
--- a/arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts
+++ b/arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts
@@ -15,15 +15,6 @@
 	compatible = "globalscale,sheevaplug-esata-rev13", "globalscale,sheevaplug-esata", "globalscale,sheevaplug", "marvell,kirkwood-88f6281", "marvell,kirkwood";
 
 	ocp at f1000000 {
-		pinctrl: pinctrl at 10000 {
-
-			pinctrl-0 = < &pmx_nand &pmx_uart0
-				      &pmx_usb_power_enable
-				      &pmx_led_blue>;
-			pinctrl-names = "default";
-
-		};
-
 		sata at 80000 {
 			status = "okay";
 			nr-ports = <2>;
@@ -37,4 +28,16 @@
 			wp-gpios = <&gpio1 15 0>;
 		};
 	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_blue>;
+		pinctrl-names = "default";
+
+		health {
+			label = "sheevaplug:blue:health";
+			gpios = <&gpio1 17 1>;
+			linux,default-trigger = "default-on";
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug.dts b/arch/arm/boot/dts/kirkwood-sheevaplug.dts
index f7684066..bf1dff2 100644
--- a/arch/arm/boot/dts/kirkwood-sheevaplug.dts
+++ b/arch/arm/boot/dts/kirkwood-sheevaplug.dts
@@ -15,16 +15,6 @@
 	compatible = "globalscale,sheevaplug", "marvell,kirkwood-88f6281", "marvell,kirkwood";
 
 	ocp at f1000000 {
-		pinctrl: pinctrl at 10000 {
-
-			pinctrl-0 = < &pmx_nand &pmx_uart0
-				      &pmx_usb_power_enable
-				      &pmx_led_red
-				      &pmx_led_blue>;
-			pinctrl-names = "default";
-
-		};
-
 		mvsdio at 90000 {
 			pinctrl-0 = <&pmx_sdio>;
 			pinctrl-names = "default";
@@ -36,6 +26,14 @@
 
 	gpio-leds {
 		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_blue &pmx_led_red>;
+		pinctrl-names = "default";
+
+		health {
+			label = "sheevaplug:blue:health";
+			gpios = <&gpio1 17 1>;
+			linux,default-trigger = "default-on";
+		};
 
 		misc {
 			label = "sheevaplug:red:misc";
-- 
1.7.9.5
