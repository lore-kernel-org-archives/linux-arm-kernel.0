From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 9 Aug 2011 16:35:23 +0530
Subject: [PATCH 6/6] spi/spi-pl022: Request/free DMA channels as and when
	required.
In-Reply-To: <cover.1312887860.git.viresh.kumar@st.com>
References: <cover.1312887860.git.viresh.kumar@st.com>
Message-ID: <68a2f54a8c2cc542278f3fe6678c555716b8f4d9.1312887860.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we request DMA channels at probe time and free them at remove. They
are always occupied, irrespective of their usage.

They must be allocated when they are required and must be freed after we are
done with transfers. So that they can be used by other users.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/spi/spi-pl022.c |   98 +++++++++++++++++++++++++++++++++-------------
 1 files changed, 70 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index e2333e7..3653f00 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -389,6 +389,7 @@ struct pl022 {
 	struct sg_table			sgt_rx;
 	struct sg_table			sgt_tx;
 	char				*dummypage;
+	dma_cap_mask_t			mask;
 #endif
 };
 
@@ -1093,16 +1094,33 @@ err_alloc_rx_sg:
 
 static int __init pl022_dma_probe(struct pl022 *pl022)
 {
-	dma_cap_mask_t mask;
+	/* set dma mask */
+	dma_cap_zero(pl022->mask);
+	dma_cap_set(DMA_SLAVE, pl022->mask);
 
-	/* Try to acquire a generic DMA engine slave channel */
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
+	pl022->dummypage = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!pl022->dummypage) {
+		dev_err(&pl022->adev->dev,
+			"Failed to work in dma mode, work without dma!\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int pl022_alloc_dmachan(struct pl022 *pl022)
+{
 	/*
-	 * We need both RX and TX channels to do DMA, else do none
-	 * of them.
+	 * Both channels should be allocated or not allocated. It is wrong if
+	 * only one allocated
 	 */
-	pl022->dma_rx_channel = dma_request_channel(mask,
+	if (pl022->dma_rx_channel && pl022->dma_tx_channel)
+		return 0;
+
+	BUG_ON(pl022->dma_rx_channel || pl022->dma_tx_channel);
+
+	/* We need both RX and TX channels to do DMA, else do none of them. */
+	pl022->dma_rx_channel = dma_request_channel(pl022->mask,
 					    pl022->master_info->dma_filter,
 					    pl022->master_info->dma_rx_param);
 	if (!pl022->dma_rx_channel) {
@@ -1110,7 +1128,7 @@ static int __init pl022_dma_probe(struct pl022 *pl022)
 		goto err_no_rxchan;
 	}
 
-	pl022->dma_tx_channel = dma_request_channel(mask,
+	pl022->dma_tx_channel = dma_request_channel(pl022->mask,
 					    pl022->master_info->dma_filter,
 					    pl022->master_info->dma_tx_param);
 	if (!pl022->dma_tx_channel) {
@@ -1118,20 +1136,12 @@ static int __init pl022_dma_probe(struct pl022 *pl022)
 		goto err_no_txchan;
 	}
 
-	pl022->dummypage = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!pl022->dummypage) {
-		dev_dbg(&pl022->adev->dev, "no DMA dummypage!\n");
-		goto err_no_dummypage;
-	}
-
-	dev_info(&pl022->adev->dev, "setup for DMA on RX %s, TX %s\n",
+	dev_dbg(&pl022->adev->dev, "setup for DMA on RX %s, TX %s\n",
 		 dma_chan_name(pl022->dma_rx_channel),
 		 dma_chan_name(pl022->dma_tx_channel));
 
 	return 0;
 
-err_no_dummypage:
-	dma_release_channel(pl022->dma_tx_channel);
 err_no_txchan:
 	dma_release_channel(pl022->dma_rx_channel);
 	pl022->dma_rx_channel = NULL;
@@ -1143,22 +1153,30 @@ err_no_rxchan:
 
 static void terminate_dma(struct pl022 *pl022)
 {
-	struct dma_chan *rxchan = pl022->dma_rx_channel;
-	struct dma_chan *txchan = pl022->dma_tx_channel;
-
-	dmaengine_terminate_all(rxchan);
-	dmaengine_terminate_all(txchan);
-	unmap_free_dma_scatter(pl022);
+	if (pl022->dma_rx_channel)
+		dmaengine_terminate_all(pl022->dma_rx_channel);
+	if (pl022->dma_tx_channel)
+		dmaengine_terminate_all(pl022->dma_tx_channel);
 }
 
-static void pl022_dma_remove(struct pl022 *pl022)
+static void pl022_free_dmachan(struct pl022 *pl022)
 {
-	if (pl022->busy)
-		terminate_dma(pl022);
 	if (pl022->dma_tx_channel)
 		dma_release_channel(pl022->dma_tx_channel);
 	if (pl022->dma_rx_channel)
 		dma_release_channel(pl022->dma_rx_channel);
+
+	pl022->dma_rx_channel = pl022->dma_tx_channel = NULL;
+}
+
+static void pl022_dma_remove(struct pl022 *pl022)
+{
+	if (pl022->busy) {
+		terminate_dma(pl022);
+		unmap_free_dma_scatter(pl022);
+	}
+
+	pl022_free_dmachan(pl022);
 	kfree(pl022->dummypage);
 }
 
@@ -1176,6 +1194,19 @@ static inline int pl022_dma_probe(struct pl022 *pl022)
 static inline void pl022_dma_remove(struct pl022 *pl022)
 {
 }
+
+static inline int pl022_alloc_dmachan(struct pl022 *pl022)
+{
+	return 0;
+}
+
+static inline void terminate_dma(struct pl022 *pl022)
+{
+}
+
+static void pl022_free_dmachan(struct pl022 *pl022)
+{
+}
 #endif
 
 /**
@@ -1401,16 +1432,20 @@ static void do_interrupt_dma_transfer(struct pl022 *pl022)
 	}
 	/* If we're using DMA, set up DMA here */
 	if (pl022->cur_chip->enable_dma) {
+		int status = pl022_alloc_dmachan(pl022);
+		if (status)
+			goto switch_to_irq_mode;
+
 		/* Configure DMA transfer */
 		if (configure_dma(pl022)) {
 			dev_dbg(&pl022->adev->dev,
 				"configuration of DMA failed, fall back to interrupt mode\n");
-			goto err_config_dma;
+			goto switch_to_irq_mode;
 		}
 		/* Disable interrupts in DMA mode, IRQ from DMA controller */
 		irqflags = DISABLE_ALL_INTERRUPTS;
 	}
-err_config_dma:
+switch_to_irq_mode:
 	/* Enable SSP, turn on interrupts */
 	writew((readw(SSP_CR1(pl022->virtbase)) | SSP_CR1_MASK_SSE),
 	       SSP_CR1(pl022->virtbase));
@@ -1513,7 +1548,14 @@ static void pump_messages(struct work_struct *work)
 	spin_lock_irqsave(&pl022->queue_lock, flags);
 	if (list_empty(&pl022->queue) || !pl022->running) {
 		pl022->busy = false;
+
 		spin_unlock_irqrestore(&pl022->queue_lock, flags);
+
+		/* free dma channels */
+		if (pl022->master_info->enable_dma) {
+			terminate_dma(pl022);
+			pl022_free_dmachan(pl022);
+		}
 		return;
 	}
 	/* Make sure we are not already running a message */
-- 
1.7.2.2
