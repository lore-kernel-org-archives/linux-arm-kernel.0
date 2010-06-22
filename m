From: leiwen@marvell.com (Lei Wen)
Date: Tue, 22 Jun 2010 21:01:27 +0800
Subject: [PATCH 06/29] pxa3xx_nand: make scan procedure more clear
Message-ID: <mailman.104.1280296645.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |   88 ++++++++++++++++++++++-----------------
 1 files changed, 50 insertions(+), 38 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 26c0286..8d030ec 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -126,6 +126,7 @@ struct pxa3xx_nand_info {
 	unsigned int 		buf_start;
 	unsigned int		buf_count;

+	struct mtd_info         *mtd;
 	/* DMA information */
 	int			drcmr_dat;
 	int			drcmr_cmd;
@@ -1046,21 +1047,13 @@ static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
 	this->chip_delay = 25;
 }

-static int __devinit pxa3xx_nand_probe(struct platform_device *pdev)
+static int alloc_nand_resource(struct platform_device *pdev)
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
@@ -1072,8 +1065,8 @@ static int __devinit pxa3xx_nand_probe(struct
platform_device *pdev)
 	info = (struct pxa3xx_nand_info *)(&mtd[1]);
 	info->pdev = pdev;

-	this = &info->nand_chip;
 	mtd->priv = info;
+	info->mtd = mtd;
 	mtd->owner = THIS_MODULE;

 	info->clk = clk_get(&pdev->dev, NULL);
@@ -1151,27 +1144,9 @@ static int __devinit pxa3xx_nand_probe(struct
platform_device *pdev)
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
+	return 0;

 fail_free_irq:
 	free_irq(irq, info);
@@ -1196,8 +1171,8 @@ fail_free_mtd:

 static int pxa3xx_nand_remove(struct platform_device *pdev)
 {
-	struct mtd_info *mtd = platform_get_drvdata(pdev);
-	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
+	struct mtd_info *mtd = info->mtd;
 	struct resource *r;
 	int irq;

@@ -1226,11 +1201,48 @@ static int pxa3xx_nand_remove(struct
platform_device *pdev)
 	return 0;
 }

+static int __devinit pxa3xx_nand_probe(struct platform_device *pdev)
+{
+	struct pxa3xx_nand_platform_data *pdata;
+	struct pxa3xx_nand_info *info;
+	int ret;
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "no platform data defined\n");
+		return -ENODEV;
+	}
+
+	ret = alloc_nand_resource(pdev);
+	if (ret)
+		return ret;
+
+	info = platform_get_drvdata(pdev);
+	if (nand_scan(info->mtd, 1)) {
+		dev_err(&pdev->dev, "failed to scan nand\n");
+		pxa3xx_nand_remove(pdev);
+		return -ENODEV;
+	}
+
+	if (mtd_has_cmdlinepart()) {
+		static const char *probes[] = { "cmdlinepart", NULL };
+		struct mtd_partition *parts;
+		int nr_parts;
+
+		nr_parts = parse_mtd_partitions(info->mtd, probes, &parts, 0);
+
+		if (nr_parts)
+			return add_mtd_partitions(info->mtd, parts, nr_parts);
+	}
+
+	return add_mtd_partitions(info->mtd, pdata->parts, pdata->nr_parts);
+}
+
 #ifdef CONFIG_PM
 static int pxa3xx_nand_suspend(struct platform_device *pdev,
pm_message_t state)
 {
-	struct mtd_info *mtd = (struct mtd_info *)platform_get_drvdata(pdev);
-	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
+	struct mtd_info *mtd = info->mtd;

 	if (info->state != STATE_READY) {
 		dev_err(&pdev->dev, "driver busy, state = %d\n", info->state);
@@ -1242,8 +1254,8 @@ static int pxa3xx_nand_suspend(struct
platform_device *pdev, pm_message_t state)

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
