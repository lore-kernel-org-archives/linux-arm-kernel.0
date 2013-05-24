From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 11:44:52 +0200
Subject: [PATCH 15/21] arm: kirkwood: readynas: affect pinmux configs to the
 right devices
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369388699-25975-16-git-send-email-thomas.petazzoni@free-electrons.com>
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
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |   22 +++++++++-----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
index 1ca66ab..b79ea8c 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
@@ -18,18 +18,6 @@
 
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
-
-			pinctrl-0 = < &pmx_uart0
-				      &pmx_button_power
-				      &pmx_button_backup
-				      &pmx_button_reset
-				      &pmx_led_blue_power
-				      &pmx_led_blue_activity
-				      &pmx_led_blue_disk1
-				      &pmx_led_blue_disk2
-				      &pmx_led_blue_backup >;
-			pinctrl-names = "default";
-
 			pmx_button_power: pmx-button-power {
 				marvell,pins = "mpp47";
 				marvell,function = "gpio";
@@ -74,6 +62,8 @@
 		};
 
 		serial at 12000 {
+			pinctrl-0 = <&pmx_uart0>;
+			pinctrl-names = "default";
 			status = "okay";
 		};
 
@@ -115,6 +105,10 @@
 
 	gpio-leds {
 		compatible = "gpio-leds";
+		pinctrl-0 = < &pmx_led_blue_power &pmx_led_blue_activity
+			      &pmx_led_blue_disk1 &pmx_led_blue_disk2
+			      &pmx_led_blue_backup >;
+		pinctrl-names = "default";
 
 		power_led {
 			label = "status:blue:power_led";
@@ -143,6 +137,10 @@
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-0 = <&pmx_button_power &pmx_button_backup
+			     &pmx_button_reset>;
+		pinctrl-names = "default";
+
 		button at 1 {
 			label = "Power Button";
 			linux,code = <116>;     /* KEY_POWER */
-- 
1.7.9.5
