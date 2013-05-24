From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 11:44:51 +0200
Subject: [PATCH 14/21] arm: kirkwood: mplcec4: affect pinmux configs to the
 right devices
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369388699-25975-15-git-send-email-thomas.petazzoni@free-electrons.com>
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
 arch/arm/boot/dts/kirkwood-mplcec4.dts |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
index 7588241..1ce1bc6 100644
--- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
+++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
@@ -18,16 +18,6 @@
 
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
-
-			pinctrl-0 = < &pmx_nand &pmx_uart0
-				      &pmx_led_health
-				      &pmx_sata0 &pmx_sata1
-				      &pmx_led_user1o
-				      &pmx_led_user1g &pmx_led_user0o
-				      &pmx_led_user0g &pmx_led_misc
-				    >;
-			pinctrl-names = "default";
-
 			pmx_led_health: pmx-led-health {
 				marvell,pins = "mpp7";
 				marvell,function = "gpo";
@@ -91,9 +81,13 @@
 
                 serial at 12000 {
                         status = "ok";
+                        pinctrl-0 = <&pmx_uart0>;
+                        pinctrl-names = "default";
                 };
 
                 nand at 3000000 {
+                        pinctrl-0 = <&pmx_nand>;
+                        pinctrl-names = "default";
                         status = "okay";
 
                         partition at 0 {
@@ -127,9 +121,10 @@
 		};
 
 		sata at 80000 {
+			pinctrl-0 = <&pmx_sata0 &pmx_sata1>;
+			pinctrl-names = "default";
 			nr-ports = <2>;
 			status = "okay";
-
 		};
 
 		mvsdio at 90000 {
@@ -143,6 +138,12 @@
 
 	gpio-leds {
 		compatible = "gpio-leds";
+		pinctrl-0 = < &pmx_led_health
+			      &pmx_led_user1o
+			      &pmx_led_user1g &pmx_led_user0o
+			      &pmx_led_user0g &pmx_led_misc
+			    >;
+		pinctrl-names = "default";
 
 		health {
 			label = "status:green:health";
-- 
1.7.9.5
