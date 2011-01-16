From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sun, 16 Jan 2011 23:19:08 +0100
Subject: [PATCH] mmci: fixup broken_blockend variant patch
Message-ID: <1295216348-28720-1-git-send-email-linus.walleij@stericsson.com>
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
Disabling the bug flag on U300 now yeilds messages like
this:

root at ME:/mnt cp stallmannen.jpg /
[   17.605191] mmci-pl18x mmci: missing 1 block interrupts!
[   17.616936] mmci-pl18x mmci: missing 1 block interrupts!
[   17.641241] mmci-pl18x mmci: missing 1 block interrupts!
[   17.673321] mmci-pl18x mmci: missing 1 block interrupts!
[   17.680344] mmci-pl18x mmci: missing 1 block interrupts!
[   17.698537] mmci-pl18x mmci: missing 2 block interrupts!
[   17.711471] mmci-pl18x mmci: missing 1 block interrupts!
[   17.718411] mmci-pl18x mmci: missing 1 block interrupts!
[   17.736399] mmci-pl18x mmci: missing 1 block interrupts!
[   17.744132] mmci-pl18x mmci: missing 1 block interrupts!

And the code copes with it. (Data is intact.)

Disabling the flag in Ux500 also works, with the error
message shouting about almost every single block interrupt
missing.

If you want me to twist this around some other way, e.g.
just terminating the transfer if not enough blockend IRQs
appear, just tell me. It's a bit sad to do that though,
because on all HW where this fails, the bytes are actually
there, just not signalled for each block as should have
been done.
---
 drivers/mmc/host/mmci.c |   64 +++++++++++++++++++++++++++++-----------------
 drivers/mmc/host/mmci.h |    4 +-
 2 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 0b4a5bf..25d69f0 100644
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
@@ -337,7 +340,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 	 *
 	 * In the U300, the IRQs can arrive out-of-order,
 	 * e.g. MCI_DATABLOCKEND sometimes arrives after MCI_DATAEND,
-	 * so for this case we use the flags "blockend" and
+	 * so for this case we use the flags "last_blockend" and
 	 * "dataend" to make sure both IRQs have arrived before
 	 * concluding the transaction. (This does not apply
 	 * to the Ux500 which doesn't fire MCI_DATABLOCKEND
@@ -353,22 +356,41 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
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
@@ -770,7 +792,6 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	struct variant_data *variant = id->data;
 	struct mmci_host *host;
 	struct mmc_host *mmc;
-	unsigned int mask;
 	int ret;
 
 	/* must have platform data */
@@ -951,12 +972,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
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
