From: yong.mao@mediatek.com (Yong Mao)
Date: Tue, 8 Nov 2016 14:09:01 +0800
Subject: [PATCH 4/4] dts: arm64: enable mmc3 for supporting sdio feature
In-Reply-To: <1478585341-6749-1-git-send-email-yong.mao@mediatek.com>
References: <1478585341-6749-1-git-send-email-yong.mao@mediatek.com>
Message-ID: <1478585341-6749-5-git-send-email-yong.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: yong mao <yong.mao@mediatek.com>

Add description of mmc3 for supporting sdio feature

Signed-off-by: Yong Mao <yong.mao@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts |   82 +++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 2a7f731..4dbd299 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -43,6 +43,14 @@
 		enable-active-high;
 	};
 
+	sdio_fixed_3v3: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pio 85 GPIO_ACTIVE_HIGH>;
+	};
+
 	connector {
 		compatible = "hdmi-connector";
 		label = "hdmi";
@@ -139,6 +147,25 @@
 	vqmmc-supply = <&mt6397_vmc_reg>;
 };
 
+&mmc3 {
+	status = "okay";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc3_pins_default>;
+	pinctrl-1 = <&mmc3_pins_uhs>;
+	bus-width = <4>;
+	max-frequency = <200000000>;
+	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	sdr104-clk-delay = <5>;
+	keep-power-in-suspend;
+	enable-sdio-wakeup;
+	cap-sdio-irq;
+	vmmc-supply = <&sdio_fixed_3v3>;
+	vqmmc-supply = <&mt6397_vgp3_reg>;
+	non-removable;
+};
+
 &pio {
 	disp_pwm0_pins: disp_pwm0_pins {
 		pins1 {
@@ -197,6 +224,36 @@
 		};
 	};
 
+	mmc3_pins_default: mmc3default {
+		pins_dat {
+			pinmux = <MT8173_PIN_22_MSDC3_DAT0__FUNC_MSDC3_DAT0>,
+				 <MT8173_PIN_23_MSDC3_DAT1__FUNC_MSDC3_DAT1>,
+				 <MT8173_PIN_24_MSDC3_DAT2__FUNC_MSDC3_DAT2>,
+				 <MT8173_PIN_25_MSDC3_DAT3__FUNC_MSDC3_DAT3>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins_cmd {
+			pinmux = <MT8173_PIN_27_MSDC3_CMD__FUNC_MSDC3_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins_clk {
+			pinmux = <MT8173_PIN_26_MSDC3_CLK__FUNC_MSDC3_CLK>;
+			bias-pull-down;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+
+		pins_pdn {
+			pinmux = <MT8173_PIN_85_AUD_DAT_MOSI__FUNC_GPIO85>;
+			output-low;
+		};
+	};
+
 	mmc0_pins_uhs: mmc0 {
 		pins_cmd_dat {
 			pinmux = <MT8173_PIN_57_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
@@ -243,6 +300,31 @@
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 	};
+
+	mmc3_pins_uhs: mmc3 {
+		pins_dat {
+			pinmux = <MT8173_PIN_22_MSDC3_DAT0__FUNC_MSDC3_DAT0>,
+				 <MT8173_PIN_23_MSDC3_DAT1__FUNC_MSDC3_DAT1>,
+				 <MT8173_PIN_24_MSDC3_DAT2__FUNC_MSDC3_DAT2>,
+				 <MT8173_PIN_25_MSDC3_DAT3__FUNC_MSDC3_DAT3>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins_cmd {
+			pinmux = <MT8173_PIN_27_MSDC3_CMD__FUNC_MSDC3_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins_clk {
+			pinmux = <MT8173_PIN_26_MSDC3_CLK__FUNC_MSDC3_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+	};
 };
 
 &pwm0 {
-- 
1.7.9.5
