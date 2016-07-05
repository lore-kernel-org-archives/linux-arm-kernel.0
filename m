From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  5 Jul 2016 14:45:02 +0200
Subject: [PATCH 03/11] ASoC: ab8500-codec: remove platform data based probe
In-Reply-To: <1467722710-1577-1-git-send-email-linus.walleij@linaro.org>
References: <1467722710-1577-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1467722710-1577-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

The ux500 platform hasn't used board files for a long time, and
nothing defines a ab8500_codec_platform_data, so we can just
remove the probing based on that and always use device tree
properties directly.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Mark: if this makes sense to you, please provide an ACK so Arnd
can merge this cleanup.
---
 sound/soc/codecs/ab8500-codec.c | 33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 8b1d0c1a7839..2fc89155f14a 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2464,45 +2464,20 @@ static int ab8500_codec_probe(struct snd_soc_codec *codec)
 	struct device *dev = codec->dev;
 	struct device_node *np = dev->of_node;
 	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(dev);
-	struct ab8500_platform_data *pdata;
+	struct ab8500_codec_platform_data codec_pdata;
 	struct filter_control *fc;
 	int status;
 
 	dev_dbg(dev, "%s: Enter.\n", __func__);
 
-	/* Setup AB8500 according to board-settings */
-	pdata = dev_get_platdata(dev->parent);
+	ab8500_codec_of_probe(dev, np, &codec_pdata);
 
-	if (np) {
-		if (!pdata)
-			pdata = devm_kzalloc(dev,
-					sizeof(struct ab8500_platform_data),
-					GFP_KERNEL);
-
-		if (pdata && !pdata->codec)
-			pdata->codec
-				= devm_kzalloc(dev,
-					sizeof(struct ab8500_codec_platform_data),
-					GFP_KERNEL);
-
-		if (!(pdata && pdata->codec))
-			return -ENOMEM;
-
-		ab8500_codec_of_probe(dev, np, pdata->codec);
-
-	} else {
-		if (!(pdata && pdata->codec)) {
-			dev_err(dev, "No codec platform data or DT found\n");
-			return -EINVAL;
-		}
-	}
-
-	status = ab8500_audio_setup_mics(codec, &pdata->codec->amics);
+	status = ab8500_audio_setup_mics(codec, &codec_pdata.amics);
 	if (status < 0) {
 		pr_err("%s: Failed to setup mics (%d)!\n", __func__, status);
 		return status;
 	}
-	status = ab8500_audio_set_ear_cmv(codec, pdata->codec->ear_cmv);
+	status = ab8500_audio_set_ear_cmv(codec, codec_pdata.ear_cmv);
 	if (status < 0) {
 		pr_err("%s: Failed to set earpiece CM-voltage (%d)!\n",
 			__func__, status);
-- 
2.4.11
