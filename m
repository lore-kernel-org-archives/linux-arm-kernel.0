From: pc.liao@mediatek.com (PC Liao)
Date: Fri, 25 Mar 2016 11:42:05 +0800
Subject: [PATCH] ASoC: mediatek: Add second I2S on mt8173-rt5650 machine driver
Message-ID: <1458877325-33980-1-git-send-email-pc.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds second I2S for rt5650 codec on mt8173-rt5650 machine driver.

Signed-off-by: PC Liao <pc.liao@mediatek.com>
---
 .../devicetree/bindings/sound/mt8173-rt5650.txt    |    6 +++
 sound/soc/mediatek/mt8173-rt5650.c                 |   55 ++++++++++++++++++--
 2 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt b/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
index fe5a5ef..0046926 100644
--- a/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
+++ b/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
@@ -5,11 +5,17 @@ Required properties:
 - mediatek,audio-codec: the phandles of rt5650 codecs
 - mediatek,platform: the phandle of MT8173 ASoC platform
 
+Optional properties:
+- mediatek,rt5650_i2s: I2S mode of rt5650
+  0: using I2S1 on rt5650 for record
+  1: using I2S2 on rt5650 for record
+
 Example:
 
 	sound {
 		compatible = "mediatek,mt8173-rt5650";
 		mediatek,audio-codec = <&rt5650>;
 		mediatek,platform = <&afe>;
+		mediatek,rt5650_i2s = <0>;
 	};
 
diff --git a/sound/soc/mediatek/mt8173-rt5650.c b/sound/soc/mediatek/mt8173-rt5650.c
index bb09bb1..ab4c806 100644
--- a/sound/soc/mediatek/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173-rt5650.c
@@ -23,6 +23,20 @@
 
 #define MCLK_FOR_CODECS		12288000
 
+struct mt8173_rt5650_platform_data {
+	unsigned int rt5650_i2s;
+	/* 0 = I2S1; 1 = I2S2 */
+};
+
+static struct mt8173_rt5650_platform_data mt8173_rt5650_priv = {
+	.rt5650_i2s = 0,
+};
+
+enum mt8173_rt5650_i2s {
+	MT8173_RT5650_I2S1 = 0,
+	MT8173_RT5650_I2S2,
+};
+
 static const struct snd_soc_dapm_widget mt8173_rt5650_widgets[] = {
 	SND_SOC_DAPM_SPK("Speaker", NULL),
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
@@ -87,10 +101,25 @@ static int mt8173_rt5650_init(struct snd_soc_pcm_runtime *runtime)
 	struct snd_soc_codec *codec = runtime->codec_dais[0]->codec;
 	int ret;
 
-	rt5645_sel_asrc_clk_src(codec,
-				RT5645_DA_STEREO_FILTER |
-				RT5645_AD_STEREO_FILTER,
-				RT5645_CLK_SEL_I2S1_ASRC);
+	switch (mt8173_rt5650_priv.rt5650_i2s) {
+	case MT8173_RT5650_I2S1:
+		rt5645_sel_asrc_clk_src(codec,
+					RT5645_DA_STEREO_FILTER |
+					RT5645_AD_STEREO_FILTER,
+					RT5645_CLK_SEL_I2S1_ASRC);
+		break;
+	case MT8173_RT5650_I2S2:
+		rt5645_sel_asrc_clk_src(codec,
+					RT5645_DA_STEREO_FILTER,
+					RT5645_CLK_SEL_I2S1_ASRC);
+		rt5645_sel_asrc_clk_src(codec,
+					RT5645_AD_STEREO_FILTER,
+					RT5645_CLK_SEL_I2S2_ASRC);
+		break;
+	default:
+		break;
+	}
+
 	/* enable jack detection */
 	ret = snd_soc_card_jack_new(card, "Headset Jack",
 				    SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
@@ -112,6 +141,9 @@ static struct snd_soc_dai_link_component mt8173_rt5650_codecs[] = {
 	{
 		.dai_name = "rt5645-aif1",
 	},
+	{
+		.dai_name = "rt5645-aif2",
+	},
 };
 
 enum {
@@ -149,7 +181,7 @@ static struct snd_soc_dai_link mt8173_rt5650_dais[] = {
 		.cpu_dai_name = "I2S",
 		.no_pcm = 1,
 		.codecs = mt8173_rt5650_codecs,
-		.num_codecs = 1,
+		.num_codecs = 2,
 		.init = mt8173_rt5650_init,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			   SND_SOC_DAIFMT_CBS_CFS,
@@ -199,6 +231,19 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 			"Property 'audio-codec' missing or invalid\n");
 		return -EINVAL;
 	}
+	mt8173_rt5650_codecs[1].of_node = mt8173_rt5650_codecs[0].of_node;
+
+	if (device_property_present(&pdev->dev, "mediatek,rt5650_i2s")) {
+		ret = device_property_read_u32(&pdev->dev,
+					       "mediatek,rt5650_i2s",
+					       &mt8173_rt5650_priv.rt5650_i2s);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"%s snd_soc_register_card fail %d\n",
+				__func__, ret);
+		}
+	}
+
 	card->dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 
-- 
1.7.9.5
