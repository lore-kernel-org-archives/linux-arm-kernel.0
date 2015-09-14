From: b18965@freescale.com (Alison Wang)
Date: Mon, 14 Sep 2015 17:03:24 +0800
Subject: [PATCH v2] audio: sai: Add Power Management support
Message-ID: <1442221404-35240-1-git-send-email-b18965@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds Power Management support for SAI.
Activate regmap cache with REGCACHE_FLAT, and use
regmap cache code to save and restore registers in
suspend and resume. The Transmit Control Register
(TCSR) and Receive Control Register(RCSR) should
be volatile registers.

Signed-off-by: Alison Wang <alison.wang@freescale.com>
---
Changes since v1:
- Use REGCACHE_FLAT instead of REGCACHE_RBTREE.
- Use SIMPLE_DEV_PM_OPS to simplify the code. 

 sound/soc/fsl/fsl_sai.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index a18fd92..030f71e 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -637,9 +637,11 @@ static bool fsl_sai_readable_reg(struct device *dev, unsigned int reg)
 static bool fsl_sai_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case FSL_SAI_TCSR:
 	case FSL_SAI_TFR:
-	case FSL_SAI_RFR:
 	case FSL_SAI_TDR:
+	case FSL_SAI_RCSR:
+	case FSL_SAI_RFR:
 	case FSL_SAI_RDR:
 		return true;
 	default:
@@ -681,6 +683,7 @@ static const struct regmap_config fsl_sai_regmap_config = {
 	.readable_reg = fsl_sai_readable_reg,
 	.volatile_reg = fsl_sai_volatile_reg,
 	.writeable_reg = fsl_sai_writeable_reg,
+	.cache_type = REGCACHE_FLAT,
 };
 
 static int fsl_sai_probe(struct platform_device *pdev)
@@ -796,6 +799,31 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		return devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int fsl_sai_suspend(struct device *dev)
+{
+	struct fsl_sai *sai = dev_get_drvdata(dev);
+
+	regcache_cache_only(sai->regmap, true);
+	regcache_mark_dirty(sai->regmap);
+
+	return 0;
+}
+
+static int fsl_sai_resume(struct device *dev)
+{
+	struct fsl_sai *sai = dev_get_drvdata(dev);
+
+	/* Restore all registers */
+	regcache_cache_only(sai->regmap, false);
+	regcache_sync(sai->regmap);
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static SIMPLE_DEV_PM_OPS(fsl_sai_pm, fsl_sai_suspend, fsl_sai_resume);
+
 static const struct of_device_id fsl_sai_ids[] = {
 	{ .compatible = "fsl,vf610-sai", },
 	{ .compatible = "fsl,imx6sx-sai", },
@@ -807,6 +835,7 @@ static struct platform_driver fsl_sai_driver = {
 	.driver = {
 		.name = "fsl-sai",
 		.of_match_table = fsl_sai_ids,
+		.pm = &fsl_sai_pm,
 	},
 };
 module_platform_driver(fsl_sai_driver);
-- 
2.1.0.27.g96db324
