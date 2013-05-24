From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 11:44:50 +0200
Subject: [PATCH 13/21] arm: kirkwood: buffalo linkstation: affect pinmux
 configs to the right devices
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369388699-25975-14-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the pinmux mechanism was added in Kirkwood, the device driver
core was not yet providing the possibility of attaching pinmux
configurations to all devices, drivers had to do it explicitly, and
not all drivers were doing this.

Now that the driver core does that in a generic way, it makes sense to
attach the pinmux configuration to their corresponding devices.

This allows the pinctrl subsystem to show in debugfs to which device
is related which pins, for example:

pin 41 (PIN41): gpio-leds.1 mvebu-gpio:41 function gpio group mpp41
pin 42 (PIN42): gpio-leds.1 mvebu-gpio:42 function gpio group mpp42
pin 43 (PIN43): gpio-leds.1 mvebu-gpio:43 function gpio group mpp43

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood-lsxl.dtsi |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
index 37d45c4..4945eba 100644
--- a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
+++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
@@ -8,16 +8,6 @@
 
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
-
-			pinctrl-0 = < &pmx_power_hdd &pmx_usb_vbus
-				      &pmx_fan_low &pmx_fan_high
-				      &pmx_led_function_red &pmx_led_alarm
-				      &pmx_led_info &pmx_led_power
-				      &pmx_fan_lock &pmx_button_function
-				      &pmx_power_switch &pmx_power_auto_switch
-				      &pmx_led_function_blue >;
-			pinctrl-names = "default";
-
 			pmx_power_hdd: pmx-power-hdd {
 				marvell,pins = "mpp10";
 				marvell,function = "gpo";
@@ -112,6 +102,10 @@
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-0 = <&pmx_button_function &pmx_power_switch
+			     &pmx_power_auto_switch>;
+		pinctrl-names = "default";
+
 		button at 1 {
 			label = "Function Button";
 			linux,code = <357>;
@@ -133,6 +127,10 @@
 
 	gpio_leds {
 		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_function_red &pmx_led_alarm
+			     &pmx_led_info &pmx_led_power
+			     &pmx_led_function_blue>;
+		pinctrl-names = "default";
 
 		led at 1 {
 			label = "lsxl:blue:func";
@@ -163,6 +161,8 @@
 
 	gpio_fan {
 		compatible = "gpio-fan";
+		pinctrl-0 = <&pmx_fan_low &pmx_fan_high &pmx_fan_lock>;
+		pinctrl-names = "default";
 		gpios = <&gpio0 19 1
 		         &gpio0 18 1>;
 		gpio-fan,speed-map = <0    3
@@ -176,6 +176,8 @@
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-0 = <&pmx_power_hdd &pmx_usb_vbus>;
+		pinctrl-names = "default";
 
 		usb_power: regulator at 1 {
 			compatible = "regulator-fixed";
-- 
1.7.9.5
