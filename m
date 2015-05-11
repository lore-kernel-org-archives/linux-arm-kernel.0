From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 11 May 2015 16:58:50 +0200
Subject: [PATCH v5 01/12] mtd: pxa3xx_nand: add a non mandatory ECC clock
In-Reply-To: <1431356341-31640-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1431356341-31640-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1431356341-31640-2-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some controllers (as the coming Berlin nand controller) need to enable
an ECC clock. Add support for this clock in the pxa3xx nand driver, and
leave it as non mandatory.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index a4615fcc3d00..f14c13c4dbfe 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -180,7 +180,7 @@ struct pxa3xx_nand_info {
 	struct nand_hw_control	controller;
 	struct platform_device	 *pdev;
 
-	struct clk		*clk;
+	struct clk		*clk, *ecc_clk;
 	void __iomem		*mmio_base;
 	unsigned long		mmio_phys;
 	struct completion	cmd_complete, dev_ready;
@@ -1656,15 +1656,26 @@ static int alloc_nand_resource(struct platform_device *pdev)
 
 	spin_lock_init(&chip->controller->lock);
 	init_waitqueue_head(&chip->controller->wq);
-	info->clk = devm_clk_get(&pdev->dev, NULL);
+	info->clk = devm_clk_get(&pdev->dev, "nfc");
 	if (IS_ERR(info->clk)) {
-		dev_err(&pdev->dev, "failed to get nand clock\n");
-		return PTR_ERR(info->clk);
+		info->clk = devm_clk_get(&pdev->dev, NULL);
+
+		if (IS_ERR(info->clk)) {
+			dev_err(&pdev->dev, "failed to get nand clock\n");
+			return PTR_ERR(info->clk);
+		}
 	}
 	ret = clk_prepare_enable(info->clk);
 	if (ret < 0)
 		return ret;
 
+	info->ecc_clk = devm_clk_get(&pdev->dev, "ecc");
+	if (!IS_ERR(info->ecc_clk)) {
+		ret = clk_prepare_enable(info->ecc_clk);
+		if (ret < 0)
+			goto fail_disable_clk;
+	}
+
 	if (use_dma) {
 		/*
 		 * This is a dirty hack to make this driver work from
@@ -1681,7 +1692,7 @@ static int alloc_nand_resource(struct platform_device *pdev)
 				dev_err(&pdev->dev,
 					"no resource defined for data DMA\n");
 				ret = -ENXIO;
-				goto fail_disable_clk;
+				goto fail_disable_ecc_clk;
 			}
 			info->drcmr_dat = r->start;
 
@@ -1690,7 +1701,7 @@ static int alloc_nand_resource(struct platform_device *pdev)
 				dev_err(&pdev->dev,
 					"no resource defined for cmd DMA\n");
 				ret = -ENXIO;
-				goto fail_disable_clk;
+				goto fail_disable_ecc_clk;
 			}
 			info->drcmr_cmd = r->start;
 		}
@@ -1700,14 +1711,14 @@ static int alloc_nand_resource(struct platform_device *pdev)
 	if (irq < 0) {
 		dev_err(&pdev->dev, "no IRQ resource defined\n");
 		ret = -ENXIO;
-		goto fail_disable_clk;
+		goto fail_disable_ecc_clk;
 	}
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	info->mmio_base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(info->mmio_base)) {
 		ret = PTR_ERR(info->mmio_base);
-		goto fail_disable_clk;
+		goto fail_disable_ecc_clk;
 	}
 	info->mmio_phys = r->start;
 
@@ -1716,7 +1727,7 @@ static int alloc_nand_resource(struct platform_device *pdev)
 	info->data_buff = kmalloc(info->buf_size, GFP_KERNEL);
 	if (info->data_buff == NULL) {
 		ret = -ENOMEM;
-		goto fail_disable_clk;
+		goto fail_disable_ecc_clk;
 	}
 
 	/* initialize all interrupts to be disabled */
@@ -1737,6 +1748,8 @@ static int alloc_nand_resource(struct platform_device *pdev)
 fail_free_buf:
 	free_irq(irq, info);
 	kfree(info->data_buff);
+fail_disable_ecc_clk:
+	clk_disable_unprepare(info->ecc_clk);
 fail_disable_clk:
 	clk_disable_unprepare(info->clk);
 	return ret;
@@ -1759,6 +1772,7 @@ static int pxa3xx_nand_remove(struct platform_device *pdev)
 	pxa3xx_nand_free_buff(info);
 
 	clk_disable_unprepare(info->clk);
+	clk_disable_unprepare(info->ecc_clk);
 
 	for (cs = 0; cs < pdata->num_cs; cs++)
 		nand_release(info->host[cs]->mtd);
-- 
2.4.0
