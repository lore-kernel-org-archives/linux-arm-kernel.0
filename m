From: leiwen@marvell.com (Lei Wen)
Date: Thu, 17 Jun 2010 09:43:24 +0800
Subject: [PATCH 25/25] pxa3xx_nand: fix power management support
Message-ID: <mailman.50.1276839621.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |   48 +++++++++++++++++++++++++++++++--------
 1 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 96b46e1..e4de69c 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1695,26 +1695,54 @@ static int __devinit pxa3xx_nand_probe(struct
platform_device *pdev)
 #ifdef CONFIG_PM
 static int pxa3xx_nand_suspend(struct platform_device *pdev,
pm_message_t state)
 {
-	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
-	struct mtd_info *mtd = info->mtd;
+	struct pxa3xx_nand *nand= platform_get_drvdata(pdev);
+	struct pxa3xx_nand_info *info;
+	struct mtd_info *mtd;
+	int ret = 0;
+	uint8_t cs;

-	if (info->state & STATE_CMD_PREPARED) {
-		dev_err(&pdev->dev, "driver busy, state = %d\n", info->state);
+	if (nand->state & STATE_CMD_PREPARED) {
+		dev_err(&pdev->dev, "driver busy, state = %d\n", nand->state);
 		return -EAGAIN;
 	}

-	return 0;
+	for (cs = 0; cs < NUM_CHIP_SELECT; cs ++) {
+		info = nand->info[cs];
+		if (!info)
+			continue;
+		mtd = get_mtd_by_info(info);
+		ret = mtd->suspend(mtd);
+	}
+
+	return ret;
 }

 static int pxa3xx_nand_resume(struct platform_device *pdev)
 {
-	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
-	struct mtd_info *mtd = info->mtd;
+	struct pxa3xx_nand *nand= platform_get_drvdata(pdev);
+	struct pxa3xx_nand_info *info;
+	struct mtd_info *mtd;
+	uint8_t cs;

-	nand_writel(info, NDTR0CS0, info->ndtr0cs0);
-	nand_writel(info, NDTR1CS0, info->ndtr1cs0);
-	clk_enable(info->clk);
+	for (cs = 0; cs < NUM_CHIP_SELECT; cs ++) {
+		info = nand->info[cs];
+		if (!info)
+			continue;
+		nand_writel(nand, NDTR0CS0, info->ndtr0cs0);
+		nand_writel(nand, NDTR1CS0, info->ndtr1cs0);
+		nand->chip_select = cs;
+		/* Sometimes nand chip would raise a ready interrupt
+		 * when resume, reset the by start and stop to prevent
+		 * it damage driver's state machine */
+		pxa3xx_nand_start(nand);
+		pxa3xx_nand_stop(nand);
+		mtd = get_mtd_by_info(info);
+		mtd->resume(mtd);
+	}

+	/* set the controller cs to a invalid num to let driver
+	 * reconfigure the timing when it call the cmdfunc */
+	nand->chip_select = 0xff;
 	return 0;
 }
 #else
-- 
1.7.0.4
