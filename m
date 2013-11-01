From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Fri, 1 Nov 2013 15:04:52 +0800
Subject: [PATCHv2 5/8] ASoC: SGTL5000: Enhance the SGTL5000 codec driver about
 regulator.
In-Reply-To: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1383289495-24523-6-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On VF610 series there are no regulators used, and now whether the
CONFIG_REGULATOR mirco is enabled or not, for the VF610 audio
patch series, the board cannot be probe successfully.
And this patch will solve this issue.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/codecs/sgtl5000.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 1f4093f..c2f6d86 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -61,6 +61,7 @@ static const struct reg_default sgtl5000_reg_defaults[] = {
 	{ SGTL5000_DAP_AVC_DECAY,		0x0050 },
 };
 
+#ifdef CONFIG_REGULATOR
 /* regulator supplies for sgtl5000, VDDD is an optional external supply */
 enum sgtl5000_regulator_supplies {
 	VDDA,
@@ -93,6 +94,9 @@ static struct regulator_init_data ldo_init_data = {
 	.num_consumer_supplies = 1,
 	.consumer_supplies = &ldo_consumer[0],
 };
+#else
+#define SGTL5000_SUPPLY_NUM 0
+#endif
 
 /*
  * sgtl5000 internal ldo regulator,
@@ -112,7 +116,9 @@ struct sgtl5000_priv {
 	int master;	/* i2s master or not */
 	int fmt;	/* i2s data format */
 	struct regulator_bulk_data supplies[SGTL5000_SUPPLY_NUM];
+#ifdef CONFIG_REGULATOR
 	struct ldo_regulator *ldo;
+#endif
 	struct regmap *regmap;
 	struct clk *mclk;
 };
@@ -879,6 +885,7 @@ static int ldo_regulator_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 #else
+#ifndef CONFIG_SND_SOC_FSL_SGTL5000_VF610
 static int ldo_regulator_register(struct snd_soc_codec *codec,
 				struct regulator_init_data *init_data,
 				int voltage)
@@ -886,6 +893,7 @@ static int ldo_regulator_register(struct snd_soc_codec *codec,
 	dev_err(codec->dev, "this setup needs regulator support in the kernel\n");
 	return -EINVAL;
 }
+#endif
 
 static int ldo_regulator_remove(struct snd_soc_codec *codec)
 {
@@ -1137,6 +1145,7 @@ static int sgtl5000_resume(struct snd_soc_codec *codec)
 #define sgtl5000_resume  NULL
 #endif	/* CONFIG_SUSPEND */
 
+#ifdef CONFIG_REGULATOR
 /*
  * sgtl5000 has 3 internal power supplies:
  * 1. VAG, normally set to vdda/2
@@ -1373,6 +1382,7 @@ err_regulator_free:
 	return ret;
 
 }
+#endif
 
 static int sgtl5000_probe(struct snd_soc_codec *codec)
 {
@@ -1387,6 +1397,7 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
+#ifdef CONFIG_REGULATOR
 	ret = sgtl5000_enable_regulators(codec);
 	if (ret)
 		return ret;
@@ -1395,6 +1406,7 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 	ret = sgtl5000_set_power_regs(codec);
 	if (ret)
 		goto err;
+#endif
 
 	/* enable small pop, introduce 400ms delay in turning off */
 	snd_soc_update_bits(codec, SGTL5000_CHIP_REF_CTRL,
-- 
1.8.4
