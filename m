From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 19 Jan 2011 22:26:37 +0100
Subject: [PATCH 2/3] mmci: fixup broken_blockend variant patch v3
Message-ID: <1295472397-13705-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

host->last_blockend flag is now set only for the last
MCI_DATABLOCKEND, the previous code would just react to
any blockend, which was buggy. Consolidate Ux500 and U300
bug flags to a single one and use only the MCI_DATAEND irq
on U300 as well, it turns out it was broken just like the
Ux500.

Tested successfully on Ux500, U300 and ARM RealView
PB1176.

Cc: Sebastian Rasmussen <sebastian.rasmussen@stericsson.com>
Cc: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
[Tweaking and adding err message]
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
Changed v2->v3:
- Split off the unrelated fix to its own patch, making this
  one way easier to read, sorry for the mess.
---
 drivers/mmc/host/mmci.c |   67 ++++++++++++++++++++++++++---------------------
 drivers/mmc/host/mmci.h |    2 +-
 2 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 24ff586..7e0d38c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -48,8 +48,6 @@ static unsigned int fmax = 515633;
  *		  is asserted (likewise for RX)
  * @broken_blockend: the MCI_DATABLOCKEND is broken on the hardware
  *		and will not work at all.
- * @broken_blockend_dma: the MCI_DATABLOCKEND is broken on the hardware when
- *		using DMA.
  * @sdio: variant supports SDIO
  * @st_clkdiv: true if using a ST-specific clock divider algorithm
  */
@@ -60,7 +58,6 @@ struct variant_data {
 	unsigned int		fifosize;
 	unsigned int		fifohalfsize;
 	bool			broken_blockend;
-	bool			broken_blockend_dma;
 	bool			sdio;
 	bool			st_clkdiv;
 };
@@ -76,7 +73,7 @@ static struct variant_data variant_u300 = {
 	.fifohalfsize		= 8 * 4,
 	.clkreg_enable		= 1 << 13, /* HWFCEN */
 	.datalength_bits	= 16,
-	.broken_blockend_dma	= true,
+	.broken_blockend	= true,
 	.sdio			= true,
 };
 
@@ -210,7 +207,7 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	host->data = data;
 	host->size = data->blksz * data->blocks;
 	host->data_xfered = 0;
-	host->blockend = false;
+	host->last_blockend = false;
 	host->dataend = false;
 
 	mmci_init_sg(host, data);
@@ -307,7 +304,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 			data->error = -EIO;
 
 		/* Force-complete the transaction */
-		host->blockend = true;
+		host->last_blockend = true;
 		host->dataend = true;
 
 		/*
@@ -328,27 +325,18 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 	}
 
 	/*
-	 * On ARM variants in PIO mode, MCI_DATABLOCKEND
-	 * is always sent first, and we increase the
-	 * transfered number of bytes for that IRQ. Then
-	 * MCI_DATAEND follows and we conclude the transaction.
-	 *
-	 * On the Ux500 single-IRQ variant MCI_DATABLOCKEND
-	 * doesn't seem to immediately clear from the status,
-	 * so we can't use it keep count when only one irq is
-	 * used because the irq will hit for other reasons, and
-	 * then the flag is still up. So we use the MCI_DATAEND
-	 * IRQ at the end of the entire transfer because
-	 * MCI_DATABLOCKEND is broken.
+	 * On ARM variants in PIO mode, MCI_DATABLOCKEND is always sent first,
+	 * and we increase the transfered number of bytes for that IRQ. Repeat
+	 * for the number of blocks in the transfer. Then MCI_DATAEND follows
+	 * and we conclude the transaction.
 	 *
-	 * In the U300, the IRQs can arrive out-of-order,
-	 * e.g. MCI_DATABLOCKEND sometimes arrives after MCI_DATAEND,
-	 * so for this case we use the flags "blockend" and
-	 * "dataend" to make sure both IRQs have arrived before
-	 * concluding the transaction. (This does not apply
-	 * to the Ux500 which doesn't fire MCI_DATABLOCKEND
-	 * at all.) In DMA mode it suffers from the same problem
-	 * as the Ux500.
+	 * On the U300 and Ux500 a few to many MCI_DATABLOCKEND interrupts
+	 * are usually missing, so the data counter is not properly increased.
+	 * This is likely because new block arrive while the IRQ is being
+	 * processed without the transfers being held back, and ACK:in the
+	 * interrupt will only clear the very last block and intermediate
+	 * blockend interrupts get lost. So we simply mask of the blockend
+	 * interrupt on these and only use the dataend interrupt.
 	 */
 	if (status & MCI_DATABLOCKEND) {
 		/*
@@ -359,22 +347,41 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		 */
 		if (!variant->broken_blockend)
 			host->data_xfered += data->blksz;
-		host->blockend = true;
+		if (host->data_xfered == data->blksz * data->blocks)
+			host->last_blockend = true;
 	}
 
-	if (status & MCI_DATAEND)
+	if (status & MCI_DATAEND) {
+		if (!host->last_blockend && !variant->broken_blockend &&
+		    !data->error) {
+			/*
+			 * This typically occur on hardware with broken
+			 * blockend reporting, which will fire less blockend
+			 * IRQs than would be expected. Print an error and
+			 * repair the situation, but the hardware should
+			 * really be flagged as broken so this IRQ is not used
+			 * at all.
+			 */
+			dev_err(mmc_dev(host->mmc),
+				"missing %d block interrupts!\n",
+				(data->blksz * data->blocks - host->data_xfered) / data->blksz);
+			host->data_xfered = data->blksz * data->blocks;
+			host->last_blockend = true;
+		}
 		host->dataend = true;
+	}
 
 	/*
 	 * On variants with broken blockend we shall only wait for dataend,
 	 * on others we must sync with the blockend signal since they can
 	 * appear out-of-order.
 	 */
-	if (host->dataend && (host->blockend || variant->broken_blockend)) {
+	if (host->dataend &&
+	    (host->last_blockend || variant->broken_blockend)) {
 		mmci_stop_data(host);
 
 		/* Reset these flags */
-		host->blockend = false;
+		host->last_blockend = false;
 		host->dataend = false;
 
 		/*
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 47eb7b4..7ac8c4d 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -177,7 +177,7 @@ struct mmci_host {
 	struct timer_list	timer;
 	unsigned int		oldstat;
 
-	bool			blockend;
+	bool			last_blockend;
 	bool			dataend;
 
 	/* pio stuff */
-- 
1.7.3.2
