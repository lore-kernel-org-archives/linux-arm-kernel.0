From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 31 Jan 2011 22:39:40 +0100
Subject: [PATCH] mmci: make sure DMA transfers wait for FIFO drain
Message-ID: <1296509980-29987-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA mode also needs to wait until the FIFO is drained before
enabling the MCI_DATAEND IRQ.

Cc: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |   31 ++++++++++++++++++++++++++-----
 1 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 800b69c..bac15a3 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -334,6 +334,24 @@ static void mmci_dma_data_error(struct mmci_host *host)
 	dmaengine_terminate_all(host->dma_current);
 }
 
+static void mmci_dma_callback(void *arg)
+{
+	unsigned long flags;
+	struct mmci_host *host = arg;
+
+	dev_vdbg(mmc_dev(host->mmc), "DMA transfer done!\n");
+	spin_lock_irqsave(&host->lock, flags);
+	host->size = 0;
+	mmci_set_mask1(host, 0);
+	/*
+	 * This will make sure the DATAEND IRQ trigger after the DMA is
+	 * finished and not while we're still reading/writing the FIFO
+	 */
+	writel(readl(host->base + MMCIMASK0) | MCI_DATAENDMASK,
+	       host->base + MMCIMASK0);
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
 static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 {
 	struct variant_data *variant = host->variant;
@@ -373,9 +391,12 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 
 	dmaengine_slave_config(chan, &conf);
 	desc = device->device_prep_slave_sg(chan, data->sg, nr_sg,
-					    conf.direction, DMA_CTRL_ACK);
+					    conf.direction,
+					    DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc)
 		goto unmap_exit;
+	desc->callback = mmci_dma_callback;
+	desc->callback_param = host;
 
 	/* Okay, go for it. */
 	host->dma_current = chan;
@@ -393,11 +414,11 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	writel(datactrl, host->base + MMCIDATACTRL);
 
 	/*
-	 * Let the MMCI say when the data is ended and it's time
-	 * to fire next DMA request. When that happens, MMCI will
-	 * call mmci_data_end()
+	 * Mask off the MCI_DATAEND IRQ until the DMA has completed,
+	 * it will then be enabled by the callback so that the transfer
+	 * can complete through the interrupt handler.
 	 */
-	writel(readl(host->base + MMCIMASK0) | MCI_DATAENDMASK,
+	writel(readl(host->base + MMCIMASK0) & ~MCI_DATAENDMASK,
 	       host->base + MMCIMASK0);
 	return 0;
 
-- 
1.7.3.2
