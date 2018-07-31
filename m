From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Tue, 31 Jul 2018 23:16:13 +0530
Subject: [RFC PATCH 2/2] dmaengine: xilinx_dma: Add Xilinx AXI MCDMA Engine
 driver support
In-Reply-To: <1533059173-21405-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1533059173-21405-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <1533059173-21405-3-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for AXI Multichannel Direct Memory Access (AXI MCDMA)
core, which is a soft Xilinx IP core that provides high-bandwidth
direct memory access between memory and AXI4-Stream target peripherals.
The AXI MCDMA core provides scatter-gather interface with multiple
independent transmit and receive channels.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 449 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 440 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index c124423..f136e5a 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -25,6 +25,11 @@
  * Access (DMA) between a memory-mapped source address and a memory-mapped
  * destination address.
  *
+ * The AXI Multichannel Direct Memory Access (AXI MCDMA) core is a soft
+ * Xilinx IP that provides high-bandwidth direct memory access between
+ * memory and AXI4-Stream target peripherals. It supports scatter-gather
+ * interface with multiple independent transmit and receive channels.
+ *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 2 of the License, or
@@ -190,6 +195,30 @@
 /* AXI CDMA Specific Masks */
 #define XILINX_CDMA_CR_SGMODE          BIT(3)
 
