From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 11:44:47 +0200
Subject: [PATCH 10/21] arm: kirkwood: iomega ix2-200: affect pinmux configs to
 the right devices
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369388699-25975-11-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the pinmux mechanism was added in Kirkwood, the device driver
core was not yet providing the possibility of attaching pinmux
configurations to all devices, drivers had to do it explicitly, and
not all drivers were doing this.

Now that the driver core does that in a generic way, it makes sense to
attach the pinmux configuration to their corresponding devices.

Note that some of the LEDs pinmux configurations are kept in the
pinctrl node, because they are not used by the gpio-leds driver.

This allows the pinctrl subsystem to show in debugfs to which device
is related which pins, for example:

pin 41 (PIN41): gpio-leds.1 mvebu-gpio:41 function gpio group mpp41
pin 42 (PIN42): gpio-leds.1 mvebu-gpio:42 function gpio group mpp42
pin 43 (PIN43): gpio-leds.1 mvebu-gpio:43 function gpio group mpp43

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
index 3694e94..00a7bfe 100644
--- a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
+++ b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
@@ -18,12 +18,7 @@
 
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
-
-			pinctrl-0 = < &pmx_button_reset &pmx_button_power
-				      &pmx_led_backup &pmx_led_power
-				      &pmx_button_otb &pmx_led_rebuild
-				      &pmx_led_health
-				      &pmx_led_sata_brt_ctrl_1
+			pinctrl-0 = < &pmx_led_sata_brt_ctrl_1
 				      &pmx_led_sata_brt_ctrl_2
 				      &pmx_led_backup_brt_ctrl_1
 				      &pmx_led_backup_brt_ctrl_2
@@ -151,6 +146,9 @@
 	};
 	gpio-leds {
 		compatible = "gpio-leds";
+		pinctrl-0 = < &pmx_led_backup &pmx_led_power
+			      &pmx_led_rebuild &pmx_led_health >;
+		pinctrl-names = "default";
 
 		power_led {
 			label = "status:white:power_led";
@@ -174,6 +172,11 @@
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-0 = <&pmx_button_reset &pmx_button_power
+			     &pmx_button_otb>;
+		pinctrl-names = "default";
+
+
 		Power {
 			label = "Power Button";
 			linux,code = <116>;
-- 
1.7.9.5
