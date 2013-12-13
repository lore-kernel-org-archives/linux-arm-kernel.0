From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 13 Dec 2013 14:43:03 +0800
Subject: [PATCH 2/2] ASoC: sgtl5000: clean up sgtl5000_enable_regulators()
In-Reply-To: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
References: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function sgtl5000_enable_regulators() is somehow odd in handling the
optional external VDDD supply.  The driver can only enable this supply
on SGTL5000 chip before revision 0x11, and of course when this external
VDDD is present.  It currently does something like below.

1. Check if regulator_bulk_get() on VDDA, VDDIO and VDDD will fail.  If
   it fails, VDDD must be absent and it falls on internal LDO by calling
   sgtl5000_replace_vddd_with_ldo().  Otherwise, VDDD is used.  And in
   either case, regulator_bulk_enable() will be called to enable
   3 supplies.

2. In case that SGTL5000 revision is later than 0x11, even if external
   VDDD is present, it has to roll back the 'enable' and 'get' calls
   with regulator_bulk_disable() and regulator_bulk_free(), and starts
   over again by calling sgtl5000_replace_vddd_with_ldo() and
   regulator_bulk_enable().

Such back and forth calls sequence is complicated and unnecessary.
Also, since commit 4ddfebd (regulator: core: Provide a dummy regulator
with full constraints), regulator_bulk_get() will always succeeds
because of the dummy regulator.  Thus the VDDD detection is broken.

The patch changes the flow to something like the following, which should
be more reasonable and clear, and also fix the VDDD detection breakage.

1. Check if we're running a chip before revision 0x11, on which an
   external VDDD can possibly be an option.

2. If it is an early revision, call regulator_get_optional() to detect
   whether an external VDDD supply is available.

3. If external VDDD is present, call sgtl5000_replace_vddd_with_ldo() to
   update sgtl5000->supplies info.

4. Drop regulator_bulk_get() call in sgtl5000_replace_vddd_with_ldo(),
   and call it in sgtl5000_enable_regulators() no matter it's an
   external VDDD or internal LDO.

5. Call regulator_bulk_enable() to enable these 3 regulators.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/codecs/sgtl5000.c |   62 +++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 40 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index bd291d2..0fcbe90 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1286,15 +1286,6 @@ static int sgtl5000_replace_vddd_with_ldo(struct snd_soc_codec *codec)
 
 	sgtl5000->supplies[VDDD].supply = LDO_CONSUMER_NAME;
 
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
-			sgtl5000->supplies);
-
-	if (ret) {
-		ldo_regulator_remove(codec);
-		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		return ret;
-	}
-
 	dev_info(codec->dev, "Using internal LDO instead of VDDD\n");
 	return 0;
 }
@@ -1305,20 +1296,35 @@ static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 	int i;
 	int external_vddd = 0;
 	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
+	struct regulator *vddd;
 
 	for (i = 0; i < ARRAY_SIZE(sgtl5000->supplies); i++)
 		sgtl5000->supplies[i].supply = supply_names[i];
 
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
-				sgtl5000->supplies);
-	if (!ret)
-		external_vddd = 1;
-	else {
+	/* External VDDD only works before revision 0x11 */
+	if (sgtl5000->revision < 0x11) {
+		vddd = regulator_get_optional(codec->dev, "VDDD");
+		if (IS_ERR(vddd)) {
+			/* See if it's just not registered yet */
+			if (PTR_ERR(vddd) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+		} else {
+			external_vddd = 1;
+			regulator_put(vddd);
+		}
+	}
+
+	if (!external_vddd) {
 		ret = sgtl5000_replace_vddd_with_ldo(codec);
 		if (ret)
 			return ret;
 	}
 
+	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
+				 sgtl5000->supplies);
+	if (ret)
+		goto err_ldo_remove;
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(sgtl5000->supplies),
 					sgtl5000->supplies);
 	if (ret)
@@ -1327,37 +1333,13 @@ static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 	/* wait for all power rails bring up */
 	udelay(10);
 
-	/*
-	 * workaround for revision 0x11 and later,
-	 * roll back to use internal LDO
-	 */
-	if (external_vddd && sgtl5000->revision >= 0x11) {
-		/* disable all regulator first */
-		regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
-					sgtl5000->supplies);
-		/* free VDDD regulator */
-		regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
-					sgtl5000->supplies);
-
-		ret = sgtl5000_replace_vddd_with_ldo(codec);
-		if (ret)
-			return ret;
-
-		ret = regulator_bulk_enable(ARRAY_SIZE(sgtl5000->supplies),
-						sgtl5000->supplies);
-		if (ret)
-			goto err_regulator_free;
-
-		/* wait for all power rails bring up */
-		udelay(10);
-	}
-
 	return 0;
 
 err_regulator_free:
 	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
 				sgtl5000->supplies);
-	if (external_vddd)
+err_ldo_remove:
+	if (!external_vddd)
 		ldo_regulator_remove(codec);
 	return ret;
 
-- 
1.7.9.5
