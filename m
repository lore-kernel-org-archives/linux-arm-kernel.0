From: koro.chen@mediatek.com (Koro Chen)
Date: Thu, 9 Jul 2015 10:51:27 +0800
Subject: [PATCH] ASoC: mediatek: Use platform_of_node for machine drivers
Message-ID: <1436410287-61097-1-git-send-email-koro.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This replaces the platform_name in snd_soc_dai_link by device tree node.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
---
 .../devicetree/bindings/sound/mt8173-max98090.txt     |  2 ++
 .../bindings/sound/mt8173-rt5650-rt5676.txt           |  2 ++
 sound/soc/mediatek/mt8173-max98090.c                  | 17 +++++++++++++----
 sound/soc/mediatek/mt8173-rt5650-rt5676.c             | 19 +++++++++++++++----
 4 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8173-max98090.txt b/Documentation/devicetree/bindings/sound/mt8173-max98090.txt
index 829bd26..519e97c 100644
--- a/Documentation/devicetree/bindings/sound/mt8173-max98090.txt
+++ b/Documentation/devicetree/bindings/sound/mt8173-max98090.txt
@@ -3,11 +3,13 @@ MT8173 with MAX98090 CODEC
 Required properties:
 - compatible : "mediatek,mt8173-max98090"
 - mediatek,audio-codec: the phandle of the MAX98090 audio codec
+- mediatek,platform: the phandle of MT8173 ASoC platform
 
 Example:
 
 	sound {
 		compatible = "mediatek,mt8173-max98090";
 		mediatek,audio-codec = <&max98090>;
+		mediatek,platform = <&afe>;
 	};
 
diff --git a/Documentation/devicetree/bindings/sound/mt8173-rt5650-rt5676.txt b/Documentation/devicetree/bindings/sound/mt8173-rt5650-rt5676.txt
index 61e98c9..f205ce9 100644
--- a/Documentation/devicetree/bindings/sound/mt8173-rt5650-rt5676.txt
+++ b/Documentation/devicetree/bindings/sound/mt8173-rt5650-rt5676.txt
@@ -3,11 +3,13 @@ MT8173 with RT5650 RT5676 CODECS
 Required properties:
 - compatible : "mediatek,mt8173-rt5650-rt5676"
 - mediatek,audio-codec: the phandles of rt5650 and rt5676 codecs
+- mediatek,platform: the phandle of MT8173 ASoC platform
 
 Example:
 
 	sound {
 		compatible = "mediatek,mt8173-rt5650-rt5676";
 		mediatek,audio-codec = <&rt5650 &rt5676>;
+		mediatek,platform = <&afe>;
 	};
 
diff --git a/sound/soc/mediatek/mt8173-max98090.c b/sound/soc/mediatek/mt8173-max98090.c
index 4d44b58..2d2536a 100644
--- a/sound/soc/mediatek/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173-max98090.c
@@ -103,7 +103,6 @@ static struct snd_soc_dai_link mt8173_max98090_dais[] = {
 		.name = "MAX98090 Playback",
 		.stream_name = "MAX98090 Playback",
 		.cpu_dai_name = "DL1",
-		.platform_name = "11220000.mt8173-afe-pcm",
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
@@ -114,7 +113,6 @@ static struct snd_soc_dai_link mt8173_max98090_dais[] = {
 		.name = "MAX98090 Capture",
 		.stream_name = "MAX98090 Capture",
 		.cpu_dai_name = "VUL",
-		.platform_name = "11220000.mt8173-afe-pcm",
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
@@ -125,7 +123,6 @@ static struct snd_soc_dai_link mt8173_max98090_dais[] = {
 	{
 		.name = "Codec",
 		.cpu_dai_name = "I2S",
-		.platform_name = "11220000.mt8173-afe-pcm",
 		.no_pcm = 1,
 		.codec_dai_name = "HiFi",
 		.init = mt8173_max98090_init,
@@ -152,9 +149,21 @@ static struct snd_soc_card mt8173_max98090_card = {
 static int mt8173_max98090_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &mt8173_max98090_card;
-	struct device_node *codec_node;
+	struct device_node *codec_node, *platform_node;
 	int ret, i;
 
+	platform_node = of_parse_phandle(pdev->dev.of_node,
+					 "mediatek,platform", 0);
+	if (!platform_node) {
+		dev_err(&pdev->dev, "Property 'platform' missing or invalid\n");
+		return -EINVAL;
+	}
+	for (i = 0; i < card->num_links; i++) {
+		if (mt8173_max98090_dais[i].platform_name)
+			continue;
+		mt8173_max98090_dais[i].platform_of_node = platform_node;
+	}
+
 	codec_node = of_parse_phandle(pdev->dev.of_node,
 				      "mediatek,audio-codec", 0);
 	if (!codec_node) {
diff --git a/sound/soc/mediatek/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
index 0940553..6f52eca 100644
--- a/sound/soc/mediatek/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
@@ -138,7 +138,6 @@ static struct snd_soc_dai_link mt8173_rt5650_rt5676_dais[] = {
 		.name = "rt5650_rt5676 Playback",
 		.stream_name = "rt5650_rt5676 Playback",
 		.cpu_dai_name = "DL1",
-		.platform_name = "11220000.mt8173-afe-pcm",
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
@@ -149,7 +148,6 @@ static struct snd_soc_dai_link mt8173_rt5650_rt5676_dais[] = {
 		.name = "rt5650_rt5676 Capture",
 		.stream_name = "rt5650_rt5676 Capture",
 		.cpu_dai_name = "VUL",
-		.platform_name = "11220000.mt8173-afe-pcm",
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
@@ -161,7 +159,6 @@ static struct snd_soc_dai_link mt8173_rt5650_rt5676_dais[] = {
 	{
 		.name = "Codec",
 		.cpu_dai_name = "I2S",
-		.platform_name = "11220000.mt8173-afe-pcm",
 		.no_pcm = 1,
 		.codecs = mt8173_rt5650_rt5676_codecs,
 		.num_codecs = 2,
@@ -209,7 +206,21 @@ static struct snd_soc_card mt8173_rt5650_rt5676_card = {
 static int mt8173_rt5650_rt5676_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &mt8173_rt5650_rt5676_card;
-	int ret;
+	struct device_node *platform_node;
+	int i, ret;
+
+	platform_node = of_parse_phandle(pdev->dev.of_node,
+					 "mediatek,platform", 0);
+	if (!platform_node) {
+		dev_err(&pdev->dev, "Property 'platform' missing or invalid\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < card->num_links; i++) {
+		if (mt8173_rt5650_rt5676_dais[i].platform_name)
+			continue;
+		mt8173_rt5650_rt5676_dais[i].platform_of_node = platform_node;
+	}
 
 	mt8173_rt5650_rt5676_codecs[0].of_node =
 		of_parse_phandle(pdev->dev.of_node, "mediatek,audio-codec", 0);
-- 
1.8.1.1.dirty
