From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:27 +0100
Subject: [PATCH 19/52] mtd: rawnand: hisi504: enhance the probe function error
 path
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-20-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare the migration of the hisi504_nand driver to use nand_scan() by
cleaning the error path in the probe function.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/hisi504_nand.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/mtd/nand/raw/hisi504_nand.c b/drivers/mtd/nand/raw/hisi504_nand.c
index 27558a67fa41..3c64a6281b54 100644
--- a/drivers/mtd/nand/raw/hisi504_nand.c
+++ b/drivers/mtd/nand/raw/hisi504_nand.c
@@ -731,23 +731,19 @@ static int hisi_nfc_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(dev, "no IRQ resource defined\n");
-		ret = -ENXIO;
-		goto err_res;
+		return -ENXIO;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->iobase = devm_ioremap_resource(dev, res);
-	if (IS_ERR(host->iobase)) {
-		ret = PTR_ERR(host->iobase);
-		goto err_res;
-	}
+	if (IS_ERR(host->iobase))
+		return PTR_ERR(host->iobase);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	host->mmio = devm_ioremap_resource(dev, res);
 	if (IS_ERR(host->mmio)) {
-		ret = PTR_ERR(host->mmio);
 		dev_err(dev, "devm_ioremap_resource[1] fail\n");
-		goto err_res;
+		return PTR_ERR(host->mmio);
 	}
 
 	mtd->name		= "hisi_nand";
@@ -770,19 +766,17 @@ static int hisi_nfc_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, irq, hinfc_irq_handle, 0x0, "nandc", host);
 	if (ret) {
 		dev_err(dev, "failed to request IRQ\n");
-		goto err_res;
+		return ret;
 	}
 
 	ret = nand_scan_ident(mtd, max_chips, NULL);
 	if (ret)
-		goto err_res;
+		return ret;
 
 	host->buffer = dmam_alloc_coherent(dev, mtd->writesize + mtd->oobsize,
 		&host->dma_buffer, GFP_KERNEL);
-	if (!host->buffer) {
-		ret = -ENOMEM;
-		goto err_res;
-	}
+	if (!host->buffer)
+		return -ENOMEM;
 
 	host->dma_oob = host->dma_buffer + mtd->writesize;
 	memset(host->buffer, 0xff, mtd->writesize + mtd->oobsize);
@@ -798,8 +792,7 @@ static int hisi_nfc_probe(struct platform_device *pdev)
 	 */
 	default:
 		dev_err(dev, "NON-2KB page size nand flash\n");
-		ret = -EINVAL;
-		goto err_res;
+		return -EINVAL;
 	}
 	hinfc_write(host, flag, HINFC504_CON);
 
@@ -809,21 +802,17 @@ static int hisi_nfc_probe(struct platform_device *pdev)
 	ret = nand_scan_tail(mtd);
 	if (ret) {
 		dev_err(dev, "nand_scan_tail failed: %d\n", ret);
-		goto err_res;
+		return ret;
 	}
 
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret) {
 		dev_err(dev, "Err MTD partition=%d\n", ret);
-		goto err_mtd;
+		nand_release(mtd);
+		return ret;
 	}
 
 	return 0;
-
-err_mtd:
-	nand_release(mtd);
-err_res:
-	return ret;
 }
 
 static int hisi_nfc_remove(struct platform_device *pdev)
-- 
2.14.1
