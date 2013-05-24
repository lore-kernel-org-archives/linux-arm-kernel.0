From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 11:44:39 +0200
Subject: [PATCH 02/21] arm: kirkwood: dlink dns: affect pinmux configs to the
 right devices
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369388699-25975-3-git-send-email-thomas.petazzoni@free-electrons.com>
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
 arch/arm/boot/dts/kirkwood-dns320.dts |    7 +++++++
 arch/arm/boot/dts/kirkwood-dns325.dts |    5 +++++
 arch/arm/boot/dts/kirkwood-dnskw.dtsi |   32 +++++++++++++++++---------------
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dns320.dts b/arch/arm/boot/dts/kirkwood-dns320.dts
index c9c44b2..14d4cee 100644
--- a/arch/arm/boot/dts/kirkwood-dns320.dts
+++ b/arch/arm/boot/dts/kirkwood-dns320.dts
@@ -17,6 +17,11 @@
 
 	gpio-leds {
 		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_power &pmx_led_red_usb_320
+			     &pmx_led_red_left_hdd &pmx_led_red_right_hdd
+			     &pmx_led_white_usb>;
+		pinctrl-names = "default";
+
 		blue-power {
 			label = "dns320:blue:power";
 			gpios = <&gpio0 26 1>; /* GPIO 26 Active Low */
@@ -46,6 +51,8 @@
 		};
 
 		serial at 12100 {
+			pinctrl-0 = <&pmx_uart1>;
+			pinctrl-names = "default";
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-dns325.dts b/arch/arm/boot/dts/kirkwood-dns325.dts
index e4e4930..6387257 100644
--- a/arch/arm/boot/dts/kirkwood-dns325.dts
+++ b/arch/arm/boot/dts/kirkwood-dns325.dts
@@ -17,6 +17,11 @@
 
 	gpio-leds {
 		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_power &pmx_led_red_usb_325
+			     &pmx_led_red_left_hdd &pmx_led_red_right_hdd
+			     &pmx_led_white_usb>;
+		pinctrl-names = "default";
+
 		white-power {
 			label = "dns325:white:power";
 			gpios = <&gpio0 26 1>; /* GPIO 26 Active Low */
diff --git a/arch/arm/boot/dts/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
index 6875ac0..0afe1d0 100644
--- a/arch/arm/boot/dts/kirkwood-dnskw.dtsi
+++ b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
@@ -9,6 +9,10 @@
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-0 = <&pmx_button_power &pmx_button_unmount
+			     &pmx_button_reset>;
+		pinctrl-names = "default";
+
 		button at 1 {
 			label = "Power button";
 			linux,code = <116>;
@@ -29,6 +33,8 @@
 	gpio_fan {
 		/* Fan: ADDA AD045HB-G73 40mm 6000rpm at 5v */
 		compatible = "gpio-fan";
+		pinctrl-0 = <&pmx_fan_high_speed &pmx_fan_low_speed>;
+		pinctrl-names = "default";
 		gpios = <&gpio1 14 1
 			 &gpio1 13 1>;
 		gpio-fan,speed-map = <0    0
@@ -38,27 +44,17 @@
 
 	gpio_poweroff {
 		compatible = "gpio-poweroff";
+		pinctrl-0 = <&pmx_power_off>;
+		pinctrl-names = "default";
 		gpios = <&gpio1 4 0>;
 	};
 
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
 
-			pinctrl-0 = < &pmx_nand &pmx_uart1
-				      &pmx_sata0 &pmx_sata1
-				      &pmx_led_power
-				      &pmx_led_red_right_hdd
-				      &pmx_led_red_left_hdd
-				      &pmx_led_red_usb_325
-				      &pmx_button_power
-				      &pmx_led_red_usb_320
-				      &pmx_power_off &pmx_power_back_on
-				      &pmx_power_sata0 &pmx_power_sata1
-				      &pmx_present_sata0 &pmx_present_sata1
-				      &pmx_led_white_usb &pmx_fan_tacho
-				      &pmx_fan_high_speed &pmx_fan_low_speed
-				      &pmx_button_unmount &pmx_button_reset
-				      &pmx_temp_alarm >;
+			pinctrl-0 = <&pmx_power_back_on &pmx_present_sata0
+				     &pmx_present_sata1 &pmx_fan_tacho
+				     &pmx_temp_alarm>;
 			pinctrl-names = "default";
 
 			pmx_sata0: pmx-sata0 {
@@ -147,11 +143,15 @@
 			};
 		};
 		sata at 80000 {
+			pinctrl-0 = <&pmx_sata0 &pmx_sata1>;
+			pinctrl-names = "default";
 			status = "okay";
 			nr-ports = <2>;
 		};
 
 		nand at 3000000 {
+			pinctrl-0 = <&pmx_nand>;
+			pinctrl-names = "default";
 			status = "okay";
 			chip-delay = <35>;
 
@@ -192,6 +192,8 @@
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-0 = <&pmx_power_sata0 &pmx_power_sata1>;
+		pinctrl-names = "default";
 
 		sata0_power: regulator at 1 {
 			compatible = "regulator-fixed";
-- 
1.7.9.5
