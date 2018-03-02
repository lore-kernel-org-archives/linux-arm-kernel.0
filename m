From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:31 +0100
Subject: [PATCH 23/52] mtd: rawnand: lpc32xx_mlc: convert driver to nand_scan()
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-24-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/lpc32xx_mlc.c | 105 +++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 50 deletions(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index 6e31faf2f07f..51ef26a91df8 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -184,6 +184,7 @@ static struct nand_bbt_descr lpc32xx_nand_bbt_mirror = {
 };
 
 struct lpc32xx_nand_host {
+	struct platform_device	*pdev;
 	struct nand_chip	nand_chip;
 	struct lpc32xx_mlc_platform_data *pdata;
 	struct clk		*clk;
@@ -653,6 +654,53 @@ static struct lpc32xx_nand_cfg_mlc *lpc32xx_parse_dt(struct device *dev)
 	return ncfg;
 }
 
+static int lpc32xx_nand_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
+	struct device *dev = &host->pdev->dev;
+
+	host->dma_buf = devm_kzalloc(dev, mtd->writesize, GFP_KERNEL);
+	if (!host->dma_buf)
+		return -ENOMEM;
+
+	host->dummy_buf = devm_kzalloc(dev, mtd->writesize, GFP_KERNEL);
+	if (!host->dummy_buf)
+		return -ENOMEM;
+
+	chip->ecc.mode = NAND_ECC_HW;
+	chip->ecc.size = 512;
+	mtd_set_ooblayout(mtd, &lpc32xx_ooblayout_ops);
+	host->mlcsubpages = mtd->writesize / 512;
+
+	/* initially clear interrupt status */
+	readb(MLC_IRQ_SR(host->io_base));
+
+	init_completion(&host->comp_nand);
+	init_completion(&host->comp_controller);
+
+	host->irq = platform_get_irq(host->pdev, 0);
+	if (host->irq < 0) {
+		dev_err(dev, "failed to get platform irq\n");
+		return -EINVAL;
+	}
+
+	if (request_irq(host->irq, (irq_handler_t)&lpc3xxx_nand_irq,
+			IRQF_TRIGGER_HIGH, DRV_NAME, host)) {
+		dev_err(dev, "Error requesting NAND IRQ\n");
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static void lpc32xx_nand_detach_chip(struct nand_chip *chip)
+{
+	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
+
+	free_irq(host->irq, host);
+}
+
 /*
  * Probe for NAND controller
  */
@@ -669,6 +717,8 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	if (!host)
 		return -ENOMEM;
 
+	host->pdev = pdev;
+
 	rc = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->io_base = devm_ioremap_resource(&pdev->dev, rc);
 	if (IS_ERR(host->io_base))
@@ -749,58 +799,15 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	}
 
 	/*
-	 * Scan to find existance of the device and
-	 * Get the type of NAND device SMALL block or LARGE block
+	 * Scan to find existence of the device and get the type of NAND device:
+	 * SMALL block or LARGE block.
 	 */
-	res = nand_scan_ident(mtd, 1, NULL);
+	nand_chip->ecc.attach_chip = lpc32xx_nand_attach_chip;
+	nand_chip->ecc.detach_chip = lpc32xx_nand_detach_chip;
+	res = nand_scan(mtd, 1);
 	if (res)
 		goto release_dma_chan;
 
-	host->dma_buf = devm_kzalloc(&pdev->dev, mtd->writesize, GFP_KERNEL);
-	if (!host->dma_buf) {
-		res = -ENOMEM;
-		goto release_dma_chan;
-	}
-
-	host->dummy_buf = devm_kzalloc(&pdev->dev, mtd->writesize, GFP_KERNEL);
-	if (!host->dummy_buf) {
-		res = -ENOMEM;
-		goto release_dma_chan;
-	}
-
-	nand_chip->ecc.mode = NAND_ECC_HW;
-	nand_chip->ecc.size = 512;
-	mtd_set_ooblayout(mtd, &lpc32xx_ooblayout_ops);
-	host->mlcsubpages = mtd->writesize / 512;
-
-	/* initially clear interrupt status */
-	readb(MLC_IRQ_SR(host->io_base));
-
-	init_completion(&host->comp_nand);
-	init_completion(&host->comp_controller);
-
-	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq < 0) {
-		dev_err(&pdev->dev, "failed to get platform irq\n");
-		res = -EINVAL;
-		goto release_dma_chan;
-	}
-
-	if (request_irq(host->irq, (irq_handler_t)&lpc3xxx_nand_irq,
-			IRQF_TRIGGER_HIGH, DRV_NAME, host)) {
-		dev_err(&pdev->dev, "Error requesting NAND IRQ\n");
-		res = -ENXIO;
-		goto release_dma_chan;
-	}
-
-	/*
-	 * Fills out all the uninitialized function pointers with the defaults
-	 * And scans for a bad block table if appropriate.
-	 */
-	res = nand_scan_tail(mtd);
-	if (res)
-		goto free_irq;
-
 	mtd->name = DRV_NAME;
 
 	res = mtd_device_register(mtd, host->ncfg->parts,
@@ -812,8 +819,6 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 
 release_nand:
 	nand_release(mtd);
-free_irq:
-	free_irq(host->irq, host);
 release_dma_chan:
 	if (use_dma)
 		dma_release_channel(host->dma_chan);
-- 
2.14.1
