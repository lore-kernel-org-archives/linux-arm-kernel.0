From: leiwen@marvell.com (Lei Wen)
Date: Tue, 22 Jun 2010 23:17:36 +0800
Subject: [PATCH 28/29] pxa3xx_nand: fix power management support
Message-ID: <mailman.149.1280297145.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |   48 +++++++++++++++++++++++++++++++--------
 1 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 65cf54c..bc2f56d 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1659,26 +1659,54 @@ static int __devinit pxa3xx_nand_probe(struct
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


>From bogus@does.not.exist.com  Sun Jun  6 12:36:48 2010
From: bogus@does.not.exist.com ()
Date: Sun, 06 Jun 2010 16:36:48 -0000
Subject: No subject
Message-ID: <mailman.151.1280365110.27306.linux-arm-kernel@lists.infradead.org>

AMD/Intel to allow the kvm code to work with a common IOMMU interface. To
that end, it isn't really a generic IOMMU interface. We have chosen to use
our own interface because it provides us with a lightweight way of
managing mappings for more esoteric MSM-specific use cases.

These map functions also take into account the way in which we map buffers
that we get from our own physical pool, because the current API was not
intended to deal with prioritized allocation of things like on/off-chip
memory. We are currently evaluating how to use the DMA API with our own
specialized allocator, which has been undergoing some discussion on the
other lists. We would like to use this allocator to maximize TLB
performance, as well as to prioritize the allocation from several
different memory pools.

Steve



>From bogus@does.not.exist.com  Sun Jun  6 12:36:48 2010
From: bogus@does.not.exist.com ()
Date: Sun, 06 Jun 2010 16:36:48 -0000
Subject: No subject
Message-ID: <mailman.153.1280740994.27306.linux-arm-kernel@lists.infradead.org>

additional IRQs to that.  That's quite small compared to some platforms
which have in the order of 512 or even 1024 IRQs.

> And current kernel don't support the sparse irq feature. then it's
> reasonable to merge it first and revise it later.

sparse irq support has been queued for almost a month for the merge
window which has just this morning opened.  This doesn't help you if
you instantiate all your 360 interrupts though - just because you
don't _use_ an interrupt which has been declared as existing doesn't
reduce the size of the arrays.

> Another why FIMC support is missing? we modified it as his requested
> and send it properly.
> [PATCH v3 3/8] ARM: Samsung: Add platform definitions and helpers for
> http://marc.info/?l=linux-arm-kernel&m=127990218813931&w=2

This looks like it's been missed.  People get busy and miss things on
the mailing list, there's nothing special about that.

> [PATCH v3 1/8] ARM: Samsung: Add register definitions for Samsung S5P
> http://marc.info/?l=linux-arm-kernel&m=127990218613922&w=2

Kukjin Kim replied to this one with a point requiring an answer, but
nothing came back.

   "Looks ok...however, I'm still thinking whether really need all these
    definitions."

Seems to be a perfectly reasonable point to raise, and if there's no
reply to justify them...
