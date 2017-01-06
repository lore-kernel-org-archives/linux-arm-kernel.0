From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  6 Jan 2017 10:42:06 +0100
Subject: [PATCH 2/3] mtd: nand: sunxi: Stop using polling mode when waiting
 for long operations
In-Reply-To: <1483695727-17415-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1483695727-17415-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1483695727-17415-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some operations, like read/write an entire page of data with the ECC
engine enabled, are known to take a lot of time. Use the interrupt-based
waiting mode in these situation.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index ba78e13a3570..76449f79d4c5 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -522,6 +522,8 @@ static void sunxi_nfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 	u32 tmp;
 
 	while (len > offs) {
+		bool poll = false;
+
 		cnt = min(len - offs, NFC_SRAM_SIZE);
 
 		ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
@@ -532,7 +534,11 @@ static void sunxi_nfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 		tmp = NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD;
 		writel(tmp, nfc->regs + NFC_REG_CMD);
 
-		ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, true, 0);
+		/* Arbitrary limit for polling mode */
+		if (cnt < 64)
+			poll = true;
+
+		ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, poll, 0);
 		if (ret)
 			break;
 
@@ -555,6 +561,8 @@ static void sunxi_nfc_write_buf(struct mtd_info *mtd, const uint8_t *buf,
 	u32 tmp;
 
 	while (len > offs) {
+		bool poll = false;
+
 		cnt = min(len - offs, NFC_SRAM_SIZE);
 
 		ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
@@ -567,7 +575,11 @@ static void sunxi_nfc_write_buf(struct mtd_info *mtd, const uint8_t *buf,
 		      NFC_ACCESS_DIR;
 		writel(tmp, nfc->regs + NFC_REG_CMD);
 
-		ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, true, 0);
+		/* Arbitrary limit for polling mode */
+		if (cnt < 64)
+			poll = true;
+
+		ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, poll, 0);
 		if (ret)
 			break;
 
@@ -961,7 +973,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
 	       nfc->regs + NFC_REG_CMD);
 
-	ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, true, 0);
+	ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, false, 0);
 	sunxi_nfc_randomizer_disable(mtd);
 	if (ret)
 		return ret;
@@ -1073,7 +1085,7 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct mtd_info *mtd, uint8_t *buf,
 	writel(NFC_PAGE_OP | NFC_DATA_SWAP_METHOD | NFC_DATA_TRANS,
 	       nfc->regs + NFC_REG_CMD);
 
-	ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, true, 0);
+	ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, false, 0);
 	if (ret)
 		dmaengine_terminate_all(nfc->dmac);
 
@@ -1193,7 +1205,7 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 	       NFC_ACCESS_DIR | NFC_ECC_OP,
 	       nfc->regs + NFC_REG_CMD);
 
-	ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, true, 0);
+	ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, false, 0);
 	sunxi_nfc_randomizer_disable(mtd);
 	if (ret)
 		return ret;
@@ -1432,7 +1444,7 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct mtd_info *mtd,
 	       NFC_DATA_TRANS | NFC_ACCESS_DIR,
 	       nfc->regs + NFC_REG_CMD);
 
-	ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, true, 0);
+	ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, false, 0);
 	if (ret)
 		dmaengine_terminate_all(nfc->dmac);
 
-- 
2.7.4
