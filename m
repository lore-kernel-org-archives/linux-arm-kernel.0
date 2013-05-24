From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 11:44:40 +0200
Subject: [PATCH 03/21] arm: kirkwood: dockstar: affect pinmux configs to the
 right devices
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369388699-25975-4-git-send-email-thomas.petazzoni@free-electrons.com>
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
 arch/arm/boot/dts/kirkwood-dockstar.dts |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dockstar.dts b/arch/arm/boot/dts/kirkwood-dockstar.dts
index 0196cf6..7714742 100644
--- a/arch/arm/boot/dts/kirkwood-dockstar.dts
+++ b/arch/arm/boot/dts/kirkwood-dockstar.dts
@@ -18,11 +18,6 @@
 
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
-
-			pinctrl-0 = < &pmx_usb_power_enable
-				      &pmx_led_green &pmx_led_orange >;
-			pinctrl-names = "default";
-
 			pmx_usb_power_enable: pmx-usb-power-enable {
 				marvell,pins = "mpp29";
 				marvell,function = "gpio";
@@ -62,6 +57,8 @@
 	};
 	gpio-leds {
 		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_green &pmx_led_orange>;
+		pinctrl-names = "default";
 
 		health {
 			label = "status:green:health";
@@ -77,6 +74,8 @@
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-0 = <&pmx_usb_power_enable>;
+		pinctrl-names = "default";
 
 		usb_power: regulator at 1 {
 			compatible = "regulator-fixed";
-- 
1.7.9.5
