From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 10 Jun 2014 17:50:11 +0800
Subject: [PATCH v2 3/3] mtd: atmel_nand: NFC: support multiple interrupt
 handling
In-Reply-To: <1402393811-24578-1-git-send-email-josh.wu@atmel.com>
References: <1402393811-24578-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1402393811-24578-3-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Josh Wu <Josh.wu@atmel.com>

It fixes following error sometime happens during the NFC data transfer:
  atmel_nand 80000000.nand: Time out to wait for interrupt: 0x00010000
  atmel_nand 80000000.nand: something wrong, No XFR_DONE interrupt comes.

The root cause is in current interrupt handler, we read the ISR but
only handle one interrupt. If there are more than one interrupt come
together, then the second one will be lost.

During the NFC data transfer. There is possible two NFC interrupts:
NFC_CMD_DONE and NFC_XFR_DONE, come in same time.

NFC_CMD_DONE means NFC command is send. and NFC_XFR_DONE means NFC data
is transfered.

This patch can handle multiple NFC interrupts in same time. And during
the NFC data transfer, we need to wait for two NFC interrupts:
NFC_CMD_DONE and NFC_XFR_DONE.

Also we seperate the completion initialization code to a
nfc_prepare_interrupt(), which is pair with nfc_wait_interrupt().

We call nfc_prepare_interrupt() before send out nfc command to make sure
no interrupt lost.

Reported-by: Matthieu CRAPET <Matthieu.CRAPET@ingenico.com>
Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
v1 -> v2:
  1. merged two patches into one.
  2. split the original nfc_wait_interrupt() into two functions to make
     sure completion is initialized before we wait the interrupt.
  3. Disable the interrupt if nfc_wait_interrupt() is timeout.

 drivers/mtd/nand/atmel_nand.c |   84 ++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 88f6dc0..182aa40 100644
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
@@ -1596,44 +1598,80 @@ static irqreturn_t hsmc_interrupt(int irq, void *dev_id)
 {
 	struct atmel_nand_host *host = dev_id;
 	u32 status, mask, pending;
-	irqreturn_t ret = IRQ_HANDLED;
+	irqreturn_t ret = IRQ_NONE;
 
 	status = nfc_read_status(host);
 	mask = nfc_readl(host->nfc->hsmc_regs, IMR);
 	pending = status & mask;
 
 	if (pending & NFC_SR_XFR_DONE) {
-		complete(&host->nfc->comp_nfc);
+		complete(&host->nfc->comp_xfer_done);
 		nfc_writel(host->nfc->hsmc_regs, IDR, NFC_SR_XFR_DONE);
-	} else if (pending & NFC_SR_RB_EDGE) {
-		complete(&host->nfc->comp_nfc);
+		ret = IRQ_HANDLED;
+	}
+	if (pending & NFC_SR_RB_EDGE) {
+		complete(&host->nfc->comp_ready);
 		nfc_writel(host->nfc->hsmc_regs, IDR, NFC_SR_RB_EDGE);
-	} else if (pending & NFC_SR_CMD_DONE) {
-		complete(&host->nfc->comp_nfc);
+		ret = IRQ_HANDLED;
+	}
+	if (pending & NFC_SR_CMD_DONE) {
+		complete(&host->nfc->comp_cmd_done);
 		nfc_writel(host->nfc->hsmc_regs, IDR, NFC_SR_CMD_DONE);
-	} else {
-		ret = IRQ_NONE;
+		ret = IRQ_HANDLED;
 	}
 
 	return ret;
 }
 
 /* NFC(Nand Flash Controller) related functions */
-static int nfc_wait_interrupt(struct atmel_nand_host *host, u32 flag)
+static void nfc_prepare_interrupt(struct atmel_nand_host *host, u32 flag)
 {
-	unsigned long timeout;
-	init_completion(&host->nfc->comp_nfc);
+	if (flag & NFC_SR_XFR_DONE)
+		init_completion(&host->nfc->comp_xfer_done);
+
+	if (flag & NFC_SR_RB_EDGE)
+		init_completion(&host->nfc->comp_ready);
+
+	if (flag & NFC_SR_CMD_DONE)
+		init_completion(&host->nfc->comp_cmd_done);
 
 	/* Enable interrupt that need to wait for */
 	nfc_writel(host->nfc->hsmc_regs, IER, flag);
+}
 
