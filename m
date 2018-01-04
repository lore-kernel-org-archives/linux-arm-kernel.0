From: broonie@kernel.org (Mark Brown)
Date: Thu, 04 Jan 2018 17:42:48 +0000
Subject: Applied "ASoC: mediatek: update MT2701 AFE documentation to adapt mfd
 device" to the asoc tree
In-Reply-To: <a716adbb734cefd8e8ea614a2e4686af8204490e.1515038387.git.ryder.lee@mediatek.com>
Message-ID: <E1eX9XU-00065p-83@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: mediatek: update MT2701 AFE documentation to adapt mfd device

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7f12a56367bf526afde7e81820a8c7d97e75ed10 Mon Sep 17 00:00:00 2001
From: Ryder Lee <ryder.lee@mediatek.com>
Date: Thu, 4 Jan 2018 15:44:09 +0800
Subject: [PATCH] ASoC: mediatek: update MT2701 AFE documentation to adapt mfd
 device

As the new MFD parent is in place, modify MT2701 AFE documentation to
adapt it. Also add three core clocks in example.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/mt2701-afe-pcm.txt   | 171 +++++++++++----------
 1 file changed, 93 insertions(+), 78 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
index 0450baad2813..6df87b97f7cb 100644
--- a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
+++ b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
@@ -2,15 +2,17 @@ Mediatek AFE PCM controller for mt2701
 
 Required properties:
 - compatible = "mediatek,mt2701-audio";
-- reg: register location and size
 - interrupts: should contain AFE and ASYS interrupts
 - interrupt-names: should be "afe" and "asys"
 - power-domains: should define the power domain
 - clocks: Must contain an entry for each entry in clock-names
   See ../clocks/clock-bindings.txt for details
 - clock-names: should have these clock names:
+		"infra_sys_audio_clk",
 		"top_audio_mux1_sel",
 		"top_audio_mux2_sel",
+		"top_audio_a1sys_hp",
+		"top_audio_a2sys_hp",
 		"i2s0_src_sel",
 		"i2s1_src_sel",
 		"i2s2_src_sel",
@@ -45,85 +47,98 @@ Required properties:
 - assigned-clocks-parents: parent of input clocks of assigned clocks.
 - assigned-clock-rates: list of clock frequencies of assigned clocks.
 
+Must be a subnode of MediaTek audsys device tree node.
+See ../arm/mediatek/mediatek,audsys.txt for details about the parent node.
+
 Example:
 
