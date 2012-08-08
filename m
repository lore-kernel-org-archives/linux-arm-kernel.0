From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed,  8 Aug 2012 12:41:25 +0300
Subject: [PATCH 09/11] ASoC: twl4030: Convert to use devm_kzalloc
In-Reply-To: <1344418887-5262-1-git-send-email-peter.ujfalusi@ti.com>
References: <1344418887-5262-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1344418887-5262-10-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allocate the private data with devm_kzalloc.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl4030.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 1247c4a..6a00c01 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -2235,7 +2235,8 @@ static int twl4030_soc_probe(struct snd_soc_codec *codec)
 {
 	struct twl4030_priv *twl4030;
 
-	twl4030 = kzalloc(sizeof(struct twl4030_priv), GFP_KERNEL);
+	twl4030 = devm_kzalloc(codec->dev, sizeof(struct twl4030_priv),
+			       GFP_KERNEL);
 	if (twl4030 == NULL) {
 		dev_err(codec->dev, "Can not allocate memory\n");
 		return -ENOMEM;
@@ -2257,7 +2258,6 @@ static int twl4030_soc_remove(struct snd_soc_codec *codec)
 	/* Reset registers to their chip default before leaving */
 	twl4030_reset_registers(codec);
 	twl4030_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	kfree(twl4030);
 
 	if (pdata && pdata->hs_extmute && gpio_is_valid(pdata->hs_extmute_gpio))
 		gpio_free(pdata->hs_extmute_gpio);
-- 
1.7.8.6
