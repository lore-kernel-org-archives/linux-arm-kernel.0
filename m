From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Tue, 15 Mar 2016 22:53:11 +0530
Subject: [PATCH 6/7] dmaengine: xilinx_vdma: Add Support for Xilinx AXI
 Central Direct Memory Access Engine
In-Reply-To: <1458062592-27981-1-git-send-email-appanad@xilinx.com>
References: <1458062592-27981-1-git-send-email-appanad@xilinx.com>
Message-ID: <1458062592-27981-7-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the AXI Central Direct Memory Access (AXI
CDMA) core, which is a soft Xilinx IP core that provides high-bandwidth
Direct Memory Access (DMA) between a memory-mapped source address and a
memory-mapped destination address.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
 drivers/dma/xilinx/xilinx_vdma.c | 173 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 169 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_vdma.c
index 87525a9..e6caf79 100644
--- a/drivers/dma/xilinx/xilinx_vdma.c
+++ b/drivers/dma/xilinx/xilinx_vdma.c
@@ -22,6 +22,10 @@
  *  channels, one is to transmit data from memory to a device and another is
  *  to receive from a device.
  *
+ *  The AXI CDMA, is a soft IP, which provides high-bandwidth Direct Memory
+ *  Access (DMA) between a memory-mapped source address and a memory-mapped
+ *  destination address.
+ *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 2 of the License, or
@@ -147,6 +151,7 @@
 
 #define AXIVDMA_SUPPORT		BIT(0)
 #define AXIDMA_SUPPORT		BIT(1)
+#define AXICDMA_SUPPORT		BIT(2)
 
 /* AXI DMA Specific Registers/Offsets */
 #define XILINX_DMA_REG_SRCDSTADDR	0x18
@@ -161,6 +166,9 @@
 #define XILINX_DMA_COALESCE_MAX		255
 #define XILINX_DMA_NUM_APP_WORDS	5
 
+/* AXI CDMA Specific Masks */
+#define XILINX_CDMA_CR_SGMODE          BIT(3)
+
 /**
  * struct xilinx_vdma_desc_hw - Hardware Descriptor
  * @next_desc: Next Descriptor Pointer @0x00
@@ -552,6 +560,12 @@ static int xilinx_vdma_alloc_chan_resources(struct dma_chan *dchan)
 	/* Enable interrupts */
 	vdma_ctrl_set(chan, XILINX_VDMA_REG_DMACR,
 		      XILINX_VDMA_DMAXR_ALL_IRQ_MASK);
+
+	if ((chan->xdev->quirks & AXICDMA_SUPPORT) && chan->has_sg) {
+		vdma_ctrl_set(chan, XILINX_VDMA_REG_DMACR,
+			      XILINX_CDMA_CR_SGMODE);
+	}
+
 	return 0;
 }
 
