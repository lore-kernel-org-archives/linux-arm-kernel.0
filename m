From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue,  6 Mar 2018 14:56:04 +0100
Subject: [PATCH v3 7/7] [DO NOT MERGE] arm: dts: sun8i: bpi-m2m: Add DSI
 display
In-Reply-To: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
References: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
Message-ID: <7c43c99d4faed3f37aad899d3516e606c14381e4.1520344489.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

The BananaPi M2M has an optional 1280x720 DSI panel. Since that panel is
optional, we can only show a DT patch that would show how to enable it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts | 39 +++++++++++++++++++++-
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
index eaf09666720d..e1bc9bb1c992 100644
--- a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
+++ b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
@@ -44,6 +44,7 @@
 #include "sun8i-a33.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "BananaPi M2 Magic";
@@ -81,6 +82,14 @@
 		};
 	};
 
+	pwm_bl: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <1 2 4 8 16 32 64 128 255>;
+		default-brightness-level = <8>;
+		enable-gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PG10 */
+	};
+
 	reg_vcc5v0: vcc5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0";
@@ -120,6 +129,26 @@
 	status = "okay";
 };
 
+&de {
+	status = "okay";
+};
+
+&dphy0 {
+	status = "okay";
+};
+
+&dsi0 {
+	status = "okay";
+
+	panel at 0 {
+		compatible = "bananapi,lhr050h41", "ilitek,ili9881c";
+		reg = <0>;
+		power-gpios = <&pio 1 7 GPIO_ACTIVE_HIGH>; /* PB07 */
+		reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL05 */
+		backlight = <&pwm_bl>;
+	};
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -179,6 +208,12 @@
 	status = "okay";
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins>;
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
@@ -291,6 +326,10 @@
 	status = "okay";
 };
 
+&tcon0 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_b>;
-- 
git-series 0.9.1
