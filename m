From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 17 Jan 2011 15:37:51 +0100
Subject: [PATCH] mmci: fixup broken_blockend variant patch v2
Message-ID: <1295275071-13146-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@stericsson.com>

host->last_blockend flag is now set only for the last
MCI_DATABLOCKEND, the previous code would just react to
any blockend, which was buggy. Consolidate Ux500 and U300
bug flags to a single one and use only the MCI_DATAEND irq
on U300 as well, it turns out it was broken just like the
Ux500.

Also make sure the MCI_DATABLOCKENDMASK is set only when
needed, instead of being set always and then masked off.

Tested successfully on Ux500, U300 and ARM RealView
PB1176.

Cc: Sebastian Rasmussen <sebastian.rasmussen@stericsson.com>
Cc: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
[Tweaking and adding err message]
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
v2: also updated the comment.
---
 drivers/mmc/host/mmci.c |   93 +++++++++++++++++++++++++----------------------
 drivers/mmc/host/mmci.h |    4 +-
 2 files changed, 52 insertions(+), 45 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 0b4a5bf..7e0d38c 100644
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
 
@@ -199,7 +196,7 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
 static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 {
 	struct variant_data *variant = host->variant;
-	unsigned int datactrl, timeout, irqmask;
+	unsigned int datactrl, timeout, irqmask0, irqmask1;
 	unsigned long long clks;
 	void __iomem *base;
 	int blksz_bits;
@@ -210,7 +207,7 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	host->data = data;
 	host->size = data->blksz * data->blocks;
 	host->data_xfered = 0;
-	host->blockend = false;
+	host->last_blockend = false;
 	host->dataend = false;
 
 	mmci_init_sg(host, data);
@@ -230,20 +227,20 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	datactrl = MCI_DPSM_ENABLE | blksz_bits << 4;
 	if (data->flags & MMC_DATA_READ) {
 		datactrl |= MCI_DPSM_DIRECTION;
-		irqmask = MCI_RXFIFOHALFFULLMASK;
+		irqmask1 = MCI_RXFIFOHALFFULLMASK;
 
 		/*
 		 * If we have less than a FIFOSIZE of bytes to transfer,
 		 * trigger a PIO interrupt as soon as any data is available.
 		 */
 		if (host->size < variant->fifosize)
-			irqmask |= MCI_RXDATAAVLBLMASK;
+			irqmask1 |= MCI_RXDATAAVLBLMASK;
 	} else {
 		/*
 		 * We don't actually need to include "FIFO empty" here
 		 * since its implicit in "FIFO half empty".
 		 */
-		irqmask = MCI_TXFIFOHALFEMPTYMASK;
+		irqmask1 = MCI_TXFIFOHALFEMPTYMASK;
 	}
 
 	/* The ST Micro variants has a special bit to enable SDIO */
@@ -252,8 +249,14 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 			datactrl |= MCI_ST_DPSM_SDIOEN;
 
 	writel(datactrl, base + MMCIDATACTRL);
-	writel(readl(base + MMCIMASK0) & ~MCI_DATAENDMASK, base + MMCIMASK0);
-	mmci_set_mask1(host, irqmask);
+	irqmask0 = readl(base + MMCIMASK0);
+	if (variant->broken_blockend)
+		irqmask0 &= ~MCI_DATABLOCKENDMASK;
+	else
+		irqmask0 |= MCI_DATABLOCKENDMASK;
+	irqmask0 &= ~MCI_DATAENDMASK;
+	writel(irqmask0, base + MMCIMASK0);
+	mmci_set_mask1(host, irqmask1);
 }
 
 static void
@@ -301,7 +304,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 			data->error = -EIO;
 
 		/* Force-complete the transaction */
-		host->blockend = true;
+		host->last_blockend = true;
 		host->dataend = true;
 
 		/*
@@ -322,27 +325,18 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 	}
 
 	/*
-	 * On ARM variants in PIO mode, MCI_DATABLOCKEND
-	 * is always sent first, and we increase the
-	 * transfered number of bytes for that IRQ. Then
-	 * MCI_DATAEND follows and we conclude the transaction.
+	 * On ARM variants in PIO mode, MCI_DATABLOCKEND is always sent first,
+	 * and we increase the transfered number of bytes for that IRQ. Repeat
+	 * for the number of blocks in the transfer. Then MCI_DATAEND follows
+	 * and we conclude the transaction.
 	 *
-	 * On the Ux500 single-IRQ variant MCI_DATABLOCKEND
-	 * doesn't seem to immediately clear from the status,
-	 * so we can't use it keep count when only one irq is
-	 * used because the irq will hit for other reasons, and
-	 * then the flag is still up. So we use the MCI_DATAEND
-	 * IRQ at the end of the entire transfer because
-	 * MCI_DATABLOCKEND is broken.
-	 *
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
@@ -353,22 +347,41 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
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
@@ -770,7 +783,6 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	struct variant_data *variant = id->data;
 	struct mmci_host *host;
 	struct mmc_host *mmc;
-	unsigned int mask;
 	int ret;
 
 	/* must have platform data */
@@ -951,12 +963,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 			goto irq0_free;
 	}
 
-	mask = MCI_IRQENABLE;
-	/* Don't use the datablockend flag if it's broken */
-	if (variant->broken_blockend)
-		mask &= ~MCI_DATABLOCKEND;
-
-	writel(mask, host->base + MMCIMASK0);
+	writel(MCI_IRQENABLE, host->base + MMCIMASK0);
 
 	amba_set_drvdata(dev, mmc);
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index df06f01..7ac8c4d 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -137,7 +137,7 @@
 #define MCI_IRQENABLE	\
 	(MCI_CMDCRCFAILMASK|MCI_DATACRCFAILMASK|MCI_CMDTIMEOUTMASK|	\
 	MCI_DATATIMEOUTMASK|MCI_TXUNDERRUNMASK|MCI_RXOVERRUNMASK|	\
-	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_DATABLOCKENDMASK)
+	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK)
 
 /* These interrupts are directed to IRQ1 when two IRQ lines are available */
 #define MCI_IRQ1MASK \
@@ -177,7 +177,7 @@ struct mmci_host {
 	struct timer_list	timer;
 	unsigned int		oldstat;
 
-	bool			blockend;
+	bool			last_blockend;
 	bool			dataend;
 
 	/* pio stuff */
-- 
1.7.3.2
