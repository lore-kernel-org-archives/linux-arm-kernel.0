From: k@japko.eu (Krzysztof Adamski)
Date: Thu, 25 Feb 2016 21:42:35 +0100
Subject: [PATCH v2] ARM: dts: sun8i: Add leds and switch on Orangepi Plus
 boards
Message-ID: <20160225204234.GA31610@box2.japko.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OrangePi Plus board has dwo leds - green ("pwr") and red ("status")
and a switch ("sw4"). This patch describes them in a devicetree.

Signed-off-by: Krzysztof Adamski <k@japko.eu>
---

Changes compared to v1:
 - Fixed leds labels
 - Merged two led sections into one


 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 57 ++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index e67df59..d81eca6 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -45,6 +45,7 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
@@ -58,6 +59,62 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&leds_opc &leds_r_opc>;
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
+	r_gpio_keys {
+		compatible = "gpio-keys";
+		input-name = "sw4";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&sw_r_opc>;
+
+		sw4 at 0 {
+			label = "sw4";
+			linux,code = <BTN_0>;
+			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
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
+		allwinner,pins = "PL03";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 };
 
 &mmc0 {
-- 
2.1.4