@@ -674,6 +688,81 @@ static void xilinx_vdma_start(struct xilinx_vdma_chan *chan)
 }
 
 /**
+ * xilinx_cdma_start_transfer - Starts cdma transfer
+ * @chan: Driver specific channel struct pointer
+ */
+static void xilinx_cdma_start_transfer(struct xilinx_vdma_chan *chan)
+{
+	struct xilinx_vdma_tx_descriptor *head_desc, *tail_desc;
+	struct xilinx_vdma_tx_segment *tail_segment;
+	u32 ctrl_reg = vdma_ctrl_read(chan, XILINX_VDMA_REG_DMACR);
+
+	if (chan->err)
+		return;
+
+	if (list_empty(&chan->pending_list))
+		return;
+
+	head_desc = list_first_entry(&chan->pending_list,
+				     struct xilinx_vdma_tx_descriptor, node);
+	tail_desc = list_last_entry(&chan->pending_list,
+				    struct xilinx_vdma_tx_descriptor, node);
+	tail_segment = list_last_entry(&tail_desc->segments,
+				       struct xilinx_vdma_tx_segment, node);
+
+	if (chan->desc_pendingcount <= XILINX_DMA_COALESCE_MAX) {
+		ctrl_reg &= ~XILINX_DMA_CR_COALESCE_MAX;
+		ctrl_reg |= chan->desc_pendingcount <<
+				XILINX_DMA_CR_COALESCE_SHIFT;
+		vdma_ctrl_write(chan, XILINX_VDMA_REG_DMACR, ctrl_reg);
+	}
+
+	if (chan->has_sg) {
+		vdma_ctrl_write(chan, XILINX_VDMA_REG_CURDESC,
+			   head_desc->async_tx.phys);
+
+		/* Update tail ptr register which will start the transfer */
+		vdma_ctrl_write(chan, XILINX_VDMA_REG_TAILDESC,
+				tail_segment->phys);
+	} else {
+		/* In simple mode */
+		struct xilinx_vdma_tx_segment *segment;
+		struct xilinx_vdma_desc_hw *hw;
+
+		segment = list_first_entry(&head_desc->segments,
+					   struct xilinx_vdma_tx_segment,
+					   node);
+
+		hw = &segment->hw;
+
+		vdma_ctrl_write(chan, XILINX_DMA_REG_SRCDSTADDR, hw->buf_addr);
+		vdma_ctrl_write(chan, XILINX_DMA_REG_DSTADDR,
+				hw->dstaddr_vsize);
+
+		/* Start the transfer */
+		vdma_ctrl_write(chan, XILINX_DMA_REG_BTT,
+				hw->control_stride & XILINX_DMA_MAX_TRANS_LEN);
+	}
+
+	list_splice_tail_init(&chan->pending_list, &chan->active_list);
+	chan->desc_pendingcount = 0;
+}
+
+/**
+ * xilinx_cdma_issue_pending - Issue pending transactions
+ * @dchan: DMA channel
+ */
+static void xilinx_cdma_issue_pending(struct dma_chan *dchan)
+{
+	struct xilinx_vdma_chan *chan = to_xilinx_chan(dchan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->lock, flags);
+	xilinx_cdma_start_transfer(chan);
+	spin_unlock_irqrestore(&chan->lock, flags);
+}
+
+/**
  * xilinx_vdma_start_transfer - Starts VDMA transfer
  * @chan: Driver specific channel struct pointer
  */
@@ -1285,6 +1374,69 @@ error:
 }
 
 /**
+ * xilinx_cdma_prep_memcpy - prepare descriptors for a memcpy transaction
+ * @dchan: DMA channel
+ * @dma_dst: destination address
+ * @dma_src: source address
+ * @len: transfer length
+ * @flags: transfer ack flags
+ *
+ * Return: Async transaction descriptor on success and NULL on failure
+ */
+static struct dma_async_tx_descriptor *
+xilinx_cdma_prep_memcpy(struct dma_chan *dchan, dma_addr_t dma_dst,
+			dma_addr_t dma_src, size_t len, unsigned long flags)
+{
+	struct xilinx_vdma_chan *chan = to_xilinx_chan(dchan);
+	struct xilinx_vdma_desc_hw *hw;
+	struct xilinx_vdma_tx_descriptor *desc;
+	struct xilinx_vdma_tx_segment *segment, *prev;
+
+	if (!len || len > XILINX_DMA_MAX_TRANS_LEN)
+		return NULL;
+
+	desc = xilinx_vdma_alloc_tx_descriptor(chan);
+	if (!desc)
+		return NULL;
+
+	dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
+	desc->async_tx.tx_submit = xilinx_vdma_tx_submit;
+	async_tx_ack(&desc->async_tx);
+
+	/* Allocate the link descriptor from DMA pool */
+	segment = xilinx_vdma_alloc_tx_segment(chan);
+	if (!segment)
+		goto error;
+
+	hw = &segment->hw;
+	hw->control_stride = len;
+	hw->buf_addr = dma_src;
+	hw->dstaddr_vsize = dma_dst;
+
+	/* Fill the previous next descriptor with current */
+	prev = list_last_entry(&desc->segments,
+			       struct xilinx_vdma_tx_segment, node);
+	prev->hw.next_desc = segment->phys;
+
+	/* Insert the segment into the descriptor segments list. */
+	list_add_tail(&segment->node, &desc->segments);
+
+	prev = segment;
+
+	/* Link the last hardware descriptor with the first. */
+	segment = list_first_entry(&desc->segments,
+				struct xilinx_vdma_tx_segment, node);
+	desc->async_tx.phys = segment->phys;
+	prev->hw.next_desc = segment->phys;
+
+	return &desc->async_tx;
+
+error:
+	xilinx_vdma_free_tx_descriptor(chan, desc);
+	return NULL;
+}
+
+/**
  * xilinx_vdma_terminate_all - Halt the channel and free descriptors
  * @chan: Driver specific VDMA Channel pointer
  */
