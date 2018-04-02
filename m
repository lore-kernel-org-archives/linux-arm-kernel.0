From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Mon, 2 Apr 2018 16:09:02 +0530
Subject: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words to
 netdev dma client
In-Reply-To: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
Message-ID: <1522665546-10035-3-git-send-email-radheys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Read DT property to check if AXI DMA is connected to axithernet.
If connected pass AXI4-Stream control words to netdev dma client.
It is mandatory that netdev dma client reserve initial memory for
max supported control words in callback_param.

Signed-off-by: Radhey Shyam Pandey <radheys@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c |   35 +++++++++++++++++++++++++++--------
 1 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 27b5235..16fee30 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -418,6 +418,7 @@ struct xilinx_dma_config {
  * @rxs_clk: DMA s2mm stream clock
  * @nr_channels: Number of channels DMA device supports
  * @chan_id: DMA channel identifier
+ * @has_axieth_connected: AXI DMA connected to AXI ethernet
  */
 struct xilinx_dma_device {
 	void __iomem *regs;
@@ -437,6 +438,7 @@ struct xilinx_dma_device {
 	struct clk *rxs_clk;
 	u32 nr_channels;
 	u32 chan_id;
+	bool has_axieth_connected;
 };
 
 /* Macros */
@@ -809,7 +811,10 @@ static void xilinx_dma_chan_handle_cyclic(struct xilinx_dma_chan *chan,
 static void xilinx_dma_chan_desc_cleanup(struct xilinx_dma_chan *chan)
 {
 	struct xilinx_dma_tx_descriptor *desc, *next;
+	struct xilinx_axidma_tx_segment *seg;
+	struct xilinx_axidma_desc_hw *hw;
 	unsigned long flags;
+	u32 *app_w;
 
 	spin_lock_irqsave(&chan->lock, flags);
 
@@ -821,17 +826,28 @@ static void xilinx_dma_chan_desc_cleanup(struct xilinx_dma_chan *chan)
 			break;
 		}
 
-		/* Remove from the list of running transactions */
-		list_del(&desc->node);
-
 		/* Run the link descriptor callback function */
 		dmaengine_desc_get_callback(&desc->async_tx, &cb);
-		if (dmaengine_desc_callback_valid(&cb)) {
-			spin_unlock_irqrestore(&chan->lock, flags);
-			dmaengine_desc_callback_invoke(&cb, NULL);
-			spin_lock_irqsave(&chan->lock, flags);
+
+		if (chan->xdev->has_axieth_connected) {
+			seg = list_first_entry(&desc->segments,
+					struct xilinx_axidma_tx_segment, node);
+			if (cb.callback_param) {
+				app_w = (u32 *) cb.callback_param;
+				hw = &seg->hw;
+				*app_w = hw->status & XILINX_DMA_MAX_TRANS_LEN;
+				memcpy(app_w, hw->app, sizeof(u32) *
+					XILINX_DMA_NUM_APP_WORDS);
+			}
 		}
 
+		/* Remove from the list of running transactions */
+		list_del(&desc->node);
+
+		spin_unlock_irqrestore(&chan->lock, flags);
+		dmaengine_desc_callback_invoke(&cb, NULL);
+		spin_lock_irqsave(&chan->lock, flags);
+
 		/* Run any dependencies, then free the descriptor */
 		dma_run_dependencies(&desc->async_tx);
 		xilinx_dma_free_tx_descriptor(chan, desc);
@@ -2602,8 +2618,11 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
 	/* Retrieve the DMA engine properties from the device tree */
 	xdev->has_sg = of_property_read_bool(node, "xlnx,include-sg");
-	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA)
+	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		xdev->mcdma = of_property_read_bool(node, "xlnx,mcdma");
+		xdev->has_axieth_connected = of_property_read_bool(node,
+						"xlnx,axieth-connected");
+	}
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
 		err = of_property_read_u32(node, "xlnx,num-fstores",
-- 
1.7.1
