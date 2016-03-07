From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 17:21:34 +0100
Subject: [PATCH 15/16] mtd: nand: sunxi: make use of readl_poll_timeout()
In-Reply-To: <1457367695-26420-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
 <1457367695-26420-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457367695-26420-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace open coded polling loops by readl_poll_timeout() calls.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 79c90fd..002194b 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -39,7 +39,7 @@
 #include <linux/dmaengine.h>
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
-#include <linux/io.h>
+#include <linux/iopoll.h>
 
 #define NFC_REG_CTL		0x0000
 #define NFC_REG_ST		0x0004
@@ -323,33 +323,33 @@ static int sunxi_nfc_wait_int(struct sunxi_nfc *nfc, u32 flags,
 
 static int sunxi_nfc_wait_cmd_fifo_empty(struct sunxi_nfc *nfc)
 {
-	unsigned long timeout = jiffies +
-				msecs_to_jiffies(NFC_DEFAULT_TIMEOUT_MS);
+	u32 status;
+	int ret;
 
-	do {
-		if (!(readl(nfc->regs + NFC_REG_ST) & NFC_CMD_FIFO_STATUS))
-			return 0;
-	} while (time_before(jiffies, timeout));
+	ret = readl_poll_timeout(nfc->regs + NFC_REG_ST, status,
+				 !(status & NFC_CMD_FIFO_STATUS), 1,
+				 NFC_DEFAULT_TIMEOUT_MS * 1000);
+	if (ret)
+		dev_err(nfc->dev, "wait for empty cmd FIFO timedout\n");
 
-	dev_err(nfc->dev, "wait for empty cmd FIFO timedout\n");
-	return -ETIMEDOUT;
+	return ret;
 }
 
 static int sunxi_nfc_rst(struct sunxi_nfc *nfc)
 {
-	unsigned long timeout = jiffies +
-				msecs_to_jiffies(NFC_DEFAULT_TIMEOUT_MS);
+	u32 ctl;
+	int ret;
 
 	writel(0, nfc->regs + NFC_REG_ECC_CTL);
 	writel(NFC_RESET, nfc->regs + NFC_REG_CTL);
 
-	do {
-		if (!(readl(nfc->regs + NFC_REG_CTL) & NFC_RESET))
-			return 0;
-	} while (time_before(jiffies, timeout));
+	ret = readl_poll_timeout(nfc->regs + NFC_REG_CTL, ctl,
+				 !(ctl & NFC_RESET), 1,
+				 NFC_DEFAULT_TIMEOUT_MS * 1000);
+	if (ret)
+		dev_err(nfc->dev, "wait for NAND controller reset timedout\n");
 
-	dev_err(nfc->dev, "wait for NAND controller reset timedout\n");
-	return -ETIMEDOUT;
+	return ret;
 }
 
 static int sunxi_nfc_dev_ready(struct mtd_info *mtd)
-- 
2.1.4
