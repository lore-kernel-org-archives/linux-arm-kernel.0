From: ryder.lee@mediatek.com (Ryder Lee)
Date: Mon, 2 Oct 2017 09:54:59 +0800
Subject: [PATCH v3 09/10] arm: dts: mt7623: enable bananapi-r2 display function
In-Reply-To: <cover.1506908511.git.ryder.lee@mediatek.com>
References: <cover.1506908511.git.ryder.lee@mediatek.com>
Message-ID: <766824a45d7170c0b2cbb36a5423821a68afa3a0.1506908511.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing MIPI pin macros in mt7623-pinfunc.h and
enables pwm backlight support for bananapi-r2.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 41 +++++++++++++++++++++++++--
 include/dt-bindings/pinctrl/mt7623-pinfunc.h  | 12 ++++++++
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 688a863..267a05a 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -17,6 +17,17 @@
 		serial2 = &uart2;
 	};
 
+	backlight_lcd: backlight_lcd {
+		compatible = "pwm-backlight";
+		pwms = <&bls 0 100000>;
+		brightness-levels = <
+			  0  16  32  48  64  80  96 112
+			128 144 160 176 192 208 224 240
+			255
+		>;
+		default-brightness-level = <9>;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
@@ -86,6 +97,12 @@
 	};
 };
 
+&bls {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&bls_pins_a>;
+};
+
 &cir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&cir_pins_a>;
@@ -210,6 +227,12 @@
 };
 
 &pio {
+	bls_pins_a: bls at 0 {
+		pins_cmd_dat {
+			pinmux = <MT7623_PIN_203_PWM0_FUNC_DISP_PWM>;
+		};
+	};
+
 	cir_pins_a:cir at 0 {
 		pins_cir {
 			pinmux = <MT7623_PIN_46_IR_FUNC_IR>;
@@ -273,6 +296,21 @@
 		};
 	};
 
+	mipi_dsi_pin: mipi_dsi_pin {
+		pins_cmd_dat {
+			pinmux = <MT7623_PIN_100_MIPI_TDP0_FUNC_TDP0>,
+				 <MT7623_PIN_99_MIPI_TDN0_FUNC_TDN0>,
+				 <MT7623_PIN_98_MIPI_TDP1_FUNC_TDP1>,
+				 <MT7623_PIN_97_MIPI_TDN1_FUNC_TDN1>,
+				 <MT7623_PIN_96_MIPI_TCP_FUNC_TCP>,
+				 <MT7623_PIN_95_MIPI_TCN_FUNC_TCN>,
+				 <MT7623_PIN_94_MIPI_TDP2_FUNC_TDP2>,
+				 <MT7623_PIN_93_MIPI_TDN2_FUNC_TDN2>,
+				 <MT7623_PIN_92_MIPI_TDP3_FUNC_TDP3>,
+				 <MT7623_PIN_91_MIPI_TDN3_FUNC_TDN3>;
+		};
+	};
+
 	mmc0_pins_default: mmc0default {
 		pins_cmd_dat {
 			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_MSDC0_DAT7>,
@@ -378,8 +416,7 @@
 
 	pwm_pins_a: pwm at 0 {
 		pins_pwm {
-			pinmux = <MT7623_PIN_203_PWM0_FUNC_PWM0>,
-				 <MT7623_PIN_204_PWM1_FUNC_PWM1>,
+			pinmux = <MT7623_PIN_204_PWM1_FUNC_PWM1>,
 				 <MT7623_PIN_205_PWM2_FUNC_PWM2>,
 				 <MT7623_PIN_206_PWM3_FUNC_PWM3>,
 				 <MT7623_PIN_207_PWM4_FUNC_PWM4>;
diff --git a/include/dt-bindings/pinctrl/mt7623-pinfunc.h b/include/dt-bindings/pinctrl/mt7623-pinfunc.h
index 436a87b..72bed67 100644
--- a/include/dt-bindings/pinctrl/mt7623-pinfunc.h
+++ b/include/dt-bindings/pinctrl/mt7623-pinfunc.h
@@ -272,6 +272,18 @@
 #define MT7623_PIN_84_DSI_TE_FUNC_GPIO84 (MTK_PIN_NO(84) | 0)
 #define MT7623_PIN_84_DSI_TE_FUNC_DSI_TE (MTK_PIN_NO(84) | 1)
 
+#define MT7623_PIN_91_MIPI_TDN3_FUNC_GPIO91 (MTK_PIN_NO(91) | 0)
+#define MT7623_PIN_91_MIPI_TDN3_FUNC_TDN3 (MTK_PIN_NO(91) | 1)
+
+#define MT7623_PIN_92_MIPI_TDP3_FUNC_GPIO92 (MTK_PIN_NO(92) | 0)
+#define MT7623_PIN_92_MIPI_TDP3_FUNC_TDP3 (MTK_PIN_NO(92) | 1)
+
+#define MT7623_PIN_93_MIPI_TDN2_FUNC_GPIO93 (MTK_PIN_NO(93) | 0)
+#define MT7623_PIN_93_MIPI_TDN2_FUNC_TDN2 (MTK_PIN_NO(93) | 1)
+
+#define MT7623_PIN_94_MIPI_TDP2_FUNC_GPIO94 (MTK_PIN_NO(94) | 0)
+#define MT7623_PIN_94_MIPI_TDP2_FUNC_TDP2 (MTK_PIN_NO(94) | 1)
+
 #define MT7623_PIN_95_MIPI_TCN_FUNC_GPIO95 (MTK_PIN_NO(95) | 0)
 #define MT7623_PIN_95_MIPI_TCN_FUNC_TCN (MTK_PIN_NO(95) | 1)
 
-- 
1.9.1
