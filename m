From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Thu, 17 Oct 2013 17:01:14 +0800
Subject: [PATCHv1 5/8] ASoC: sgtl5000: Revise the bugs about the sgt15000
 codec.
In-Reply-To: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1382000477-17304-6-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the CONFIG_REGULATOR is disabled there will be some warnings
printed out.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/codecs/sgtl5000.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 1f4093f..4e2e4c9 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -883,14 +883,19 @@ static int ldo_regulator_register(struct snd_soc_codec *codec,
 				struct regulator_init_data *init_data,
 				int voltage)
 {
+#ifdef CONFIG_SND_SOC_FSL_SGTL5000
+	return 0;
+#else
 	dev_err(codec->dev, "this setup needs regulator support in the kernel\n");
 	return -EINVAL;
+#endif
 }
 
 static int ldo_regulator_remove(struct snd_soc_codec *codec)
 {
 	return 0;
 }
+
 #endif
 
 /*
@@ -1137,6 +1142,7 @@ static int sgtl5000_resume(struct snd_soc_codec *codec)
 #define sgtl5000_resume  NULL
 #endif	/* CONFIG_SUSPEND */
 
+#ifdef CONFIG_REGULATOR
 /*
  * sgtl5000 has 3 internal power supplies:
  * 1. VAG, normally set to vdda/2
@@ -1269,6 +1275,7 @@ static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
 
 	return 0;
 }
+#endif
 
 static int sgtl5000_replace_vddd_with_ldo(struct snd_soc_codec *codec)
 {
@@ -1370,6 +1377,7 @@ err_regulator_free:
 				sgtl5000->supplies);
 	if (external_vddd)
 		ldo_regulator_remove(codec);
+
 	return ret;
 
 }
@@ -1391,11 +1399,12 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_REGULATOR
 	/* power up sgtl5000 */
 	ret = sgtl5000_set_power_regs(codec);
 	if (ret)
 		goto err;
-
+#endif
 	/* enable small pop, introduce 400ms delay in turning off */
 	snd_soc_update_bits(codec, SGTL5000_CHIP_REF_CTRL,
 				SGTL5000_SMALL_POP,
@@ -1446,6 +1455,7 @@ err:
 						sgtl5000->supplies);
 	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
 				sgtl5000->supplies);
+
 	ldo_regulator_remove(codec);
 
 	return ret;
@@ -1461,6 +1471,7 @@ static int sgtl5000_remove(struct snd_soc_codec *codec)
 						sgtl5000->supplies);
 	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
 				sgtl5000->supplies);
+
 	ldo_regulator_remove(codec);
 
 	return 0;
-- 
1.8.0
