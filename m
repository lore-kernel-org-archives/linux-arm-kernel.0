From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:28 +0100
Subject: [PATCH 20/52] mtd: rawnand: hisi504: convert driver to nand_scan()
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-21-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/hisi504_nand.c | 74 ++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/drivers/mtd/nand/raw/hisi504_nand.c b/drivers/mtd/nand/raw/hisi504_nand.c
index 3c64a6281b54..94d02539d150 100644
--- a/drivers/mtd/nand/raw/hisi504_nand.c
+++ b/drivers/mtd/nand/raw/hisi504_nand.c
@@ -709,9 +709,46 @@ static int hisi_nfc_ecc_probe(struct hinfc_host *host)
 	return 0;
 }
 
+static int hisi_nfc_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct hinfc_host *host = nand_get_controller_data(chip);
+	int flag;
+
+	host->buffer = dmam_alloc_coherent(host->dev,
+					   mtd->writesize + mtd->oobsize,
+					   &host->dma_buffer, GFP_KERNEL);
+	if (!host->buffer)
+		return -ENOMEM;
+
+	host->dma_oob = host->dma_buffer + mtd->writesize;
+	memset(host->buffer, 0xff, mtd->writesize + mtd->oobsize);
+
+	flag = hinfc_read(host, HINFC504_CON);
+	flag &= ~(HINFC504_CON_PAGESIZE_MASK << HINFC504_CON_PAGEISZE_SHIFT);
+	switch (mtd->writesize) {
+	case 2048:
+		flag |= (0x001 << HINFC504_CON_PAGEISZE_SHIFT);
+		break;
+	/*
+	 * TODO: add more pagesize support,
+	 * default pagesize has been set in hisi_nfc_host_init
+	 */
+	default:
+		dev_err(host->dev, "NON-2KB page size nand flash\n");
+		return -EINVAL;
+	}
+	hinfc_write(host, flag, HINFC504_CON);
+
+	if (chip->ecc.mode == NAND_ECC_HW)
+		hisi_nfc_ecc_probe(host);
+
+	return 0;
+}
+
 static int hisi_nfc_probe(struct platform_device *pdev)
 {
-	int ret = 0, irq, flag, max_chips = HINFC504_MAX_CHIP;
+	int ret = 0, irq, max_chips = HINFC504_MAX_CHIP;
 	struct device *dev = &pdev->dev;
 	struct hinfc_host *host;
 	struct nand_chip  *chip;
@@ -769,42 +806,11 @@ static int hisi_nfc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = nand_scan_ident(mtd, max_chips, NULL);
+	chip->ecc.attach_chip = hisi_nfc_attach_chip;
+	ret = nand_scan(mtd, max_chips);
 	if (ret)
 		return ret;
 
-	host->buffer = dmam_alloc_coherent(dev, mtd->writesize + mtd->oobsize,
-		&host->dma_buffer, GFP_KERNEL);
-	if (!host->buffer)
-		return -ENOMEM;
-
-	host->dma_oob = host->dma_buffer + mtd->writesize;
-	memset(host->buffer, 0xff, mtd->writesize + mtd->oobsize);
-
-	flag = hinfc_read(host, HINFC504_CON);
-	flag &= ~(HINFC504_CON_PAGESIZE_MASK << HINFC504_CON_PAGEISZE_SHIFT);
-	switch (mtd->writesize) {
-	case 2048:
-		flag |= (0x001 << HINFC504_CON_PAGEISZE_SHIFT); break;
-	/*
-	 * TODO: add more pagesize support,
-	 * default pagesize has been set in hisi_nfc_host_init
-	 */
-	default:
-		dev_err(dev, "NON-2KB page size nand flash\n");
-		return -EINVAL;
-	}
-	hinfc_write(host, flag, HINFC504_CON);
-
-	if (chip->ecc.mode == NAND_ECC_HW)
-		hisi_nfc_ecc_probe(host);
-
-	ret = nand_scan_tail(mtd);
-	if (ret) {
-		dev_err(dev, "nand_scan_tail failed: %d\n", ret);
-		return ret;
-	}
-
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret) {
 		dev_err(dev, "Err MTD partition=%d\n", ret);
-- 
2.14.1
