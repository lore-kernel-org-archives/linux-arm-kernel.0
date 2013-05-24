From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 11:44:41 +0200
Subject: [PATCH 04/21] arm: kirkwood: dreamplug: affect pinmux configs to the
 right devices
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369388699-25975-5-git-send-email-thomas.petazzoni@free-electrons.com>
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
 arch/arm/boot/dts/kirkwood-dreamplug.dts |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
index 289e51d..3744e07 100644
--- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -18,12 +18,6 @@
 
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
-
-			pinctrl-0 = < &pmx_spi
-				      &pmx_led_bluetooth &pmx_led_wifi
-				      &pmx_led_wifi_ap >;
-			pinctrl-names = "default";
-
 			pmx_led_bluetooth: pmx-led-bluetooth {
 				marvell,pins = "mpp47";
 				marvell,function = "gpio";
@@ -43,6 +37,8 @@
 
 		spi at 10600 {
 			status = "okay";
+			pinctrl-0 = <&pmx_spi>;
+			pinctrl-names = "default";
 
 			m25p40 at 0 {
 				#address-cells = <1>;
@@ -84,6 +80,9 @@
 
 	gpio-leds {
 		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_bluetooth &pmx_led_wifi
+			     &pmx_led_wifi_ap >;
+		pinctrl-names = "default";
 
 		bluetooth {
 			label = "dreamplug:blue:bluetooth";
-- 
1.7.9.5
