From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 19 Oct 2010 12:22:25 +0200
Subject: [PATCH 1/3] mmci: work with only one irq
Message-ID: <1287483745-28585-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@stericsson.com>

The DBx500 variants have only one IRQ line hooked up.  Allow these (and
any other implementations which choose to use only one irq) to work by
directing the PIO interrupts also to the first IRQ line.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
This is an authorized respin of Rabins patch, it will now just
handle the single-IRQ case without the fixups relating to how
the DATAEND and BLOCKEND flags were being treated in the ux500
hardware.

The latter fixes have been folded into a follow-up patch that adds
two bug flags for the way DATAEND and BLOCKEND is treated.
---
 drivers/mmc/host/mmci.c |   50 ++++++++++++++++++++++++++++++++++++++--------
 drivers/mmc/host/mmci.h |    6 +++++
 2 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 87b4fc6..ed700a5 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -129,10 +129,26 @@ mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 	spin_lock(&host->lock);
 }
 
+static void mmci_set_mask1(struct mmci_host *host, unsigned int mask)
+{
+	void __iomem *base = host->base;
+
+	if (host->singleirq) {
+		unsigned int mask0 = readl(base + MMCIMASK0);
+
+		mask0 &= ~MCI_IRQ1MASK;
+		mask0 |= mask;
+
+		writel(mask0, base + MMCIMASK0);
+	}
+
+	writel(mask, base + MMCIMASK1);
+}
+
 static void mmci_stop_data(struct mmci_host *host)
 {
 	writel(0, host->base + MMCIDATACTRL);
-	writel(0, host->base + MMCIMASK1);
+	mmci_set_mask1(host, 0);
 	host->data = NULL;
 }
 
@@ -198,7 +214,7 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 
 	writel(datactrl, base + MMCIDATACTRL);
 	writel(readl(base + MMCIMASK0) & ~MCI_DATAENDMASK, base + MMCIMASK0);
-	writel(irqmask, base + MMCIMASK1);
+	mmci_set_mask1(host, irqmask);
 }
 
 static void
@@ -437,7 +453,7 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 	 * "any data available" mode.
 	 */
 	if (status & MCI_RXACTIVE && host->size < variant->fifosize)
-		writel(MCI_RXDATAAVLBLMASK, base + MMCIMASK1);
+		mmci_set_mask1(host, MCI_RXDATAAVLBLMASK);
 
 	/*
 	 * If we run out of data, disable the data IRQs; this
@@ -446,7 +462,7 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 	 * stops us racing with our data end IRQ.
 	 */
 	if (host->size == 0) {
-		writel(0, base + MMCIMASK1);
+		mmci_set_mask1(host, 0);
 		writel(readl(base + MMCIMASK0) | MCI_DATAENDMASK, base + MMCIMASK0);
 	}
 
@@ -469,6 +485,14 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 		struct mmc_data *data;
 
 		status = readl(host->base + MMCISTATUS);
+
+		if (host->singleirq) {
+			if (status & readl(host->base + MMCIMASK1))
+				mmci_pio_irq(irq, dev_id);
+
+			status &= ~MCI_IRQ1MASK;
+		}
+
 		status &= readl(host->base + MMCIMASK0);
 		writel(status, host->base + MMCICLEAR);
 
@@ -635,6 +659,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	struct variant_data *variant = id->data;
 	struct mmci_host *host;
 	struct mmc_host *mmc;
+	unsigned int mask;
 	int ret;
 
 	/* must have platform data */
@@ -806,11 +831,17 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	if (ret)
 		goto unmap;
 
-	ret = request_irq(dev->irq[1], mmci_pio_irq, IRQF_SHARED, DRIVER_NAME " (pio)", host);
-	if (ret)
-		goto irq0_free;
+	if (dev->irq[1] == NO_IRQ)
+		host->singleirq = true;
+	else {
+		ret = request_irq(dev->irq[1], mmci_pio_irq, IRQF_SHARED,
+				  DRIVER_NAME " (pio)", host);
+		if (ret)
+			goto irq0_free;
+	}
 
-	writel(MCI_IRQENABLE, host->base + MMCIMASK0);
+	mask = MCI_IRQENABLE;
+	writel(mask, host->base + MMCIMASK0);
 
 	amba_set_drvdata(dev, mmc);
 
@@ -864,7 +895,8 @@ static int __devexit mmci_remove(struct amba_device *dev)
 		writel(0, host->base + MMCIDATACTRL);
 
 		free_irq(dev->irq[0], host);
-		free_irq(dev->irq[1], host);
+		if (!host->singleirq)
+			free_irq(dev->irq[1], host);
 
 		if (host->gpio_wp != -ENOSYS)
 			gpio_free(host->gpio_wp);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 4ae887f..b4e48bd 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -139,6 +139,11 @@
 	MCI_DATATIMEOUTMASK|MCI_TXUNDERRUNMASK|MCI_RXOVERRUNMASK|	\
 	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_DATABLOCKENDMASK)
 
+/* These interrupts are directed to IRQ1 when two IRQ lines are available */
+#define MCI_IRQ1MASK \
+	(MCI_RXFIFOHALFFULLMASK | MCI_RXDATAAVLBLMASK | \
+	 MCI_TXFIFOHALFEMPTYMASK)
+
 #define NR_SG		16
 
 struct clk;
@@ -154,6 +159,7 @@ struct mmci_host {
 	int			gpio_cd;
 	int			gpio_wp;
 	int			gpio_cd_irq;
+	bool			singleirq;
 
 	unsigned int		data_xfered;
 
-- 
1.7.2.3
