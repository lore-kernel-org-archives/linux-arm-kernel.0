From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 16 Nov 2016 14:15:08 +0100
Subject: [PATCH v2] ARM: dts: sun5i: Add touchscreen node to
 reference-design-tablet.dtsi
Message-ID: <20161116131508.12541-1-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like on sun8i all sun5i tablets use the same interrupt and power
gpios for their touchscreens. I've checked all known a13 fex files and
only the UTOO P66 uses a different gpio for the interrupt.

Add a touchscreen node to sun5i-reference-design-tablet.dtsi, which
fills in the necessary gpios to avoid duplication in the tablet dts files,
just like we do in sun8i-reference-design-tablet.dtsi.

This will make future patches adding touchscreen nodes to a13 tablets
simpler.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Use generic pin mux properties "pins", "function", "drive-strength" and
 "bias-disable"
---
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts           | 38 ++++++++--------------
 .../boot/dts/sun5i-reference-design-tablet.dtsi    | 25 ++++++++++++++
 2 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
index a8b0bcc..3d7ff10 100644
--- a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
+++ b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
@@ -83,22 +83,6 @@
 	allwinner,pins = "PG3";
 };
 
-&i2c1 {
-	icn8318: touchscreen at 40 {
-		compatible = "chipone,icn8318";
-		reg = <0x40>;
-		interrupt-parent = <&pio>;
-		interrupts = <6 9 IRQ_TYPE_EDGE_FALLING>; /* EINT9 (PG9) */
-		pinctrl-names = "default";
-		pinctrl-0 = <&ts_wake_pin_p66>;
-		wake-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
-		touchscreen-size-x = <800>;
-		touchscreen-size-y = <480>;
-		touchscreen-inverted-x;
-		touchscreen-swapped-x-y;
-	};
-};
-
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins_a>;
@@ -121,20 +105,26 @@
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 	};
-
-	ts_wake_pin_p66: ts_wake_pin at 0 {
-		allwinner,pins = "PB3";
-		allwinner,function = "gpio_out";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-	};
-
 };
 
 &reg_usb0_vbus {
 	gpio = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
 };
 
+&touchscreen {
+	compatible = "chipone,icn8318";
+	reg = <0x40>;
+	/* The P66 uses a different EINT then the reference design */
+	interrupts = <6 9 IRQ_TYPE_EDGE_FALLING>; /* EINT9 (PG9) */
+	/* The icn8318 binding expects wake-gpios instead of power-gpios */
+	wake-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
+	touchscreen-size-x = <800>;
+	touchscreen-size-y = <480>;
+	touchscreen-inverted-x;
+	touchscreen-swapped-x-y;
+	status = "okay";
+};
+
 &uart1 {
 	/* The P66 uses the uart pins as gpios */
 	status = "disabled";
diff --git a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
index 20cc940..82f87cd 100644
--- a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
@@ -41,6 +41,7 @@
  */
 #include "sunxi-reference-design-tablet.dtsi"
 
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pwm/pwm.h>
 
 / {
@@ -84,6 +85,23 @@
 };
 
 &i2c1 {
+	/*
+	 * The gsl1680 is rated at 400KHz and it will not work reliable at
+	 * 100KHz, this has been confirmed on multiple different q8 tablets.
+	 * All other devices on this bus are also rated for 400KHz.
+	 */
+	clock-frequency = <400000>;
+
+	touchscreen: touchscreen {
+		interrupt-parent = <&pio>;
+		interrupts = <6 11 IRQ_TYPE_EDGE_FALLING>; /* EINT11 (PG11) */
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_power_pin>;
+		power-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
+		/* Tablet dts must provide reg and compatible */
+		status = "disabled";
+	};
+
 	pcf8563: rtc at 51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
@@ -125,6 +143,13 @@
 		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 	};
 
+	ts_power_pin: ts_power_pin {
+		pins = "PB3";
+		function = "gpio_out";
+		drive-strength = <10>;
+		bias-disable;
+	};
+
 	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
 		allwinner,pins = "PG1";
 		allwinner,function = "gpio_in";
-- 
2.9.3
