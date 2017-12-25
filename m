From: ryder.lee@mediatek.com (Ryder Lee)
Date: Mon, 25 Dec 2017 16:28:48 +0800
Subject: [PATCH 4/4] ASoC: mediatek: update clock properties for mt2701
In-Reply-To: <18b7f0ec484300af795b1873efab96e51393459c.1514190169.git.ryder.lee@mediatek.com>
References: <18b7f0ec484300af795b1873efab96e51393459c.1514190169.git.ryder.lee@mediatek.com>
Message-ID: <2e48c9498b552336aa21c130125d633c7b2d129e.1514190169.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 'assigned-clocks*' properties which are used to initialize default
domain sources of audio system. we could configure different sets of
input clocks through DTS now - depends on the platform design. Hence
driver no longer cares about that.

Also we change some 'clock-names' to make them more generic so that
other chips can reuse gracefully.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Tested-by: Garlic Tseng <garlic.tseng@mediatek.com>
---
 .../devicetree/bindings/sound/mt2701-afe-pcm.txt   | 199 ++++++++++-----------
 1 file changed, 93 insertions(+), 106 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
index 77a57f8..dd99990 100644
--- a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
+++ b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
@@ -6,51 +6,48 @@ Required properties:
 - interrupts: should contain AFE and ASYS interrupts
 - interrupt-names: should be "afe" and "asys"
 - power-domains: should define the power domain
+- clocks: Must contain an entry for each entry in clock-names
+  See ../clocks/clock-bindings.txt for details
 - clock-names: should have these clock names:
 		"infra_sys_audio_clk",
 		"top_audio_mux1_sel",
 		"top_audio_mux2_sel",
-		"top_audio_mux1_div",
-		"top_audio_mux2_div",
-		"top_audio_48k_timing",
-		"top_audio_44k_timing",
-		"top_audpll_mux_sel",
-		"top_apll_sel",
-		"top_aud1_pll_98M",
-		"top_aud2_pll_90M",
-		"top_hadds2_pll_98M",
-		"top_hadds2_pll_294M",
-		"top_audpll",
-		"top_audpll_d4",
-		"top_audpll_d8",
-		"top_audpll_d16",
-		"top_audpll_d24",
+		"top_audio_a1sys_hp",
+		"top_audio_a2sys_hp",
 		"top_audintbus_sel",
-		"clk_26m",
-		"top_syspll1_d4",
-		"top_aud_k1_src_sel",
-		"top_aud_k2_src_sel",
-		"top_aud_k3_src_sel",
-		"top_aud_k4_src_sel",
-		"top_aud_k5_src_sel",
-		"top_aud_k6_src_sel",
-		"top_aud_k1_src_div",
-		"top_aud_k2_src_div",
-		"top_aud_k3_src_div",
-		"top_aud_k4_src_div",
-		"top_aud_k5_src_div",
-		"top_aud_k6_src_div",
-		"top_aud_i2s1_mclk",
-		"top_aud_i2s2_mclk",
-		"top_aud_i2s3_mclk",
-		"top_aud_i2s4_mclk",
-		"top_aud_i2s5_mclk",
-		"top_aud_i2s6_mclk",
-		"top_asm_m_sel",
-		"top_asm_h_sel",
-		"top_univpll2_d4",
-		"top_univpll2_d2",
-		"top_syspll_d5";
+		"i2s0_src_sel",
+		"i2s1_src_sel",
+		"i2s2_src_sel",
+		"i2s3_src_sel",
+		"i2s0_src_div",
+		"i2s1_src_div",
+		"i2s2_src_div",
+		"i2s3_src_div",
+		"i2s0_mclk_en",
+		"i2s1_mclk_en",
+		"i2s2_mclk_en",
+		"i2s3_mclk_en",
+		"i2so0_hop_ck",
+		"i2so1_hop_ck",
+		"i2so2_hop_ck",
+		"i2so3_hop_ck",
+		"i2si0_hop_ck",
+		"i2si1_hop_ck",
+		"i2si2_hop_ck",
+		"i2si3_hop_ck",
+		"asrc0_out_ck",
+		"asrc1_out_ck",
+		"asrc2_out_ck",
+		"asrc3_out_ck",
+		"audio_afe_pd",
+		"audio_afe_conn_pd",
+		"audio_a1sys_pd",
+		"audio_a2sys_pd",
+		"audio_mrgif_pd";
+- assigned-clocks: list of input clocks and dividers for the audio system.
+		   See ../clocks/clock-bindings.txt for details.
+- assigned-clocks-parents: parent of input clocks of assigned clocks.
+- assigned-clock-rates: list of clock frequencies of assigned clocks.
 
 Example:
 
