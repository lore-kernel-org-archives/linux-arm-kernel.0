From: pc.liao@mediatek.com (PC Liao)
Date: Wed, 1 Jun 2016 20:00:12 +0800
Subject: [PATCH] ASoC: mediatek: add MCLK source selection
Message-ID: <1464782412-632-1-git-send-email-pc.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new machine's MCLK source is from mt8173 which is dynamic from
sampling rate*256. This patch provides the selection for device tree.

Signed-off-by: PC Liao <pc.liao@mediatek.com>
---
 .../devicetree/bindings/sound/mt8173-rt5650.txt    |    5 +++
 sound/soc/mediatek/mt8173-rt5650.c                 |   45 +++++++++++++++++++-
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt b/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
index 5bfa6b6..f250fc7 100644
--- a/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
+++ b/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
@@ -12,12 +12,17 @@ Required codec-capture subnode properties:
   <&rt5650 0> : Default setting. Connect rt5650 I2S1 for capture. (dai_name = rt5645-aif1)
   <&rt5650 1> : Connect rt5650 I2S2 for capture. (dai_name = rt5645-aif2)
 
+- mediatek,mclk: the MCLK source
+  0 : external oscillator, MCLK = 12.288M
+  1 : internal source from mt8173, MCLK = sampling rate*256
+
 Example:
 
 	sound {
 		compatible = "mediatek,mt8173-rt5650";
 		mediatek,audio-codec = <&rt5650>;
 		mediatek,platform = <&afe>;
+		mediatek,mclk = <0>;
 		codec-capture {
 			sound-dai = <&rt5650 1>;
 		};
diff --git a/sound/soc/mediatek/mt8173-rt5650.c b/sound/soc/mediatek/mt8173-rt5650.c
index a27a667..072934b 100644
--- a/sound/soc/mediatek/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173-rt5650.c
@@ -23,6 +23,20 @@
 
 #define MCLK_FOR_CODECS		12288000
 
+enum mt8173_rt5650_mclk {
+	MT8173_RT5650_MCLK_EXTERNAL = 0,
+	MT8173_RT5650_MCLK_INTERNAL,
+};
+
+struct mt8173_rt5650_platform_data {
+	enum mt8173_rt5650_mclk pll_from;
+	/* 0 = external oscillator; 1 = internal source from mt8173 */
+};
+
+static struct mt8173_rt5650_platform_data mt8173_rt5650_priv = {
+	.pll_from = MT8173_RT5650_MCLK_EXTERNAL,
+};
+
 static const struct snd_soc_dapm_widget mt8173_rt5650_widgets[] = {
 	SND_SOC_DAPM_SPK("Speaker", NULL),
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
@@ -54,13 +68,29 @@ static int mt8173_rt5650_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	unsigned int mclk_clock;
 	int i, ret;
 
+	switch (mt8173_rt5650_priv.pll_from) {
+	case MT8173_RT5650_MCLK_EXTERNAL:
+		/* mclk = 12.288M */
+		mclk_clock = MCLK_FOR_CODECS;
+		break;
+	case MT8173_RT5650_MCLK_INTERNAL:
+		/* mclk = sampling rate*256 */
+		mclk_clock = params_rate(params) * 256;
+		break;
+	default:
+		/* mclk = 12.288M */
+		mclk_clock = MCLK_FOR_CODECS;
+		break;
+	}
+
 	for (i = 0; i < rtd->num_codecs; i++) {
 		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
 
-		/* pll from mclk 12.288M */
-		ret = snd_soc_dai_set_pll(codec_dai, 0, 0, MCLK_FOR_CODECS,
+		/* pll from mclk */
+		ret = snd_soc_dai_set_pll(codec_dai, 0, 0, mclk_clock,
 					  params_rate(params) * 512);
 		if (ret)
 			return ret;
@@ -243,6 +273,17 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 		mt8173_rt5650_codecs[1].dai_name = codec_capture_dai;
 	}
 
+	if (device_property_present(&pdev->dev, "mediatek,mclk")) {
+		ret = device_property_read_u32(&pdev->dev,
+					       "mediatek,mclk",
+					       &mt8173_rt5650_priv.pll_from);
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
