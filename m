From: erin.lo@mediatek.com (Erin Lo)
Date: Thu, 1 Jun 2017 14:08:43 +0800
Subject: [PATCH 2/3] arm: dts: mt2701: Add display bls related nodes for MT2701
In-Reply-To: <1496297324-21091-1-git-send-email-erin.lo@mediatek.com>
References: <1496297324-21091-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1496297324-21091-3-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: YT Shen <yt.shen@mediatek.com>

This patch adds the device node of display backlight for MT2701

Signed-off-by: Weiqing Kong <weiqing.kong@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 arch/arm/boot/dts/mt2701-evb.dts | 29 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/mt2701.dtsi    |  9 +++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701-evb.dts b/arch/arm/boot/dts/mt2701-evb.dts
index a483798..e49c2b7 100644
--- a/arch/arm/boot/dts/mt2701-evb.dts
+++ b/arch/arm/boot/dts/mt2701-evb.dts
@@ -22,6 +22,35 @@
 	memory {
 		reg = <0 0x80000000 0 0x40000000>;
 	};
+
+	backlight_lcd: backlight_lcd {
+		compatible = "pwm-backlight";
+		pwms = <&bls 0 100000>;
+		brightness-levels = <
+			  0  16  32  48  64  80  96 112
+			128 144 160 176 192 208 224 240
+			255
+		>;
+		default-brightness-level = <9>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm_bls_gpio>;
+	};
+};
+
+&bls {
+	status = "okay";
+};
+
+&mmsys {
+	status = "okay";
+};
+
+&pio {
+	pwm_bls_gpio: pwm_bls_gpio {
+		pins_cmd_dat {
+			pinmux = <MT2701_PIN_208_AUD_EXT_CK1__FUNC_DISP_PWM>;
+		};
+	};
 };
 
 &auxadc {
diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index de88bd7..4f110d5 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -366,6 +366,15 @@
 		#clock-cells = <1>;
 	};
 
+	bls: bls at 1400a000 {
+		compatible = "mediatek,mt2701-disp-pwm";
+		reg = <0 0x1400a000 0 0x1000>;
+		#pwm-cells = <2>;
+		clocks = <&mmsys CLK_MM_MDP_BLS_26M>, <&mmsys CLK_MM_DISP_BLS>;
+		clock-names = "main", "mm";
+		status = "disabled";
+	};
+
 	larb0: larb at 14010000 {
 		compatible = "mediatek,mt2701-smi-larb";
 		reg = <0 0x14010000 0 0x1000>;
-- 
1.9.1
