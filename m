From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Nov 2012 11:55:14 -0700
Subject: [PATCH] ARM: tegra: seaboard: enable internal LCD
Message-ID: <1353092114-18410-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Enable host1x and add the rgb (LCD) output.

Also add the power sequence that controls the backlight and panel. The
sequence strictly follows the order and timings of the panel
specification.

Currently the backlight device controls both backlight and panel, this
needs to be fixed once the panel framework supports power sequences.

Based on (cut/paste) work for Ventana by Alexandre Courbot.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20-seaboard.dts |  127 +++++++++++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index eafeca6..a999430 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -10,6 +10,16 @@
 		reg = <0x00000000 0x40000000>;
 	};
 
+	host1x {
+		dc at 54200000 {
+			rgb {
+				status = "okay";
+				nvidia,ddc-i2c-bus = <&lcd_ddc>;
+				backlight = <&backlight>;
+			};
+		};
+	};
+
 	pinmux {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
@@ -351,7 +361,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c at 1 {
+		lcd_ddc: i2c at 1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -600,6 +610,101 @@
 		};
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		brightness-levels = <0 16 32 48 64 80 96 112 128 144 160 176 192 208 224 240 255>;
+		default-brightness-level = <12>;
+
+		/* resources used by the power sequences */
+		pwms = <&pwm 2 5000000>;
+		pwm-names = "backlight";
+		power-supply = <&vdd_bl_reg>;
+		panel-supply = <&vdd_panel_reg>;
+
+		power-sequences {
+			power-on {
+				/*
+				 * Panel power and LVDS enable.
+				 * TODO: move into the panel device as soon as
+				 * panel framework supports power sequences.
+				 */
+				step0 {
+					type = "regulator";
+					id = "panel";
+					enable;
+				};
+				step1 {
+					/* LVDS_SHTDN* */
+					type = "gpio";
+					gpio = <&gpio 10 0>; /* GPIO PC6 */ 
+					value = <1>;
+				};
+				step2 {
+					type = "delay";
+					delay = <200000>;
+				};
+				/* Backlight sequence. This belongs here. */
+				step3 {
+					type = "regulator";
+					id = "power";
+					enable;
+				};
+				step4 {
+					type = "delay";
+					delay = <10000>;
+				};
+				step5 {
+					type = "pwm";
+					id = "backlight";
+					enable;
+				};
+				step6 {
+					/* LCD_BL_EN */
+					type = "gpio";
+					gpio = <&gpio 28 0>; /* GPIO PD4 */
+					value = <1>;
+				};
+			};
+
+			power-off {
+				step0 {
+					type = "gpio";
+					gpio = <&gpio 28 0>;
+					value = <0>;
+				};
+				step1 {
+					type = "pwm";
+					id = "backlight";
+					disable;
+				};
+				step2 {
+					type = "delay";
+					delay = <10000>;
+				};
+				step3 {
+					type = "regulator";
+					id = "power";
+					disable;
+				};
+				/* This also belongs to the panel sequence */
+				step4 {
+					type = "delay";
+					delay = <200000>;
+				};
+				step5 {
+					type = "gpio";
+					gpio = <&gpio 10 0>;
+					value = <0>;
+				};
+				step6 {
+					type = "regulator";
+					id = "panel";
+					disable;
+				};
+			};
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -632,6 +737,26 @@
 			gpio = <&pmic 1 0>;
 			enable-active-high;
 		};
+
+		vdd_panel_reg: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "vdd_pnl";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			gpio = <&gpio 22 0>; /* gpio PC6 */
+			enable-active-high;
+		};
+
+		vdd_bl_reg: regulator at 4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+			regulator-name = "vdd_bl";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			gpio = <&gpio 176 0>; /* gpio PW0 */
+			enable-active-high;
+		};
 	};
 
 	sound {
-- 
1.7.10.4
