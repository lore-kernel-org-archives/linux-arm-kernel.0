From: broonie@kernel.org (Mark Brown)
Date: Mon, 04 Jul 2016 16:49:42 +0200
Subject: Applied "ASoC: bt-sco: extend rate and add a general compatible
 string" to the asoc tree
In-Reply-To: <1467629788-14411-3-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <E1bK5Bu-0007K5-6d@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: bt-sco: extend rate and add a general compatible string

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

>From 5947e1b4992e2852b5176df6a554b5ebfbc9eff2 Mon Sep 17 00:00:00 2001
From: Garlic Tseng <garlic.tseng@mediatek.com>
Date: Mon, 4 Jul 2016 18:56:26 +0800
Subject: [PATCH] ASoC: bt-sco: extend rate and add a general compatible string

Add supports for 16k (wideband BT) and add a general compatible
string "linux,bt-sco"

Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/bt-sco.txt |  2 +-
 sound/soc/codecs/bt-sco.c                          | 52 +++++++++++++++-------
 2 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/bt-sco.txt b/Documentation/devicetree/bindings/sound/bt-sco.txt
index 29b8e5d40203..641edf75e184 100644
--- a/Documentation/devicetree/bindings/sound/bt-sco.txt
+++ b/Documentation/devicetree/bindings/sound/bt-sco.txt
@@ -4,7 +4,7 @@ This device support generic Bluetooth SCO link.
 
 Required properties:
 
-  - compatible : "delta,dfbmcs320"
+  - compatible : "delta,dfbmcs320" or "linux,bt-sco"
 
 Example:
 
diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
index b084ad113e96..2a8d0ee141d4 100644
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
2.8.1
