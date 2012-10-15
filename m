From: Elen.Song@atmel.com (Song, Elen)
Date: Mon, 15 Oct 2012 09:18:47 +0000
Subject: [PATCH] DMA: AT91: Get residual bytes in dma buffer
Message-ID: <E8F7C03B253D5640818937FAAE6B175C39DC2F95@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The main purpose of atc_tx_status is to get residual bytes when dma transfer in progress or complete.

Residual bytes is the number of bytes left to read from DMA source.
During transfer, residual bytes is changing as DMA read from its source.
When transfer complete, the residual bytes is zero.

atc_get_bytes_left will dynamically get bytes left in dma buffer.
It reads count register bit btsize to get residue, the btsize only indicate current descriptor receive data.
So we should let atc_get_bytes_left know when descriptor switch or dma transfer done.
DMA_CTRL_ACK is a useful ack, it means current descriptor can not be reused when clear.
The atc_get_bytes_left will find out whether move to next descriptor or transfer done.

So in dma handler, we get residue like below:
dma_handler() {
        async_tx_clear_ack; //clear ack, tell driver it is time to switch descriptor
        read residue;
        async_tx_ack; //move to next descriptor
                        // no need to set ack when dma transfer done }

DMA should be pause so that we can trust data count.

Signed-off-by: Elen Song <elen.song@atmel.com>
---
 drivers/dma/at_hdmac.c      |  127 +++++++++++++++++++++++++++++++++++++++----
 drivers/dma/at_hdmac_regs.h |    4 ++
 2 files changed, 120 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c index 13a02f4..b0aa783 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -229,6 +229,101 @@ static void atc_dostart(struct at_dma_chan *atchan, struct at_desc *first)
 	vdbg_dump_regs(atchan);
 }
 
+/*
+ * atc_get_current_descriptors - get descriptor which equal to
+ * physical address in DSCR.
+ * @atchan: the channel we want to start
+ * @dscr_addr: physical descriptor address in DSCR  */ static struct 
+at_desc *atc_get_current_descriptors(struct at_dma_chan *atchan,
+							u32 dscr_addr)
+{
+	struct at_desc  *desc, *_desc, *child, *desc_cur = NULL;
+
+	list_for_each_entry_safe(desc, _desc, &atchan->active_list, desc_node) 
+{
+
+		if (desc->lli.dscr == dscr_addr) {
+			desc_cur = desc;
+			break;
+		}
+
+		list_for_each_entry(child, &desc->tx_list, desc_node) {
+
+			if (child->lli.dscr == dscr_addr) {
+				desc_cur = child;
+				break;
+			}
+		}
+	}
+
+	return desc_cur;
+}
+
+/*
+ * atc_get_bytes_left - Get the number of bytes
+ * residue in dma buffer,
+ * it is unwise to call this before stopping the channel for
+ * absolute measures.
+ * @atchan: the channel we want to start  */ static int 
+atc_get_bytes_left(struct at_dma_chan *atchan) {
+	struct at_desc *desc_first;
+	int left = 0, count = 0;
+	u32 dscr_addr;
+
+	/* First descriptor embedds additional information */
+	desc_first = atc_first_active(atchan);
+	if (!desc_first)
+		return -EINVAL;
+
+	/* Initialize necessary value in the first time.
+	 * We use desc_cur to save current descriptor,
+	 * save_len record residual dma buffer length.
+	 */
+	if (!atchan->desc_cur &&
+	    !atchan->save_len) {
+		atchan->desc_cur = desc_first;
+		atchan->save_len = desc_first->len;
+	}
+
+	/* This happend in the end of dma transfer or descriptor switch,
+	 * during the dma interrupt handler, DMA_CTRL_ACK should be cleared.
+	 * We trigger this flag to get residual values.
+	 * To be aware of, two conditions should be taken into consideration:
+	 * at the end of a dma transfer, or descriptors switch.
+	 */
+	if (!(desc_first->txd.flags & DMA_CTRL_ACK)) {
+		dscr_addr = channel_readl(atchan, DSCR);
+		/* End of a single or cyclic transfer */
+		if (dscr_addr == 0 || dscr_addr == desc_first->lli.dscr) {
+			atchan->desc_cur = NULL;
+			atchan->save_len = 0;
+		/* Switch between two descriptor.
+		 * Current descriptor transfer done.
+		 * The residual buffer length should reduce current descriptor.
+		 */
+		} else {
+			atchan->desc_cur = atc_get_current_descriptors(atchan,
+								dscr_addr);
+			if (!atchan->desc_cur)
+				return -EINVAL;
+			atchan->save_len -= (atchan->desc_cur->lli.ctrla
+						& ATC_BTSIZE_MAX);
+		}
+
+		left = atchan->save_len;
+	}
+
+	/* Get residual value during a descriptor transfer */
+	if (atchan->desc_cur) {
+		count = channel_readl(atchan, CTRLA) & ATC_BTSIZE_MAX;
+		left = atchan->save_len - count;
+	}
+
+	return left;
+}
+
 /**
  * atc_chain_complete - finish work for one transaction chain
  * @atchan: channel we work on
@@ -1034,23 +1129,33 @@ atc_tx_status(struct dma_chan *chan,
 	dma_cookie_t		last_complete;
 	unsigned long		flags;
 	enum dma_status		ret;
-
-	spin_lock_irqsave(&atchan->lock, flags);
+	int bytes = 0;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret != DMA_SUCCESS) {
-		atc_cleanup_descriptors(atchan);
-
-		ret = dma_cookie_status(chan, cookie, txstate);
+	/* Residue is zero while transactions complete */
+	if (ret == DMA_SUCCESS) {
+		dma_set_residue(txstate, 0);
+		return ret;
+	}
+	/*
+	 * There's no point calculating the residue if there's
+	 * no txstate to store the value.
+	 */
+	if (!txstate) {
+		if (atc_chan_is_paused(atchan))
+			ret = DMA_PAUSED;
+		return ret;
 	}
 
