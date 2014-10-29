From: b18965@freescale.com (Alison Wang)
Date: Wed, 29 Oct 2014 11:21:36 +0800
Subject: [PATCH] audio: sai: Add Power Management support
Message-ID: <1414552896-20797-1-git-send-email-b18965@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds Power Management support for SAI.
Activate regmap cache with REGCACHE_RBTREE, and use
regmap cache code to save and restore registers in
suspend and resume. The Transmit Control Register
(TCSR) and Receive Control Register(RCSR) should
be volatile registers.

Signed-off-by: Alison Wang <alison.wang@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 7eeb1dd..c7dd953 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -509,9 +509,11 @@ static bool fsl_sai_readable_reg(struct device *dev, unsigned int reg)
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
@@ -553,6 +555,7 @@ static const struct regmap_config fsl_sai_regmap_config = {
 	.readable_reg = fsl_sai_readable_reg,
 	.volatile_reg = fsl_sai_volatile_reg,
 	.writeable_reg = fsl_sai_writeable_reg,
+	.cache_type = REGCACHE_RBTREE,
 };
 
 static int fsl_sai_probe(struct platform_device *pdev)
@@ -668,6 +671,33 @@ static int fsl_sai_probe(struct platform_device *pdev)
 				SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
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
+};
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops fsl_sai_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(fsl_sai_suspend, fsl_sai_resume)
+};
+
 static const struct of_device_id fsl_sai_ids[] = {
 	{ .compatible = "fsl,vf610-sai", },
 	{ .compatible = "fsl,imx6sx-sai", },
@@ -680,6 +710,7 @@ static struct platform_driver fsl_sai_driver = {
 		.name = "fsl-sai",
 		.owner = THIS_MODULE,
 		.of_match_table = fsl_sai_ids,
+		.pm = &fsl_sai_pm,
 	},
 };
 module_platform_driver(fsl_sai_driver);
-- 
2.1.0.27.g96db324
