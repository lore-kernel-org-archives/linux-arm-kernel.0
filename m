From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:30 +0100
Subject: [PATCH 22/52] mtd: rawnand: lpc32xx_mlc: enhance the probe function
 error path
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-23-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare the migration of the lpc32xx_mlc driver to use nand_scan() by
cleaning the error path in the probe function.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/lpc32xx_mlc.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index e357948a7505..6e31faf2f07f 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -673,7 +673,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	host->io_base = devm_ioremap_resource(&pdev->dev, rc);
 	if (IS_ERR(host->io_base))
 		return PTR_ERR(host->io_base);
-	
+
 	host->io_base_phy = rc->start;
 
 	nand_chip = &host->nand_chip;
@@ -706,11 +706,11 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	if (IS_ERR(host->clk)) {
 		dev_err(&pdev->dev, "Clock initialization failure\n");
 		res = -ENOENT;
-		goto err_exit1;
+		goto free_gpio;
 	}
 	res = clk_prepare_enable(host->clk);
 	if (res)
-		goto err_put_clk;
+		goto put_clk;
 
 	nand_chip->cmd_ctrl = lpc32xx_nand_cmd_ctrl;
 	nand_chip->dev_ready = lpc32xx_nand_device_ready;
@@ -744,7 +744,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 		res = lpc32xx_dma_setup(host);
 		if (res) {
 			res = -EIO;
-			goto err_exit2;
+			goto unprepare_clk;
 		}
 	}
 
@@ -754,18 +754,18 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	 */
 	res = nand_scan_ident(mtd, 1, NULL);
 	if (res)
-		goto err_exit3;
+		goto release_dma_chan;
 
 	host->dma_buf = devm_kzalloc(&pdev->dev, mtd->writesize, GFP_KERNEL);
 	if (!host->dma_buf) {
 		res = -ENOMEM;
-		goto err_exit3;
+		goto release_dma_chan;
 	}
 
 	host->dummy_buf = devm_kzalloc(&pdev->dev, mtd->writesize, GFP_KERNEL);
 	if (!host->dummy_buf) {
 		res = -ENOMEM;
-		goto err_exit3;
+		goto release_dma_chan;
 	}
 
 	nand_chip->ecc.mode = NAND_ECC_HW;
@@ -783,14 +783,14 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	if (host->irq < 0) {
 		dev_err(&pdev->dev, "failed to get platform irq\n");
 		res = -EINVAL;
-		goto err_exit3;
+		goto release_dma_chan;
 	}
 
 	if (request_irq(host->irq, (irq_handler_t)&lpc3xxx_nand_irq,
 			IRQF_TRIGGER_HIGH, DRV_NAME, host)) {
 		dev_err(&pdev->dev, "Error requesting NAND IRQ\n");
 		res = -ENXIO;
-		goto err_exit3;
+		goto release_dma_chan;
 	}
 
 	/*
@@ -799,27 +799,29 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	 */
 	res = nand_scan_tail(mtd);
 	if (res)
-		goto err_exit4;
+		goto free_irq;
 
 	mtd->name = DRV_NAME;
 
 	res = mtd_device_register(mtd, host->ncfg->parts,
 				  host->ncfg->num_parts);
-	if (!res)
-		return res;
+	if (res)
+		goto release_nand;
 
+	return 0;
+
+release_nand:
 	nand_release(mtd);
-
-err_exit4:
+free_irq:
 	free_irq(host->irq, host);
-err_exit3:
+release_dma_chan:
 	if (use_dma)
 		dma_release_channel(host->dma_chan);
-err_exit2:
+unprepare_clk:
 	clk_disable_unprepare(host->clk);
-err_put_clk:
+put_clk:
 	clk_put(host->clk);
-err_exit1:
+free_gpio:
 	lpc32xx_wp_enable(host);
 	gpio_free(host->ncfg->wp_gpio);
 
-- 
2.14.1
