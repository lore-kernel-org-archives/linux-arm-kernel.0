From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Thu, 14 Apr 2016 15:37:06 +0800
Subject: [alsa-devel] [RFC PATCH 2/4] ASoC: mediatek: add documents for mt2701
In-Reply-To: <1460619428-48882-1-git-send-email-garlic.tseng@mediatek.com>
References: <1460619428-48882-1-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <1460619428-48882-3-git-send-email-garlic.tseng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documents for mt2701-cs42448 machine driver and mt2701 platform driver.

Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
---
 .../devicetree/bindings/sound/mt2701-cs42448.txt   |  39 ++++++
 .../devicetree/bindings/sound/mtk2701-afe-pcm.txt  | 150 +++++++++++++++++++++
 2 files changed, 189 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt2701-cs42448.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mtk2701-afe-pcm.txt

diff --git a/Documentation/devicetree/bindings/sound/mt2701-cs42448.txt b/Documentation/devicetree/bindings/sound/mt2701-cs42448.txt
new file mode 100644
index 0000000..be5d9b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mt2701-cs42448.txt
@@ -0,0 +1,39 @@
+MT2701 with CS42448 CODEC
+
+Required properties:
+- compatible : "mediatek,mt2701-cs42448-machin"
+- mediatek,platform: the phandle of MT8173 ASoC platform
+- audio-routing: a list of the connections between audio
+- pinctrl-names: Should contain only one value - "default"
+- pinctrl-0: Should specify pin control groups used for this controller.
+- i2s1-in-sel-gpio1, i2s1-in-sel-gpio2: Should specify two gpio pins to
+					control I2S1-in mux.
+
+Example:
+
+	sound:sound {
+		compatible = "mediatek,mt2701-cs42448-machine";
+		mediatek,platform = <&afe>;
+		/* CS42448 Machine name */
+		audio-routing =
+			"Line Out Jack", "AOUT1L",
+			"Line Out Jack", "AOUT1R",
+			"Line Out Jack", "AOUT2L",
+			"Line Out Jack", "AOUT2R",
+			"Line Out Jack", "AOUT3L",
+			"Line Out Jack", "AOUT3R",
+			"Line Out Jack", "AOUT4L",
+			"Line Out Jack", "AOUT4R",
+			"AIN1L", "AMIC",
+			"AIN1R", "AMIC",
+			"AIN2L", "Tuner In",
+			"AIN2R", "Tuner In",
+			"AIN3L", "Satellite Tuner In",
+			"AIN3R", "Satellite Tuner In",
+			"AIN3L", "AUX In",
+			"AIN3R", "AUX In";
+		pinctrl-names = "default";
+		pinctrl-0 = <&aud_pins_default>;
+		i2s1-in-sel-gpio1 = <&pio 53 0>;
+		i2s1-in-sel-gpio2 = <&pio 54 0>;
+	};
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/sound/mtk2701-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mtk2701-afe-pcm.txt
new file mode 100644
index 0000000..02232ca0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mtk2701-afe-pcm.txt
@@ -0,0 +1,150 @@
+Mediatek AFE PCM controller for mt2701
+
+Required properties:
+- compatible = "mediatek,mt2701-audio";
+- reg: register location and size
+- interrupts: Should contain AFE interrupt
+- clock-names: should have these clock names:
+		"infra_sys_audio_clk",
+		"top_audio_mux1_sel",
+		"top_audio_mux2_sel",
+		"top_audio_mux1_div",
+		"top_audio_mux2_div",
+		"top_audio_48k_timing",
+		"top_audio_44k_timing",
+		"top_audpll_mux_sel",
+		"top_apll_sel",
+		"top_aud1_pll_98M",
+		"top_aud2_pll_90M",
+		"top_hadds2_pll_98M",
+		"top_hadds2_pll_294M",
+		"top_audpll",
+		"top_audpll_d4",
+		"top_audpll_d8",
+		"top_audpll_d16",
+		"top_audpll_d24",
+		"top_audintbus_sel",
+		"clk_26m",
+		"top_syspll1_d4",
+		"top_aud_k1_src_sel",
+		"top_aud_k2_src_sel",
+		"top_aud_k3_src_sel",
+		"top_aud_k4_src_sel",
+		"top_aud_k5_src_sel",
+		"top_aud_k6_src_sel",
+		"top_aud_k1_src_div",
+		"top_aud_k2_src_div",
+		"top_aud_k3_src_div",
+		"top_aud_k4_src_div",
+		"top_aud_k5_src_div",
+		"top_aud_k6_src_div",
+		"top_aud_i2s1_mclk",
+		"top_aud_i2s2_mclk",
+		"top_aud_i2s3_mclk",
+		"top_aud_i2s4_mclk",
+		"top_aud_i2s5_mclk",
+		"top_aud_i2s6_mclk",
+		"top_asm_m_sel",
+		"top_asm_h_sel",
+		"top_univpll2_d4",
+		"top_univpll2_d2",
+		"top_syspll_d5";
+
+Example:
+
+	afe: mt8173-afe-pcm at 11220000 {
+		compatible = "mediatek,mt2701-audio";
+		reg = <0 0x11220000 0 0x2000>,
+		      <0 0x112A0000 0 0x20000>;
+		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infracfg CLK_INFRA_AUDIO>,
+			 <&topckgen CLK_TOP_AUD_MUX1_SEL>,
+			 <&topckgen CLK_TOP_AUD_MUX2_SEL>,
+			 <&topckgen CLK_TOP_AUD_MUX1_DIV>,
+			 <&topckgen CLK_TOP_AUD_MUX2_DIV>,
+			 <&topckgen CLK_TOP_AUD_48K_TIMING>,
+			 <&topckgen CLK_TOP_AUD_44K_TIMING>,
+			 <&topckgen CLK_TOP_AUDPLL_MUX_SEL>,
+			 <&topckgen CLK_TOP_APLL_SEL>,
+			 <&topckgen CLK_TOP_AUD1PLL_98M>,
+			 <&topckgen CLK_TOP_AUD2PLL_90M>,
+			 <&topckgen CLK_TOP_HADDS2PLL_98M>,
+			 <&topckgen CLK_TOP_HADDS2PLL_294M>,
+			 <&topckgen CLK_TOP_AUDPLL>,
+			 <&topckgen CLK_TOP_AUDPLL_D4>,
+			 <&topckgen CLK_TOP_AUDPLL_D8>,
+			 <&topckgen CLK_TOP_AUDPLL_D16>,
+			 <&topckgen CLK_TOP_AUDPLL_D24>,
+			 <&topckgen CLK_TOP_AUDINTBUS_SEL>,
+			 <&clk26m>,
+			 <&topckgen CLK_TOP_SYSPLL1_D4>,
+			 <&topckgen CLK_TOP_AUD_K1_SRC_SEL>,
+			 <&topckgen CLK_TOP_AUD_K2_SRC_SEL>,
+			 <&topckgen CLK_TOP_AUD_K3_SRC_SEL>,
+			 <&topckgen CLK_TOP_AUD_K4_SRC_SEL>,
+			 <&topckgen CLK_TOP_AUD_K5_SRC_SEL>,
+			 <&topckgen CLK_TOP_AUD_K6_SRC_SEL>,
+			 <&topckgen CLK_TOP_AUD_K1_SRC_DIV>,
+			 <&topckgen CLK_TOP_AUD_K2_SRC_DIV>,
+			 <&topckgen CLK_TOP_AUD_K3_SRC_DIV>,
+			 <&topckgen CLK_TOP_AUD_K4_SRC_DIV>,
+			 <&topckgen CLK_TOP_AUD_K5_SRC_DIV>,
+			 <&topckgen CLK_TOP_AUD_K6_SRC_DIV>,
+			 <&topckgen CLK_TOP_AUD_I2S1_MCLK>,
+			 <&topckgen CLK_TOP_AUD_I2S2_MCLK>,
+			 <&topckgen CLK_TOP_AUD_I2S3_MCLK>,
+			 <&topckgen CLK_TOP_AUD_I2S4_MCLK>,
+			 <&topckgen CLK_TOP_AUD_I2S5_MCLK>,
+			 <&topckgen CLK_TOP_AUD_I2S6_MCLK>,
+			 <&topckgen CLK_TOP_ASM_M_SEL>,
+			 <&topckgen CLK_TOP_ASM_H_SEL>,
+			 <&topckgen CLK_TOP_UNIVPLL2_D4>,
+			 <&topckgen CLK_TOP_UNIVPLL2_D2>,
+			 <&topckgen CLK_TOP_SYSPLL_D5>;
+
+		clock-names = "infra_sys_audio_clk",
+			      "top_audio_mux1_sel",
+			      "top_audio_mux2_sel",
+			      "top_audio_mux1_div",
+			      "top_audio_mux2_div",
+			      "top_audio_48k_timing",
+			      "top_audio_44k_timing",
+			      "top_audpll_mux_sel",
+			      "top_apll_sel",
+			      "top_aud1_pll_98M",
+			      "top_aud2_pll_90M",
+			      "top_hadds2_pll_98M",
+			      "top_hadds2_pll_294M",
+			      "top_audpll",
+			      "top_audpll_d4",
+			      "top_audpll_d8",
+			      "top_audpll_d16",
+			      "top_audpll_d24",
+			      "top_audintbus_sel",
+			      "clk_26m",
+			      "top_syspll1_d4",
+			      "top_aud_k1_src_sel",
+			      "top_aud_k2_src_sel",
+			      "top_aud_k3_src_sel",
+			      "top_aud_k4_src_sel",
+			      "top_aud_k5_src_sel",
+			      "top_aud_k6_src_sel",
+			      "top_aud_k1_src_div",
+			      "top_aud_k2_src_div",
+			      "top_aud_k3_src_div",
+			      "top_aud_k4_src_div",
+			      "top_aud_k5_src_div",
+			      "top_aud_k6_src_div",
+			      "top_aud_i2s1_mclk",
+			      "top_aud_i2s2_mclk",
+			      "top_aud_i2s3_mclk",
+			      "top_aud_i2s4_mclk",
+			      "top_aud_i2s5_mclk",
+			      "top_aud_i2s6_mclk",
+			      "top_asm_m_sel",
+			      "top_asm_h_sel",
+			      "top_univpll2_d4",
+			      "top_univpll2_d2",
+			      "top_syspll_d5";
+	};
-- 
1.9.1