+/* AXI MCDMA Specific Registers/Offsets */
+#define XILINX_MCDMA_MM2S_CTRL_OFFSET		0x0000
+#define XILINX_MCDMA_S2MM_CTRL_OFFSET		0x0500
+#define XILINX_MCDMA_CHEN_OFFSET		0x0008
+#define XILINX_MCDMA_CH_ERR_OFFSET		0x0010
+#define XILINX_MCDMA_RXINT_SER_OFFSET		0x0020
+#define XILINX_MCDMA_TXINT_SER_OFFSET		0x0028
+#define XILINX_MCDMA_CHAN_CR_OFFSET(x)		(0x40 + (x) * 0x40)
+#define XILINX_MCDMA_CHAN_SR_OFFSET(x)		(0x44 + (x) * 0x40)
+#define XILINX_MCDMA_CHAN_CDESC_OFFSET(x)	(0x48 + (x) * 0x40)
+#define XILINX_MCDMA_CHAN_TDESC_OFFSET(x)	(0x50 + (x) * 0x40)
+
+/* AXI MCDMA Specific Masks/Shifts */
+#define XILINX_MCDMA_COALESCE_SHIFT		16
+#define XILINX_MCDMA_COALESCE_MAX		24
+#define XILINX_MCDMA_IRQ_ALL_MASK		GENMASK(7, 5)
+#define XILINX_MCDMA_COALESCE_MASK		GENMASK(23, 16)
+#define XILINX_MCDMA_CR_RUNSTOP_MASK		BIT(0)
+#define XILINX_MCDMA_IRQ_IOC_MASK		BIT(5)
+#define XILINX_MCDMA_IRQ_DELAY_MASK		BIT(6)
+#define XILINX_MCDMA_IRQ_ERR_MASK		BIT(7)
+#define XILINX_MCDMA_BD_EOP			BIT(30)
+#define XILINX_MCDMA_BD_SOP			BIT(31)
+
 /**
  * struct xilinx_vdma_desc_hw - Hardware Descriptor
  * @next_desc: Next Descriptor Pointer @0x00
@@ -236,6 +265,30 @@ struct xilinx_axidma_desc_hw {
 } __aligned(64);
 
 /**
+ * struct xilinx_aximcdma_desc_hw - Hardware Descriptor for AXI MCDMA
+ * @next_desc: Next Descriptor Pointer @0x00
+ * @next_desc_msb: MSB of Next Descriptor Pointer @0x04
+ * @buf_addr: Buffer address @0x08
+ * @buf_addr_msb: MSB of Buffer address @0x0C
+ * @rsvd: Reserved field @0x10
+ * @control: Control Information field @0x14
+ * @status: Status field @0x18
+ * @sideband_status: Status of sideband signals @0x1C
+ * @app: APP Fields @0x20 - 0x30
+ */
+struct xilinx_aximcdma_desc_hw {
+	u32 next_desc;
+	u32 next_desc_msb;
+	u32 buf_addr;
+	u32 buf_addr_msb;
+	u32 rsvd;
+	u32 control;
+	u32 status;
+	u32 sideband_status;
+	u32 app[XILINX_DMA_NUM_APP_WORDS];
+} __aligned(64);
+
+/**
  * struct xilinx_cdma_desc_hw - Hardware Descriptor
  * @next_desc: Next Descriptor Pointer @0x00
  * @next_desc_msb: Next Descriptor Pointer MSB @0x04
@@ -282,6 +335,18 @@ struct xilinx_axidma_tx_segment {
 } __aligned(64);
 
 /**
+ * struct xilinx_aximcdma_tx_segment - Descriptor segment
+ * @hw: Hardware descriptor
+ * @node: Node in the descriptor segments list
+ * @phys: Physical address of segment
+ */
+struct xilinx_aximcdma_tx_segment {
+	struct xilinx_aximcdma_desc_hw hw;
+	struct list_head node;
+	dma_addr_t phys;
+} __aligned(64);
+
+/**
  * struct xilinx_cdma_tx_segment - Descriptor segment
  * @hw: Hardware descriptor
  * @node: Node in the descriptor segments list
@@ -336,7 +401,8 @@ struct xilinx_dma_tx_descriptor {
  * @ext_addr: Indicates 64 bit addressing is supported by dma channel
  * @desc_submitcount: Descriptor h/w submitted count
  * @residue: Residue for AXI DMA
- * @seg_v: Statically allocated segments base
+ * @seg_v: Statically allocated segments base for AXI DMA
+ * @seg_mv: Statically allocated segments base for AXI MCDMA
  * @seg_p: Physical allocated segments base
  * @cyclic_seg_v: Statically allocated segment base for cyclic transfers
  * @cyclic_seg_p: Physical allocated segments base for cyclic dma
@@ -374,6 +440,7 @@ struct xilinx_dma_chan {
 	u32 desc_submitcount;
 	u32 residue;
 	struct xilinx_axidma_tx_segment *seg_v;
+	struct xilinx_aximcdma_tx_segment *seg_mv;
 	dma_addr_t seg_p;
 	struct xilinx_axidma_tx_segment *cyclic_seg_v;
 	dma_addr_t cyclic_seg_p;
@@ -395,6 +462,7 @@ enum xdma_ip_type {
 	XDMA_TYPE_AXIDMA = 0,
 	XDMA_TYPE_CDMA,
 	XDMA_TYPE_VDMA,
+	XDMA_TYPE_AXIMCDMA
 };
 
 struct xilinx_dma_config {
@@ -402,6 +470,7 @@ struct xilinx_dma_config {
 	int (*clk_init)(struct platform_device *pdev, struct clk **axi_clk,
 			struct clk **tx_clk, struct clk **txs_clk,
 			struct clk **rx_clk, struct clk **rxs_clk);
+	irqreturn_t (*irq_handler)(int irq, void *data);
 };
 
 /**
@@ -542,6 +611,18 @@ static inline void xilinx_axidma_buf(struct xilinx_dma_chan *chan,
 	}
 }
 
+static inline void xilinx_aximcdma_buf(struct xilinx_dma_chan *chan,
+				     struct xilinx_aximcdma_desc_hw *hw,
+				     dma_addr_t buf_addr, size_t sg_used)
+{
+	if (chan->ext_addr) {
+		hw->buf_addr = lower_32_bits(buf_addr + sg_used);
+		hw->buf_addr_msb = upper_32_bits(buf_addr + sg_used);
+	} else {
+		hw->buf_addr = buf_addr + sg_used;
+	}
+}
+
 /* -----------------------------------------------------------------------------
  * Descriptors and segments alloc and free
  */
