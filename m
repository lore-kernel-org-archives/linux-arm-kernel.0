From: contact@paulk.fr (Paul Kocialkowski)
Date: Wed,  7 Nov 2018 19:18:43 +0100
Subject: [PATCH NOT FOR MERGE v3 8/8] ARM: dts: sun7i-a20-bananapi: Add
 bindings for the LeMaker 3.5" LCD
In-Reply-To: <20181107181843.27628-1-contact@paulk.fr>
References: <20181107181843.27628-1-contact@paulk.fr>
Message-ID: <20181107181843.27628-9-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the backlight panel, power, pwm and tcon0 device-tree bindings
required for supporting the 3.5" LCD from LeMaker on the BananaPi M1.

The brightness levels are adjusted with a gamma curve using a 1.8 power,
with indices from 0 to 100 and values ranging from 0 to 255, such as:
level = (index / 100)^1.8 * 255

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts | 71 ++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 70dfc4ac0bb5..ac6c3e988203 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -48,6 +48,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "LeMaker Banana Pi";
@@ -63,6 +64,57 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 50000 0>;
+		/* This table uses a gamma curve with a 1.8 power. */
+		brightness-levels = <  0   1   1   1   1   1   2   2
+				       3   3   4   5   6   6   7   8
+				       9  11  12  13  14  15  17  18
+				      20  21  23  24  26  27  29  31
+				      33  35  37  39  41  43  45  47
+				      49  51  54  56  58  61  63  66
+				      68  71  73  76  79  81  84  87
+				      90  93  96  99 102 105 108 111
+				     114 117 121 124 127 131 134 138
+				     141 145 148 152 156 159 163 167
+				     171 175 178 182 186 190 194 198
+				     203 207 211 215 219 224 228 233
+				     237 241 246 250 255>;
+		default-brightness-level = <50>;
+		enable-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
+	};
+
+	panel: panel {
+		compatible = "lemaker,bl035-rgb-002";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-supply = <&panel_power>;
+		backlight = <&backlight>;
+
+		port at 0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			panel_input: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&tcon0_out_panel>;
+			};
+		};
+	};
+
+	panel_power: panel_power {
+		compatible = "regulator-fixed";
+		regulator-name = "panel-power";
+		regulator-min-microvolt = <10400000>;
+		regulator-max-microvolt = <10400000>;
+		gpio = <&pio 7 12 GPIO_ACTIVE_HIGH>; /* PH12 */
+		enable-active-high;
+		regulator-boot-on;
+	};
+
 	hdmi-connector {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -275,6 +327,12 @@
 	};
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins_a>;
+	status = "okay";
+};
+
 #include "axp209.dtsi"
 
 &reg_dcdc2 {
@@ -322,6 +380,19 @@
 	status = "okay";
 };
 
+&tcon0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd0_rgb888_pins>;
+	status = "okay";
+};
+
+&tcon0_out {
+	tcon0_out_panel: endpoint at 0 {
+		reg = <0>;
+		remote-endpoint = <&panel_input>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.19.1
