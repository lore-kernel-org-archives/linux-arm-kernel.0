From: josh.wu@atmel.com (Josh Wu)
Date: Fri, 6 Jun 2014 11:47:59 +0800
Subject: [PATCH 1/2] mtd: atmel_nand: NFC: use different compeletion for
 different interrupt
Message-ID: <1402026480-26648-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After this patch, we can know which NFC interrupt is handled. It's a
preparation for handling multiple NFC interrupts.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c |   27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 4ce181a..347cee2 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -97,7 +97,9 @@ struct atmel_nfc {
 	bool			write_by_sram;
 
 	bool			is_initialized;
-	struct completion	comp_nfc;
+	struct completion	comp_ready;
+	struct completion	comp_cmd_done;
+	struct completion	comp_xfer_done;
 
 	/* Point to the sram bank which include readed data via NFC */
 	void __iomem		*data_in_sram;
@@ -1584,13 +1586,13 @@ static irqreturn_t hsmc_interrupt(int irq, void *dev_id)
 	pending = status & mask;
 
 	if (pending & NFC_SR_XFR_DONE) {
-		complete(&host->nfc->comp_nfc);
+		complete(&host->nfc->comp_xfer_done);
 		nfc_writel(host->nfc->hsmc_regs, IDR, NFC_SR_XFR_DONE);
 	} else if (pending & NFC_SR_RB_EDGE) {
-		complete(&host->nfc->comp_nfc);
+		complete(&host->nfc->comp_ready);
 		nfc_writel(host->nfc->hsmc_regs, IDR, NFC_SR_RB_EDGE);
 	} else if (pending & NFC_SR_CMD_DONE) {
-		complete(&host->nfc->comp_nfc);
+		complete(&host->nfc->comp_cmd_done);
 		nfc_writel(host->nfc->hsmc_regs, IDR, NFC_SR_CMD_DONE);
 	} else {
 		ret = IRQ_NONE;
@@ -1603,12 +1605,25 @@ static irqreturn_t hsmc_interrupt(int irq, void *dev_id)
 static int nfc_wait_interrupt(struct atmel_nand_host *host, u32 flag)
 {
 	unsigned long timeout;
-	init_completion(&host->nfc->comp_nfc);
+	struct completion *comp;
+
+	if (flag & NFC_SR_XFR_DONE) {
+		comp = &host->nfc->comp_xfer_done;
+	} else if (flag & NFC_SR_RB_EDGE) {
+		comp = &host->nfc->comp_ready;
+	} else if (flag & NFC_SR_CMD_DONE) {
+		comp = &host->nfc->comp_cmd_done;
+	} else {
+		dev_err(host->dev, "Unkown interrupt flag: 0x%08x\n", flag);
+		return -EINVAL;
+	}
+
+	init_completion(comp);
 
 	/* Enable interrupt that need to wait for */
 	nfc_writel(host->nfc->hsmc_regs, IER, flag);
 
-	timeout = wait_for_completion_timeout(&host->nfc->comp_nfc,
+	timeout = wait_for_completion_timeout(comp,
 			msecs_to_jiffies(NFC_TIME_OUT_MS));
 	if (timeout)
 		return 0;
-- 
1.7.9.5
