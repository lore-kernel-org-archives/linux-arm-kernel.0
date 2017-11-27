From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Nov 2017 16:41:42 +0100
Subject: [PATCH v2 18/18] ARM: dts: sun8i: a711: Enable the LCD
In-Reply-To: <cover.d89f3ea4e1698f9343aef4852977c80edc75f21a.1511797218.git-series.maxime.ripard@free-electrons.com>
References: <cover.d89f3ea4e1698f9343aef4852977c80edc75f21a.1511797218.git-series.maxime.ripard@free-electrons.com>
Message-ID: <1a9c9ec49f2b0c55e9a72205e87474a0bc34d9f7.1511797218.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A711 has 1024x600 LVDS panel, with a PWM-based backlight. Add it to our
DT.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 61 ++++++++++++++++++++++++-
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index a021ee6da396..511fca491fe8 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -45,6 +45,7 @@
 #include "sun8i-a83t.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "TBS A711 Tablet";
@@ -59,6 +60,44 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
+		enable-gpios = <&pio 3 29 GPIO_ACTIVE_HIGH>;
+
+		brightness-levels = <0 1 2 4 8 16 32 64 128 255>;
+		default-brightness-level = <9>;
+	};
+
+	panel {
+		compatible = "tbs,a711-panel", "panel-lvds";
+		backlight = <&backlight>;
+		power-supply = <&reg_sw>;
+
+		width-mm = <153>;
+		height-mm = <90>;
+		data-mapping = "vesa-24";
+
+		panel-timing {
+			/* 1024x600 @60Hz */
+			clock-frequency = <52000000>;
+			hactive = <1024>;
+			vactive = <600>;
+			hsync-len = <20>;
+			hfront-porch = <180>;
+			hback-porch = <160>;
+			vfront-porch = <12>;
+			vback-porch = <23>;
+			vsync-len = <5>;
+		};
+
+		port {
+			panel_input: endpoint {
+				remote-endpoint = <&tcon0_out_lcd>;
+			};
+		};
+	};
+
 	reg_vbat: reg-vbat {
 		compatible = "regulator-fixed";
 		regulator-name = "vbat";
@@ -89,6 +128,10 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
 /*
  * An USB-2 hub is connected here, which also means we don't need to
  * enable the OHCI controller.
@@ -142,6 +185,12 @@
 	status = "okay";
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_pin>;
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
@@ -323,6 +372,18 @@
 	regulator-name = "vcc-lcd";
 };
 
+&tcon0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd_lvds_pins>;
+};
+
+&tcon0_out {
+	tcon0_out_lcd: endpoint at 0 {
+		reg = <0>;
+		remote-endpoint = <&panel_input>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
git-series 0.9.1
