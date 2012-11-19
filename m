From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:04:55 +0100
Subject: [PATCH 17/30] dma: mv_xor: introduce a mv_chan_to_devp() helper
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-18-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In many place, we need to get the 'struct device *' pointer from a
'struct mv_chan *', so we add a helper that makes this a bit
easier. It will also help reducing the change noise in further
patches.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |   61 ++++++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index b799d33..38dac0d 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -39,6 +39,9 @@ static void mv_xor_issue_pending(struct dma_chan *chan);
 #define to_mv_xor_slot(tx)		\
 	container_of(tx, struct mv_xor_desc_slot, async_tx)
 
+#define mv_chan_to_devp(chan)           \
+	((chan)->device->common.dev)
+
 static void mv_desc_init(struct mv_xor_desc_slot *desc, unsigned long flags)
 {
 	struct mv_xor_desc *hw_desc = desc->hw_desc;
@@ -163,7 +166,7 @@ static int mv_is_err_intr(u32 intr_cause)
 static void mv_xor_device_clear_eoc_cause(struct mv_xor_chan *chan)
 {
 	u32 val = ~(1 << (chan->idx * 16));
-	dev_dbg(chan->device->common.dev, "%s, val 0x%08x\n", __func__, val);
+	dev_dbg(mv_chan_to_devp(chan), "%s, val 0x%08x\n", __func__, val);
 	__raw_writel(val, XOR_INTR_CAUSE(chan));
 }
 
@@ -203,7 +206,7 @@ static void mv_set_mode(struct mv_xor_chan *chan,
 		op_mode = XOR_OPERATION_MODE_MEMSET;
 		break;
 	default:
-		dev_err(chan->device->common.dev,
+		dev_err(mv_chan_to_devp(chan),
 			"error: unsupported operation %d.\n",
 			type);
 		BUG();
@@ -220,7 +223,7 @@ static void mv_chan_activate(struct mv_xor_chan *chan)
 {
 	u32 activation;
 
-	dev_dbg(chan->device->common.dev, " activate chan.\n");
+	dev_dbg(mv_chan_to_devp(chan), " activate chan.\n");
 	activation = __raw_readl(XOR_ACTIVATION(chan));
 	activation |= 0x1;
 	__raw_writel(activation, XOR_ACTIVATION(chan));
@@ -248,7 +251,7 @@ static int mv_chan_xor_slot_count(size_t len, int src_cnt)
 static void mv_xor_free_slots(struct mv_xor_chan *mv_chan,
 			      struct mv_xor_desc_slot *slot)
 {
-	dev_dbg(mv_chan->device->common.dev, "%s %d slot %p\n",
+	dev_dbg(mv_chan_to_devp(mv_chan), "%s %d slot %p\n",
 		__func__, __LINE__, slot);
 
 	slot->slots_per_op = 0;
@@ -263,7 +266,7 @@ static void mv_xor_free_slots(struct mv_xor_chan *mv_chan,
 static void mv_xor_start_new_chain(struct mv_xor_chan *mv_chan,
 				   struct mv_xor_desc_slot *sw_desc)
 {
-	dev_dbg(mv_chan->device->common.dev, "%s %d: sw_desc %p\n",
+	dev_dbg(mv_chan_to_devp(mv_chan), "%s %d: sw_desc %p\n",
 		__func__, __LINE__, sw_desc);
 	if (sw_desc->type != mv_chan->current_type)
 		mv_set_mode(mv_chan, sw_desc->type);
@@ -350,7 +353,7 @@ mv_xor_clean_completed_slots(struct mv_xor_chan *mv_chan)
 {
 	struct mv_xor_desc_slot *iter, *_iter;
 
-	dev_dbg(mv_chan->device->common.dev, "%s %d\n", __func__, __LINE__);
+	dev_dbg(mv_chan_to_devp(mv_chan), "%s %d\n", __func__, __LINE__);
 	list_for_each_entry_safe(iter, _iter, &mv_chan->completed_slots,
 				 completed_node) {
 
@@ -366,7 +369,7 @@ static int
 mv_xor_clean_slot(struct mv_xor_desc_slot *desc,
 	struct mv_xor_chan *mv_chan)
 {
-	dev_dbg(mv_chan->device->common.dev, "%s %d: desc %p flags %d\n",
+	dev_dbg(mv_chan_to_devp(mv_chan), "%s %d: desc %p flags %d\n",
 		__func__, __LINE__, desc, desc->async_tx.flags);
 	list_del(&desc->chain_node);
 	/* the client is allowed to attach dependent operations
@@ -390,8 +393,8 @@ static void __mv_xor_slot_cleanup(struct mv_xor_chan *mv_chan)
 	u32 current_desc = mv_chan_get_current_desc(mv_chan);
 	int seen_current = 0;
 
-	dev_dbg(mv_chan->device->common.dev, "%s %d\n", __func__, __LINE__);
-	dev_dbg(mv_chan->device->common.dev, "current_desc %x\n", current_desc);
+	dev_dbg(mv_chan_to_devp(mv_chan), "%s %d\n", __func__, __LINE__);
+	dev_dbg(mv_chan_to_devp(mv_chan), "current_desc %x\n", current_desc);
 	mv_xor_clean_completed_slots(mv_chan);
 
 	/* free completed slots from the chain starting with
@@ -544,7 +547,7 @@ mv_xor_tx_submit(struct dma_async_tx_descriptor *tx)
 	dma_cookie_t cookie;
 	int new_hw_chain = 1;
 
-	dev_dbg(mv_chan->device->common.dev,
+	dev_dbg(mv_chan_to_devp(mv_chan),
 		"%s sw_desc %p: async_tx %p\n",
 		__func__, sw_desc, &sw_desc->async_tx);
 
@@ -567,7 +570,7 @@ mv_xor_tx_submit(struct dma_async_tx_descriptor *tx)
 		if (!mv_can_chain(grp_start))
 			goto submit_done;
 
-		dev_dbg(mv_chan->device->common.dev, "Append to last desc %x\n",
+		dev_dbg(mv_chan_to_devp(mv_chan), "Append to last desc %x\n",
 			old_chain_tail->async_tx.phys);
 
 		/* fix up the hardware chain */
@@ -636,7 +639,7 @@ static int mv_xor_alloc_chan_resources(struct dma_chan *chan)
 					struct mv_xor_desc_slot,
 					slot_node);
 
-	dev_dbg(mv_chan->device->common.dev,
+	dev_dbg(mv_chan_to_devp(mv_chan),
 		"allocated %d descriptor slots last_used: %p\n",
 		mv_chan->slots_allocated, mv_chan->last_used);
 
@@ -651,7 +654,7 @@ mv_xor_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	struct mv_xor_desc_slot *sw_desc, *grp_start;
 	int slot_cnt;
 
-	dev_dbg(mv_chan->device->common.dev,
+	dev_dbg(mv_chan_to_devp(mv_chan),
 		"%s dest: %x src %x len: %u flags: %ld\n",
 		__func__, dest, src, len, flags);
 	if (unlikely(len < MV_XOR_MIN_BYTE_COUNT))
@@ -675,7 +678,7 @@ mv_xor_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	}
 	spin_unlock_bh(&mv_chan->lock);
 
-	dev_dbg(mv_chan->device->common.dev,
+	dev_dbg(mv_chan_to_devp(mv_chan),
 		"%s sw_desc %p async_tx %p\n",
 		__func__, sw_desc, sw_desc ? &sw_desc->async_tx : 0);
 
@@ -690,7 +693,7 @@ mv_xor_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
 	struct mv_xor_desc_slot *sw_desc, *grp_start;
 	int slot_cnt;
 
-	dev_dbg(mv_chan->device->common.dev,
+	dev_dbg(mv_chan_to_devp(mv_chan),
 		"%s dest: %x len: %u flags: %ld\n",
 		__func__, dest, len, flags);
 	if (unlikely(len < MV_XOR_MIN_BYTE_COUNT))
@@ -713,7 +716,7 @@ mv_xor_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
 		sw_desc->unmap_len = len;
 	}
 	spin_unlock_bh(&mv_chan->lock);
-	dev_dbg(mv_chan->device->common.dev,
+	dev_dbg(mv_chan_to_devp(mv_chan),
 		"%s sw_desc %p async_tx %p \n",
 		__func__, sw_desc, &sw_desc->async_tx);
 	return sw_desc ? &sw_desc->async_tx : NULL;
@@ -732,7 +735,7 @@ mv_xor_prep_dma_xor(struct dma_chan *chan, dma_addr_t dest, dma_addr_t *src,
 
 	BUG_ON(len > MV_XOR_MAX_BYTE_COUNT);
 
-	dev_dbg(mv_chan->device->common.dev,
+	dev_dbg(mv_chan_to_devp(mv_chan),
 		"%s src_cnt: %d len: dest %x %u flags: %ld\n",
 		__func__, src_cnt, len, dest, flags);
 
@@ -753,7 +756,7 @@ mv_xor_prep_dma_xor(struct dma_chan *chan, dma_addr_t dest, dma_addr_t *src,
 			mv_desc_set_src_addr(grp_start, src_cnt, src[src_cnt]);
 	}
 	spin_unlock_bh(&mv_chan->lock);
-	dev_dbg(mv_chan->device->common.dev,
+	dev_dbg(mv_chan_to_devp(mv_chan),
 		"%s sw_desc %p async_tx %p \n",
 		__func__, sw_desc, &sw_desc->async_tx);
 	return sw_desc ? &sw_desc->async_tx : NULL;
@@ -786,12 +789,12 @@ static void mv_xor_free_chan_resources(struct dma_chan *chan)
 	}
 	mv_chan->last_used = NULL;
 
-	dev_dbg(mv_chan->device->common.dev, "%s slots_allocated %d\n",
+	dev_dbg(mv_chan_to_devp(mv_chan), "%s slots_allocated %d\n",
 		__func__, mv_chan->slots_allocated);
 	spin_unlock_bh(&mv_chan->lock);
 
 	if (in_use_descs)
-		dev_err(mv_chan->device->common.dev,
+		dev_err(mv_chan_to_devp(mv_chan),
 			"freeing %d in use descriptors!\n", in_use_descs);
 }
 
@@ -823,27 +826,27 @@ static void mv_dump_xor_regs(struct mv_xor_chan *chan)
 	u32 val;
 
 	val = __raw_readl(XOR_CONFIG(chan));
-	dev_err(chan->device->common.dev,
+	dev_err(mv_chan_to_devp(chan),
 		"config       0x%08x.\n", val);
 
 	val = __raw_readl(XOR_ACTIVATION(chan));
-	dev_err(chan->device->common.dev,
+	dev_err(mv_chan_to_devp(chan),
 		"activation   0x%08x.\n", val);
 
 	val = __raw_readl(XOR_INTR_CAUSE(chan));
-	dev_err(chan->device->common.dev,
+	dev_err(mv_chan_to_devp(chan),
 		"intr cause   0x%08x.\n", val);
 
 	val = __raw_readl(XOR_INTR_MASK(chan));
-	dev_err(chan->device->common.dev,
+	dev_err(mv_chan_to_devp(chan),
 		"intr mask    0x%08x.\n", val);
 
 	val = __raw_readl(XOR_ERROR_CAUSE(chan));
-	dev_err(chan->device->common.dev,
+	dev_err(mv_chan_to_devp(chan),
 		"error cause  0x%08x.\n", val);
 
 	val = __raw_readl(XOR_ERROR_ADDR(chan));
-	dev_err(chan->device->common.dev,
+	dev_err(mv_chan_to_devp(chan),
 		"error addr   0x%08x.\n", val);
 }
 
@@ -851,12 +854,12 @@ static void mv_xor_err_interrupt_handler(struct mv_xor_chan *chan,
 					 u32 intr_cause)
 {
 	if (intr_cause & (1 << 4)) {
-	     dev_dbg(chan->device->common.dev,
+	     dev_dbg(mv_chan_to_devp(chan),
 		     "ignore this error\n");
 	     return;
 	}
 
-	dev_err(chan->device->common.dev,
+	dev_err(mv_chan_to_devp(chan),
 		"error on chan %d. intr cause 0x%08x.\n",
 		chan->idx, intr_cause);
 
@@ -869,7 +872,7 @@ static irqreturn_t mv_xor_interrupt_handler(int irq, void *data)
 	struct mv_xor_chan *chan = data;
 	u32 intr_cause = mv_chan_get_intr_cause(chan);
 
-	dev_dbg(chan->device->common.dev, "intr cause %x\n", intr_cause);
+	dev_dbg(mv_chan_to_devp(chan), "intr cause %x\n", intr_cause);
 
 	if (mv_is_err_intr(intr_cause))
 		mv_xor_err_interrupt_handler(chan, intr_cause);
-- 
1.7.9.5
