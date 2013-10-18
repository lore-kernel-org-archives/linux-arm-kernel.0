From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 18 Oct 2013 20:02:34 -0300
Subject: [PATCH v2 07/27] mtd: nand: pxa3xx: Early variant detection
In-Reply-To: <1382137374-21251-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1382137374-21251-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1382137374-21251-8-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to customize early settings depending on the detected SoC variant,
move the detection to be before the nand_chip struct filling.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 48 +++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 5ca3154..83ea806 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -256,6 +256,29 @@ static struct pxa3xx_nand_flash builtin_flash_types[] = {
 /* convert nano-seconds to nand flash controller clock cycles */
 #define ns2cycle(ns, clk)	(int)((ns) * (clk / 1000000) / 1000)
 
+static struct of_device_id pxa3xx_nand_dt_ids[] = {
+	{
+		.compatible = "marvell,pxa3xx-nand",
+		.data       = (void *)PXA3XX_NAND_VARIANT_PXA,
+	},
+	{
+		.compatible = "marvell,armada370-nand",
+		.data       = (void *)PXA3XX_NAND_VARIANT_ARMADA370,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, pxa3xx_nand_dt_ids);
+
+static enum pxa3xx_nand_variant
+pxa3xx_nand_get_variant(struct platform_device *pdev)
+{
+	const struct of_device_id *of_id =
+			of_match_device(pxa3xx_nand_dt_ids, &pdev->dev);
+	if (!of_id)
+		return PXA3XX_NAND_VARIANT_PXA;
+	return (enum pxa3xx_nand_variant)of_id->data;
+}
+
 static void pxa3xx_nand_set_timing(struct pxa3xx_nand_host *host,
 				   const struct pxa3xx_nand_timing *t)
 {
@@ -1121,6 +1144,7 @@ static int alloc_nand_resource(struct platform_device *pdev)
 		return -ENOMEM;
 
 	info->pdev = pdev;
+	info->variant = pxa3xx_nand_get_variant(pdev);
 	for (cs = 0; cs < pdata->num_cs; cs++) {
 		mtd = (struct mtd_info *)((unsigned int)&info[1] +
 		      (sizeof(*mtd) + sizeof(*host)) * cs);
@@ -1256,29 +1280,6 @@ static int pxa3xx_nand_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id pxa3xx_nand_dt_ids[] = {
-	{
-		.compatible = "marvell,pxa3xx-nand",
-		.data       = (void *)PXA3XX_NAND_VARIANT_PXA,
-	},
-	{
-		.compatible = "marvell,armada370-nand",
-		.data       = (void *)PXA3XX_NAND_VARIANT_ARMADA370,
-	},
-	{}
-};
-MODULE_DEVICE_TABLE(of, pxa3xx_nand_dt_ids);
-
-static enum pxa3xx_nand_variant
-pxa3xx_nand_get_variant(struct platform_device *pdev)
-{
-	const struct of_device_id *of_id =
-			of_match_device(pxa3xx_nand_dt_ids, &pdev->dev);
-	if (!of_id)
-		return PXA3XX_NAND_VARIANT_PXA;
-	return (enum pxa3xx_nand_variant)of_id->data;
-}
-
 static int pxa3xx_nand_probe_dt(struct platform_device *pdev)
 {
 	struct pxa3xx_nand_platform_data *pdata;
@@ -1335,7 +1336,6 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
 	}
 
 	info = platform_get_drvdata(pdev);
-	info->variant = pxa3xx_nand_get_variant(pdev);
 	probe_success = 0;
 	for (cs = 0; cs < pdata->num_cs; cs++) {
 		struct mtd_info *mtd = info->host[cs]->mtd;
-- 
1.8.1.5