@@ -612,6 +693,31 @@ xilinx_axidma_alloc_tx_segment(struct xilinx_dma_chan *chan)
 	return segment;
 }
 
+/**
+ * xilinx_aximcdma_alloc_tx_segment - Allocate transaction segment
+ * @chan: Driver specific DMA channel
+ *
+ * Return: The allocated segment on success and NULL on failure.
+ */
+static struct xilinx_aximcdma_tx_segment *
+xilinx_aximcdma_alloc_tx_segment(struct xilinx_dma_chan *chan)
+{
+	struct xilinx_aximcdma_tx_segment *segment = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->lock, flags);
+	if (!list_empty(&chan->free_seg_list)) {
+		segment = list_first_entry(&chan->free_seg_list,
+					   struct xilinx_aximcdma_tx_segment,
+					   node);
+		list_del(&segment->node);
+	}
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	return segment;
+}
+
+
 static void xilinx_dma_clean_hw_desc(struct xilinx_axidma_desc_hw *hw)
 {
 	u32 next_desc = hw->next_desc;
@@ -623,6 +729,17 @@ static void xilinx_dma_clean_hw_desc(struct xilinx_axidma_desc_hw *hw)
 	hw->next_desc_msb = next_desc_msb;
 }
 
+static void xilinx_mcdma_clean_hw_desc(struct xilinx_aximcdma_desc_hw *hw)
+{
+	u32 next_desc = hw->next_desc;
+	u32 next_desc_msb = hw->next_desc_msb;
+
+	memset(hw, 0, sizeof(struct xilinx_aximcdma_desc_hw));
+
+	hw->next_desc = next_desc;
+	hw->next_desc_msb = next_desc_msb;
+}
+
 /**
  * xilinx_dma_free_tx_segment - Free transaction segment
  * @chan: Driver specific DMA channel
@@ -637,6 +754,19 @@ static void xilinx_dma_free_tx_segment(struct xilinx_dma_chan *chan,
 }
 
 /**
+ * xilinx_mcdma_free_tx_segment - Free transaction segment
+ * @chan: Driver specific DMA channel
+ * @segment: DMA transaction segment
+ */
+static void xilinx_mcdma_free_tx_segment(struct xilinx_dma_chan *chan,
+				struct xilinx_aximcdma_tx_segment *segment)
+{
+	xilinx_mcdma_clean_hw_desc(&segment->hw);
+
+	list_add_tail(&segment->node, &chan->free_seg_list);
+}
+
+/**
  * xilinx_cdma_free_tx_segment - Free transaction segment
  * @chan: Driver specific DMA channel
  * @segment: DMA transaction segment
@@ -690,6 +820,7 @@ xilinx_dma_free_tx_descriptor(struct xilinx_dma_chan *chan,
 	struct xilinx_vdma_tx_segment *segment, *next;
 	struct xilinx_cdma_tx_segment *cdma_segment, *cdma_next;
 	struct xilinx_axidma_tx_segment *axidma_segment, *axidma_next;
+	struct xilinx_aximcdma_tx_segment *aximcdma_segment, *aximcdma_next;
 
 	if (!desc)
 		return;
@@ -705,12 +836,18 @@ xilinx_dma_free_tx_descriptor(struct xilinx_dma_chan *chan,
 			list_del(&cdma_segment->node);
 			xilinx_cdma_free_tx_segment(chan, cdma_segment);
 		}
-	} else {
+	} else if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		list_for_each_entry_safe(axidma_segment, axidma_next,
 					 &desc->segments, node) {
 			list_del(&axidma_segment->node);
 			xilinx_dma_free_tx_segment(chan, axidma_segment);
 		}
+	} else {
+		list_for_each_entry_safe(aximcdma_segment, aximcdma_next,
+					 &desc->segments, node) {
+			list_del(&aximcdma_segment->node);
+			xilinx_mcdma_free_tx_segment(chan, aximcdma_segment);
+		}
 	}
 
 	kfree(desc);
@@ -779,7 +916,19 @@ static void xilinx_dma_free_chan_resources(struct dma_chan *dchan)
 				  chan->cyclic_seg_v, chan->cyclic_seg_p);
 	}
 
-	if (chan->xdev->dma_config->dmatype != XDMA_TYPE_AXIDMA) {
+	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
+		spin_lock_irqsave(&chan->lock, flags);
+		INIT_LIST_HEAD(&chan->free_seg_list);
+		spin_unlock_irqrestore(&chan->lock, flags);
+
+		/* Free memory that is allocated for BD */
+		dma_free_coherent(chan->dev, sizeof(*chan->seg_mv) *
+				  XILINX_DMA_NUM_DESCS, chan->seg_mv,
+				  chan->seg_p);
+	}
+
+	if (chan->xdev->dma_config->dmatype != XDMA_TYPE_AXIDMA &&
+	    chan->xdev->dma_config->dmatype != XDMA_TYPE_AXIMCDMA) {
 		dma_pool_destroy(chan->desc_pool);
 		chan->desc_pool = NULL;
 	}
