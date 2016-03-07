From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 17:21:35 +0100
Subject: [PATCH 16/16] mtd: nand: sunxi: poll for events instead of using
 interrupts
In-Reply-To: <1457367695-26420-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
 <1457367695-26420-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457367695-26420-7-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some NAND operations are so fast that it doesn't make any sense to use
interrupt based waits (the scheduling overhead is not worth it).
Rename sunxi_nfc_wait_int() into sunxi_nfc_wait_events() and add a
parameter to specify whether polling should be used or not.

Note that all sunxi_nfc_wait_int() are moved to the polling approach now,
but this should change as soon as we have more information about the
approximate time we are about to wait (can be extracted from the NAND
timings, and the type of operation).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 45 +++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 002194b..0616f3b 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -302,23 +302,40 @@ static irqreturn_t sunxi_nfc_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int sunxi_nfc_wait_int(struct sunxi_nfc *nfc, u32 flags,
-			      unsigned int timeout_ms)
+static int sunxi_nfc_wait_events(struct sunxi_nfc *nfc, u32 events,
+				 bool use_polling, unsigned int timeout_ms)
 {
-	init_completion(&nfc->complete);
+	int ret;
 
-	writel(flags, nfc->regs + NFC_REG_INT);
+	if (events & ~NFC_INT_MASK)
+		return -EINVAL;
 
 	if (!timeout_ms)
 		timeout_ms = NFC_DEFAULT_TIMEOUT_MS;
 
-	if (!wait_for_completion_timeout(&nfc->complete,
-					 msecs_to_jiffies(timeout_ms))) {
-		dev_err(nfc->dev, "wait interrupt timedout\n");
-		return -ETIMEDOUT;
+	if (!use_polling) {
+		init_completion(&nfc->complete);
+
+		writel(events, nfc->regs + NFC_REG_INT);
+
+		ret = wait_for_completion_timeout(&nfc->complete,
+						msecs_to_jiffies(timeout_ms));
+
+		writel(0, nfc->regs + NFC_REG_INT);
+	} else {
+		u32 status;
+
+		ret = readl_poll_timeout(nfc->regs + NFC_REG_ST, status,
+					 (status & events) == events, 1,
+					 timeout_ms * 1000);
 	}
 
-	return 0;
+	writel(events & NFC_INT_MASK, nfc->regs + NFC_REG_ST);
+
+	if (ret)
+		dev_err(nfc->dev, "wait interrupt timedout\n");
+
+	return ret;
 }
 
 static int sunxi_nfc_wait_cmd_fifo_empty(struct sunxi_nfc *nfc)
@@ -449,7 +466,7 @@ static void sunxi_nfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 		tmp = NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD;
 		writel(tmp, nfc->regs + NFC_REG_CMD);
 
-		ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
+		ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, true, 0);
 		if (ret)
 			break;
 
@@ -484,7 +501,7 @@ static void sunxi_nfc_write_buf(struct mtd_info *mtd, const uint8_t *buf,
 		      NFC_ACCESS_DIR;
 		writel(tmp, nfc->regs + NFC_REG_CMD);
 
-		ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
+		ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, true, 0);
 		if (ret)
 			break;
 
@@ -546,7 +563,7 @@ static void sunxi_nfc_cmd_ctrl(struct mtd_info *mtd, int dat,
 		sunxi_nand->addr[0] = 0;
 		sunxi_nand->addr[1] = 0;
 		sunxi_nand->addr_cycles = 0;
-		sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
+		sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, true, 0);
 	}
 
 	if (ctrl & NAND_CLE) {
@@ -789,7 +806,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
 	       nfc->regs + NFC_REG_CMD);
 
-	ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
+	ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, true, 0);
 	sunxi_nfc_randomizer_disable(mtd);
 	if (ret)
 		return ret;
@@ -927,7 +944,7 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 	       NFC_ACCESS_DIR | NFC_ECC_OP,
 	       nfc->regs + NFC_REG_CMD);
 
-	ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
+	ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, true, 0);
 	sunxi_nfc_randomizer_disable(mtd);
 	if (ret)
 		return ret;
-- 
2.1.4
