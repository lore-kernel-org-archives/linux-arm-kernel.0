From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Mon, 11 Oct 2010 05:36:41 +0530
Subject: [PATCHv2] mmci: work with only one irq
In-Reply-To: <1277198267-10860-12-git-send-email-rabin.vincent@stericsson.com>
References: <1277198267-10860-12-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1286755601-25664-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DBx500 variants have only one IRQ line hooked up.  Allow these (and
any other implementations which choose to use only one irq) to work by
directing the PIO interrupts also to the first IRQ line.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
v2: don't depend on variant, as suggested by Russell in the patch tracker

 drivers/mmc/host/mmci.c |   62 ++++++++++++++++++++++++++++++++++++++++-------
 drivers/mmc/host/mmci.h |    6 ++++
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 87b4fc6..8255333 100644
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
@@ -276,6 +292,10 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 	if (status & MCI_DATAEND) {
 		mmci_stop_data(host);
 
+		/* MCI_DATABLOCKEND not used with single irq */
+		if (host->singleirq && !data->error)
+			host->data_xfered = data->blksz * data->blocks;
+
 		if (!data->stop) {
 			mmci_request_end(host, data->mrq);
 		} else {
@@ -437,7 +457,7 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 	 * "any data available" mode.
 	 */
 	if (status & MCI_RXACTIVE && host->size < variant->fifosize)
-		writel(MCI_RXDATAAVLBLMASK, base + MMCIMASK1);
+		mmci_set_mask1(host, MCI_RXDATAAVLBLMASK);
 
 	/*
 	 * If we run out of data, disable the data IRQs; this
@@ -446,7 +466,7 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 	 * stops us racing with our data end IRQ.
 	 */
 	if (host->size == 0) {
-		writel(0, base + MMCIMASK1);
+		mmci_set_mask1(host, 0);
 		writel(readl(base + MMCIMASK0) | MCI_DATAENDMASK, base + MMCIMASK0);
 	}
 
@@ -469,6 +489,14 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
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
 
@@ -635,6 +663,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	struct variant_data *variant = id->data;
 	struct mmci_host *host;
 	struct mmc_host *mmc;
+	unsigned int mask;
 	int ret;
 
 	/* must have platform data */
@@ -806,11 +835,25 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
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
+
+	/*
+	 * MCI_DATABLOCKEND doesn't seem to immediately clear from the status,
+	 * so we can't use it keep count when only one irq is used because the
+	 * irq will hit for other reasons.
+	 */
+	mask = MCI_IRQENABLE;
+	if (host->singleirq)
+		mask &= ~MCI_DATABLOCKEND;
 
-	writel(MCI_IRQENABLE, host->base + MMCIMASK0);
+	writel(mask, host->base + MMCIMASK0);
 
 	amba_set_drvdata(dev, mmc);
 
@@ -864,7 +907,8 @@ static int __devexit mmci_remove(struct amba_device *dev)
 		writel(0, host->base + MMCIDATACTRL);
 
 		free_irq(dev->irq[0], host);
-		free_irq(dev->irq[1], host);
+		if (!host->singleirq)
+			free_irq(dev->irq[1], host);
 
 		if (host->gpio_wp != -ENOSYS)
 			gpio_free(host->gpio_wp);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index c7d373c..b4fdd65 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -133,6 +133,11 @@
 	MCI_DATATIMEOUTMASK|MCI_TXUNDERRUNMASK|MCI_RXOVERRUNMASK|	\
 	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_DATABLOCKENDMASK)
 
+/* These interrupts are directed to IRQ1 when two IRQ lines are available */
+#define MCI_IRQ1MASK \
+	(MCI_RXFIFOHALFFULLMASK | MCI_RXDATAAVLBLMASK | \
+	 MCI_TXFIFOHALFEMPTYMASK)
+
 #define NR_SG		16
 
 struct clk;
@@ -148,6 +153,7 @@ struct mmci_host {
 	int			gpio_cd;
 	int			gpio_wp;
 	int			gpio_cd_irq;
+	bool			singleirq;
 
 	unsigned int		data_xfered;
 
-- 
1.7.1
