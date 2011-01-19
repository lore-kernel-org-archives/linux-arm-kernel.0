From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 19 Jan 2011 22:26:47 +0100
Subject: [PATCH 3/3] RFC: mmci: stop using the blockend interrupts
Message-ID: <1295472407-13739-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement a suggestion from Russell to drop the use of blockend
interrupts altogether and instead rely on the data counter.

Tested with error-free cards on U300, U8500 and RealView PB1176.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
This simplifies the code a lot and works fine on error-free
transfers, we need to test it on some buggy cards.
---
 drivers/mmc/host/mmci.c |   99 ++++++++--------------------------------------
 drivers/mmc/host/mmci.h |    3 -
 2 files changed, 18 insertions(+), 84 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 7e0d38c..fc72e96 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -46,8 +46,6 @@ static unsigned int fmax = 515633;
  *	      is asserted (likewise for RX)
  * @fifohalfsize: number of bytes that can be written when MCI_TXFIFOHALFEMPTY
  *		  is asserted (likewise for RX)
- * @broken_blockend: the MCI_DATABLOCKEND is broken on the hardware
- *		and will not work at all.
  * @sdio: variant supports SDIO
  * @st_clkdiv: true if using a ST-specific clock divider algorithm
  */
@@ -57,7 +55,6 @@ struct variant_data {
 	unsigned int		datalength_bits;
 	unsigned int		fifosize;
 	unsigned int		fifohalfsize;
-	bool			broken_blockend;
 	bool			sdio;
 	bool			st_clkdiv;
 };
@@ -73,7 +70,6 @@ static struct variant_data variant_u300 = {
 	.fifohalfsize		= 8 * 4,
 	.clkreg_enable		= 1 << 13, /* HWFCEN */
 	.datalength_bits	= 16,
-	.broken_blockend	= true,
 	.sdio			= true,
 };
 
@@ -83,7 +79,6 @@ static struct variant_data variant_ux500 = {
 	.clkreg			= MCI_CLK_ENABLE,
 	.clkreg_enable		= 1 << 14, /* HWFCEN */
 	.datalength_bits	= 24,
-	.broken_blockend	= true,
 	.sdio			= true,
 	.st_clkdiv		= true,
 };
@@ -207,8 +202,6 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	host->data = data;
 	host->size = data->blksz * data->blocks;
 	host->data_xfered = 0;
-	host->last_blockend = false;
-	host->dataend = false;
 
 	mmci_init_sg(host, data);
 
@@ -250,10 +243,6 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 
 	writel(datactrl, base + MMCIDATACTRL);
 	irqmask0 = readl(base + MMCIMASK0);
-	if (variant->broken_blockend)
-		irqmask0 &= ~MCI_DATABLOCKENDMASK;
-	else
-		irqmask0 |= MCI_DATABLOCKENDMASK;
 	irqmask0 &= ~MCI_DATAENDMASK;
 	writel(irqmask0, base + MMCIMASK0);
 	mmci_set_mask1(host, irqmask1);
@@ -291,21 +280,26 @@ static void
 mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 	      unsigned int status)
 {
-	struct variant_data *variant = host->variant;
-
 	/* First check for errors */
 	if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
+		u32 remain, success;
+
+		/* Calculate how far we are into the transfer */
+		remain = readl(host->base + MMCIDATACNT) << 2;
+		success = data->blksz * data->blocks - remain;
+
 		dev_dbg(mmc_dev(host->mmc), "MCI ERROR IRQ (status %08x)\n", status);
-		if (status & MCI_DATACRCFAIL)
+		if (status & MCI_DATACRCFAIL) {
+			/* Last block was not successful */
+			host->data_xfered = ((success / data->blksz) - 1 * data->blksz);
 			data->error = -EILSEQ;
-		else if (status & MCI_DATATIMEOUT)
+		} else if (status & MCI_DATATIMEOUT) {
+			host->data_xfered = success;
 			data->error = -ETIMEDOUT;
-		else if (status & (MCI_TXUNDERRUN|MCI_RXOVERRUN))
+		} else if (status & (MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
+			host->data_xfered = success;
 			data->error = -EIO;
-
-		/* Force-complete the transaction */
-		host->last_blockend = true;
-		host->dataend = true;
+		}
 
 		/*
 		 * We hit an error condition.  Ensure that any data
@@ -324,71 +318,14 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		}
 	}
 
-	/*
-	 * On ARM variants in PIO mode, MCI_DATABLOCKEND is always sent first,
-	 * and we increase the transfered number of bytes for that IRQ. Repeat
-	 * for the number of blocks in the transfer. Then MCI_DATAEND follows
-	 * and we conclude the transaction.
-	 *
-	 * On the U300 and Ux500 a few to many MCI_DATABLOCKEND interrupts
-	 * are usually missing, so the data counter is not properly increased.
-	 * This is likely because new block arrive while the IRQ is being
-	 * processed without the transfers being held back, and ACK:in the
-	 * interrupt will only clear the very last block and intermediate
-	 * blockend interrupts get lost. So we simply mask of the blockend
-	 * interrupt on these and only use the dataend interrupt.
-	 */
-	if (status & MCI_DATABLOCKEND) {
-		/*
-		 * Just being a little over-cautious, we do not
-		 * use this progressive update if the hardware blockend
-		 * flag is unreliable: since it can stay high between
-		 * IRQs it will corrupt the transfer counter.
-		 */
-		if (!variant->broken_blockend)
-			host->data_xfered += data->blksz;
-		if (host->data_xfered == data->blksz * data->blocks)
-			host->last_blockend = true;
-	}
+	if (status & MCI_DATABLOCKEND)
+		dev_err(mmc_dev(host->mmc), "stray MCI_DATABLOCKEND interrupt\n");
 
 	if (status & MCI_DATAEND) {
-		if (!host->last_blockend && !variant->broken_blockend &&
-		    !data->error) {
-			/*
-			 * This typically occur on hardware with broken
-			 * blockend reporting, which will fire less blockend
-			 * IRQs than would be expected. Print an error and
-			 * repair the situation, but the hardware should
-			 * really be flagged as broken so this IRQ is not used
-			 * at all.
-			 */
-			dev_err(mmc_dev(host->mmc),
-				"missing %d block interrupts!\n",
-				(data->blksz * data->blocks - host->data_xfered) / data->blksz);
-			host->data_xfered = data->blksz * data->blocks;
-			host->last_blockend = true;
-		}
-		host->dataend = true;
-	}
-
-	/*
-	 * On variants with broken blockend we shall only wait for dataend,
-	 * on others we must sync with the blockend signal since they can
-	 * appear out-of-order.
-	 */
-	if (host->dataend &&
-	    (host->last_blockend || variant->broken_blockend)) {
 		mmci_stop_data(host);
 
-		/* Reset these flags */
-		host->last_blockend = false;
-		host->dataend = false;
-
-		/*
-		 * Variants with broken blockend flags need to handle the
-		 * end of the entire transfer here.
-		 */
-		if (variant->broken_blockend && !data->error)
+		if (!data->error)
+			/* The error clause is handled above, success! */
 			host->data_xfered += data->blksz * data->blocks;
 
 		if (!data->stop) {
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 7ac8c4d..c1df7b8 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -177,9 +177,6 @@ struct mmci_host {
 	struct timer_list	timer;
 	unsigned int		oldstat;
 
-	bool			last_blockend;
-	bool			dataend;
-
 	/* pio stuff */
 	struct sg_mapping_iter	sg_miter;
 	unsigned int		size;
-- 
1.7.3.2