-	afe: mt2701-afe-pcm at 11220000 {
-		compatible = "mediatek,mt2701-audio";
-		reg = <0 0x11220000 0 0x2000>,
-		      <0 0x112A0000 0 0x20000>;
-		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-names	= "afe", "asys";
-		power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
-		clocks = <&topckgen CLK_TOP_AUD_MUX1_SEL>,
-			 <&topckgen CLK_TOP_AUD_MUX2_SEL>,
-			 <&topckgen CLK_TOP_AUD_K1_SRC_SEL>,
-			 <&topckgen CLK_TOP_AUD_K2_SRC_SEL>,
-			 <&topckgen CLK_TOP_AUD_K3_SRC_SEL>,
-			 <&topckgen CLK_TOP_AUD_K4_SRC_SEL>,
-			 <&topckgen CLK_TOP_AUD_K1_SRC_DIV>,
-			 <&topckgen CLK_TOP_AUD_K2_SRC_DIV>,
-			 <&topckgen CLK_TOP_AUD_K3_SRC_DIV>,
-			 <&topckgen CLK_TOP_AUD_K4_SRC_DIV>,
-			 <&topckgen CLK_TOP_AUD_I2S1_MCLK>,
-			 <&topckgen CLK_TOP_AUD_I2S2_MCLK>,
-			 <&topckgen CLK_TOP_AUD_I2S3_MCLK>,
-			 <&topckgen CLK_TOP_AUD_I2S4_MCLK>,
-			 <&audiosys CLK_AUD_I2SO1>,
-			 <&audiosys CLK_AUD_I2SO2>,
-			 <&audiosys CLK_AUD_I2SO3>,
-			 <&audiosys CLK_AUD_I2SO4>,
-			 <&audiosys CLK_AUD_I2SIN1>,
-			 <&audiosys CLK_AUD_I2SIN2>,
-			 <&audiosys CLK_AUD_I2SIN3>,
-			 <&audiosys CLK_AUD_I2SIN4>,
-			 <&audiosys CLK_AUD_ASRCO1>,
-			 <&audiosys CLK_AUD_ASRCO2>,
-			 <&audiosys CLK_AUD_ASRCO3>,
-			 <&audiosys CLK_AUD_ASRCO4>,
-			 <&audiosys CLK_AUD_AFE>,
-			 <&audiosys CLK_AUD_AFE_CONN>,
-			 <&audiosys CLK_AUD_A1SYS>,
-			 <&audiosys CLK_AUD_A2SYS>,
-			 <&audiosys CLK_AUD_AFE_MRGIF>;
+	audsys: audio-subsystem at 11220000 {
+		compatible = "mediatek,mt2701-audsys", "syscon", "simple-mfd";
+		...
+
+		afe: audio-controller {
+			compatible = "mediatek,mt2701-audio";
+			interrupts =  <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
+				      <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-names	= "afe", "asys";
+			power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
+
+			clocks = <&infracfg CLK_INFRA_AUDIO>,
+				 <&topckgen CLK_TOP_AUD_MUX1_SEL>,
+				 <&topckgen CLK_TOP_AUD_MUX2_SEL>,
+				 <&topckgen CLK_TOP_AUD_48K_TIMING>,
+				 <&topckgen CLK_TOP_AUD_44K_TIMING>,
+				 <&topckgen CLK_TOP_AUD_K1_SRC_SEL>,
+				 <&topckgen CLK_TOP_AUD_K2_SRC_SEL>,
+				 <&topckgen CLK_TOP_AUD_K3_SRC_SEL>,
+				 <&topckgen CLK_TOP_AUD_K4_SRC_SEL>,
+				 <&topckgen CLK_TOP_AUD_K1_SRC_DIV>,
+				 <&topckgen CLK_TOP_AUD_K2_SRC_DIV>,
+				 <&topckgen CLK_TOP_AUD_K3_SRC_DIV>,
+				 <&topckgen CLK_TOP_AUD_K4_SRC_DIV>,
+				 <&topckgen CLK_TOP_AUD_I2S1_MCLK>,
+				 <&topckgen CLK_TOP_AUD_I2S2_MCLK>,
+				 <&topckgen CLK_TOP_AUD_I2S3_MCLK>,
+				 <&topckgen CLK_TOP_AUD_I2S4_MCLK>,
+				 <&audsys CLK_AUD_I2SO1>,
+				 <&audsys CLK_AUD_I2SO2>,
+				 <&audsys CLK_AUD_I2SO3>,
+				 <&audsys CLK_AUD_I2SO4>,
+				 <&audsys CLK_AUD_I2SIN1>,
+				 <&audsys CLK_AUD_I2SIN2>,
+				 <&audsys CLK_AUD_I2SIN3>,
+				 <&audsys CLK_AUD_I2SIN4>,
+				 <&audsys CLK_AUD_ASRCO1>,
+				 <&audsys CLK_AUD_ASRCO2>,
+				 <&audsys CLK_AUD_ASRCO3>,
+				 <&audsys CLK_AUD_ASRCO4>,
+				 <&audsys CLK_AUD_AFE>,
+				 <&audsys CLK_AUD_AFE_CONN>,
+				 <&audsys CLK_AUD_A1SYS>,
+				 <&audsys CLK_AUD_A2SYS>,
+				 <&audsys CLK_AUD_AFE_MRGIF>;
 
-		clock-names = "top_audio_mux1_sel",
-			      "top_audio_mux2_sel",
-			      "i2s0_src_sel",
-			      "i2s1_src_sel",
-			      "i2s2_src_sel",
-			      "i2s3_src_sel",
-			      "i2s0_src_div",
-			      "i2s1_src_div",
-			      "i2s2_src_div",
-			      "i2s3_src_div",
-			      "i2s0_mclk_en",
-			      "i2s1_mclk_en",
-			      "i2s2_mclk_en",
-			      "i2s3_mclk_en",
-			      "i2so0_hop_ck",
-			      "i2so1_hop_ck",
-			      "i2so2_hop_ck",
-			      "i2so3_hop_ck",
-			      "i2si0_hop_ck",
-			      "i2si1_hop_ck",
-			      "i2si2_hop_ck",
-			      "i2si3_hop_ck",
-			      "asrc0_out_ck",
-			      "asrc1_out_ck",
-			      "asrc2_out_ck",
-			      "asrc3_out_ck",
-			      "audio_afe_pd",
-			      "audio_afe_conn_pd",
-			      "audio_a1sys_pd",
-			      "audio_a2sys_pd",
-			      "audio_mrgif_pd";
+			clock-names = "infra_sys_audio_clk",
+				      "top_audio_mux1_sel",
+				      "top_audio_mux2_sel",
+				      "top_audio_a1sys_hp",
+				      "top_audio_a2sys_hp",
+				      "i2s0_src_sel",
+				      "i2s1_src_sel",
+				      "i2s2_src_sel",
+				      "i2s3_src_sel",
+				      "i2s0_src_div",
+				      "i2s1_src_div",
+				      "i2s2_src_div",
+				      "i2s3_src_div",
+				      "i2s0_mclk_en",
+				      "i2s1_mclk_en",
+				      "i2s2_mclk_en",
+				      "i2s3_mclk_en",
+				      "i2so0_hop_ck",
+				      "i2so1_hop_ck",
+				      "i2so2_hop_ck",
+				      "i2so3_hop_ck",
+				      "i2si0_hop_ck",
+				      "i2si1_hop_ck",
+				      "i2si2_hop_ck",
+				      "i2si3_hop_ck",
+				      "asrc0_out_ck",
+				      "asrc1_out_ck",
+				      "asrc2_out_ck",
+				      "asrc3_out_ck",
+				      "audio_afe_pd",
+				      "audio_afe_conn_pd",
+				      "audio_a1sys_pd",
+				      "audio_a2sys_pd",
+				      "audio_mrgif_pd";
 
-		assigned-clocks = <&topckgen CLK_TOP_AUD_MUX1_SEL>,
-				  <&topckgen CLK_TOP_AUD_MUX2_SEL>,
-				  <&topckgen CLK_TOP_AUD_MUX1_DIV>,
-				  <&topckgen CLK_TOP_AUD_MUX2_DIV>;
-		assigned-clock-parents = <&topckgen CLK_TOP_AUD1PLL_98M>,
-					 <&topckgen CLK_TOP_AUD2PLL_90M>;
-		assigned-clock-rates = <0>, <0>, <49152000>, <45158400>;
+			assigned-clocks = <&topckgen CLK_TOP_AUD_MUX1_SEL>,
+					  <&topckgen CLK_TOP_AUD_MUX2_SEL>,
+					  <&topckgen CLK_TOP_AUD_MUX1_DIV>,
+					  <&topckgen CLK_TOP_AUD_MUX2_DIV>;
+			assigned-clock-parents = <&topckgen CLK_TOP_AUD1PLL_98M>,
+						 <&topckgen CLK_TOP_AUD2PLL_90M>;
+			assigned-clock-rates = <0>, <0>, <49152000>, <45158400>;
+		};
 	};
-- 
2.15.1
