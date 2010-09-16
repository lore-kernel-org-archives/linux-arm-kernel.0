From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 16 Sep 2010 12:05:34 +0200
Subject: [PATCH] mmci: handle out-of-order IRQ events
Message-ID: <1284631534-21459-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the U300 the MCI_DATAEND and MCI_DATABLOCKEND IRQs can arrive
out-of-order. Replace an ugly #ifdef hack with a proper runtime
solution which models what is really happening.

Also host->data_xfered should be incremented and not assigned
a fixed value as is done in earlier patches I believe.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
This patch is broken out of the DMA patch series I'm preparing
for MMCI, and applied on top of the stuff that is already pending
in the patch tracker.

I have regression tested this (on top of Rabins patches) on U300,
U8500 and RealView PB1176.

On a side note I can actually increase the f_max parameter quite
a bit on the PB1176 nowadays, but I don't know if it is only on
this board.
---
 drivers/mmc/host/mmci.c |   70 +++++++++++++++++++++++++++++++++++------------
 drivers/mmc/host/mmci.h |    3 ++
 2 files changed, 55 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 082abad..ae164e1 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -254,20 +254,7 @@ static void
 mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 	      unsigned int status)
 {
-	if (status & MCI_DATABLOCKEND) {
-		host->data_xfered += data->blksz;
-#ifdef CONFIG_ARCH_U300
-		/*
-		 * On the U300 some signal or other is
-		 * badly routed so that a data write does
-		 * not properly terminate with a MCI_DATAEND
-		 * status flag. This quirk will make writes
-		 * work again.
-		 */
-		if (data->flags & MMC_DATA_WRITE)
-			status |= MCI_DATAEND;
-#endif
-	}
+	/* First check for errors */
 	if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
 		dev_dbg(mmc_dev(host->mmc), "MCI ERROR IRQ (status %08x)\n", status);
 		if (status & MCI_DATACRCFAIL)
@@ -276,7 +263,10 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 			data->error = -ETIMEDOUT;
 		else if (status & (MCI_TXUNDERRUN|MCI_RXOVERRUN))
 			data->error = -EIO;
-		status |= MCI_DATAEND;
+
+		/* Force-complete the transaction */
+		host->blockend = true;
+		host->dataend = true;
 
 		/*
 		 * We hit an error condition.  Ensure that any data
@@ -294,12 +284,56 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 			local_irq_restore(flags);
 		}
 	}
-	if (status & MCI_DATAEND) {
+
+	/*
+	 * On ARM variants in PIO mode, MCI_DATABLOCKEND
+	 * is always sent first, and we increase the
+	 * transfered number of bytes for that IRQ. Then
+	 * MCI_DATEND follows and we conclude the transaction.
+	 *
+	 * The Ux500 single-IRQ variant only fires the
+	 * MCI_DATAEND IRQ at the end of the entire transfer.
+	 *
+	 * In the U300, the IRQs can arrive out-of-order,
+	 * e.g. MCI_DATABLOCKEND sometimes arrives after MCI_DATAEND,
+	 * so in this case we use the flags "blockend" and
+	 * "dataend" to make sure both IRQs have arrived before
+	 * concluding the transaction. (This does not apply
+	 * to the Ux500 which doesn't fire MCI_DATABLOCKEND
+	 * at all.)
+	 */
+	if (status & MCI_DATABLOCKEND) {
+		/*
+		 * Just being a little over-cautious, we do not
+		 * use this progressive update in DMA or single-IRQ
+		 * mode.
+		 */
+		if (!host->variant->singleirq)
+			host->data_xfered += data->blksz;
+		host->blockend = true;
+	}
+
+	if (status & MCI_DATAEND)
+		host->dataend = true;
+
+	/*
+	 * On Ux500 we shall only wait for dataend, on others we must sync
+	 * with the blockend signal since they can appear out-of-order.
+	 */
+	if (host->dataend && (host->blockend || host->variant->singleirq)) {
 		mmci_stop_data(host);
 
-		/* MCI_DATABLOCKEND not used with single irq */
+		/* Reset these flags */
+		host->blockend = false;
+		host->dataend = false;
+
+		/*
+		 * Single IRQ variants do not transmit MCI_DATABLOCKEND
+		 * and in DMA mode this signal need to be synchronized
+		 * with MCI_DATEND
+		 */
 		if (host->variant->singleirq && !data->error)
-			host->data_xfered = data->blksz * data->blocks;
+			host->data_xfered += data->blksz * data->blocks;
 
 		if (!data->stop) {
 			mmci_request_end(host, data->mrq);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index ba203b8..acac081 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -170,6 +170,9 @@ struct mmci_host {
 	struct timer_list	timer;
 	unsigned int		oldstat;
 
+	bool			blockend;
+	bool			dataend;
+
 	/* pio stuff */
 	struct sg_mapping_iter	sg_miter;
 	unsigned int		size;
-- 
1.7.2.2
