From: shijie8@gmail.com (Huang Shijie)
Date: Sat, 21 Dec 2013 00:02:28 +0800
Subject: [PATCH 2/4] mtd: denali: kill the NAND_MAX_PAGESIZE/NAND_MAX_OOBSIZE
In-Reply-To: <1387555350-989-1-git-send-email-shijie8@gmail.com>
References: <1387555350-989-1-git-send-email-shijie8@gmail.com>
Message-ID: <1387555350-989-3-git-send-email-shijie8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch kills the NAND_MAX_PAGESIZE/NAND_MAX_OOBSIZE by the following
way:
 1.) change the @buf field of nand_buf{} from an array to a pointer.
     also remove the DENALI_BUF_SIZE macro.

 2.) Before we call the nand_scan_ident, we allocate a temporary buffer
     whose size is PAGE_SIZE.

 3.) After we finish the nand_scan_ident, we have already getten the
     page size and oob size. We will allocate the right buffer size
     again.

Signed-off-by: Huang Shijie <shijie8@gmail.com>
---
 drivers/mtd/nand/denali.c | 51 ++++++++++++++++++++++++++++-------------------
 drivers/mtd/nand/denali.h |  4 +---
 2 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
index 3a3a47f..c07cd57 100644
--- a/drivers/mtd/nand/denali.c
+++ b/drivers/mtd/nand/denali.c
@@ -125,7 +125,6 @@ static void reset_buf(struct denali_nand_info *denali)
 
 static void write_byte_to_buf(struct denali_nand_info *denali, uint8_t byte)
 {
-	BUG_ON(denali->buf.tail >= sizeof(denali->buf.buf));
 	denali->buf.buf[denali->buf.tail++] = byte;
 }
 
@@ -1429,20 +1428,12 @@ int denali_init(struct denali_nand_info *denali)
 		}
 	}
 
-	/* Is 32-bit DMA supported? */
-	ret = dma_set_mask(denali->dev, DMA_BIT_MASK(32));
-	if (ret) {
-		pr_err("Spectra: no usable DMA configuration\n");
-		return ret;
-	}
-	denali->buf.dma_buf = dma_map_single(denali->dev, denali->buf.buf,
-					     DENALI_BUF_SIZE,
-					     DMA_BIDIRECTIONAL);
+	/* allocate a temporary buffer for nand_scan_ident() */
+	denali->buf.buf = devm_kzalloc(denali->dev, PAGE_SIZE,
+					GFP_DMA | GFP_KERNEL);
+	if (!denali->buf.buf)
+		return -ENOMEM;
 
-	if (dma_mapping_error(denali->dev, denali->buf.dma_buf)) {
-		dev_err(denali->dev, "Spectra: failed to map DMA buffer\n");
-		return -EIO;
-	}
 	denali->mtd.dev.parent = denali->dev;
 	denali_hw_init(denali);
 	denali_drv_init(denali);
@@ -1475,12 +1466,29 @@ int denali_init(struct denali_nand_info *denali)
 		goto failed_req_irq;
 	}
 
-	/* MTD supported page sizes vary by kernel. We validate our
-	 * kernel supports the device here.
-	 */
-	if (denali->mtd.writesize > NAND_MAX_PAGESIZE + NAND_MAX_OOBSIZE) {
-		ret = -ENODEV;
-		pr_err("Spectra: device size not supported by this version of MTD.");
+	/* allocate the right size buffer now */
+	devm_kfree(denali->dev, denali->buf.buf);
+	denali->buf.buf = devm_kzalloc(denali->dev,
+			     denali->mtd.writesize + denali->mtd.oobsize,
+			     GFP_KERNEL);
+	if (!denali->buf.buf) {
+		ret = -ENOMEM;
+		goto failed_req_irq;
+	}
+
+	/* Is 32-bit DMA supported? */
+	ret = dma_set_mask(denali->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		pr_err("Spectra: no usable DMA configuration\n");
+		goto failed_req_irq;
+	}
+
+	denali->buf.dma_buf = dma_map_single(denali->dev, denali->buf.buf,
+			     denali->mtd.writesize + denali->mtd.oobsize,
+			     DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(denali->dev, denali->buf.dma_buf)) {
+		dev_err(denali->dev, "Spectra: failed to map DMA buffer\n");
+		ret = -EIO;
 		goto failed_req_irq;
 	}
 
@@ -1602,7 +1610,8 @@ EXPORT_SYMBOL(denali_init);
 void denali_remove(struct denali_nand_info *denali)
 {
 	denali_irq_cleanup(denali->irq, denali);
-	dma_unmap_single(denali->dev, denali->buf.dma_buf, DENALI_BUF_SIZE,
+	dma_unmap_single(denali->dev, denali->buf.dma_buf,
+			denali->mtd.writesize + denali->mtd.oobsize,
 			DMA_BIDIRECTIONAL);
 }
 EXPORT_SYMBOL(denali_remove);
diff --git a/drivers/mtd/nand/denali.h b/drivers/mtd/nand/denali.h
index cec5712..9668174 100644
--- a/drivers/mtd/nand/denali.h
+++ b/drivers/mtd/nand/denali.h
@@ -455,12 +455,10 @@
 
 #define ECC_SECTOR_SIZE     512
 
-#define DENALI_BUF_SIZE		(NAND_MAX_PAGESIZE + NAND_MAX_OOBSIZE)
-
 struct nand_buf {
 	int head;
 	int tail;
-	uint8_t buf[DENALI_BUF_SIZE];
+	uint8_t *buf;
 	dma_addr_t dma_buf;
 };
 
-- 
1.8.3.1
