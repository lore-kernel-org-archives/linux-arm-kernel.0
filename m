From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri,  1 Apr 2011 16:40:44 +0200
Subject: [PATCH 1/3 v2] MTD: atmel_nand: modify test case for using DMA
	operations
In-Reply-To: <1301662188.2789.57.camel@localhost>
References: <1301662188.2789.57.camel@localhost>
Message-ID: <1301668844-4500-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have better performances not using DMA for oob operations.
Modify size test so that it is using DMA for size greater than oobsize.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Artem,

Here is the v2 version with embedded comment as you suggested.

Best regards,

 drivers/mtd/nand/atmel_nand.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 6fae04b..5872f2a 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -280,7 +280,8 @@ static void atmel_read_buf(struct mtd_info *mtd, u8 *buf, int len)
 	struct nand_chip *chip = mtd->priv;
 	struct atmel_nand_host *host = chip->priv;
 
-	if (use_dma && len >= mtd->oobsize)
+	if (use_dma && len > mtd->oobsize)
+		/* only use DMA for bigger than oob size: better performances */
 		if (atmel_nand_dma_op(mtd, buf, len, 1) == 0)
 			return;
 
@@ -295,7 +296,8 @@ static void atmel_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
 	struct nand_chip *chip = mtd->priv;
 	struct atmel_nand_host *host = chip->priv;
 
-	if (use_dma && len >= mtd->oobsize)
+	if (use_dma && len > mtd->oobsize)
+		/* only use DMA for bigger than oob size: better performances */
 		if (atmel_nand_dma_op(mtd, (void *)buf, len, 0) == 0)
 			return;
 
-- 
1.7.3
