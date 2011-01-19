From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 19 Jan 2011 22:26:26 +0100
Subject: [PATCH 1/3] mmci: move blockend IRQ masking to data function
Message-ID: <1295472386-13671-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@stericsson.com>

The flag define MCI_IRQENABLE containing the blockend IRQ mask
bit was used in the resume() function, overriding the decision
whether to mask it off taken in probe(). Remove the bit
altogether and decide in mmci_start_data() whether to use it
or not.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |   26 +++++++++++++-------------
 drivers/mmc/host/mmci.h |    2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 0b4a5bf..24ff586 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -199,7 +199,7 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
 static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 {
 	struct variant_data *variant = host->variant;
-	unsigned int datactrl, timeout, irqmask;
+	unsigned int datactrl, timeout, irqmask0, irqmask1;
 	unsigned long long clks;
 	void __iomem *base;
 	int blksz_bits;
@@ -230,20 +230,20 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
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
@@ -252,8 +252,14 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
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
@@ -770,7 +776,6 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	struct variant_data *variant = id->data;
 	struct mmci_host *host;
 	struct mmc_host *mmc;
-	unsigned int mask;
 	int ret;
 
 	/* must have platform data */
@@ -951,12 +956,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
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
index df06f01..47eb7b4 100644
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
-- 
1.7.3.2
