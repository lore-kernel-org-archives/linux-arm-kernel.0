From: elen.song@atmel.com (Elen Song)
Date: Fri, 26 Oct 2012 15:32:26 +0800
Subject: [PATCH v2] DMA: AT91: Get residual bytes in dma buffer
Message-ID: <1351236746-4721-1-git-send-email-elen.song@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for returning the residue for a particular descriptor by
reading the BTSIZE in CTRLA register.

- If the cookie has completed successfully, the residue will be zero.
- If the cookie is in progress or the channel is paused, it will be
  the number of bytes yet to be transferred.
- If the cookie is queued, it will be the number of bytes in the
  descriptor.
- If get residue error, the cookie will be turn into error status,
  and dma transfer will be terminated.

Signed-off-by: Elen Song <elen.song@atmel.com>
---
Change compare to v1:
1. Do not need to use DMA_CTRL_ACK flag to know descriptor transfer complete.
2. Pause dma before read residue.
3. Change comment.

 drivers/dma/at_hdmac.c      |  137 +++++++++++++++++++++++++++++++++++++++----
 drivers/dma/at_hdmac_regs.h |    5 ++
 2 files changed, 131 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 13a02f4..c771e83 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -229,6 +229,101 @@ static void atc_dostart(struct at_dma_chan *atchan, struct at_desc *first)
 	vdbg_dump_regs(atchan);
 }
 
+/*
+ * atc_get_current_descriptors -
+ * locate the descriptor which equal to physical address in DSCR
+ * @atchan: the channel we want to start
+ * @dscr_addr: physical descriptor address in DSCR
+ */
+static struct at_desc *atc_get_current_descriptors(struct at_dma_chan *atchan,
+							u32 dscr_addr)
+{
+	struct at_desc  *desc, *_desc, *child, *desc_cur = NULL;
+
+	list_for_each_entry_safe(desc, _desc, &atchan->active_list, desc_node) {
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
+ * atc_get_bytes_left -
+ * Get the number of bytes residue in dma buffer,
+ * the channel should be paused when calling this
+ * @atchan: the channel we want to start
+ */
+static int atc_get_bytes_left(struct at_dma_chan *atchan)
+{
+	struct at_desc *desc_first;
+	int left = 0, count = 0;
+	u32 dscr_addr;
+
+	/* First descriptor embedds the transaction length */
+	desc_first = atc_first_active(atchan);
+	if (!desc_first)
+		return -EINVAL;
+	/*
+	 * Initialize necessary values in the first time.
+	 * We use desc_cur to save current descriptor,
+	 * save_len record residual dma buffer length.
+	 */
+	if (!atchan->desc_cur &&
+	    !atchan->save_len) {
+		atchan->desc_cur = desc_first;
+		atchan->save_len = desc_first->len;
+	}
+	/*
+	 * This happens when current descriptor transfer complete.
+	 * When transfer terminated, we reset the necessary values.
+	 * Otherwise, we calculate the remain buffer size.
+	 */
+	if (test_and_clear_bit(ATC_IS_BTC, &atchan->status)) {
+		dscr_addr = channel_readl(atchan, DSCR);
+		/* End of a single or cyclic transfer */
+		if (dscr_addr == 0 || dscr_addr == desc_first->lli.dscr) {
+			atchan->desc_cur = NULL;
+			atchan->save_len = 0;
+		/*
+		 * Current descriptor transfer done and switch to next.
+		 * The residual buffer size should
+		 * reduce current descriptor length.
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
+	/*
+	 * Get residual bytes when current descriptor transfer in progress.
+	 */
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
@@ -494,6 +589,8 @@ static irqreturn_t at_dma_interrupt(int irq, void *dev_id)
 					/* Give information to tasklet */
 					set_bit(ATC_IS_ERROR, &atchan->status);
 				}
+				if (pending & AT_DMA_BTC(i))
+					set_bit(ATC_IS_BTC, &atchan->status);
 				tasklet_schedule(&atchan->tasklet);
 				ret = IRQ_HANDLED;
 			}
@@ -1034,32 +1131,50 @@ atc_tx_status(struct dma_chan *chan,
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
 	}
+	/*
+	 * There's no point calculating the residue if there's
+	 * no txstate to store the value.
+	 */
+	if (!txstate)
+		goto err_dma;
 
-	last_complete = chan->completed_cookie;
-	last_used = chan->cookie;
+	/* Channel should be paused before get residue */
+	if (!atc_chan_is_paused(atchan))
+		atc_control(chan, DMA_PAUSE, 0);
+
+	spin_lock_irqsave(&atchan->lock, flags);
+
+	/*  Get number of bytes left in the active transactions */
+	bytes = atc_get_bytes_left(atchan);
 
 	spin_unlock_irqrestore(&atchan->lock, flags);
 
-	if (ret != DMA_SUCCESS)
-		dma_set_residue(txstate, atc_first_active(atchan)->len);
+	if (bytes < 0)
+		goto err_dma;
+	else
+		dma_set_residue(txstate, bytes);
 
 	if (atc_chan_is_paused(atchan))
-		ret = DMA_PAUSED;
+		atc_control(chan, DMA_RESUME, 0);
 
 	dev_vdbg(chan2dev(chan), "tx_status %d: cookie = %d (d%d, u%d)\n",
 		 ret, cookie, last_complete ? last_complete : 0,
 		 last_used ? last_used : 0);
 
 	return ret;
+
+err_dma:
+	atc_control(chan, DMA_TERMINATE_ALL, 0);
+	ret = DMA_ERROR;
+	return ret;
 }
 
 /**
diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
index 116e4ad..b1861cb 100644
--- a/drivers/dma/at_hdmac_regs.h
+++ b/drivers/dma/at_hdmac_regs.h
@@ -211,6 +211,7 @@ txd_to_at_desc(struct dma_async_tx_descriptor *txd)
 enum atc_status {
 	ATC_IS_ERROR = 0,
 	ATC_IS_PAUSED = 1,
+	ATC_IS_BTC = 2,
 	ATC_IS_CYCLIC = 24,
 };
 
@@ -226,12 +227,14 @@ enum atc_status {
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
@@ -242,6 +245,7 @@ struct at_dma_chan {
 	struct tasklet_struct	tasklet;
 	u32			save_cfg;
 	u32			save_dscr;
+	u32			save_len;
 	struct dma_slave_config dma_sconfig;
 
 	spinlock_t		lock;
@@ -251,6 +255,7 @@ struct at_dma_chan {
 	struct list_head	queue;
 	struct list_head	free_list;
 	unsigned int		descs_allocated;
+	struct at_desc		*desc_cur;
 };
 
 #define	channel_readl(atchan, name) \
-- 
1.7.9.5