@@ -65,90 +62,80 @@ Example:
 		clocks = <&infracfg CLK_INFRA_AUDIO>,
 			 <&topckgen CLK_TOP_AUD_MUX1_SEL>,
 			 <&topckgen CLK_TOP_AUD_MUX2_SEL>,
-			 <&topckgen CLK_TOP_AUD_MUX1_DIV>,
-			 <&topckgen CLK_TOP_AUD_MUX2_DIV>,
 			 <&topckgen CLK_TOP_AUD_48K_TIMING>,
 			 <&topckgen CLK_TOP_AUD_44K_TIMING>,
-			 <&topckgen CLK_TOP_AUDPLL_MUX_SEL>,
-			 <&topckgen CLK_TOP_APLL_SEL>,
-			 <&topckgen CLK_TOP_AUD1PLL_98M>,
-			 <&topckgen CLK_TOP_AUD2PLL_90M>,
-			 <&topckgen CLK_TOP_HADDS2PLL_98M>,
-			 <&topckgen CLK_TOP_HADDS2PLL_294M>,
-			 <&topckgen CLK_TOP_AUDPLL>,
-			 <&topckgen CLK_TOP_AUDPLL_D4>,
-			 <&topckgen CLK_TOP_AUDPLL_D8>,
-			 <&topckgen CLK_TOP_AUDPLL_D16>,
-			 <&topckgen CLK_TOP_AUDPLL_D24>,
 			 <&topckgen CLK_TOP_AUDINTBUS_SEL>,
-			 <&clk26m>,
-			 <&topckgen CLK_TOP_SYSPLL1_D4>,
 			 <&topckgen CLK_TOP_AUD_K1_SRC_SEL>,
 			 <&topckgen CLK_TOP_AUD_K2_SRC_SEL>,
 			 <&topckgen CLK_TOP_AUD_K3_SRC_SEL>,
 			 <&topckgen CLK_TOP_AUD_K4_SRC_SEL>,
-			 <&topckgen CLK_TOP_AUD_K5_SRC_SEL>,
-			 <&topckgen CLK_TOP_AUD_K6_SRC_SEL>,
 			 <&topckgen CLK_TOP_AUD_K1_SRC_DIV>,
 			 <&topckgen CLK_TOP_AUD_K2_SRC_DIV>,
 			 <&topckgen CLK_TOP_AUD_K3_SRC_DIV>,
 			 <&topckgen CLK_TOP_AUD_K4_SRC_DIV>,
-			 <&topckgen CLK_TOP_AUD_K5_SRC_DIV>,
-			 <&topckgen CLK_TOP_AUD_K6_SRC_DIV>,
 			 <&topckgen CLK_TOP_AUD_I2S1_MCLK>,
 			 <&topckgen CLK_TOP_AUD_I2S2_MCLK>,
 			 <&topckgen CLK_TOP_AUD_I2S3_MCLK>,
 			 <&topckgen CLK_TOP_AUD_I2S4_MCLK>,
-			 <&topckgen CLK_TOP_AUD_I2S5_MCLK>,
-			 <&topckgen CLK_TOP_AUD_I2S6_MCLK>,
-			 <&topckgen CLK_TOP_ASM_M_SEL>,
-			 <&topckgen CLK_TOP_ASM_H_SEL>,
-			 <&topckgen CLK_TOP_UNIVPLL2_D4>,
-			 <&topckgen CLK_TOP_UNIVPLL2_D2>,
-			 <&topckgen CLK_TOP_SYSPLL_D5>;
+			 <&audiosys CLK_AUD_I2SO1>,
+			 <&audiosys CLK_AUD_I2SO2>,
+			 <&audiosys CLK_AUD_I2SO3>,
+			 <&audiosys CLK_AUD_I2SO4>,
+			 <&audiosys CLK_AUD_I2SIN1>,
+			 <&audiosys CLK_AUD_I2SIN2>,
+			 <&audiosys CLK_AUD_I2SIN3>,
+			 <&audiosys CLK_AUD_I2SIN4>,
+			 <&audiosys CLK_AUD_ASRCO1>,
+			 <&audiosys CLK_AUD_ASRCO2>,
+			 <&audiosys CLK_AUD_ASRCO3>,
+			 <&audiosys CLK_AUD_ASRCO4>,
+			 <&audiosys CLK_AUD_AFE>,
+			 <&audiosys CLK_AUD_AFE_CONN>,
+			 <&audiosys CLK_AUD_A1SYS>,
+			 <&audiosys CLK_AUD_A2SYS>,
+			 <&audiosys CLK_AUD_AFE_MRGIF>;
 
 		clock-names = "infra_sys_audio_clk",
 			      "top_audio_mux1_sel",
 			      "top_audio_mux2_sel",
