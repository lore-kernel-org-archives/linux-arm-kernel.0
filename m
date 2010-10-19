From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 19 Oct 2010 12:22:34 +0200
Subject: [PATCH 2/3] mmci: handle out-of-order IRQ events
Message-ID: <1287483754-28859-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the U300 the MCI_DATAEND and MCI_DATABLOCKEND IRQs can arrive
out-of-order. Replace an ugly #ifdef hack with a proper runtime
solution which models what is really happening.

In the U300 DMA mode and on all Ux500 models, the MCI_DATABLOCKEND
flag isn't properly cleared in hardware following and ACK leading
to all kind of weird behaviour when the flag is still up in
subsequent interrupts, so we add two flags indicating the
error and handle this runtime.

Cc: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
This respin incorporates the related code from Rabins patch
for Ux500 support.
---
 drivers/mmc/host/mmci.c |   91 ++++++++++++++++++++++++++++++++++++++--------
 drivers/mmc/host/mmci.h |    3 ++
 2 files changed, 78 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index ed700a5..1294a41 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -45,6 +45,10 @@ static unsigned int fmax = 515633;
  *	      is asserted (likewise for RX)
  * @fifohalfsize: number of bytes that can be written when MCI_TXFIFOHALFEMPTY
  *		  is asserted (likewise for RX)
+ * @broken_blockend: the MCI_DATABLOCKEND is broken on the hardware
+ *		and will not work at all.
+ * @broken_blockend_dma: the MCI_DATABLOCKEND is broken on the hardware when
+ *		using DMA.
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -52,6 +56,8 @@ struct variant_data {
 	unsigned int		datalength_bits;
 	unsigned int		fifosize;
 	unsigned int		fifohalfsize;
+	bool			broken_blockend;
+	bool			broken_blockend_dma;
 };
 
 static struct variant_data variant_arm = {
@@ -65,6 +71,7 @@ static struct variant_data variant_u300 = {
 	.fifohalfsize		= 8 * 4,
 	.clkreg_enable		= 1 << 13, /* HWFCEN */
 	.datalength_bits	= 16,
+	.broken_blockend_dma	= true,
 };
 
 static struct variant_data variant_ux500 = {
@@ -73,6 +80,7 @@ static struct variant_data variant_ux500 = {
 	.clkreg			= MCI_CLK_ENABLE,
 	.clkreg_enable		= 1 << 14, /* HWFCEN */
 	.datalength_bits	= 24,
+	.broken_blockend	= true,
 };
 /*
  * This must be called with host->lock held
@@ -249,20 +257,9 @@ static void
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
+	struct variant_data *variant = host->variant;
+
+	/* First check for errors */
 	if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
 		dev_dbg(mmc_dev(host->mmc), "MCI ERROR IRQ (status %08x)\n", status);
 		if (status & MCI_DATACRCFAIL)
@@ -271,7 +268,10 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
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
@@ -289,9 +289,64 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 			local_irq_restore(flags);
 		}
 	}
-	if (status & MCI_DATAEND) {
+
+	/*
+	 * On ARM variants in PIO mode, MCI_DATABLOCKEND
+	 * is always sent first, and we increase the
+	 * transfered number of bytes for that IRQ. Then
+	 * MCI_DATAEND follows and we conclude the transaction.
+	 *
+	 * On the Ux500 single-IRQ variant MCI_DATABLOCKEND
+	 * doesn't seem to immediately clear from the status,
+	 * so we can't use it keep count when only one irq is
+	 * used because the irq will hit for other reasons, and
+	 * then the flag is still up. So we use the MCI_DATAEND
+	 * IRQ at the end of the entire transfer because
+	 * MCI_DATABLOCKEND is broken.
+	 *
+	 * In the U300, the IRQs can arrive out-of-order,
+	 * e.g. MCI_DATABLOCKEND sometimes arrives after MCI_DATAEND,
+	 * so for this case we use the flags "blockend" and
+	 * "dataend" to make sure both IRQs have arrived before
+	 * concluding the transaction. (This does not apply
+	 * to the Ux500 which doesn't fire MCI_DATABLOCKEND
+	 * at all.) In DMA mode it suffers from the same problem
+	 * as the Ux500.
+	 */
+	if (status & MCI_DATABLOCKEND) {
+		/*
+		 * Just being a little over-cautious, we do not
+		 * use this progressive update if the hardware blockend
+		 * flag is unreliable: since it can stay high between
+		 * IRQs it will corrupt the transfer counter.
+		 */
+		if (!variant->broken_blockend)
+			host->data_xfered += data->blksz;
+		host->blockend = true;
+	}
+
+	if (status & MCI_DATAEND)
+		host->dataend = true;
+
+	/*
+	 * On variants with broken blockend we shall only wait for dataend,
+	 * on others we must sync with the blockend signal since they can
+	 * appear out-of-order.
+	 */
+	if (host->dataend && (host->blockend || variant->broken_blockend)) {
 		mmci_stop_data(host);
 
+		/* Reset these flags */
+		host->blockend = false;
+		host->dataend = false;
+
+		/*
+		 * Variants with broken blockend flags need to handle the
+		 * end of the entire transfer here.
+		 */
+		if (variant->broken_blockend && !data->error)
+			host->data_xfered += data->blksz * data->blocks;
+
 		if (!data->stop) {
 			mmci_request_end(host, data->mrq);
 		} else {
@@ -841,6 +896,10 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	}
 
 	mask = MCI_IRQENABLE;
+	/* Don't use the datablockend flag if it's broken */
+	if (variant->broken_blockend)
+		mask &= ~MCI_DATABLOCKEND;
+
 	writel(mask, host->base + MMCIMASK0);
 
 	amba_set_drvdata(dev, mmc);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index b4e48bd..df06f01 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -177,6 +177,9 @@ struct mmci_host {
 	struct timer_list	timer;
 	unsigned int		oldstat;
 
+	bool			blockend;
+	bool			dataend;
+
 	/* pio stuff */
 	struct sg_mapping_iter	sg_miter;
 	unsigned int		size;
-- 
1.7.2.3
