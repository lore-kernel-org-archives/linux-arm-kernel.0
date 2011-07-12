From: leiwen@marvell.com (Lei Wen)
Date: Tue, 12 Jul 2011 03:28:55 -0700
Subject: [PATCH V6 4/4] MTD: pxa3xx_nand: enhance suspend and resume routine
In-Reply-To: <1310096084-14646-1-git-send-email-leiwen@marvell.com>
References: <1310096084-14646-1-git-send-email-leiwen@marvell.com>
Message-ID: <1310466535-15287-5-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add protection on the suspend&resume path to prevent
some unexpected behavior, like interrupt occur at the very second
of resume back and it don't follow normal command path, which lead
to bug.

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 3756d54..35149fe 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1246,18 +1246,34 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
 static int pxa3xx_nand_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
+	struct pxa3xx_nand_platform_data *pdata;
+	struct mtd_info *mtd;
+	int cs;
 
+	pdata = pdev->dev.platform_data;
 	if (info->state) {
 		dev_err(&pdev->dev, "driver busy, state = %d\n", info->state);
 		return -EAGAIN;
 	}
 
+	for (cs = 0; cs < pdata->num_cs; cs ++) {
+		mtd = info->host[cs]->mtd;
+		mtd->suspend(mtd);
+	}
+
+	clk_disable(info->clk);
 	return 0;
 }
 
 static int pxa3xx_nand_resume(struct platform_device *pdev)
 {
 	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
+	struct pxa3xx_nand_platform_data *pdata;
+	int cs;
+
+	pdata = pdev->dev.platform_data;
+	/* We don't want to handle interrupt without calling mtd routine */
+	disable_int(info, NDCR_INT_MASK);
 
 	/*
 	 * Directly set the chip select to a invalid value,
@@ -1267,6 +1283,18 @@ static int pxa3xx_nand_resume(struct platform_device *pdev)
 	info->cs = 0xff;
 	clk_enable(info->clk);
 
+	/*
+	 * As the spec, the NDSR would be updated to 0x1800 when
+	 * do the nand_clk disable/enable.
+	 * To prevent it damage state machine of the driver, clear
+	 * all status before resume
+	 */
+	nand_writel(nand, NDSR, NDSR_MASK);
+	for (cs = 0; cs < pdata->num_cs; cs ++) {
+		mtd = info->host[cs]->mtd;
+		mtd->resume(mtd);
+	}
+
 	return 0;
 }
 #else
-- 
1.7.0.4
