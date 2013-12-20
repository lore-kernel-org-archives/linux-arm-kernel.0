From: shijie8@gmail.com (Huang Shijie)
Date: Sat, 21 Dec 2013 00:02:29 +0800
Subject: [PATCH 3/4] mtd: nand: kill the the
 NAND_MAX_PAGESIZE/NAND_MAX_OOBSIZE for nand_buffers{}
In-Reply-To: <1387555350-989-1-git-send-email-shijie8@gmail.com>
References: <1387555350-989-1-git-send-email-shijie8@gmail.com>
Message-ID: <1387555350-989-4-git-send-email-shijie8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch converts the arrays to buffer pointers for nand_buffers{}.

The cafe_nand.c is the only NAND_OWN_BUFFERS user which allocates
a nand_buffers{} itself.

This patch disables the DMA for nand_scan_ident, and restore the DMA
status after we finish the nand_scan_ident. By this way, we can get the
mtd->writesize and mtd->oobsize, and then allocates the cafe->dmabuf
with them.

Since the cafe_nand.c uses the NAND_ECC_HW_SYNDROME ECC mode, we do not
allocate the buffers for @ecccalc and @ecccode.

Signed-off-by: Huang Shijie <shijie8@gmail.com>
---
 drivers/mtd/nand/cafe_nand.c | 49 ++++++++++++++++++++++++++++++++------------
 drivers/mtd/nand/nand_base.c | 19 +++++++++++++----
 include/linux/mtd/nand.h     | 12 +++++------
 3 files changed, 57 insertions(+), 23 deletions(-)

diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index c34985a..e9186e7 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -627,6 +627,8 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 	struct cafe_priv *cafe;
 	uint32_t ctrl;
 	int err = 0;
+	int old_dma;
+	struct nand_buffers *nbuf;
 
 	/* Very old versions shared the same PCI ident for all three
 	   functions on the chip. Verify the class too... */
@@ -657,13 +659,6 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 		err = -ENOMEM;
 		goto out_free_mtd;
 	}
-	cafe->dmabuf = dma_alloc_coherent(&cafe->pdev->dev, 2112 + sizeof(struct nand_buffers),
-					  &cafe->dmaaddr, GFP_KERNEL);
-	if (!cafe->dmabuf) {
-		err = -ENOMEM;
-		goto out_ior;
-	}
-	cafe->nand.buffers = (void *)cafe->dmabuf + 2112;
 
 	cafe->rs = init_rs_non_canonical(12, &cafe_mul, 0, 1, 8);
 	if (!cafe->rs) {
@@ -723,7 +718,7 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 			  "CAFE NAND", mtd);
 	if (err) {
 		dev_warn(&pdev->dev, "Could not register IRQ %d\n", pdev->irq);
-		goto out_free_dma;
+		goto out_ior;
 	}
 
 	/* Disable master reset, enable NAND clock */
@@ -753,12 +748,34 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 	cafe_dev_dbg(&cafe->pdev->dev, "Control %x, IRQ mask %x\n",
 		cafe_readl(cafe, GLOBAL_CTRL), cafe_readl(cafe, GLOBAL_IRQ_MASK));
 
+	/* Do not use the DMA for the nand_scan_ident() */
+	old_dma = usedma;
+	usedma = 0;
+
 	/* Scan to find existence of the device */
 	if (nand_scan_ident(mtd, 2, NULL)) {
 		err = -ENXIO;
 		goto out_irq;
 	}
 
+	cafe->dmabuf = dma_alloc_coherent(&cafe->pdev->dev,
+				2112 + sizeof(struct nand_buffers) +
+				mtd->writesize + mtd->oobsize,
+				&cafe->dmaaddr, GFP_KERNEL);
+	if (!cafe->dmabuf) {
+		err = -ENOMEM;
+		goto out_irq;
+	}
+	cafe->nand.buffers = nbuf = (void *)cafe->dmabuf + 2112;
+
+	/* this driver does not need the @ecccalc and @ecccode */
+	nbuf->ecccalc = NULL;
+	nbuf->ecccode = NULL;
+	nbuf->databuf = (uint8_t *)(nbuf + 1);
+
+	/* Restore the DMA flag */
+	usedma = old_dma;
+
 	cafe->ctl2 = 1<<27; /* Reed-Solomon ECC */
 	if (mtd->writesize == 2048)
 		cafe->ctl2 |= 1<<29; /* 2KiB page size */