-			      "top_audio_mux1_div",
-			      "top_audio_mux2_div",
-			      "top_audio_48k_timing",
-			      "top_audio_44k_timing",
-			      "top_audpll_mux_sel",
-			      "top_apll_sel",
-			      "top_aud1_pll_98M",
-			      "top_aud2_pll_90M",
-			      "top_hadds2_pll_98M",
-			      "top_hadds2_pll_294M",
-			      "top_audpll",
-			      "top_audpll_d4",
-			      "top_audpll_d8",
-			      "top_audpll_d16",
-			      "top_audpll_d24",
+			      "top_audio_a1sys_hp",
+			      "top_audio_a2sys_hp",
 			      "top_audintbus_sel",
-			      "clk_26m",
-			      "top_syspll1_d4",
-			      "top_aud_k1_src_sel",
-			      "top_aud_k2_src_sel",
-			      "top_aud_k3_src_sel",
-			      "top_aud_k4_src_sel",
-			      "top_aud_k5_src_sel",
-			      "top_aud_k6_src_sel",
-			      "top_aud_k1_src_div",
-			      "top_aud_k2_src_div",
-			      "top_aud_k3_src_div",
-			      "top_aud_k4_src_div",
-			      "top_aud_k5_src_div",
-			      "top_aud_k6_src_div",
-			      "top_aud_i2s1_mclk",
-			      "top_aud_i2s2_mclk",
-			      "top_aud_i2s3_mclk",
-			      "top_aud_i2s4_mclk",
-			      "top_aud_i2s5_mclk",
-			      "top_aud_i2s6_mclk",
-			      "top_asm_m_sel",
-			      "top_asm_h_sel",
-			      "top_univpll2_d4",
-			      "top_univpll2_d2",
-			      "top_syspll_d5";
+			      "i2s0_src_sel",
+			      "i2s1_src_sel",
+			      "i2s2_src_sel",
+			      "i2s3_src_sel",
+			      "i2s0_src_div",
+			      "i2s1_src_div",
+			      "i2s2_src_div",
+			      "i2s3_src_div",
+			      "i2s0_mclk_en",
+			      "i2s1_mclk_en",
+			      "i2s2_mclk_en",
+			      "i2s3_mclk_en",
+			      "i2so0_hop_ck",
+			      "i2so1_hop_ck",
+			      "i2so2_hop_ck",
+			      "i2so3_hop_ck",
+			      "i2si0_hop_ck",
+			      "i2si1_hop_ck",
+			      "i2si2_hop_ck",
+			      "i2si3_hop_ck",
+			      "asrc0_out_ck",
+			      "asrc1_out_ck",
+			      "asrc2_out_ck",
+			      "asrc3_out_ck",
+			      "audio_afe_pd",
+			      "audio_afe_conn_pd",
+			      "audio_a1sys_pd",
+			      "audio_a2sys_pd",
+			      "audio_mrgif_pd";
+
+		assigned-clocks = <&topckgen CLK_TOP_AUD_MUX1_SEL>,
+				  <&topckgen CLK_TOP_AUD_MUX2_SEL>,
+				  <&topckgen CLK_TOP_AUD_MUX1_DIV>,
+				  <&topckgen CLK_TOP_AUD_MUX2_DIV>;
+		assigned-clock-parents = <&topckgen CLK_TOP_AUD1PLL_98M>,
+					 <&topckgen CLK_TOP_AUD2PLL_90M>;
+		assigned-clock-rates = <0>, <0>, <49152000>, <45158400>;
 	};
-- 
1.9.1
