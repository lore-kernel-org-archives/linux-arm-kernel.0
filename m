From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 16 Jan 2017 11:22:45 +0100
Subject: [PATCH] ARM64: meson-gxbb-p200: add ADC laddered keys
Message-ID: <1484562165-29449-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the 5 buttons connected to a resistor laddered matrix and sampled
by the SAR ADC channel 0.

Only the p200 board has these buttons, the P201 doesn't.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts | 50 +++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

This patch depends on Martin Blumenstingl's sar adc patchset at [1].

[1] http://lkml.kernel.org/r/20170115224221.15510-1-martin.blumenstingl at googlemail.com

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
index af7b151..3051cc8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
@@ -45,6 +45,7 @@
 /dts-v1/;
 
 #include "meson-gxbb-p20x.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	compatible = "amlogic,p200", "amlogic,meson-gxbb";
@@ -58,6 +59,50 @@
 		 */
 		linux,usable-memory = <0x0 0x1000000 0x0 0x3f000000>;
 	};
+
+	avdd18_usb_adc: regulator-avdd18_usb_adc {
+		compatible = "regulator-fixed";
+		regulator-name = "AVDD18_USB_ADC";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	adc_keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+
+		button-home {
+			label = "Home";
+			linux,code = <KEY_HOME>;
+			press-threshold-microvolt = <900000>; /* 50% */
+		};
+
+		button-esc {
+			label = "Esc";
+			linux,code = <KEY_ESC>;
+			press-threshold-microvolt = <684000>; /* 38% */
+		};
+
+		button-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			press-threshold-microvolt = <468000>; /* 26% */
+		};
+
+		button-down {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			press-threshold-microvolt = <252000>; /* 14% */
+		};
+
+		button-menu {
+			label = "Menu";
+			linux,code = <KEY_MENU>;
+			press-threshold-microvolt = <0>; /* 0% */
+		};
+	};
 };
 
 &i2c_B {
@@ -65,3 +110,8 @@
 	pinctrl-0 = <&i2c_b_pins>;
 	pinctrl-names = "default";
 };
+
+&saradc {
+	status = "okay";
+	vref-supply = <&avdd18_usb_adc>;
+};
-- 
1.9.1
