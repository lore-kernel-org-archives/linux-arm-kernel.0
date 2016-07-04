From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Mon, 4 Jul 2016 18:56:26 +0800
Subject: [alsa-devel] [PATCH 2/4] ASoC: bt-sco: extend rate and add a general
 compatible string
In-Reply-To: <1467629788-14411-1-git-send-email-garlic.tseng@mediatek.com>
References: <1467629788-14411-1-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <1467629788-14411-3-git-send-email-garlic.tseng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add supports for 16k (wideband BT) and add a general compatible
string "linux,bt-sco"

Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
---
 Documentation/devicetree/bindings/sound/bt-sco.txt |  2 +-
 sound/soc/codecs/bt-sco.c                          | 52 +++++++++++++++-------
 2 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/bt-sco.txt b/Documentation/devicetree/bindings/sound/bt-sco.txt
index 29b8e5d..641edf7 100644
--- a/Documentation/devicetree/bindings/sound/bt-sco.txt
+++ b/Documentation/devicetree/bindings/sound/bt-sco.txt
@@ -4,7 +4,7 @@ This device support generic Bluetooth SCO link.
 
 Required properties:
 
-  - compatible : "delta,dfbmcs320"
+  - compatible : "delta,dfbmcs320" or "linux,bt-sco"
 
 Example:
 
diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
index b084ad1..2a8d0ee 100644
--- a/sound/soc/codecs/bt-sco.c
+++ b/sound/soc/codecs/bt-sco.c
@@ -25,22 +25,41 @@ static const struct snd_soc_dapm_route bt_sco_routes[] = {
 	{ "TX", NULL, "Playback" },
 };
 
-static struct snd_soc_dai_driver bt_sco_dai = {
-	.name = "bt-sco-pcm",
-	.playback = {
-		.stream_name = "Playback",
-		.channels_min = 1,
-		.channels_max = 1,
-		.rates = SNDRV_PCM_RATE_8000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
-	},
-	.capture = {
-		 .stream_name = "Capture",
-		.channels_min = 1,
-		.channels_max = 1,
-		.rates = SNDRV_PCM_RATE_8000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+static struct snd_soc_dai_driver bt_sco_dai[] = {
+	{
+		.name = "bt-sco-pcm",
+		.playback = {
+			.stream_name = "Playback",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = SNDRV_PCM_RATE_8000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.capture = {
+			 .stream_name = "Capture",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = SNDRV_PCM_RATE_8000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
 	},
+	{
+		.name = "bt-sco-pcm-wb",
+		.playback = {
+			.stream_name = "Playback",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.capture = {
+			 .stream_name = "Capture",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+	}
 };
 
 static struct snd_soc_codec_driver soc_codec_dev_bt_sco = {
@@ -53,7 +72,7 @@ static struct snd_soc_codec_driver soc_codec_dev_bt_sco = {
 static int bt_sco_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_bt_sco,
-			&bt_sco_dai, 1);
+				      bt_sco_dai, ARRAY_SIZE(bt_sco_dai));
 }
 
 static int bt_sco_remove(struct platform_device *pdev)
@@ -77,6 +96,7 @@ MODULE_DEVICE_TABLE(platform, bt_sco_driver_ids);
 #if defined(CONFIG_OF)
 static const struct of_device_id bt_sco_codec_of_match[] = {
 	{ .compatible = "delta,dfbmcs320", },
+	{ .compatible = "linux,bt-sco", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, bt_sco_codec_of_match);
-- 
1.9.1
