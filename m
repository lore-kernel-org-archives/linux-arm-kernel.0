From: yh.huang@mediatek.com (YH Huang)
Date: Tue, 18 Aug 2015 15:27:55 +0800
Subject: [PATCH v7 3/3] arm64: dts: mt8173: add MT8173 display PWM driver
 support node
In-Reply-To: <1439882875-19596-1-git-send-email-yh.huang@mediatek.com>
References: <1439882875-19596-1-git-send-email-yh.huang@mediatek.com>
Message-ID: <1439882875-19596-4-git-send-email-yh.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add display PWM node in mt8173-evb.dts and mt8173.dtsi.

Signed-off-by: YH Huang <yh.huang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts |   13 +++++++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    |   22 ++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 4be66ca..de95cf3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -92,6 +92,13 @@
 };
 
 &pio {
+	disp_pwm0_pins: disp_pwm0_pins {
+		pins1 {
+			pinmux = <MT8173_PIN_87_DISP_PWM0__FUNC_DISP_PWM0>;
+			output-low;
+		};
+	};
+
 	mmc0_pins_default: mmc0default {
 		pins_cmd_dat {
 			pinmux = <MT8173_PIN_57_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
@@ -190,6 +197,12 @@
 	};
 };
 
+&pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&disp_pwm0_pins>;
+	status = "okay";
+};
+
 &pwrap {
 	pmic: mt6397 {
 		compatible = "mediatek,mt6397";
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 6c3f047..68b1ef0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -501,6 +501,28 @@
 			#clock-cells = <1>;
 		};
 
+		pwm0: pwm at 1401e000 {
+			compatible = "mediatek,mt8173-disp-pwm",
+				     "mediatek,mt6595-disp-pwm";
+			reg = <0 0x1401e000 0 0x1000>;
+			#pwm-cells = <2>;
+			clocks = <&mmsys CLK_MM_DISP_PWM026M>,
+				 <&mmsys CLK_MM_DISP_PWM0MM>;
+			clock-names = "main", "mm";
+			status = "disabled";
+		};
+
+		pwm1: pwm at 1401f000 {
+			compatible = "mediatek,mt8173-disp-pwm",
+				     "mediatek,mt6595-disp-pwm";
+			reg = <0 0x1401f000 0 0x1000>;
+			#pwm-cells = <2>;
+			clocks = <&mmsys CLK_MM_DISP_PWM126M>,
+				 <&mmsys CLK_MM_DISP_PWM1MM>;
+			clock-names = "main", "mm";
+			status = "disabled";
+		};
+
 		imgsys: clock-controller at 15000000 {
 			compatible = "mediatek,mt8173-imgsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;
-- 
1.7.9.5
