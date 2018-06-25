From: andrea.merello@gmail.com (Andrea Merello)
Date: Mon, 25 Jun 2018 11:27:22 +0200
Subject: [PATCH v3 3/5] dmaengine: xilinx_dma: program hardware supported
 buffer length
In-Reply-To: <20180625092724.22164-1-andrea.merello@gmail.com>
References: <20180625092724.22164-1-andrea.merello@gmail.com>
Message-ID: <20180625092724.22164-3-andrea.merello@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>

AXI-DMA IP supports configurable (c_sg_length_width) buffer length
register width, hence read buffer length (xlnx,sg-length-width) DT
property and ensure that driver doesn't program buffer length
exceeding the supported limit. For VDMA and CDMA there is no change.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com> [rebase, reword]
---
Changes in v2:
        - drop original patch and replace with the one in Xilinx tree
Changes in v3:
	- cc DT maintainers/ML
---
 drivers/dma/xilinx/xilinx_dma.c | 35 ++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 113d9bf1b6a1..7f0ab904b749 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -158,7 +158,8 @@
 #define XILINX_DMA_REG_BTT		0x28
 
 /* AXI DMA Specific Masks/Bit fields */
-#define XILINX_DMA_MAX_TRANS_LEN	GENMASK(22, 0)
+#define XILINX_DMA_MAX_TRANS_LEN_MIN	8
+#define XILINX_DMA_MAX_TRANS_LEN_MAX	23
 #define XILINX_DMA_CR_COALESCE_MAX	GENMASK(23, 16)
 #define XILINX_DMA_CR_CYCLIC_BD_EN_MASK	BIT(4)
 #define XILINX_DMA_CR_COALESCE_SHIFT	16
@@ -418,6 +419,7 @@ struct xilinx_dma_config {
  * @rxs_clk: DMA s2mm stream clock
  * @nr_channels: Number of channels DMA device supports
  * @chan_id: DMA channel identifier
+ * @max_buffer_len: Max buffer length
  */
 struct xilinx_dma_device {
 	void __iomem *regs;
@@ -437,6 +439,7 @@ struct xilinx_dma_device {
 	struct clk *rxs_clk;
 	u32 nr_channels;
 	u32 chan_id;
+	u32 max_buffer_len;
 };
 
 /* Macros */
@@ -985,7 +988,7 @@ static enum dma_status xilinx_dma_tx_status(struct dma_chan *dchan,
 			list_for_each_entry(segment, &desc->segments, node) {
 				hw = &segment->hw;
 				residue += (hw->control - hw->status) &
-					   XILINX_DMA_MAX_TRANS_LEN;
+					   chan->xdev->max_buffer_len;
 			}
 		}
 		spin_unlock_irqrestore(&chan->lock, flags);
@@ -1237,7 +1240,7 @@ static void xilinx_cdma_start_transfer(struct xilinx_dma_chan *chan)
 
 		/* Start the transfer */
 		dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
-				hw->control & XILINX_DMA_MAX_TRANS_LEN);
+				hw->control & chan->xdev->max_buffer_len);
 	}
 
 	list_splice_tail_init(&chan->pending_list, &chan->active_list);
@@ -1340,7 +1343,7 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 
 		/* Start the transfer */
 		dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
-			       hw->control & XILINX_DMA_MAX_TRANS_LEN);
+			       hw->control & chan->xdev->max_buffer_len);
 	}
 
 	list_splice_tail_init(&chan->pending_list, &chan->active_list);
@@ -1701,7 +1704,7 @@ xilinx_cdma_prep_memcpy(struct dma_chan *dchan, dma_addr_t dma_dst,
 	struct xilinx_cdma_tx_segment *segment;
 	struct xilinx_cdma_desc_hw *hw;
 
-	if (!len || len > XILINX_DMA_MAX_TRANS_LEN)
+	if (!len || len > chan->xdev->max_buffer_len)
 		return NULL;
 
 	desc = xilinx_dma_alloc_tx_descriptor(chan);
@@ -1792,7 +1795,7 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 			 * making sure it is less than the hw limit
 			 */
 			copy = min_t(size_t, sg_dma_len(sg) - sg_used,
-				     XILINX_DMA_MAX_TRANS_LEN);
+				     chan->xdev->max_buffer_len);
 
 			if ((copy + sg_used < sg_dma_len(sg)) &&
 			    chan->xdev->common.copy_align) {
@@ -1907,7 +1910,7 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 			 * making sure it is less than the hw limit
 			 */
 			copy = min_t(size_t, period_len - sg_used,
-				     XILINX_DMA_MAX_TRANS_LEN);
+				     chan->xdev->max_buffer_len);
 
 			if ((copy + sg_used < period_len) &&
 			    chan->xdev->common.copy_align) {
@@ -2590,7 +2593,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	struct xilinx_dma_device *xdev;
 	struct device_node *child, *np = pdev->dev.of_node;
 	struct resource *io;
-	u32 num_frames, addr_width;
+	u32 num_frames, addr_width, len_width;
 	int i, err;
 
 	/* Allocate and initialize the DMA engine structure */
@@ -2622,8 +2625,22 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
 	/* Retrieve the DMA engine properties from the device tree */
 	xdev->has_sg = of_property_read_bool(node, "xlnx,include-sg");
-	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA)
+	xdev->max_buffer_len = GENMASK(XILINX_DMA_MAX_TRANS_LEN_MAX - 1, 0);
+
+	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		xdev->mcdma = of_property_read_bool(node, "xlnx,mcdma");
+		if (!of_property_read_u32(node, "xlnx,sg-length-width",
+					  &len_width)) {
+			if (len_width < XILINX_DMA_MAX_TRANS_LEN_MIN ||
+			    len_width > XILINX_DMA_MAX_TRANS_LEN_MAX) {
+				dev_warn(xdev->dev,
+					 "invalid xlnx,sg-length-width property value using default width\n");
+			} else {
+				xdev->max_buffer_len = GENMASK(len_width - 1,
+							       0);
+			}
+		}
+	}
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
 		err = of_property_read_u32(node, "xlnx,num-fstores",
-- 
2.17.1