-	timeout = wait_for_completion_timeout(&host->nfc->comp_nfc,
-			msecs_to_jiffies(NFC_TIME_OUT_MS));
-	if (timeout)
-		return 0;
+static int nfc_wait_interrupt(struct atmel_nand_host *host, u32 flag)
+{
+	int i, index = 0;
+	struct completion *comp[3];	/* Support 3 interrupt completion */
+
+	if (flag & NFC_SR_XFR_DONE)
+		comp[index++] = &host->nfc->comp_xfer_done;
+
+	if (flag & NFC_SR_RB_EDGE)
+		comp[index++] = &host->nfc->comp_ready;
 
-	/* Time out to wait for the interrupt */
+	if (flag & NFC_SR_CMD_DONE)
+		comp[index++] = &host->nfc->comp_cmd_done;
+
+	if (index == 0) {
+		dev_err(host->dev, "Unkown interrupt flag: 0x%08x\n", flag);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < index; i++) {
+		if (wait_for_completion_timeout(comp[i],
+				msecs_to_jiffies(NFC_TIME_OUT_MS)))
+			continue;	/* wait for next completion */
+		else
+			goto err_timeout;
+	}
+
+	return 0;
+
+err_timeout:
 	dev_err(host->dev, "Time out to wait for interrupt: 0x%08x\n", flag);
+	/* Disable the interrupt as it is not handled by interrupt handler */
+	nfc_writel(host->nfc->hsmc_regs, IDR, flag);
 	return -ETIMEDOUT;
 }
 
@@ -1641,6 +1679,9 @@ static int nfc_send_command(struct atmel_nand_host *host,
 	unsigned int cmd, unsigned int addr, unsigned char cycle0)
 {
 	unsigned long timeout;
+	u32 flag = NFC_SR_CMD_DONE;
+	flag |= cmd & NFCADDR_CMD_DATAEN ? NFC_SR_XFR_DONE : 0;
+
 	dev_dbg(host->dev,
 		"nfc_cmd: 0x%08x, addr1234: 0x%08x, cycle0: 0x%02x\n",
 		cmd, addr, cycle0);
@@ -1654,9 +1695,11 @@ static int nfc_send_command(struct atmel_nand_host *host,
 			return -ETIMEDOUT;
 		}
 	}
+
+	nfc_prepare_interrupt(host, flag);
 	nfc_writel(host->nfc->hsmc_regs, CYCLE0, cycle0);
 	nfc_cmd_addr1234_writel(cmd, addr, host->nfc->base_cmd_regs);
-	return nfc_wait_interrupt(host, NFC_SR_CMD_DONE);
+	return nfc_wait_interrupt(host, flag);
 }
 
 static int nfc_device_ready(struct mtd_info *mtd)
@@ -1822,10 +1865,6 @@ static void nfc_nand_command(struct mtd_info *mtd, unsigned int command,
 	nfc_addr_cmd = cmd1 | cmd2 | vcmd2 | acycle | csid | dataen | nfcwr;
 	nfc_send_command(host, nfc_addr_cmd, addr1234, cycle0);
 
-	if (dataen == NFCADDR_CMD_DATAEN)
-		if (nfc_wait_interrupt(host, NFC_SR_XFR_DONE))
-			dev_err(host->dev, "something wrong, No XFR_DONE interrupt comes.\n");
-
 	/*
 	 * Program and erase have their own busy handlers status, sequential
 	 * in, and deplete1 need no delay.
@@ -1850,6 +1889,7 @@ static void nfc_nand_command(struct mtd_info *mtd, unsigned int command,
 		}
 		/* fall through */
 	default:
+		nfc_prepare_interrupt(host, NFC_SR_RB_EDGE);
 		nfc_wait_interrupt(host, NFC_SR_RB_EDGE);
 	}
 }
-- 
1.7.9.5
