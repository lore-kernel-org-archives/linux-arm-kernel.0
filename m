From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Apr 2016 10:58:42 +0100
Subject: Applied "ASoC: mediatek: Add second I2S on mt8173-rt5650 machine
 driver" to the asoc tree
In-Reply-To: <1461059172-47460-1-git-send-email-pc.liao@mediatek.com>
Message-ID: <E1asSQc-0004NY-44@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: mediatek: Add second I2S on mt8173-rt5650 machine driver

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 0beeb8d0b434b8b007ac8058fb2cac5997fff6df Mon Sep 17 00:00:00 2001
From: PC Liao <pc.liao@mediatek.com>
Date: Tue, 19 Apr 2016 17:46:12 +0800
Subject: [PATCH] ASoC: mediatek: Add second I2S on mt8173-rt5650 machine
 driver

This patch adds second I2S connection to rt5650 codec for capture path on
mt8173-rt5650 machine driver.

This patch depends on [1], because snd_soc_of_get_dai_name() fix the property
name "sound-dai". This patch needs to change name to use, so export
snd_soc_get_dai_name() which is included in snd_soc_of_get_dai_name().

[1] https://patchwork.kernel.org/patch/5671961/ ("ASoC: core: export
snd_soc_get_dai_name")

Signed-off-by: PC Liao <pc.liao@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/mt8173-rt5650.txt    |  6 +++
 sound/soc/mediatek/mt8173-rt5650.c                 | 44 ++++++++++++++++++++--
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt b/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
index fe5a5ef1714d..802dd1bf0fc6 100644
--- a/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
+++ b/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
@@ -5,11 +5,17 @@ Required properties:
 - mediatek,audio-codec: the phandles of rt5650 codecs
 - mediatek,platform: the phandle of MT8173 ASoC platform
 
+Optional properties:
+- capture-dai: audio codec dai on capture path
+  <&rt5650 0> : Default setting. Connect rt5650 I2S1 for capture. (dai_name = rt5645-aif1)
+  <&rt5650 1> : Connect rt5650 I2S2 for capture. (dai_name = rt5645-aif2)
+
 Example:
 
 	sound {
 		compatible = "mediatek,mt8173-rt5650";
 		mediatek,audio-codec = <&rt5650>;
 		mediatek,platform = <&afe>;
+		capture-dai = <&rt5650 1>;
 	};
 
diff --git a/sound/soc/mediatek/mt8173-rt5650.c b/sound/soc/mediatek/mt8173-rt5650.c
index bb09bb1b7f1c..45dea226e4c8 100644
--- a/sound/soc/mediatek/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173-rt5650.c
@@ -85,12 +85,26 @@ static int mt8173_rt5650_init(struct snd_soc_pcm_runtime *runtime)
 {
 	struct snd_soc_card *card = runtime->card;
 	struct snd_soc_codec *codec = runtime->codec_dais[0]->codec;
+	const char *codec_dai_capture = runtime->codec_dais[1]->name;
 	int ret;
 
 	rt5645_sel_asrc_clk_src(codec,
-				RT5645_DA_STEREO_FILTER |
-				RT5645_AD_STEREO_FILTER,
+				RT5645_DA_STEREO_FILTER,
 				RT5645_CLK_SEL_I2S1_ASRC);
+
+	if (!strcmp(codec_dai_capture, "rt5645-aif1")) {
+		rt5645_sel_asrc_clk_src(codec,
+					RT5645_AD_STEREO_FILTER,
+					RT5645_CLK_SEL_I2S1_ASRC);
+	} else if (!strcmp(codec_dai_capture, "rt5645-aif2")) {
+		rt5645_sel_asrc_clk_src(codec,
+					RT5645_AD_STEREO_FILTER,
+					RT5645_CLK_SEL_I2S2_ASRC);
+	} else {
+		dev_err(card->dev, "Can't get the right codec dai\n");
+		return -EINVAL;
+	}
+
 	/* enable jack detection */
 	ret = snd_soc_card_jack_new(card, "Headset Jack",
 				    SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
@@ -110,6 +124,11 @@ static int mt8173_rt5650_init(struct snd_soc_pcm_runtime *runtime)
 
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
@@ -149,7 +168,7 @@ static struct snd_soc_dai_link mt8173_rt5650_dais[] = {
 		.cpu_dai_name = "I2S",
 		.no_pcm = 1,
 		.codecs = mt8173_rt5650_codecs,
-		.num_codecs = 1,
+		.num_codecs = 2,
 		.init = mt8173_rt5650_init,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			   SND_SOC_DAIFMT_CBS_CFS,
@@ -177,6 +196,8 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &mt8173_rt5650_card;
 	struct device_node *platform_node;
+	const char *codec_dai_capture;
+	struct of_phandle_args args;
 	int i, ret;
 
 	platform_node = of_parse_phandle(pdev->dev.of_node,
@@ -199,6 +220,23 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 			"Property 'audio-codec' missing or invalid\n");
 		return -EINVAL;
 	}
+	mt8173_rt5650_codecs[1].of_node = mt8173_rt5650_codecs[0].of_node;
+
+	if (device_property_present(&pdev->dev, "capture-dai")) {
+		ret = of_parse_phandle_with_args(pdev->dev.of_node,
+						 "capture-dai",
+						 "#sound-dai-cells", 0, &args);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"%s capture-dai name fail %d\n",
+				__func__, ret);
+			return ret;
+		}
+
+		ret = snd_soc_get_dai_name(&args, &codec_dai_capture);
+		mt8173_rt5650_codecs[1].dai_name = codec_dai_capture;
+	}
+
 	card->dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 
-- 
2.8.0.rc3
