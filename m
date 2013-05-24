From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 11:44:44 +0200
Subject: [PATCH 07/21] arm: kirkwood: ib62x0: affect pinmux configs to the
 right devices
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369388699-25975-8-git-send-email-thomas.petazzoni@free-electrons.com>
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
 arch/arm/boot/dts/kirkwood-ib62x0.dts |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
index 5335b1a..20c4b08 100644
--- a/arch/arm/boot/dts/kirkwood-ib62x0.dts
+++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
@@ -18,13 +18,6 @@
 
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
-
-			pinctrl-0 = < &pmx_nand
-				      &pmx_led_os_red &pmx_power_off
-				      &pmx_led_os_green &pmx_led_usb_transfer
-				      &pmx_button_reset &pmx_button_usb_copy >;
-			pinctrl-names = "default";
-
 			pmx_led_os_red: pmx-led-os-red {
 				marvell,pins = "mpp22";
 				marvell,function = "gpio";
@@ -61,6 +54,8 @@
 
 		nand at 3000000 {
 			status = "okay";
+			pinctrl-0 = <&pmx_nand>;
+			pinctrl-names = "default";
 
 			partition at 0 {
 				label = "u-boot";
@@ -84,6 +79,9 @@
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-0 = <&pmx_button_reset &pmx_button_usb_copy>;
+		pinctrl-names = "default";
+
 		button at 1 {
 			label = "USB Copy";
 			linux,code = <133>;
@@ -97,6 +95,9 @@
 	};
 	gpio-leds {
 		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_os_red &pmx_led_os_green
+			     &pmx_led_usb_transfer>;
+		pinctrl-names = "default";
 
 		green-os {
 			label = "ib62x0:green:os";
@@ -114,6 +115,8 @@
 	};
 	gpio_poweroff {
 		compatible = "gpio-poweroff";
+		pinctrl-0 = <&pmx_power_off>;
+		pinctrl-names = "default";
 		gpios = <&gpio0 24 0>;
 	};
 
-- 
1.7.9.5