@@ -1472,8 +1624,10 @@ static int xilinx_vdma_chan_probe(struct xilinx_vdma_device *xdev,
 
 	if (xdev->quirks & AXIVDMA_SUPPORT)
 		chan->start_transfer = xilinx_vdma_start_transfer;
-	else
+	else if (xdev->quirks & AXIDMA_SUPPORT)
 		chan->start_transfer = xilinx_dma_start_transfer;
+	else
+		chan->start_transfer = xilinx_cdma_start_transfer;
 
 	/* Request the interrupt */
 	chan->irq = irq_of_parse_and_map(node, 0);
@@ -1534,9 +1688,14 @@ static const struct xdma_platform_data xdma_def = {
 	.quirks = AXIDMA_SUPPORT,
 };
 
+static const struct xdma_platform_data xcdma_def = {
+	.quirks = AXICDMA_SUPPORT,
+};
+
 static const struct of_device_id xilinx_vdma_of_ids[] = {
 	{ .compatible = "xlnx,axi-vdma-1.00.a", .data = &xvdma_def},
 	{ .compatible = "xlnx,axi-dma-1.00.a", .data = &xdma_def},
+	{ .compatible = "xlnx,axi-cdma-1.00.a", .data = &xcdma_def},
 	{}
 };
 MODULE_DEVICE_TABLE(of, xilinx_vdma_of_ids);
@@ -1601,8 +1760,10 @@ static int xilinx_vdma_probe(struct platform_device *pdev)
 	xdev->common.dev = &pdev->dev;
 
 	INIT_LIST_HEAD(&xdev->common.channels);
-	dma_cap_set(DMA_SLAVE, xdev->common.cap_mask);
-	dma_cap_set(DMA_PRIVATE, xdev->common.cap_mask);
+	if (!(xdev->quirks & AXICDMA_SUPPORT)) {
+		dma_cap_set(DMA_SLAVE, xdev->common.cap_mask);
+		dma_cap_set(DMA_PRIVATE, xdev->common.cap_mask);
+	}
 
 	xdev->common.device_alloc_chan_resources =
 				xilinx_vdma_alloc_chan_resources;
@@ -1614,13 +1775,17 @@ static int xilinx_vdma_probe(struct platform_device *pdev)
 		xdev->common.device_issue_pending = xilinx_vdma_issue_pending;
 		xdev->common.device_prep_interleaved_dma =
 				xilinx_vdma_dma_prep_interleaved;
-	} else {
+	} else if (xdev->quirks & AXIDMA_SUPPORT) {
 		xdev->common.device_prep_slave_sg = xilinx_dma_prep_slave_sg;
 		xdev->common.device_issue_pending = xilinx_dma_issue_pending;
 		xdev->common.directions = BIT(DMA_DEV_TO_MEM) |
 					  BIT(DMA_MEM_TO_DEV);
 		xdev->common.residue_granularity =
 					  DMA_RESIDUE_GRANULARITY_SEGMENT;
+	} else {
+		dma_cap_set(DMA_MEMCPY, xdev->common.cap_mask);
+		xdev->common.device_prep_dma_memcpy = xilinx_cdma_prep_memcpy;
+		xdev->common.device_issue_pending = xilinx_cdma_issue_pending;
 	}
 
 	platform_set_drvdata(pdev, xdev);
-- 
2.1.2
