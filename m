From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 20 Mar 2016 19:55:02 +0100
Subject: [PATCH v7] ARM: dts: sun8i: Add leds and switches on Orangepi Plus
 boards
Message-ID: <1458500102-11071-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Adamski <k@japko.eu>

OrangePi Plus board has two leds - green ("pwr") and red ("status")
and two switches ("sw4" and "sw2"). This patch describes them in
devicetree.

Signed-off-by: Krzysztof Adamski <k@japko.eu>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v6 (hdegoede):
-Merge leds and r_leds nodes into one
-Fix led labels to be in <board>:<colour>:<role> form
-Alphabetically sort the added nodes
-Add support for sw2 (this is the small reset-like button)
Changes in v7 (hdegoede):
-Use PL3 / PL4 in the pinctrl node, not PL03 / PL04
---
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 63 ++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index a680b1f..9d8c038 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -45,6 +45,7 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
@@ -59,6 +60,43 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	gpio_keys {
+		compatible = "gpio-keys";
+		input-name = "sw4";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&sw_r_opc>;
+
+		sw2 at 0 {
+			label = "sw2";
+			linux,code = <BTN_1>;
+			gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>;
+		};
+
+		sw4 at 0 {
+			label = "sw4";
+			linux,code = <BTN_0>;
+			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&leds_opc>, <&leds_r_opc>;
+
+		status_led {
+			label = "orangepi-plus:red:status";
+			gpios = <&pio 0 15 GPIO_ACTIVE_HIGH>;
+		};
+
+		pwr_led {
+			label = "orangepi-plus:green:pwr";
+			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+
 	reg_usb3_vbus: usb3-vbus {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -72,6 +110,31 @@
 	};
 };
 
+&pio {
+	leds_opc: led_pins at 0 {
+		allwinner,pins = "PA15";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
+&r_pio {
+	leds_r_opc: led_pins at 0 {
+		allwinner,pins = "PL10";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	sw_r_opc: key_pins at 0 {
+		allwinner,pins = "PL3", "PL4";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
 &ehci1 {
 	status = "okay";
 };
-- 
2.7.3