@@ -775,7 +792,7 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 	} else {
 		printk(KERN_WARNING "Unexpected NAND flash writesize %d. Aborting\n",
 		       mtd->writesize);
-		goto out_irq;
+		goto out_free_dma;
 	}
 	cafe->nand.ecc.mode = NAND_ECC_HW_SYNDROME;
 	cafe->nand.ecc.size = mtd->writesize;
@@ -792,7 +809,7 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 
 	err = nand_scan_tail(mtd);
 	if (err)
-		goto out_irq;
+		goto out_free_dma;
 
 	pci_set_drvdata(pdev, mtd);
 
@@ -801,12 +818,15 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 
 	goto out;
 
+ out_free_dma:
+	dma_free_coherent(&cafe->pdev->dev,
+			2112 + sizeof(struct nand_buffers) +
+			mtd->writesize + mtd->oobsize,
+			cafe->dmabuf, cafe->dmaaddr);
  out_irq:
 	/* Disable NAND IRQ in global IRQ mask register */
 	cafe_writel(cafe, ~1 & cafe_readl(cafe, GLOBAL_IRQ_MASK), GLOBAL_IRQ_MASK);
 	free_irq(pdev->irq, mtd);
- out_free_dma:
-	dma_free_coherent(&cafe->pdev->dev, 2112, cafe->dmabuf, cafe->dmaaddr);
  out_ior:
 	pci_iounmap(pdev, cafe->mmio);
  out_free_mtd:
@@ -826,7 +846,10 @@ static void cafe_nand_remove(struct pci_dev *pdev)
 	nand_release(mtd);
 	free_rs(cafe->rs);
 	pci_iounmap(pdev, cafe->mmio);
-	dma_free_coherent(&cafe->pdev->dev, 2112, cafe->dmabuf, cafe->dmaaddr);
+	dma_free_coherent(&cafe->pdev->dev,
+			2112 + sizeof(struct nand_buffers) +
+			mtd->writesize + mtd->oobsize,
+			cafe->dmabuf, cafe->dmaaddr);
 	kfree(mtd);
 }
 
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 9b3bb3c..02d6707 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -3559,15 +3559,26 @@ int nand_scan_tail(struct mtd_info *mtd)
 	int i;
 	struct nand_chip *chip = mtd->priv;
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	struct nand_buffers *nbuf;
 
 	/* New bad blocks should be marked in OOB, flash-based BBT, or both */
 	BUG_ON((chip->bbt_options & NAND_BBT_NO_OOB_BBM) &&
 			!(chip->bbt_options & NAND_BBT_USE_FLASH));
 
-	if (!(chip->options & NAND_OWN_BUFFERS))
-		chip->buffers = kmalloc(sizeof(*chip->buffers), GFP_KERNEL);
-	if (!chip->buffers)
-		return -ENOMEM;
+	if (!(chip->options & NAND_OWN_BUFFERS)) {
+		nbuf = kzalloc(sizeof(*nbuf) + mtd->writesize
+				+ mtd->oobsize * 3, GFP_KERNEL);
+		if (!nbuf)
+			return -ENOMEM;
+		nbuf->ecccalc = (uint8_t *)(nbuf + 1);
+		nbuf->ecccode = nbuf->ecccalc + mtd->oobsize;
+		nbuf->databuf = nbuf->ecccode + mtd->oobsize;
+
+		chip->buffers = nbuf;
+	} else {
+		if (!chip->buffers)
+			return -ENOMEM;
+	}
 
 	/* Set the internal oob buffer location, just after the page data */
 	chip->oob_poi = chip->buffers->databuf + mtd->writesize;
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index f3ea8da..4bbcaba 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -411,17 +411,17 @@ struct nand_ecc_ctrl {
 
 /**
  * struct nand_buffers - buffer structure for read/write
- * @ecccalc:	buffer for calculated ECC
- * @ecccode:	buffer for ECC read from flash
- * @databuf:	buffer for data - dynamically sized
+ * @ecccalc:	buffer pointer for calculated ECC, size is oobsize.
+ * @ecccode:	buffer pointer for ECC read from flash, size is oobsize.
+ * @databuf:	buffer pointer for data, size is (page size + oobsize).
  *
  * Do not change the order of buffers. databuf and oobrbuf must be in
  * consecutive order.
  */
 struct nand_buffers {
-	uint8_t	ecccalc[NAND_MAX_OOBSIZE];
-	uint8_t	ecccode[NAND_MAX_OOBSIZE];
-	uint8_t databuf[NAND_MAX_PAGESIZE + NAND_MAX_OOBSIZE];
+	uint8_t	*ecccalc;
+	uint8_t	*ecccode;
+	uint8_t *databuf;
 };
 
 /**
-- 
1.8.3.1