@@ -900,6 +1049,30 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
 			list_add_tail(&chan->seg_v[i].node,
 				      &chan->free_seg_list);
 		}
+	} else if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
+		/* Allocate the buffer descriptors. */
+		chan->seg_mv = dma_zalloc_coherent(chan->dev,
+						  sizeof(*chan->seg_mv) *
+						  XILINX_DMA_NUM_DESCS,
+						  &chan->seg_p, GFP_KERNEL);
+		if (!chan->seg_mv) {
+			dev_err(chan->dev,
+				"unable to allocate channel %d descriptors\n",
+				chan->id);
+			return -ENOMEM;
+		}
+		for (i = 0; i < XILINX_DMA_NUM_DESCS; i++) {
+			chan->seg_mv[i].hw.next_desc =
+			lower_32_bits(chan->seg_p + sizeof(*chan->seg_mv) *
+				((i + 1) % XILINX_DMA_NUM_DESCS));
+			chan->seg_mv[i].hw.next_desc_msb =
+			upper_32_bits(chan->seg_p + sizeof(*chan->seg_mv) *
+				((i + 1) % XILINX_DMA_NUM_DESCS));
+			chan->seg_mv[i].phys = chan->seg_p +
+				sizeof(*chan->seg_v) * i;
+			list_add_tail(&chan->seg_mv[i].node,
+				      &chan->free_seg_list);
+		}
 	} else if (chan->xdev->dma_config->dmatype == XDMA_TYPE_CDMA) {
 		chan->desc_pool = dma_pool_create("xilinx_cdma_desc_pool",
 				   chan->dev,
@@ -915,7 +1088,8 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
 	}
 
 	if (!chan->desc_pool &&
-	    (chan->xdev->dma_config->dmatype != XDMA_TYPE_AXIDMA)) {
+	    ((chan->xdev->dma_config->dmatype != XDMA_TYPE_AXIDMA) &&
+		chan->xdev->dma_config->dmatype != XDMA_TYPE_AXIMCDMA)) {
 		dev_err(chan->dev,
 			"unable to allocate channel %d descriptor pool\n",
 			chan->id);
@@ -1362,6 +1536,71 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 }
 
 /**
+ * xilinx_mcdma_start_transfer - Starts MCDMA transfer
+ * @chan: Driver specific channel struct pointer
+ */
+static void xilinx_mcdma_start_transfer(struct xilinx_dma_chan *chan)
+{
+	struct xilinx_dma_tx_descriptor *head_desc, *tail_desc;
+	struct xilinx_axidma_tx_segment *tail_segment;
+	u32 reg;
+
+	if (chan->err)
+		return;
+
+	if (!chan->idle)
+		return;
+
+	if (list_empty(&chan->pending_list))
+		return;
+
+	head_desc = list_first_entry(&chan->pending_list,
+				     struct xilinx_dma_tx_descriptor, node);
+	tail_desc = list_last_entry(&chan->pending_list,
+				    struct xilinx_dma_tx_descriptor, node);
+	tail_segment = list_last_entry(&tail_desc->segments,
+				       struct xilinx_axidma_tx_segment, node);
+
+	reg = dma_ctrl_read(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest));
+
+	if (chan->desc_pendingcount <= XILINX_MCDMA_COALESCE_MAX) {
+		reg &= ~XILINX_MCDMA_COALESCE_MASK;
+		reg |= chan->desc_pendingcount <<
+				  XILINX_MCDMA_COALESCE_SHIFT;
+	}
+
+	reg |= XILINX_MCDMA_IRQ_ALL_MASK;
+	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest), reg);
+
+	/* Program current descriptor */
+	xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
+		     head_desc->async_tx.phys);
+
+	/* Program channel enable register */
+	reg = dma_ctrl_read(chan, XILINX_MCDMA_CHEN_OFFSET);
+	reg |= BIT(chan->tdest);
+	dma_ctrl_write(chan, XILINX_MCDMA_CHEN_OFFSET, reg);
+
+	/* Start the fetch of BDs for the channel */
+	reg = dma_ctrl_read(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest));
+	reg |= XILINX_MCDMA_CR_RUNSTOP_MASK;
+	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest), reg);
+
+	xilinx_dma_start(chan);
+
+	if (chan->err)
+		return;
+
+	/* Start the transfer */
+	xilinx_write(chan, XILINX_MCDMA_CHAN_TDESC_OFFSET(chan->tdest),
+		     tail_segment->phys);
+
+	list_splice_tail_init(&chan->pending_list, &chan->active_list);
+	chan->desc_pendingcount = 0;
+	chan->idle = false;
+}
+
+/**
  * xilinx_dma_issue_pending - Issue pending transactions
  * @dchan: DMA channel
  */