-	last_complete = chan->completed_cookie;
-	last_used = chan->cookie;
+	spin_lock_irqsave(&atchan->lock, flags);
 
-	spin_unlock_irqrestore(&atchan->lock, flags);
+	/*  Get number of bytes left in the active transactions */
+	bytes = atc_get_bytes_left(atchan);
+	if (bytes < 0)
+		dev_err(chan2dev(chan), "get residue value error\n");
+	dma_set_residue(txstate, bytes);
 
-	if (ret != DMA_SUCCESS)
-		dma_set_residue(txstate, atc_first_active(atchan)->len);
+	spin_unlock_irqrestore(&atchan->lock, flags);
 
 	if (atc_chan_is_paused(atchan))
 		ret = DMA_PAUSED;
diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h index 116e4ad..ea8d747 100644
--- a/drivers/dma/at_hdmac_regs.h
+++ b/drivers/dma/at_hdmac_regs.h
@@ -226,12 +226,14 @@ enum atc_status {
  * @save_cfg: configuration register that is saved on suspend/resume cycle
  * @save_dscr: for cyclic operations, preserve next descriptor address in
  *             the cyclic list on suspend/resume cycle
+ * @save_len: to record dma buffer length
  * @dma_sconfig: configuration for slave transfers, passed via DMA_SLAVE_CONFIG
  * @lock: serializes enqueue/dequeue operations to descriptors lists
  * @active_list: list of descriptors dmaengine is being running on
  * @queue: list of descriptors ready to be submitted to engine
  * @free_list: list of descriptors usable by the channel
  * @descs_allocated: records the actual size of the descriptor pool
+ * @desc_cur: current descriptor
  */
 struct at_dma_chan {
 	struct dma_chan		chan_common;
@@ -242,6 +244,7 @@ struct at_dma_chan {
 	struct tasklet_struct	tasklet;
 	u32			save_cfg;
 	u32			save_dscr;
+	u32			save_len;
 	struct dma_slave_config dma_sconfig;
 
 	spinlock_t		lock;
@@ -251,6 +254,7 @@ struct at_dma_chan {
 	struct list_head	queue;
 	struct list_head	free_list;
 	unsigned int		descs_allocated;
+	struct at_desc		*desc_cur;
 };
 
 #define	channel_readl(atchan, name) \
--
1.7.9.5
