From: leiwen@marvell.com (Lei Wen)
Date: Tue, 12 Jul 2011 07:35:33 -0700
Subject: [PATCH V7 1/4] MTD: pxa3xx_nand: enhance suspend and resume routine
In-Reply-To: <1310466535-15287-1-git-send-email-leiwen@marvell.com>
References: <1310466535-15287-1-git-send-email-leiwen@marvell.com>
Message-ID: <1310481336-13230-2-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add protection on the suspend&resume path to prevent
some unexpected behavior, like interrupt occur at the very second
of resume back and it don't follow normal command path, which lead
to bug.

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index b7db1b2..1efecf7 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1158,23 +1158,38 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
 static int pxa3xx_nand_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
+	struct mtd_info *mtd;
 
 	if (info->state) {
 		dev_err(&pdev->dev, "driver busy, state = %d\n", info->state);
 		return -EAGAIN;
 	}
 
+	mtd = info->mtd;
+	mtd->suspend(mtd);
 	return 0;
 }
 
 static int pxa3xx_nand_resume(struct platform_device *pdev)
 {
 	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
+	struct mtd_info *mtd;
+
+	/* We don't want to handle interrupt without calling mtd routine */
+	disable_int(info, NDCR_INT_MASK);
 
 	nand_writel(info, NDTR0CS0, info->ndtr0cs0);
 	nand_writel(info, NDTR1CS0, info->ndtr1cs0);
-	clk_enable(info->clk);
 
+	/*
+	 * As the spec, the NDSR would be updated to 0x1800 when
+	 * do the nand_clk disable/enable.
+	 * To prevent it damage state machine of the driver, clear
+	 * all status before resume
+	 */
+	nand_writel(info, NDSR, NDSR_MASK);
+	mtd = info->mtd;
+	mtd->resume(mtd);
 	return 0;
 }
 #else
-- 
1.7.0.4