@@ -1452,6 +1691,75 @@ static int xilinx_dma_chan_reset(struct xilinx_dma_chan *chan)
 }
 
 /**
+ * xilinx_mcdma_irq_handler - MCDMA Interrupt handler
+ * @irq: IRQ number
+ * @data: Pointer to the Xilinx MCDMA channel structure
+ *
+ * Return: IRQ_HANDLED/IRQ_NONE
+ */
+static irqreturn_t xilinx_mcdma_irq_handler(int irq, void *data)
+{
+	struct xilinx_dma_chan *chan = data;
+	u32 status, ser_offset, chan_sermask, chan_offset = 0, chan_id;
+
+	if (chan->direction == DMA_DEV_TO_MEM)
+		ser_offset = XILINX_MCDMA_RXINT_SER_OFFSET;
+	else
+		ser_offset = XILINX_MCDMA_TXINT_SER_OFFSET;
+
+	/* Read the channel id raising the interrupt*/
+	chan_sermask = dma_ctrl_read(chan, ser_offset);
+	chan_id = ffs(chan_sermask);
+
+	if (!chan_id)
+		return IRQ_NONE;
+
+	if (chan->direction == DMA_DEV_TO_MEM)
+		chan_offset = XILINX_DMA_MAX_CHANS_PER_DEVICE / 2;
+
+	chan_offset = chan_offset + (chan_id - 1);
+	chan = chan->xdev->chan[chan_offset];
+	/* Read the status and ack the interrupts. */
+	status = dma_ctrl_read(chan, XILINX_MCDMA_CHAN_SR_OFFSET(chan->tdest));
+	if (!(status & XILINX_MCDMA_IRQ_ALL_MASK))
+		return IRQ_NONE;
+
+	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_SR_OFFSET(chan->tdest),
+		       status & XILINX_MCDMA_IRQ_ALL_MASK);
+
+	if (status & XILINX_MCDMA_IRQ_ERR_MASK) {
+		dev_err(chan->dev, "Channel %p has errors %x cdr %x tdr %x\n",
+			chan, dma_ctrl_read(chan,
+			XILINX_MCDMA_CH_ERR_OFFSET), dma_ctrl_read(chan,
+			XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest)),
+			dma_ctrl_read(chan,
+				      XILINX_MCDMA_CHAN_TDESC_OFFSET
+				      (chan->tdest)));
+		chan->err = true;
+	}
+
+	if (status & XILINX_MCDMA_IRQ_DELAY_MASK) {
+		/*
+		 * Device takes too long to do the transfer when user requires
+		 * responsiveness.
+		 */
+		dev_dbg(chan->dev, "Inter-packet latency too long\n");
+	}
+
+	if (status & XILINX_MCDMA_IRQ_IOC_MASK) {
+		spin_lock(&chan->lock);
+		xilinx_dma_complete_descriptor(chan);
+		chan->idle = true;
+		chan->start_transfer(chan);
+		spin_unlock(&chan->lock);
+	}
+
+	tasklet_schedule(&chan->tasklet);
+	return IRQ_HANDLED;
+
+}
+
+/**
  * xilinx_dma_irq_handler - DMA Interrupt handler
  * @irq: IRQ number
  * @data: Pointer to the Xilinx DMA channel structure
@@ -1750,6 +2058,103 @@ xilinx_cdma_prep_memcpy(struct dma_chan *dchan, dma_addr_t dma_dst,
 	xilinx_dma_free_tx_descriptor(chan, desc);
 	return NULL;
 }
+/**
+ * xilinx_mcdma_prep_slave_sg - prepare descriptors for a DMA_SLAVE transaction
+ * @dchan: DMA channel
+ * @sgl: scatterlist to transfer to/from
+ * @sg_len: number of entries in @scatterlist
+ * @direction: DMA direction
+ * @flags: transfer ack flags
+ * @context: APP words of the descriptor
+ *
+ * Return: Async transaction descriptor on success and NULL on failure
+ */
+static struct dma_async_tx_descriptor *xilinx_mcdma_prep_slave_sg(
+	struct dma_chan *dchan, struct scatterlist *sgl, unsigned int sg_len,
+	enum dma_transfer_direction direction, unsigned long flags,
+	void *context)
+{
+	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
+	struct xilinx_dma_tx_descriptor *desc;
+	struct xilinx_aximcdma_tx_segment *segment = NULL;
+	u32 *app_w = (u32 *)context;
+	struct scatterlist *sg;
+	size_t copy;
+	size_t sg_used;
+	unsigned int i;
+
+	if (!is_slave_direction(direction))
+		return NULL;
+
+	/* Allocate a transaction descriptor. */
+	desc = xilinx_dma_alloc_tx_descriptor(chan);
+	if (!desc)
+		return NULL;
+
+	dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
+	desc->async_tx.tx_submit = xilinx_dma_tx_submit;
+
+	/* Build transactions using information in the scatter gather list */
+	for_each_sg(sgl, sg, sg_len, i) {
+		sg_used = 0;
+
+		/* Loop until the entire scatterlist entry is used */
+		while (sg_used < sg_dma_len(sg)) {
+			struct xilinx_aximcdma_desc_hw *hw;
+
+			/* Get a free segment */
+			segment = xilinx_aximcdma_alloc_tx_segment(chan);
+			if (!segment)
+				goto error;
+
+			/*
+			 * Calculate the maximum number of bytes to transfer,
+			 * making sure it is less than the hw limit
+			 */
+			copy = min_t(size_t, sg_dma_len(sg) - sg_used,
+				     XILINX_DMA_MAX_TRANS_LEN);
+			hw = &segment->hw;
+
+			/* Fill in the descriptor */
+			xilinx_aximcdma_buf(chan, hw, sg_dma_address(sg),
+					    sg_used);
+			hw->control = copy;
+
+			if (chan->direction == DMA_MEM_TO_DEV) {
+				if (app_w)
+					memcpy(hw->app, app_w, sizeof(u32) *
+					       XILINX_DMA_NUM_APP_WORDS);
+			}
+
+			sg_used += copy;
+			/*
+			 * Insert the segment into the descriptor segments
+			 * list.
+			 */
+			list_add_tail(&segment->node, &desc->segments);
+		}
+	}
+
+	segment = list_first_entry(&desc->segments,
+				   struct xilinx_aximcdma_tx_segment, node);
+	desc->async_tx.phys = segment->phys;
+
+	/* For the last DMA_MEM_TO_DEV transfer, set EOP */
+	if (chan->direction == DMA_MEM_TO_DEV) {
+		segment->hw.control |= XILINX_MCDMA_BD_SOP;
+		segment = list_last_entry(&desc->segments,
+					  struct xilinx_aximcdma_tx_segment,
+					  node);
+		segment->hw.control |= XILINX_MCDMA_BD_EOP;
+	}
+
+	return &desc->async_tx;
+
+error:
+	xilinx_dma_free_tx_descriptor(chan, desc);
+
+	return NULL;
+}
 
 /**
  * xilinx_dma_prep_slave_sg - prepare descriptors for a DMA_SLAVE transaction
@@ -2422,12 +2827,16 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 
 	if (of_device_is_compatible(node, "xlnx,axi-vdma-mm2s-channel") ||
 	    of_device_is_compatible(node, "xlnx,axi-dma-mm2s-channel") ||
-	    of_device_is_compatible(node, "xlnx,axi-cdma-channel")) {
+	    of_device_is_compatible(node, "xlnx,axi-cdma-channel") ||
+	    of_device_is_compatible(node, "xlnx,axi-mcdma-mm2s-channel")) {
 		chan->direction = DMA_MEM_TO_DEV;
 		chan->id = chan_id;
 		chan->tdest = chan_id;
 
-		chan->ctrl_offset = XILINX_DMA_MM2S_CTRL_OFFSET;
+		if (xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA)
+			chan->ctrl_offset = XILINX_MCDMA_MM2S_CTRL_OFFSET;
+		else
+			chan->ctrl_offset = XILINX_DMA_MM2S_CTRL_OFFSET;
 		if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
 			chan->desc_offset = XILINX_VDMA_MM2S_DESC_OFFSET;
 			chan->config.park = 1;
@@ -2439,7 +2848,9 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 	} else if (of_device_is_compatible(node,
 					   "xlnx,axi-vdma-s2mm-channel") ||
 		   of_device_is_compatible(node,
-					   "xlnx,axi-dma-s2mm-channel")) {
+					   "xlnx,axi-dma-s2mm-channel") ||
+		   of_device_is_compatible(node,
+					   "xlnx,axi-mcdma-s2mm-channel")) {
 		chan->direction = DMA_DEV_TO_MEM;
 		chan->id = chan_id;
 		chan->tdest = chan_id - xdev->nr_channels;
@@ -2451,7 +2862,11 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 				XILINX_VDMA_ENABLE_VERTICAL_FLIP;
 		}
 
-		chan->ctrl_offset = XILINX_DMA_S2MM_CTRL_OFFSET;
+		if (xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA)
+			chan->ctrl_offset = XILINX_MCDMA_S2MM_CTRL_OFFSET;
+		else
+			chan->ctrl_offset = XILINX_DMA_S2MM_CTRL_OFFSET;
+
 		if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
 			chan->desc_offset = XILINX_VDMA_S2MM_DESC_OFFSET;
 			chan->config.park = 1;
@@ -2467,7 +2882,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 
 	/* Request the interrupt */
 	chan->irq = irq_of_parse_and_map(node, 0);
