From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 11:44:46 +0200
Subject: [PATCH 09/21] arm: kirkwood: iconnect: affect pinmux configs to the
 right devices
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369388699-25975-10-git-send-email-thomas.petazzoni@free-electrons.com>
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
 arch/arm/boot/dts/kirkwood-iconnect.dts |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/kirkwood-iconnect.dts
index 20c3ece..0275018 100644
--- a/arch/arm/boot/dts/kirkwood-iconnect.dts
+++ b/arch/arm/boot/dts/kirkwood-iconnect.dts
@@ -20,14 +20,6 @@
 
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
-
-			pinctrl-0 = < &pmx_button_reset &pmx_button_otb
-				      &pmx_led_level &pmx_led_power_blue
-				      &pmx_led_power_red &pmx_led_usb1
-				      &pmx_led_usb2 &pmx_led_usb3
-				      &pmx_led_usb4 &pmx_led_otb >;
-			pinctrl-names = "default";
-
 			pmx_button_reset: pmx-button-reset {
 				marvell,pins = "mpp12";
 				marvell,function = "gpio";
@@ -113,6 +105,11 @@
 
 	gpio-leds {
 		compatible = "gpio-leds";
+		pinctrl-0 = < &pmx_led_level &pmx_led_power_blue
+			      &pmx_led_power_red &pmx_led_usb1
+			      &pmx_led_usb2 &pmx_led_usb3
+			      &pmx_led_usb4 &pmx_led_otb >;
+		pinctrl-names = "default";
 
 		led-level {
 			label = "led_level";
@@ -154,6 +151,9 @@
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-0 = < &pmx_button_reset &pmx_button_otb >;
+		pinctrl-names = "default";
+
 		button at 1 {
 			label = "OTB Button";
 			linux,code = <133>;
-- 
1.7.9.5
