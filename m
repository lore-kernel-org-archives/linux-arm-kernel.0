From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 11:44:53 +0200
Subject: [PATCH 16/21] arm: kirkwood: nsa310: affect pinmux configs to the
 right devices
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369388699-25975-17-git-send-email-thomas.petazzoni@free-electrons.com>
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
 arch/arm/boot/dts/kirkwood-nsa310.dts |   29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
index a7412b9..79391ca 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
@@ -17,22 +17,7 @@
 
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
-			pinctrl-0 = < &pmx_led_esata_green
-				      &pmx_led_esata_red
-				      &pmx_led_usb_green
-				      &pmx_led_usb_red
-				      &pmx_usb_power_off
-				      &pmx_led_sys_green
-				      &pmx_led_sys_red
-				      &pmx_btn_reset
-				      &pmx_btn_copy
-				      &pmx_led_copy_green
-				      &pmx_led_copy_red
-				      &pmx_led_hdd_green
-				      &pmx_led_hdd_red
-				      &pmx_unknown
-				      &pmx_btn_power
-				      &pmx_pwr_off >;
+			pinctrl-0 = <&pmx_unknown>;
 			pinctrl-names = "default";
 
 			pmx_led_esata_green: pmx-led-esata-green {
@@ -182,6 +167,8 @@
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-0 = <&pmx_btn_reset &pmx_btn_copy &pmx_btn_power>;
+		pinctrl-names = "default";
 
 		button at 1 {
 			label = "Power Button";
@@ -202,6 +189,12 @@
 
 	gpio-leds {
 		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_esata_green &pmx_led_esata_red
+			     &pmx_led_usb_green &pmx_led_usb_red
+			     &pmx_led_sys_green &pmx_led_sys_red
+			     &pmx_led_copy_green &pmx_led_copy_red
+			     &pmx_led_hdd_green &pmx_led_hdd_red>;
+		pinctrl-names = "default";
 
 		green-sys {
 			label = "nsa310:green:sys";
@@ -247,6 +240,8 @@
 
 	gpio_poweroff {
 		compatible = "gpio-poweroff";
+		pinctrl-0 = <&pmx_pwr_off>;
+		pinctrl-names = "default";
 		gpios = <&gpio1 16 0>;
 	};
 
@@ -254,6 +249,8 @@
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-0 = <&pmx_usb_power_off>;
+		pinctrl-names = "default";
 
 		usb0_power_off: regulator at 1 {
 			compatible = "regulator-fixed";
-- 
1.7.9.5
