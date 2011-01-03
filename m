From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:45:37 +0000
Subject: [PATCH 46/48] ARM: PL08x: fix locking between prepare function and
	submit function
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt9l-0003Sk-Ll@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PL08x driver holds on to the channel lock with interrupts disabled
between the prepare and the subsequent submit API functions.  This
means that the locking state when the prepare function returns is
dependent on whether it suceeeds or not.

It did this to ensure that the physical channel wasn't released, and
as it used to add the descriptor onto the pending list at prepare time
rather than submit time.

Now that we have reorganized the code to remove those reasons, we can
now safely release the spinlock at the end of preparation and reacquire
it in our submit function.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |   28 +++++++++-------------------
 include/linux/amba/pl08x.h |    4 ----
 2 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index bf6f7d0..1c9f712 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -981,6 +981,9 @@ static dma_cookie_t pl08x_tx_submit(struct dma_async_tx_descriptor *tx)
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(tx->chan);
 	struct pl08x_txd *txd = to_pl08x_txd(tx);
+	unsigned long flags;
+
+	spin_lock_irqsave(&plchan->lock, flags);
 
 	plchan->chan.cookie += 1;
 	if (plchan->chan.cookie < 0)
@@ -1003,8 +1006,7 @@ static dma_cookie_t pl08x_tx_submit(struct dma_async_tx_descriptor *tx)
 		plchan->phychan_hold--;
 	}
 
-	/* This unlock follows the lock in the prep() function */
-	spin_unlock_irqrestore(&plchan->lock, plchan->lockflags);
+	spin_unlock_irqrestore(&plchan->lock, flags);
 
 	return tx->cookie;
 }
@@ -1225,9 +1227,9 @@ static void pl08x_issue_pending(struct dma_chan *chan)
 static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
 					struct pl08x_txd *txd)
 {
-	int num_llis;
 	struct pl08x_driver_data *pl08x = plchan->host;
-	int ret;
+	unsigned long flags;
+	int num_llis, ret;
 
 	num_llis = pl08x_fill_llis_for_desc(pl08x, txd);
 	if (!num_llis) {
@@ -1235,7 +1237,7 @@ static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&plchan->lock, plchan->lockflags);
+	spin_lock_irqsave(&plchan->lock, flags);
 
 	/*
 	 * See if we already have a physical channel allocated,
@@ -1258,7 +1260,7 @@ static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
 		if (plchan->slave) {
 			pl08x_free_txd_list(pl08x, plchan);
 			pl08x_free_txd(pl08x, txd);
-			spin_unlock_irqrestore(&plchan->lock, plchan->lockflags);
+			spin_unlock_irqrestore(&plchan->lock, flags);
 			return -EBUSY;
 		}
 	} else
@@ -1272,11 +1274,7 @@ static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
 		if (plchan->state == PL08X_CHAN_IDLE)
 			plchan->state = PL08X_CHAN_PAUSED;
 
-	/*
-	 * Notice that we leave plchan->lock locked on purpose:
-	 * it will be unlocked in the subsequent tx_submit()
-	 * call. This is a consequence of the current API.
-	 */
+	spin_unlock_irqrestore(&plchan->lock, flags);
 
 	return 0;
 }
@@ -1355,10 +1353,6 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 	ret = pl08x_prep_channel_resources(plchan, txd);
 	if (ret)
 		return NULL;
-	/*
-	 * NB: the channel lock is held at this point so tx_submit()
-	 * must be called in direct succession.
-	 */
 
 	return &txd->tx;
 }
@@ -1444,10 +1438,6 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	ret = pl08x_prep_channel_resources(plchan, txd);
 	if (ret)
 		return NULL;
-	/*
-	 * NB: the channel lock is held at this point so tx_submit()
-	 * must be called in direct succession.
-	 */
 
 	return &txd->tx;
 }
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 95b76ea..933b4ed 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -162,9 +162,6 @@ enum pl08x_dma_chan_state {
  * @lc: last completed transaction on this channel
  * @pend_list: queued transactions pending on this channel
  * @at: active transaction on this channel
- * @lockflags: sometimes we let a lock last between two function calls,
- * especially prep/submit, and then we need to store the IRQ flags
- * in the channel state, here
  * @lock: a lock for this channel data
  * @host: a pointer to the host (internal use)
  * @state: whether the channel is idle, paused, running etc
@@ -184,7 +181,6 @@ struct pl08x_dma_chan {
 	dma_cookie_t lc;
 	struct list_head pend_list;
 	struct pl08x_txd *at;
-	unsigned long lockflags;
 	spinlock_t lock;
 	struct pl08x_driver_data *host;
 	enum pl08x_dma_chan_state state;
-- 
1.6.2.5
