From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 11:44:42 +0200
Subject: [PATCH 05/21] arm: kirkwood: goflexnet: affect pinmux configs to the
 right devices
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369388699-25975-6-git-send-email-thomas.petazzoni@free-electrons.com>
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
 arch/arm/boot/dts/kirkwood-goflexnet.dts |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-goflexnet.dts b/arch/arm/boot/dts/kirkwood-goflexnet.dts
index c3573be..31caa64 100644
--- a/arch/arm/boot/dts/kirkwood-goflexnet.dts
+++ b/arch/arm/boot/dts/kirkwood-goflexnet.dts
@@ -18,15 +18,6 @@
 
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
-
-			pinctrl-0 = < &pmx_usb_power_enable &pmx_led_orange
-				      &pmx_led_left_cap_0 &pmx_led_left_cap_1
-				      &pmx_led_left_cap_2 &pmx_led_left_cap_3
-				      &pmx_led_right_cap_0 &pmx_led_right_cap_1
-				      &pmx_led_right_cap_2 &pmx_led_right_cap_3
-				    >;
-			pinctrl-names = "default";
-
 			pmx_usb_power_enable: pmx-usb-power-enable {
 				marvell,pins = "mpp29";
 				marvell,function = "gpio";
@@ -109,6 +100,13 @@
 	};
 	gpio-leds {
 		compatible = "gpio-leds";
+		pinctrl-0 = < &pmx_led_orange
+			      &pmx_led_left_cap_0 &pmx_led_left_cap_1
+			      &pmx_led_left_cap_2 &pmx_led_left_cap_3
+			      &pmx_led_right_cap_0 &pmx_led_right_cap_1
+			      &pmx_led_right_cap_2 &pmx_led_right_cap_3
+			    >;
+		pinctrl-names = "default";
 
 		health {
 			label = "status:green:health";
@@ -156,6 +154,8 @@
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-0 = <&pmx_usb_power_enable>;
+		pinctrl-names = "default";
 
 		usb_power: regulator at 1 {
 			compatible = "regulator-fixed";
-- 
1.7.9.5
