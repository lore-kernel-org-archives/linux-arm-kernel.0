From: k@japko.eu (Krzysztof Adamski)
Date: Mon, 22 Feb 2016 14:03:28 +0100
Subject: [PATCH v5 4/4] ARM: dts: sun8i: Add leds and switch on Orangepi Plus
 boards
In-Reply-To: <1456146208-13890-1-git-send-email-k@japko.eu>
References: <1456146208-13890-1-git-send-email-k@japko.eu>
Message-ID: <1456146208-13890-5-git-send-email-k@japko.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OrangePi Plus board has two leds - green ("pwr") and red ("status")
and a switch ("sw4"). This patch describes them in a devicetree.

Signed-off-by: Krzysztof Adamski <k@japko.eu>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 63 ++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index e67df59..5f159d0 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -45,6 +45,7 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
@@ -58,6 +59,68 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&leds_opc>;
+
+		status_led {
+			label = "status:red:user";
+			gpios = <&pio 0 15 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	r_leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&leds_r_opc>;
+
+		tx {
+			label = "pwr:green:user";
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
