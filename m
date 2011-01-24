From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 17:03:04 +0000
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <20110124165356.GG24104@n2100.arm.linux.org.uk>
References: <1295618352-26432-1-git-send-email-pawel.moll@arm.com>
	<alpine.LFD.2.00.1101211456200.8580@xanadu.home>
	<000001cbbbc2$0e815e80$2b841b80$@moll@arm.com>
	<20110124133513.GL16202@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA45911F43295@GEORGE.Emea.Arm.com>
	<20110124162400.GC24104@n2100.arm.linux.org.uk>
	<000101cbbbe5$45d47ed0$d17d7c70$@moll@arm.com>
	<20110124165356.GG24104@n2100.arm.linux.org.uk>
Message-ID: <20110124170304.GH24104@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My final mail on this subject.  I'm adding Philippe and Catalin so that
they're in the loop on this.

Take a mainline kernel.  Apply the attached three patches.  MMC will then
work without any problems.  No hacks required.  There is *absolutely* *no*
need to waste time with hardware modifications.

With this you will find that MMCI FIFO underruns/overruns are no longer
any problem.
-------------- next part --------------
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index bfc8a8a..264a6bb 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -245,6 +245,20 @@ static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
 	return result;
 }
 
+static void send_stop(struct mmc_card *card, struct request *req)
+{
+	struct mmc_command cmd;
+	int err;
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+	cmd.opcode = MMC_STOP_TRANSMISSION;
+	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+	err = mmc_wait_for_cmd(card->host, &cmd, 0);
+	if (err)
+		pr_err("%s: error %d sending stop command\n",
+		       req->rq_disk->disk_name, err);
+}
+
 static u32 get_card_status(struct mmc_card *card, struct request *req)
 {
 	struct mmc_command cmd;
@@ -255,9 +269,9 @@ static u32 get_card_status(struct mmc_card *card, struct request *req)
 	if (!mmc_host_is_spi(card->host))
 		cmd.arg = card->rca << 16;
 	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
-	err = mmc_wait_for_cmd(card->host, &cmd, 0);
+	err = mmc_wait_for_cmd(card->host, &cmd, 2);
 	if (err)
-		printk(KERN_ERR "%s: error %d sending status command",
+		pr_err("%s: error %d sending status command\n",
 		       req->rq_disk->disk_name, err);
 	return cmd.resp[0];
 }
@@ -336,7 +350,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
 	struct mmc_blk_request brq;
-	int ret = 1, disable_multi = 0;
+	int ret = 1, disable_multi = 0, retry = 0;
 
 	mmc_claim_host(card->host);
 
@@ -432,6 +446,53 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 		 * programming mode even when things go wrong.
 		 */
 		if (brq.cmd.error || brq.data.error || brq.stop.error) {
+			status = get_card_status(card, req);
+
+			/* First print what's up */
+			if (brq.cmd.error)
+				pr_err("%s: error %d sending read/write command, card status %#x\n",
+				       req->rq_disk->disk_name, brq.cmd.error,
+				       status);
+
+			if (brq.data.error)
+				pr_err("%s: error %d transferring data, sector %u, nr %u, cmd response %#x, card status %#x\n",
+				       req->rq_disk->disk_name, brq.data.error,
+				       (unsigned)blk_rq_pos(req),
+				       (unsigned)blk_rq_sectors(req),
+				       brq.cmd.resp[0], status);
+
+			if (brq.stop.error)
+				pr_err("%s: error %d sending stop command, original cmd response %#x, card status %#x\n",
+				       req->rq_disk->disk_name, brq.stop.error,
+				       brq.cmd.resp[0], status);
+
+			/*
+			 * Now check the current card state.  If it is
+			 * in some data transfer mode, tell it to stop
+			 * (and hopefully transition back to TRAN.)
+			 */
+			if (R1_CURRENT_STATE(status) == R1_STATE_DATA ||
+			    R1_CURRENT_STATE(status) == R1_STATE_RCV)
+				send_stop(card, req);
+
+			/*
+			 * r/w cmd failure - get_card_status() should
+			 * tell us why the command was not accepted
+			 */
+			if (brq.cmd.error && retry < 2) {
+				/*
+				 * if it was a r/w cmd crc error, or illegal
+				 * command (eg, issued in wrong state) then
+				 * retry - we should have corrected the
+				 * state problem above.
+				 */
+				if (status & (R1_COM_CRC_ERROR |
+					      R1_ILLEGAL_COMMAND)) {
+					retry++;
+					continue;
+				}
+			}
+
 			if (brq.data.blocks > 1 && rq_data_dir(req) == READ) {
 				/* Redo read one sector at a time */
 				printk(KERN_WARNING "%s: retrying using single "
@@ -439,32 +500,9 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 				disable_multi = 1;
 				continue;
 			}
-			status = get_card_status(card, req);
-		}
-
-		if (brq.cmd.error) {
-			printk(KERN_ERR "%s: error %d sending read/write "
-			       "command, response %#x, card status %#x\n",
-			       req->rq_disk->disk_name, brq.cmd.error,
-			       brq.cmd.resp[0], status);
-		}
 
-		if (brq.data.error) {
-			if (brq.data.error == -ETIMEDOUT && brq.mrq.stop)
-				/* 'Stop' response contains card status */
-				status = brq.mrq.stop->resp[0];
-			printk(KERN_ERR "%s: error %d transferring data,"
-			       " sector %u, nr %u, card status %#x\n",
-			       req->rq_disk->disk_name, brq.data.error,
-			       (unsigned)blk_rq_pos(req),
-			       (unsigned)blk_rq_sectors(req), status);
-		}
-
-		if (brq.stop.error) {
-			printk(KERN_ERR "%s: error %d sending stop command, "
-			       "response %#x, card status %#x\n",
-			       req->rq_disk->disk_name, brq.stop.error,
-			       brq.stop.resp[0], status);
+			if (retry++ < 5)
+				continue;
 		}
 
 		if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ) {
@@ -486,7 +524,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 				 * indication and the card state.
 				 */
 			} while (!(cmd.resp[0] & R1_READY_FOR_DATA) ||
-				(R1_CURRENT_STATE(cmd.resp[0]) == 7));
+			    (R1_CURRENT_STATE(cmd.resp[0]) == R1_STATE_PRG));
 
 #if 0
 			if (cmd.resp[0] & ~0x00000900)
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 612301f..9d067ee 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -133,6 +133,16 @@
 #define R1_SWITCH_ERROR		(1 << 7)	/* sx, c */
 #define R1_APP_CMD		(1 << 5)	/* sr, c */
 
