From: hong.xu@atmel.com (Hong Xu)
Date: Wed, 30 Mar 2011 16:26:39 +0800
Subject: [PATCH 1/3] MTD: atmel_nand: modify test case for using DMA operations
Message-ID: <1301473601-29570-1-git-send-email-hong.xu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>

We have better performances not using DMA for oob operations.
Modify size test so that it is using DMA for size greater than oobsize.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 6fae04b..9acecdc 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -280,7 +280,7 @@ static void atmel_read_buf(struct mtd_info *mtd, u8 *buf, int len)
 	struct nand_chip *chip = mtd->priv;
 	struct atmel_nand_host *host = chip->priv;
 
-	if (use_dma && len >= mtd->oobsize)
+	if (use_dma && len > mtd->oobsize)
 		if (atmel_nand_dma_op(mtd, buf, len, 1) == 0)
 			return;
 
@@ -295,7 +295,7 @@ static void atmel_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
 	struct nand_chip *chip = mtd->priv;
 	struct atmel_nand_host *host = chip->priv;
 
-	if (use_dma && len >= mtd->oobsize)
+	if (use_dma && len > mtd->oobsize)
 		if (atmel_nand_dma_op(mtd, (void *)buf, len, 0) == 0)
 			return;
 
-- 
1.7.3.3
