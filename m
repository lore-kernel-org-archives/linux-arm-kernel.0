From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:44:16 +0000
Subject: [PATCH 42/48] ARM: PL08x: implement unmapping of memcpy buffers
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt8S-0003S8-Jq@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA engine API requires DMA engine implementations to unmap buffers
passed into the non-slave DMA methods unless the relevant completion
flag is set.  We aren't doing this, so implement this facility.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   52 ++++++++++++++++++++++++++++++++++-----------
 1 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 00058e3..fb469de 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1527,13 +1527,33 @@ static void pl08x_ensure_on(struct pl08x_driver_data *pl08x)
 	writel(val, pl08x->base + PL080_CONFIG);
 }
 
+static void pl08x_unmap_buffers(struct pl08x_txd *txd)
+{
+	struct device *dev = txd->tx.chan->device->dev;
+
+	if (!(txd->tx.flags & DMA_COMPL_SKIP_SRC_UNMAP)) {
+		if (txd->tx.flags & DMA_COMPL_SRC_UNMAP_SINGLE)
+			dma_unmap_single(dev, txd->src_addr, txd->len,
+				DMA_TO_DEVICE);
+		else
+			dma_unmap_page(dev, txd->src_addr, txd->len,
+				DMA_TO_DEVICE);
+	}
+	if (!(txd->tx.flags & DMA_COMPL_SKIP_DEST_UNMAP)) {
+		if (txd->tx.flags & DMA_COMPL_DEST_UNMAP_SINGLE)
+			dma_unmap_single(dev, txd->dst_addr, txd->len,
+				DMA_FROM_DEVICE);
+		else
+			dma_unmap_page(dev, txd->dst_addr, txd->len,
+				DMA_FROM_DEVICE);
+	}
+}
+
 static void pl08x_tasklet(unsigned long data)
 {
 	struct pl08x_dma_chan *plchan = (struct pl08x_dma_chan *) data;
 	struct pl08x_driver_data *pl08x = plchan->host;
 	struct pl08x_txd *txd;
-	dma_async_tx_callback callback = NULL;
-	void *callback_param = NULL;
 	unsigned long flags;
 
 	spin_lock_irqsave(&plchan->lock, flags);
@@ -1542,18 +1562,10 @@ static void pl08x_tasklet(unsigned long data)
 	plchan->at = NULL;
 
 	if (txd) {
-		callback = txd->tx.callback;
-		callback_param = txd->tx.callback_param;
-
 		/*
 		 * Update last completed
 		 */
 		plchan->lc = txd->tx.cookie;
-
-		/*
-		 * Free the descriptor
-		 */
-		pl08x_free_txd(pl08x, txd);
 	}
 	/*
 	 * If a new descriptor is queued, set it up
@@ -1605,9 +1617,23 @@ static void pl08x_tasklet(unsigned long data)
 
 	spin_unlock_irqrestore(&plchan->lock, flags);
 
-	/* Callback to signal completion */
-	if (callback)
-		callback(callback_param);
+	if (txd) {
+		dma_async_tx_callback callback = txd->tx.callback;
+		void *callback_param = txd->tx.callback_param;
+
+		/* Don't try to unmap buffers on slave channels */
+		if (!plchan->slave)
+			pl08x_unmap_buffers(txd);
+
+		/* Free the descriptor */
+		spin_lock_irqsave(&plchan->lock, flags);
+		pl08x_free_txd(pl08x, txd);
+		spin_unlock_irqrestore(&plchan->lock, flags);
+
+		/* Callback to signal completion */
+		if (callback)
+			callback(callback_param);
+	}
 }
 
 static irqreturn_t pl08x_irq(int irq, void *dev)
-- 
1.6.2.5
