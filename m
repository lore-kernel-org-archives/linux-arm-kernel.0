From: pc.liao@mediatek.com (PC Liao)
Date: Thu, 21 Apr 2016 19:38:14 +0800
Subject: [PATCH v8] ASoC: mediatek: Add second I2S on mt8173-rt5650 machine
 driver
Message-ID: <1461238694-46035-1-git-send-email-pc.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds second I2S connection to rt5650 codec for capture path on
mt8173-rt5650 machine driver.

Signed-off-by: PC Liao <pc.liao@mediatek.com>
---
Changes since v7:
Change the code for compatibility
Changes since v6:
Use subnode to determine the capture path
---
 .../devicetree/bindings/sound/mt8173-rt5650.txt    |   10 ++++
 sound/soc/mediatek/mt8173-rt5650.c                 |   50 ++++++++++++++++++--
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt b/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
index fe5a5ef..5bfa6b6 100644
--- a/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
+++ b/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
@@ -5,11 +5,21 @@ Required properties:
 - mediatek,audio-codec: the phandles of rt5650 codecs
 - mediatek,platform: the phandle of MT8173 ASoC platform
 
+Optional subnodes:
+- codec-capture : the subnode of rt5650 codec capture
+Required codec-capture subnode properties:
+- sound-dai: audio codec dai name on capture path
+  <&rt5650 0> : Default setting. Connect rt5650 I2S1 for capture. (dai_name = rt5645-aif1)
+  <&rt5650 1> : Connect rt5650 I2S2 for capture. (dai_name = rt5645-aif2)
+
 Example:
 
 	sound {
 		compatible = "mediatek,mt8173-rt5650";
 		mediatek,audio-codec = <&rt5650>;
 		mediatek,platform = <&afe>;
+		codec-capture {
+			sound-dai = <&rt5650 1>;
+		};
 	};
 
diff --git a/sound/soc/mediatek/mt8173-rt5650.c b/sound/soc/mediatek/mt8173-rt5650.c
index bb09bb1..a27a667 100644
--- a/sound/soc/mediatek/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173-rt5650.c
@@ -85,12 +85,29 @@ static int mt8173_rt5650_init(struct snd_soc_pcm_runtime *runtime)
 {
 	struct snd_soc_card *card = runtime->card;
 	struct snd_soc_codec *codec = runtime->codec_dais[0]->codec;
+	const char *codec_capture_dai = runtime->codec_dais[1]->name;
 	int ret;
 
 	rt5645_sel_asrc_clk_src(codec,
-				RT5645_DA_STEREO_FILTER |
-				RT5645_AD_STEREO_FILTER,
+				RT5645_DA_STEREO_FILTER,
 				RT5645_CLK_SEL_I2S1_ASRC);
+
+	if (!strcmp(codec_capture_dai, "rt5645-aif1")) {
+		rt5645_sel_asrc_clk_src(codec,
+					RT5645_AD_STEREO_FILTER,
+					RT5645_CLK_SEL_I2S1_ASRC);
+	} else if (!strcmp(codec_capture_dai, "rt5645-aif2")) {
+		rt5645_sel_asrc_clk_src(codec,
+					RT5645_AD_STEREO_FILTER,
+					RT5645_CLK_SEL_I2S2_ASRC);
+	} else {
+		dev_warn(card->dev,
+			 "Only one dai codec found in DTS, enabled rt5645 AD filter\n");
+		rt5645_sel_asrc_clk_src(codec,
+					RT5645_AD_STEREO_FILTER,
+					RT5645_CLK_SEL_I2S1_ASRC);
+	}
+
 	/* enable jack detection */
 	ret = snd_soc_card_jack_new(card, "Headset Jack",
 				    SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
@@ -110,6 +127,11 @@ static int mt8173_rt5650_init(struct snd_soc_pcm_runtime *runtime)
 
 static struct snd_soc_dai_link_component mt8173_rt5650_codecs[] = {
 	{
+		/* Playback */
+		.dai_name = "rt5645-aif1",
+	},
+	{
+		/* Capture */
 		.dai_name = "rt5645-aif1",
 	},
 };
@@ -149,7 +171,7 @@ static struct snd_soc_dai_link mt8173_rt5650_dais[] = {
 		.cpu_dai_name = "I2S",
 		.no_pcm = 1,
 		.codecs = mt8173_rt5650_codecs,
-		.num_codecs = 1,
+		.num_codecs = 2,
 		.init = mt8173_rt5650_init,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			   SND_SOC_DAIFMT_CBS_CFS,
@@ -177,6 +199,8 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &mt8173_rt5650_card;
 	struct device_node *platform_node;
+	struct device_node *np;
+	const char *codec_capture_dai;
 	int i, ret;
 
 	platform_node = of_parse_phandle(pdev->dev.of_node,
@@ -199,6 +223,26 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 			"Property 'audio-codec' missing or invalid\n");
 		return -EINVAL;
 	}
+	mt8173_rt5650_codecs[1].of_node = mt8173_rt5650_codecs[0].of_node;
+
+	if (of_find_node_by_name(platform_node, "codec-capture")) {
+		np = of_get_child_by_name(pdev->dev.of_node, "codec-capture");
+		if (!np) {
+			dev_err(&pdev->dev,
+				"%s: Can't find codec-capture DT node\n",
+				__func__);
+			return -EINVAL;
+		}
+		ret = snd_soc_of_get_dai_name(np, &codec_capture_dai);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"%s codec_capture_dai name fail %d\n",
+				__func__, ret);
+			return ret;
+		}
+		mt8173_rt5650_codecs[1].dai_name = codec_capture_dai;
+	}
+
 	card->dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 
-- 
1.7.9.5
