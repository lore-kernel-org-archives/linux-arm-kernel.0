From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Fri, 10 Jun 2016 14:42:32 +0530
Subject: [PATCH 2/4] dmaengine: vdma: Add support for mulit-channel dma mode
In-Reply-To: <1465549954-30220-1-git-send-email-appanad@xilinx.com>
References: <1465549954-30220-1-git-send-email-appanad@xilinx.com>
Message-ID: <1465549954-30220-3-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for AXI DMA multi-channel dma mode
Multichannel mode enables DMA to connect to multiple masters
And slaves on the streaming side.
In Multichannel mode AXI DMA supports 2D transfers.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
 drivers/dma/xilinx/xilinx_vdma.c |  242 ++++++++++++++++++++++++++++++++++----
 include/linux/dma/xilinx_dma.h   |   18 +++
 2 files changed, 237 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_vdma.c
index 20fe5ea..480b0ba 100644
--- a/drivers/dma/xilinx/xilinx_vdma.c
+++ b/drivers/dma/xilinx/xilinx_vdma.c
@@ -114,7 +114,7 @@
 #define XILINX_VDMA_REG_START_ADDRESS_64(n)	(0x000c + 8 * (n))
 
 /* HW specific definitions */
-#define XILINX_DMA_MAX_CHANS_PER_DEVICE	0x2
+#define XILINX_DMA_MAX_CHANS_PER_DEVICE	0x20
 
 #define XILINX_DMA_DMAXR_ALL_IRQ_MASK	\
 		(XILINX_DMA_DMASR_FRM_CNT_IRQ | \
@@ -165,6 +165,17 @@
 #define XILINX_DMA_COALESCE_MAX		255
 #define XILINX_DMA_NUM_APP_WORDS	5
 
+/* Multi-Channel DMA Descriptor offsets*/
+#define XILINX_DMA_MCRX_CDESC(x)	(0x40 + (x-1) * 0x20)
+#define XILINX_DMA_MCRX_TDESC(x)	(0x48 + (x-1) * 0x20)
+
+/* Multi-Channel DMA Masks/Shifts */
+#define XILINX_DMA_BD_HSIZE_MASK	GENMASK(15, 0)
+#define XILINX_DMA_BD_STRIDE_MASK	GENMASK(15, 0)
+#define XILINX_DMA_BD_VSIZE_MASK	GENMASK(31, 19)
+#define XILINX_DMA_BD_STRIDE_SHIFT	0
+#define XILINX_DMA_BD_VSIZE_SHIFT	19
+
 /* AXI CDMA Specific Registers/Offsets */
 #define XILINX_CDMA_REG_SRCADDR		0x18
 #define XILINX_CDMA_REG_DSTADDR		0x20
@@ -172,6 +183,13 @@
 /* AXI CDMA Specific Masks */
 #define XILINX_CDMA_CR_SGMODE          BIT(3)
 
+#define mm2s_mcdmatx_control(tdest, tid, tuser, axcache, aruser) \
+			     ((aruser << 28) | (axcache << 24) | \
+			     (tuser << 16) | (tid << 8) | (tdest))
+
+#define mm2s_mcdmarx_control(axcache, aruser) \
+			     ((aruser << 28) | (axcache << 24))
+
 /**
  * struct xilinx_vdma_desc_hw - Hardware Descriptor
  * @next_desc: Next Descriptor Pointer @0x00
@@ -210,8 +228,8 @@ struct xilinx_axidma_desc_hw {
 	u32 next_desc_msb;
 	u32 buf_addr;
 	u32 buf_addr_msb;
-	u32 pad1;
-	u32 pad2;
+	u32 mcdma_fields;
+	u32 vsize_stride;
 	u32 control;
 	u32 status;
 	u32 app[XILINX_DMA_NUM_APP_WORDS];
@@ -318,6 +336,7 @@ struct xilinx_dma_tx_descriptor {
  * @residue: Residue for AXI DMA
  * @seg_v: Statically allocated segments base
  * @cyclic_seg_v: Statically allocated segment base for cyclic transfers
+ * @mcdma_config: Device configuration info for MCDMA
  * @start_transfer: Differentiate b/w DMA IP's transfer
  */
 struct xilinx_dma_chan {
@@ -348,6 +367,7 @@ struct xilinx_dma_chan {
 	u32 residue;
 	struct xilinx_axidma_tx_segment *seg_v;
 	struct xilinx_axidma_tx_segment *cyclic_seg_v;
+	struct xilinx_mcdma_config mcdma_config;
 	void (*start_transfer)(struct xilinx_dma_chan *chan);
 };
 
@@ -365,6 +385,7 @@ struct xilinx_dma_config {
  * @common: DMA device structure
  * @chan: Driver specific DMA channel
  * @has_sg: Specifies whether Scatter-Gather is present or not
+ * @mcdma: Specifies whether Multi-Channel is present or not
  * @flush_on_fsync: Flush on frame sync
  * @ext_addr: Indicates 64 bit addressing is supported by dma device
  * @pdev: Platform device structure pointer
@@ -374,6 +395,8 @@ struct xilinx_dma_config {
  * @txs_clk: DMA mm2s stream clock
  * @rx_clk: DMA s2mm clock
  * @rxs_clk: DMA s2mm stream clock
+ * @nr_channels: Number of channels DMA device supports
+ * @chan_id: DMA channel identifier
  */
 struct xilinx_dma_device {
 	void __iomem *regs;
@@ -381,6 +404,7 @@ struct xilinx_dma_device {
 	struct dma_device common;
 	struct xilinx_dma_chan *chan[XILINX_DMA_MAX_CHANS_PER_DEVICE];
 	bool has_sg;
+	bool mcdma;
 	u32 flush_on_fsync;
 	bool ext_addr;
 	struct platform_device  *pdev;
@@ -390,6 +414,8 @@ struct xilinx_dma_device {
 	struct clk *txs_clk;
 	struct clk *rx_clk;
 	struct clk *rxs_clk;
+	u32 nr_channels;
+	u32 chan_id;
 };
 
 /* Macros */
@@ -1174,6 +1200,7 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 {
 	struct xilinx_dma_tx_descriptor *head_desc, *tail_desc;
 	struct xilinx_axidma_tx_segment *tail_segment, *old_head, *new_head;
+	struct xilinx_mcdma_config *config = &chan->mcdma_config;
 	u32 reg;
 
 	if (chan->err)
@@ -1196,18 +1223,20 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 	tail_segment = list_last_entry(&tail_desc->segments,
 				       struct xilinx_axidma_tx_segment, node);
 
-	old_head = list_first_entry(&head_desc->segments,
-				struct xilinx_axidma_tx_segment, node);
-	new_head = chan->seg_v;
-	/* Copy Buffer Descriptor fields. */
-	new_head->hw = old_head->hw;
+	if (chan->has_sg && !chan->xdev->mcdma) {
+		old_head = list_first_entry(&head_desc->segments,
+					struct xilinx_axidma_tx_segment, node);
+		new_head = chan->seg_v;
+		/* Copy Buffer Descriptor fields. */
+		new_head->hw = old_head->hw;
 
-	/* Swap and save new reserve */
-	list_replace_init(&old_head->node, &new_head->node);
-	chan->seg_v = old_head;
+		/* Swap and save new reserve */
+		list_replace_init(&old_head->node, &new_head->node);
+		chan->seg_v = old_head;
 
-	tail_segment->hw.next_desc = chan->seg_v->phys;
-	head_desc->async_tx.phys = new_head->phys;
+		tail_segment->hw.next_desc = chan->seg_v->phys;
+		head_desc->async_tx.phys = new_head->phys;
+	}
 
 	reg = dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
 
@@ -1218,23 +1247,53 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 	}
 
-	if (chan->has_sg)
+	if (chan->has_sg && !chan->xdev->mcdma)
 		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
 			     head_desc->async_tx.phys);
 
+	if (chan->has_sg && chan->xdev->mcdma) {
+		if (chan->direction == DMA_MEM_TO_DEV) {
+			dma_ctrl_write(chan, XILINX_DMA_REG_CURDESC,
+				       head_desc->async_tx.phys);
+		} else {
+			if (!config->tdest) {
+				dma_ctrl_write(chan, XILINX_DMA_REG_CURDESC,
+				       head_desc->async_tx.phys);
+			} else {
+				dma_ctrl_write(chan,
+					XILINX_DMA_MCRX_CDESC(config->tdest),
+				       head_desc->async_tx.phys);
+			}
+		}
+	}
+
 	xilinx_dma_start(chan);
 
 	if (chan->err)
 		return;
 
 	/* Start the transfer */
-	if (chan->has_sg) {
+	if (chan->has_sg && !chan->xdev->mcdma) {
 		if (chan->cyclic)
 			xilinx_write(chan, XILINX_DMA_REG_TAILDESC,
 				     chan->cyclic_seg_v->phys);
 		else
 			xilinx_write(chan, XILINX_DMA_REG_TAILDESC,
 				     tail_segment->phys);
+	} else if (chan->has_sg && chan->xdev->mcdma) {
+		if (chan->direction == DMA_MEM_TO_DEV) {
+			dma_ctrl_write(chan, XILINX_DMA_REG_TAILDESC,
+			       tail_segment->phys);
+		} else {
+			if (!config->tdest) {
+				dma_ctrl_write(chan, XILINX_DMA_REG_TAILDESC,
+					       tail_segment->phys);
+			} else {
+				dma_ctrl_write(chan,
+					XILINX_DMA_MCRX_TDESC(config->tdest),
+					tail_segment->phys);
+			}
+		}
 	} else {
 		struct xilinx_axidma_tx_segment *segment;
 		struct xilinx_axidma_desc_hw *hw;
@@ -1856,6 +1915,98 @@ error:
 }
 
 /**
+ * xilinx_dma_prep_interleaved - prepare a descriptor for a
+ *	DMA_SLAVE transaction
+ * @dchan: DMA channel
+ * @xt: Interleaved template pointer
+ * @flags: transfer ack flags
+ *
+ * Return: Async transaction descriptor on success and NULL on failure
+ */
+static struct dma_async_tx_descriptor *
+xilinx_dma_prep_interleaved(struct dma_chan *dchan,
+				 struct dma_interleaved_template *xt,
+				 unsigned long flags)
+{
+	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
+	struct xilinx_mcdma_config *config = &chan->mcdma_config;
+	struct xilinx_dma_tx_descriptor *desc;
+	struct xilinx_axidma_tx_segment *segment;
+	struct xilinx_axidma_desc_hw *hw;
+
+	if (!is_slave_direction(xt->dir))
+		return NULL;
+
+	if (!xt->numf || !xt->sgl[0].size)
+		return NULL;
+
+	if (xt->frame_size != 1)
+		return NULL;
+
+	/* Allocate a transaction descriptor. */
+	desc = xilinx_dma_alloc_tx_descriptor(chan);
+	if (!desc)
+		return NULL;
+
+	chan->direction = xt->dir;
+	dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
+	desc->async_tx.tx_submit = xilinx_dma_tx_submit;
+
+	/* Get a free segment */
+	segment = xilinx_axidma_alloc_tx_segment(chan);
+	if (!segment)
+		goto error;
+
+	hw = &segment->hw;
+
+	/* Fill in the descriptor */
+	if (xt->dir != DMA_MEM_TO_DEV) {
+		hw->buf_addr = xt->dst_start;
+		hw->mcdma_fields = mm2s_mcdmarx_control(config->ax_cache,
+							config->ax_user);
+	} else {
+		hw->buf_addr = xt->src_start;
+		hw->mcdma_fields = mm2s_mcdmatx_control(config->tdest,
+							config->tid,
+							config->tuser,
+							config->ax_cache,
+							config->ax_user);
+	}
+
+	hw->vsize_stride = (xt->numf << XILINX_DMA_BD_VSIZE_SHIFT) &
+			    XILINX_DMA_BD_VSIZE_MASK;
+	hw->vsize_stride |= (xt->sgl[0].icg + xt->sgl[0].size) &
+			    XILINX_DMA_BD_STRIDE_MASK;
+	hw->control = xt->sgl[0].size & XILINX_DMA_BD_HSIZE_MASK;
+
+	/*
+	 * Insert the segment into the descriptor segments
+	 * list.
+	 */
+	list_add_tail(&segment->node, &desc->segments);
+
+
+	segment = list_first_entry(&desc->segments,
+				   struct xilinx_axidma_tx_segment, node);
+	desc->async_tx.phys = segment->phys;
+
+	/* For the last DMA_MEM_TO_DEV transfer, set EOP */
+	if (xt->dir == DMA_MEM_TO_DEV) {
+		segment->hw.control |= XILINX_DMA_BD_SOP;
+		segment = list_last_entry(&desc->segments,
+					  struct xilinx_axidma_tx_segment,
+					  node);
+		segment->hw.control |= XILINX_DMA_BD_EOP;
+	}
+
+	return &desc->async_tx;
+
+error:
+	xilinx_dma_free_tx_descriptor(chan, desc);
+	return NULL;
+}
+
+/**
  * xilinx_dma_terminate_all - Halt the channel and free descriptors
  * @chan: Driver specific DMA Channel pointer
  */
@@ -1948,6 +2099,21 @@ int xilinx_vdma_channel_set_config(struct dma_chan *dchan,
 }
 EXPORT_SYMBOL(xilinx_vdma_channel_set_config);
 
+int xilinx_dma_channel_mcdma_set_config(struct dma_chan *dchan,
+					struct xilinx_mcdma_config *cfg)
+{
+	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
+
+	chan->mcdma_config.tdest = cfg->tdest;
+	chan->mcdma_config.tid = cfg->tid;
+	chan->mcdma_config.tuser = cfg->tuser;
+	chan->mcdma_config.ax_user = cfg->ax_user;
+	chan->mcdma_config.ax_cache = cfg->ax_cache;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xilinx_dma_channel_mcdma_set_config);
+
 /* -----------------------------------------------------------------------------
  * Probe and remove
  */
@@ -2170,7 +2336,7 @@ static void xdma_disable_allclks(struct xilinx_dma_device *xdev)
  * Return: '0' on success and failure value on error
  */
 static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
-				  struct device_node *node)
+				  struct device_node *node, int chan_id)
 {
 	struct xilinx_dma_chan *chan;
 	bool has_dre = false;
@@ -2214,7 +2380,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 
 	if (of_device_is_compatible(node, "xlnx,axi-vdma-mm2s-channel")) {
 		chan->direction = DMA_MEM_TO_DEV;
-		chan->id = 0;
+		chan->id = chan_id;
 
 		chan->ctrl_offset = XILINX_DMA_MM2S_CTRL_OFFSET;
 		if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
@@ -2227,7 +2393,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 	} else if (of_device_is_compatible(node,
 					    "xlnx,axi-vdma-s2mm-channel")) {
 		chan->direction = DMA_DEV_TO_MEM;
-		chan->id = 1;
+		chan->id = chan_id;
 
 		chan->ctrl_offset = XILINX_DMA_S2MM_CTRL_OFFSET;
 		if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
@@ -2282,6 +2448,32 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 }
 
 /**
+ * xilinx_dma_child_probe - Per child node probe
+ * It get number of dma-channels per child node from
+ * device-tree and initializes all the channels.
+ *
+ * @xdev: Driver specific device structure
+ * @node: Device node
+ *
+ * Return: 0 always.
+ */
+static int xilinx_dma_child_probe(struct xilinx_dma_device *xdev,
+				    struct device_node *node) {
+	int ret, i, nr_channels = 1;
+
+	ret = of_property_read_u32(node, "dma-channels", &nr_channels);
+	if ((ret < 0) && xdev->mcdma)
+		dev_warn(xdev->dev, "missing dma-channels property\n");
+
+	xdev->nr_channels += nr_channels;
+
+	for (i = 0; i < nr_channels; i++)
+		xilinx_dma_chan_probe(xdev, node, xdev->chan_id++);
+
+	return 0;
+}
+
+/**
  * of_dma_xilinx_xlate - Translation function
  * @dma_spec: Pointer to DMA specifier as found in the device tree
  * @ofdma: Pointer to DMA controller data
@@ -2294,7 +2486,7 @@ static struct dma_chan *of_dma_xilinx_xlate(struct of_phandle_args *dma_spec,
 	struct xilinx_dma_device *xdev = ofdma->of_dma_data;
 	int chan_id = dma_spec->args[0];
 
-	if (chan_id >= XILINX_DMA_MAX_CHANS_PER_DEVICE || !xdev->chan[chan_id])
+	if (chan_id >= xdev->nr_channels || !xdev->chan[chan_id])
 		return NULL;
 
 	return dma_get_slave_channel(&xdev->chan[chan_id]->common);
@@ -2370,6 +2562,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
 	/* Retrieve the DMA engine properties from the device tree */
 	xdev->has_sg = of_property_read_bool(node, "xlnx,include-sg");
+	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA)
+		xdev->mcdma = of_property_read_bool(node, "xlnx,mcdma");
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
 		err = of_property_read_u32(node, "xlnx,num-fstores",
@@ -2420,6 +2614,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		xdev->common.device_prep_slave_sg = xilinx_dma_prep_slave_sg;
 		xdev->common.device_prep_dma_cyclic =
 					  xilinx_dma_prep_dma_cyclic;
+		xdev->common.device_prep_interleaved_dma =
+					xilinx_dma_prep_interleaved;
 		/* Residue calculation is supported by only AXI DMA */
 		xdev->common.residue_granularity =
 					  DMA_RESIDUE_GRANULARITY_SEGMENT;
@@ -2435,13 +2631,13 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
 	/* Initialize the channels */
 	for_each_child_of_node(node, child) {
-		err = xilinx_dma_chan_probe(xdev, child);
+		err = xilinx_dma_child_probe(xdev, child);
 		if (err < 0)
 			goto disable_clks;
 	}
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
-		for (i = 0; i < XILINX_DMA_MAX_CHANS_PER_DEVICE; i++)
+		for (i = 0; i < xdev->nr_channels; i++)
 			if (xdev->chan[i])
 				xdev->chan[i]->num_frms = num_frames;
 	}
@@ -2464,7 +2660,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 disable_clks:
 	xdma_disable_allclks(xdev);
 error:
-	for (i = 0; i < XILINX_DMA_MAX_CHANS_PER_DEVICE; i++)
+	for (i = 0; i < xdev->nr_channels; i++)
 		if (xdev->chan[i])
 			xilinx_dma_chan_remove(xdev->chan[i]);
 
@@ -2486,7 +2682,7 @@ static int xilinx_dma_remove(struct platform_device *pdev)
 
 	dma_async_device_unregister(&xdev->common);
 
-	for (i = 0; i < XILINX_DMA_MAX_CHANS_PER_DEVICE; i++)
+	for (i = 0; i < xdev->nr_channels; i++)
 		if (xdev->chan[i])
 			xilinx_dma_chan_remove(xdev->chan[i]);
 
diff --git a/include/linux/dma/xilinx_dma.h b/include/linux/dma/xilinx_dma.h
index 7d7312f..dbb05df 100644
--- a/include/linux/dma/xilinx_dma.h
+++ b/include/linux/dma/xilinx_dma.h
@@ -60,6 +60,22 @@ struct zynqmp_dma_config {
 };
 
 /**
+ * struct xilinx_mcdma_config - DMA Multi channel configuration structure
+ * @tdest: Channel to operate on
+ * @tid:   Channel configuration
+ * @tuser: Tuser configuration
+ * @ax_user: ax_user value
+ * @ax_cache: ax_cache value
+ */
+struct xilinx_mcdma_config {
+	u8 tdest;
+	u8 tid;
+	u8 tuser;
+	u8 ax_user;
+	u8 ax_cache;
+};
+
+/**
  * enum xdma_ip_type: DMA IP type.
  *
  * XDMA_TYPE_AXIDMA: Axi dma ip.
@@ -77,4 +93,6 @@ int xilinx_vdma_channel_set_config(struct dma_chan *dchan,
 					struct xilinx_vdma_config *cfg);
 int zynqmp_dma_channel_set_config(struct dma_chan *dchan,
 					struct zynqmp_dma_config *cfg);
+int xilinx_dma_channel_mcdma_set_config(struct dma_chan *dchan,
+					struct xilinx_mcdma_config *cfg);
 #endif
-- 
1.7.1