+#define R1_STATE_IDLE	0
+#define R1_STATE_READY	1
+#define R1_STATE_IDENT	2
+#define R1_STATE_STBY	3
+#define R1_STATE_TRAN	4
+#define R1_STATE_DATA	5
+#define R1_STATE_RCV	6
+#define R1_STATE_PRG	7
+#define R1_STATE_DIS	8
+
 /*
  * MMC/SD in SPI mode reports R1 status always, and R2 for SEND_STATUS
  * R1 is the low order byte; R2 is the next highest byte, when present.
-------------- next part --------------
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 5630228..040de4f 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -342,15 +342,15 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 
 	host->cmd = NULL;
 
-	cmd->resp[0] = readl(base + MMCIRESPONSE0);
-	cmd->resp[1] = readl(base + MMCIRESPONSE1);
-	cmd->resp[2] = readl(base + MMCIRESPONSE2);
-	cmd->resp[3] = readl(base + MMCIRESPONSE3);
-
 	if (status & MCI_CMDTIMEOUT) {
 		cmd->error = -ETIMEDOUT;
 	} else if (status & MCI_CMDCRCFAIL && cmd->flags & MMC_RSP_CRC) {
 		cmd->error = -EILSEQ;
+	} else {
+		cmd->resp[0] = readl(base + MMCIRESPONSE0);
+		cmd->resp[1] = readl(base + MMCIRESPONSE1);
+		cmd->resp[2] = readl(base + MMCIRESPONSE2);
+		cmd->resp[3] = readl(base + MMCIRESPONSE3);
 	}
 
 	if (!cmd->data || cmd->error) {
-------------- next part --------------
diff --git a/drivers/usb/host/isp1760-hcd.c b/drivers/usb/host/isp1760-hcd.c
index bdba8c5..9cb8722 100644
--- a/drivers/usb/host/isp1760-hcd.c
+++ b/drivers/usb/host/isp1760-hcd.c
@@ -1049,17 +1049,6 @@ static void do_atl_int(struct usb_hcd *usb_hcd)
 		if (!nakcount && (dw3 & DW3_QTD_ACTIVE)) {
 			u32 buffstatus;
 
-			/*
-			 * NAKs are handled in HW by the chip. Usually if the
-			 * device is not able to send data fast enough.
-			 * This happens mostly on slower hardware.
-			 */
-			printk(KERN_NOTICE "Reloading ptd %p/%p... qh %p read: "
-					"%d of %zu done: %08x cur: %08x\n", qtd,
-					urb, qh, PTD_XFERRED_LENGTH(dw3),
-					qtd->length, done_map,
-					(1 << queue_entry));
-
 			/* RL counter = ERR counter */
 			dw3 &= ~(0xf << 19);
 			dw3 |= rl << 19;
@@ -1770,7 +1759,7 @@ static irqreturn_t isp1760_irq(struct usb_hcd *usb_hcd)
 		goto leave;
 
 	isp1760_writel(imask, usb_hcd->regs + HC_INTERRUPT_REG);
-	if (imask & HC_ATL_INT)
+	if (imask & (HC_ATL_INT | HC_SOT_INT))
 		do_atl_int(usb_hcd);
 
 	if (imask & HC_INTL_INT)
diff --git a/drivers/usb/host/isp1760-hcd.h b/drivers/usb/host/isp1760-hcd.h
index 6931ef5..0d6023b 100644
--- a/drivers/usb/host/isp1760-hcd.h
+++ b/drivers/usb/host/isp1760-hcd.h
@@ -68,7 +68,7 @@ void deinit_kmem_cache(void);
 #define HC_INTERRUPT_REG	0x310
 
 #define HC_INTERRUPT_ENABLE	0x314
-#define INTERRUPT_ENABLE_MASK	(HC_INTL_INT | HC_ATL_INT | HC_EOT_INT)
+#define INTERRUPT_ENABLE_MASK	(HC_INTL_INT | HC_SOT_INT | HC_EOT_INT)
 
 #define HC_ISO_INT		(1 << 9)
 #define HC_ATL_INT		(1 << 8)