-	err = request_irq(chan->irq, xilinx_dma_irq_handler, IRQF_SHARED,
+	err = request_irq(chan->irq, xdev->dma_config->irq_handler, IRQF_SHARED,
 			  "xilinx-dma-controller", chan);
 	if (err) {
 		dev_err(xdev->dev, "unable to request IRQ %d\n", chan->irq);
@@ -2477,6 +2892,9 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		chan->start_transfer = xilinx_dma_start_transfer;
 		chan->stop_transfer = xilinx_dma_stop_transfer;
+	} else if (xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
+		chan->start_transfer = xilinx_mcdma_start_transfer;
+		chan->stop_transfer = xilinx_dma_stop_transfer;
 	} else if (xdev->dma_config->dmatype == XDMA_TYPE_CDMA) {
 		chan->start_transfer = xilinx_cdma_start_transfer;
 		chan->stop_transfer = xilinx_cdma_stop_transfer;
@@ -2557,22 +2975,31 @@ static struct dma_chan *of_dma_xilinx_xlate(struct of_phandle_args *dma_spec,
 static const struct xilinx_dma_config axidma_config = {
 	.dmatype = XDMA_TYPE_AXIDMA,
 	.clk_init = axidma_clk_init,
+	.irq_handler = xilinx_dma_irq_handler,
 };
 
+static const struct xilinx_dma_config aximcdma_config = {
+	.dmatype = XDMA_TYPE_AXIMCDMA,
+	.clk_init = axidma_clk_init,
+	.irq_handler = xilinx_mcdma_irq_handler,
+};
 static const struct xilinx_dma_config axicdma_config = {
 	.dmatype = XDMA_TYPE_CDMA,
 	.clk_init = axicdma_clk_init,
+	.irq_handler = xilinx_dma_irq_handler,
 };
 
 static const struct xilinx_dma_config axivdma_config = {
 	.dmatype = XDMA_TYPE_VDMA,
 	.clk_init = axivdma_clk_init,
+	.irq_handler = xilinx_dma_irq_handler,
 };
 
 static const struct of_device_id xilinx_dma_of_ids[] = {
 	{ .compatible = "xlnx,axi-dma-1.00.a", .data = &axidma_config },
 	{ .compatible = "xlnx,axi-cdma-1.00.a", .data = &axicdma_config },
 	{ .compatible = "xlnx,axi-vdma-1.00.a", .data = &axivdma_config },
+	{ .compatible = "xlnx,axi-mcdma-1.00.a", .data = &aximcdma_config },
 	{}
 };
 MODULE_DEVICE_TABLE(of, xilinx_dma_of_ids);
@@ -2684,6 +3111,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	} else if (xdev->dma_config->dmatype == XDMA_TYPE_CDMA) {
 		dma_cap_set(DMA_MEMCPY, xdev->common.cap_mask);
 		xdev->common.device_prep_dma_memcpy = xilinx_cdma_prep_memcpy;
+	} else if (xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
+		xdev->common.device_prep_slave_sg = xilinx_mcdma_prep_slave_sg;
 	} else {
 		xdev->common.device_prep_interleaved_dma =
 				xilinx_vdma_dma_prep_interleaved;
@@ -2719,6 +3148,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		dev_info(&pdev->dev, "Xilinx AXI DMA Engine Driver Probed!!\n");
 	else if (xdev->dma_config->dmatype == XDMA_TYPE_CDMA)
 		dev_info(&pdev->dev, "Xilinx AXI CDMA Engine Driver Probed!!\n");
+	else if (xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA)
+		dev_info(&pdev->dev, "Xilinx AXI MCDMA Engine Driver Probed!!\n");
 	else
 		dev_info(&pdev->dev, "Xilinx AXI VDMA Engine Driver Probed!!\n");
 
-- 
2.7.4
