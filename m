From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 13 Dec 2013 14:43:02 +0800
Subject: [PATCH 1/2] ASoC: sgtl5000: read chip revision for once
Message-ID: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Store chip revision in struct sgtl5000_priv when sgtl5000_i2c_probe()
reads it out from register, so that we can use it in
sgtl5000_enable_regulators() with no need to read register again.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/codecs/sgtl5000.c |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 1f4093f..bd291d2 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -115,6 +115,7 @@ struct sgtl5000_priv {
 	struct ldo_regulator *ldo;
 	struct regmap *regmap;
 	struct clk *mclk;
+	int revision;
 };
 
 /*
@@ -1300,9 +1301,7 @@ static int sgtl5000_replace_vddd_with_ldo(struct snd_soc_codec *codec)
 
 static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 {
-	int reg;
 	int ret;
-	int rev;
 	int i;
 	int external_vddd = 0;
 	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
@@ -1332,14 +1331,7 @@ static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 	 * workaround for revision 0x11 and later,
 	 * roll back to use internal LDO
 	 */
-
-	ret = regmap_read(sgtl5000->regmap, SGTL5000_CHIP_ID, &reg);
-	if (ret)
-		goto err_regulator_disable;
-
-	rev = (reg & SGTL5000_REVID_MASK) >> SGTL5000_REVID_SHIFT;
-
-	if (external_vddd && rev >= 0x11) {
+	if (external_vddd && sgtl5000->revision >= 0x11) {
 		/* disable all regulator first */
 		regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
 					sgtl5000->supplies);
@@ -1362,9 +1354,6 @@ static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 
 	return 0;
 
-err_regulator_disable:
-	regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
-				sgtl5000->supplies);
 err_regulator_free:
 	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
 				sgtl5000->supplies);
@@ -1566,6 +1555,7 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 
 	rev = (reg & SGTL5000_REVID_MASK) >> SGTL5000_REVID_SHIFT;
 	dev_info(&client->dev, "sgtl5000 revision 0x%x\n", rev);
+	sgtl5000->revision = rev;
 
 	i2c_set_clientdata(client, sgtl5000);
 
-- 
1.7.9.5
