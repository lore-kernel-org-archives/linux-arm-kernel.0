From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:15 +0100
Subject: [PATCH 07/52] mtd: rawnand: cafe: convert driver to nand_scan()
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-8-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/cafe_nand.c | 133 ++++++++++++++++++++++-----------------
 1 file changed, 76 insertions(+), 57 deletions(-)

diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index 15cec32383a6..ff51b56dfcef 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -71,7 +71,9 @@ struct cafe_priv {
 	unsigned char *dmabuf;
 };
 
-static int usedma = 1;
+#define CAFE_DEFAULT_DMA	1
+
+static int usedma = CAFE_DEFAULT_DMA;
 module_param(usedma, int, 0644);
 
 static int skipbbt = 0;
@@ -597,6 +599,74 @@ static int cafe_mul(int x)
 	return gf4096_mul(x, 0xe01);
 }
 
+static int cafe_nand_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct cafe_priv *cafe = nand_get_controller_data(chip);
+	int err = 0;
+
+	cafe->dmabuf = dma_alloc_coherent(&cafe->pdev->dev, 2112,
+					  &cafe->dmaaddr, GFP_KERNEL);
+	if (!cafe->dmabuf)
+		return -ENOMEM;
+
+	/* Set up DMA address */
+	cafe_writel(cafe, lower_32_bits(cafe->dmaaddr), NAND_DMA_ADDR0);
+	cafe_writel(cafe, upper_32_bits(cafe->dmaaddr), NAND_DMA_ADDR1);
+
+	cafe_dev_dbg(&cafe->pdev->dev, "Set DMA address to %x (virt %p)\n",
+		     cafe_readl(cafe, NAND_DMA_ADDR0), cafe->dmabuf);
+
+	/* Restore the DMA flag */
+	usedma = CAFE_DEFAULT_DMA;
+
+	cafe->ctl2 = BIT(27); /* Reed-Solomon ECC */
+	if (mtd->writesize == 2048)
+		cafe->ctl2 |= BIT(29); /* 2KiB page size */
+
+	/* Set up ECC according to the type of chip we found */
+	mtd_set_ooblayout(mtd, &cafe_ooblayout_ops);
+	if (mtd->writesize == 2048) {
+		cafe->nand.bbt_td = &cafe_bbt_main_descr_2048;
+		cafe->nand.bbt_md = &cafe_bbt_mirror_descr_2048;
+	} else if (mtd->writesize == 512) {
+		cafe->nand.bbt_td = &cafe_bbt_main_descr_512;
+		cafe->nand.bbt_md = &cafe_bbt_mirror_descr_512;
+	} else {
+		dev_warn(&cafe->pdev->dev,
+			 "Unexpected NAND flash writesize %d. Aborting\n",
+			 mtd->writesize);
+		err = -ENOTSUPP;
+		goto out_free_dma;
+	}
+
+	cafe->nand.ecc.mode = NAND_ECC_HW_SYNDROME;
+	cafe->nand.ecc.size = mtd->writesize;
+	cafe->nand.ecc.bytes = 14;
+	cafe->nand.ecc.strength = 4;
+	cafe->nand.ecc.hwctl  = (void *)cafe_nand_bug;
+	cafe->nand.ecc.calculate = (void *)cafe_nand_bug;
+	cafe->nand.ecc.correct  = (void *)cafe_nand_bug;
+	cafe->nand.ecc.write_page = cafe_nand_write_page_lowlevel;
+	cafe->nand.ecc.write_oob = cafe_nand_write_oob;
+	cafe->nand.ecc.read_page = cafe_nand_read_page;
+	cafe->nand.ecc.read_oob = cafe_nand_read_oob;
+
+	return 0;
+
+ out_free_dma:
+	dma_free_coherent(&cafe->pdev->dev, 2112, cafe->dmabuf, cafe->dmaaddr);
+
+	return err;
+}
+
+static void cafe_nand_detach_chip(struct nand_chip *chip)
+{
+	struct cafe_priv *cafe = nand_get_controller_data(chip);
+
+	dma_free_coherent(&cafe->pdev->dev, 2112, cafe->dmabuf, cafe->dmaaddr);
+}
+
 static int cafe_nand_probe(struct pci_dev *pdev,
 				     const struct pci_device_id *ent)
 {
@@ -712,65 +782,16 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 		cafe_readl(cafe, GLOBAL_CTRL),
 		cafe_readl(cafe, GLOBAL_IRQ_MASK));
 
