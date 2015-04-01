From: hdegoede@redhat.com (Hans de Goede)
Date: Wed,  1 Apr 2015 17:29:37 +0200
Subject: [PATCH v2] ARM: dts: sun5i: Enable touchscreen on Utoo P66
Message-ID: <1427902177-26526-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node for the chipone-icn8318 touchscreen found on the Utoo P66 tablet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Fix touchscreen node name
---
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
index 9108ecd..00bdf28 100644
--- a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
+++ b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
@@ -50,6 +50,7 @@
 #include "sunxi-common-regulators.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
@@ -93,6 +94,20 @@
 	pinctrl-0 = <&i2c1_pins_a>;
 	status = "okay";
 
+	icn8318: touchscreen at 40 {
+		compatible = "chipone,icn8318";
+		reg = <0x40>;
+		interrupt-parent = <&pio>;
+		interrupts = <9 IRQ_TYPE_EDGE_FALLING>; /* EINT9 (PG9) */
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_wake_pin_p66>;
+		wake-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+		touchscreen-inverted-x;
+		touchscreen-swapped-x-y;
+	};
+
 	pcf8563: rtc at 51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
@@ -172,6 +187,13 @@
 		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 	};
 
+	ts_wake_pin_p66: ts_wake_pin at 0 {
+		allwinner,pins = "PB3";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	usb0_vbus_pin_a: usb0_vbus_pin at 0 {
 		allwinner,pins = "PB4";
 		allwinner,function = "gpio_out";
-- 
2.3.4
