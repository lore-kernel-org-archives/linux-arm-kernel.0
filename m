From: leiwen@marvell.com (Lei Wen)
Date: Wed, 22 Sep 2010 00:21:25 +0800
Subject: [PATCH 1/6 V2] pxa3xx_nand: make scan procedure more clear
In-Reply-To: <AANLkTinGdpt3kiCas6tpEZPbTknEe1Upz9D_aLgfNWo_@mail.gmail.com>
References: <AANLkTinGdpt3kiCas6tpEZPbTknEe1Upz9D_aLgfNWo_@mail.gmail.com>
Message-ID: <1285086085-2264-1-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 drivers/mtd/nand/pxa3xx_nand.c |   98 ++++++++++++++++++++++------------------
 1 files changed, 54 insertions(+), 44 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 17f8518..aff28dc 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -126,6 +126,7 @@ struct pxa3xx_nand_info {
 	unsigned int 		buf_start;
 	unsigned int		buf_count;
 
+	struct mtd_info         *mtd;
 	/* DMA information */
 	int			drcmr_dat;
 	int			drcmr_cmd;
@@ -1044,34 +1045,26 @@ static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
 	this->chip_delay = 25;
 }
 
-static int pxa3xx_nand_probe(struct platform_device *pdev)
+static struct pxa3xx_nand_info *alloc_nand_resource(struct platform_device *pdev)
 {
-	struct pxa3xx_nand_platform_data *pdata;
+	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
 	struct pxa3xx_nand_info *info;
-	struct nand_chip *this;
 	struct mtd_info *mtd;
 	struct resource *r;
-	int ret = 0, irq;
-
-	pdata = pdev->dev.platform_data;
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data defined\n");
-		return -ENODEV;
-	}
+	int ret, irq;
 
 	mtd = kzalloc(sizeof(struct mtd_info) + sizeof(struct pxa3xx_nand_info),
 			GFP_KERNEL);
 	if (!mtd) {
 		dev_err(&pdev->dev, "failed to allocate memory\n");
-		return -ENOMEM;
+		return NULL;
 	}
 
 	info = (struct pxa3xx_nand_info *)(&mtd[1]);
 	info->pdev = pdev;
 
-	this = &info->nand_chip;
 	mtd->priv = info;
+	info->mtd = mtd;
 	mtd->owner = THIS_MODULE;
 
 	info->clk = clk_get(&pdev->dev, NULL);
@@ -1149,31 +1142,9 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
 	}
 
 	pxa3xx_nand_init_mtd(mtd, info);
+	platform_set_drvdata(pdev, info);
 
-	platform_set_drvdata(pdev, mtd);
-
-	if (nand_scan(mtd, 1)) {
-		dev_err(&pdev->dev, "failed to scan nand\n");
-		ret = -ENXIO;
-		goto fail_free_irq;
-	}
-
-#ifdef CONFIG_MTD_PARTITIONS
-	if (mtd_has_cmdlinepart()) {
-		static const char *probes[] = { "cmdlinepart", NULL };
-		struct mtd_partition *parts;
-		int nr_parts;
-
-		nr_parts = parse_mtd_partitions(mtd, probes, &parts, 0);
-
-		if (nr_parts)
-			return add_mtd_partitions(mtd, parts, nr_parts);
-	}
-
-	return add_mtd_partitions(mtd, pdata->parts, pdata->nr_parts);
-#else
-	return 0;
-#endif
+	return info;
 
 fail_free_irq:
 	free_irq(irq, info);
@@ -1193,13 +1164,13 @@ fail_put_clk:
 	clk_put(info->clk);
 fail_free_mtd:
 	kfree(mtd);
-	return ret;
+	return NULL;
 }
 
 static int pxa3xx_nand_remove(struct platform_device *pdev)
 {
-	struct mtd_info *mtd = platform_get_drvdata(pdev);
-	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
+	struct mtd_info *mtd = info->mtd;
 	struct resource *r;
 	int irq;
 
@@ -1230,11 +1201,50 @@ static int pxa3xx_nand_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int pxa3xx_nand_probe(struct platform_device *pdev)
+{
+	struct pxa3xx_nand_platform_data *pdata;
+	struct pxa3xx_nand_info *info;
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "no platform data defined\n");
+		return -ENODEV;
+	}
+
+	info = alloc_nand_resource(pdev);
+	if (info == NULL)
+		return -ENOMEM;
+
+	if (nand_scan(info->mtd, 1)) {
+		dev_err(&pdev->dev, "failed to scan nand\n");
+		pxa3xx_nand_remove(pdev);
+		return -ENODEV;
+	}
+
+#ifdef CONFIG_MTD_PARTITIONS
+	if (mtd_has_cmdlinepart()) {
+		static const char *probes[] = { "cmdlinepart", NULL };
+		struct mtd_partition *parts;
+		int nr_parts;
+
+		nr_parts = parse_mtd_partitions(info->mtd, probes, &parts, 0);
+
+		if (nr_parts)
+			return add_mtd_partitions(mtd, parts, nr_parts);
+	}
+
+	return add_mtd_partitions(mtd, pdata->parts, pdata->nr_parts);
+#else
+	return 0;
+#endif
+}
+
 #ifdef CONFIG_PM
 static int pxa3xx_nand_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	struct mtd_info *mtd = (struct mtd_info *)platform_get_drvdata(pdev);
-	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
+	struct mtd_info *mtd = info->mtd;
 
 	if (info->state != STATE_READY) {
 		dev_err(&pdev->dev, "driver busy, state = %d\n", info->state);
@@ -1246,8 +1256,8 @@ static int pxa3xx_nand_suspend(struct platform_device *pdev, pm_message_t state)
 
 static int pxa3xx_nand_resume(struct platform_device *pdev)
 {
-	struct mtd_info *mtd = (struct mtd_info *)platform_get_drvdata(pdev);
-	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
+	struct mtd_info *mtd = info->mtd;
 
 	nand_writel(info, NDTR0CS0, info->ndtr0cs0);
 	nand_writel(info, NDTR1CS0, info->ndtr1cs0);
-- 
1.7.0.4
