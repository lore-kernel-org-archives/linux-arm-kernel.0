From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 10 Jun 2014 17:50:10 +0800
Subject: [PATCH v2 2/3] mtd: atmel_nand: implement the nfc_device_ready() by
 checking the R/B bit
In-Reply-To: <1402393811-24578-1-git-send-email-josh.wu@atmel.com>
References: <1402393811-24578-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1402393811-24578-2-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In nfc_device_ready(), it's more reasonable to check R/B bit in NFC_SR
than waiting for the R/B interrupt. It cost less time.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 25d9921..88f6dc0 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -1661,11 +1661,19 @@ static int nfc_send_command(struct atmel_nand_host *host,
 
 static int nfc_device_ready(struct mtd_info *mtd)
 {
+	u32 status, mask;
 	struct nand_chip *nand_chip = mtd->priv;
 	struct atmel_nand_host *host = nand_chip->priv;
-	if (!nfc_wait_interrupt(host, NFC_SR_RB_EDGE))
-		return 1;
-	return 0;
+
+	status = nfc_read_status(host);
+	mask = nfc_readl(host->nfc->hsmc_regs, IMR);
+
+	/* The mask should be 0. If not we may lost interrupts */
+	if (unlikely(mask & status))
+		dev_err(host->dev, "Lost the interrupt flags: 0x%08x\n",
+				mask & status);
+
+	return status & NFC_SR_RB_EDGE;
 }
 
 static void nfc_select_chip(struct mtd_info *mtd, int chip)
-- 
1.7.9.5