-	/* Do not use the DMA for the nand_scan_ident() */
-	old_dma = usedma;
+	/* Do not use the DMA during the NAND identification */
 	usedma = 0;
 
 	/* Scan to find existence of the device */
-	err = nand_scan_ident(mtd, 2, NULL);
+	cafe->nand.ecc.attach_chip = cafe_nand_attach_chip;
+	cafe->nand.ecc.detach_chip = cafe_nand_detach_chip;
+	err = nand_scan(mtd, 2);
 	if (err)
 		goto out_irq;
 
-	cafe->dmabuf = dma_alloc_coherent(&cafe->pdev->dev, 2112,
-					  &cafe->dmaaddr, GFP_KERNEL);
-	if (!cafe->dmabuf) {
-		err = -ENOMEM;
-		goto out_irq;
-	}
-
-	/* Set up DMA address */
-	cafe_writel(cafe, lower_32_bits(cafe->dmaaddr), NAND_DMA_ADDR0);
-	cafe_writel(cafe, upper_32_bits(cafe->dmaaddr), NAND_DMA_ADDR1);
-
-	cafe_dev_dbg(&cafe->pdev->dev, "Set DMA address to %x (virt %p)\n",
-		cafe_readl(cafe, NAND_DMA_ADDR0), cafe->dmabuf);
-
-	/* Restore the DMA flag */
-	usedma = old_dma;
-
-	cafe->ctl2 = 1<<27; /* Reed-Solomon ECC */
-	if (mtd->writesize == 2048)
-		cafe->ctl2 |= 1<<29; /* 2KiB page size */
-
-	/* Set up ECC according to the type of chip we found */
-	mtd_set_ooblayout(mtd, &cafe_ooblayout_ops);
-	if (mtd->writesize == 2048) {
-		cafe->nand.bbt_td = &cafe_bbt_main_descr_2048;
-		cafe->nand.bbt_md = &cafe_bbt_mirror_descr_2048;
-	} else if (mtd->writesize == 512) {
-		cafe->nand.bbt_td = &cafe_bbt_main_descr_512;
-		cafe->nand.bbt_md = &cafe_bbt_mirror_descr_512;
-	} else {
-		printk(KERN_WARNING "Unexpected NAND flash writesize %d. Aborting\n",
-		       mtd->writesize);
-		goto out_free_dma;
-	}
-	cafe->nand.ecc.mode = NAND_ECC_HW_SYNDROME;
-	cafe->nand.ecc.size = mtd->writesize;
-	cafe->nand.ecc.bytes = 14;
-	cafe->nand.ecc.strength = 4;
-	cafe->nand.ecc.hwctl  = (void *)cafe_nand_bug;
-	cafe->nand.ecc.calculate = (void *)cafe_nand_bug;
-	cafe->nand.ecc.correct  = (void *)cafe_nand_bug;
-	cafe->nand.ecc.write_page = cafe_nand_write_page_lowlevel;
-	cafe->nand.ecc.write_oob = cafe_nand_write_oob;
-	cafe->nand.ecc.read_page = cafe_nand_read_page;
-	cafe->nand.ecc.read_oob = cafe_nand_read_oob;
-
-	err = nand_scan_tail(mtd);
-	if (err)
-		goto out_free_dma;
-
 	pci_set_drvdata(pdev, mtd);
 
 	mtd->name = "cafe_nand";
@@ -778,12 +799,10 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 	if (err)
 		goto out_release_nand;
 
-	goto out;
+	return 0;
 
 out_release_nand:
 	nand_release(mtd);
-out_free_dma:
-	dma_free_coherent(&cafe->pdev->dev, 2112, cafe->dmabuf, cafe->dmaaddr);
 out_irq:
 	/* Disable NAND IRQ in global IRQ mask register */
 	cafe_writel(cafe, ~1 & cafe_readl(cafe, GLOBAL_IRQ_MASK), GLOBAL_IRQ_MASK);
-- 
2.14.1
