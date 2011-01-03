From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:44:57 +0000
Subject: [PATCH 44/48] ARM: PL08x: put txd's on the pending list in
	pl08x_tx_submit()
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt97-0003SG-5J@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't place TXDs on the pending list when they're prepared - place
them on the list when they're ready to be submitted.  Also, only
place memcpy requests in the wait state when they're submitted and
don't have a physical channel associated.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   46 ++++++++++++++++++++++++++++++++--------------
 1 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 433b9e7..650e2bb 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -173,6 +173,11 @@ static inline struct pl08x_dma_chan *to_pl08x_chan(struct dma_chan *chan)
 	return container_of(chan, struct pl08x_dma_chan, chan);
 }
 
+static inline struct pl08x_txd *to_pl08x_txd(struct dma_async_tx_descriptor *tx)
+{
+	return container_of(tx, struct pl08x_txd, tx);
+}
+
 /*
  * Physical channel handling
  */
@@ -974,11 +979,27 @@ static void release_phy_channel(struct pl08x_dma_chan *plchan)
 static dma_cookie_t pl08x_tx_submit(struct dma_async_tx_descriptor *tx)
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(tx->chan);
+	struct pl08x_txd *txd = to_pl08x_txd(tx);
 
 	plchan->chan.cookie += 1;
 	if (plchan->chan.cookie < 0)
 		plchan->chan.cookie = 1;
 	tx->cookie = plchan->chan.cookie;
+
+	/* Put this onto the pending list */
+	list_add_tail(&txd->node, &plchan->pend_list);
+
+	/*
+	 * If there was no physical channel available for this memcpy,
+	 * stack the request up and indicate that the channel is waiting
+	 * for a free physical channel.
+	 */
+	if (!plchan->slave && !plchan->phychan) {
+		/* Do this memcpy whenever there is a channel ready */
+		plchan->state = PL08X_CHAN_WAITING;
+		plchan->waiting = txd;
+	}
+
 	/* This unlock follows the lock in the prep() function */
 	spin_unlock_irqrestore(&plchan->lock, plchan->lockflags);
 
@@ -1213,8 +1234,6 @@ static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
 
 	spin_lock_irqsave(&plchan->lock, plchan->lockflags);
 
-	list_add_tail(&txd->node, &plchan->pend_list);
-
 	/*
 	 * See if we already have a physical channel allocated,
 	 * else this is the time to try to get one.
@@ -1222,24 +1241,23 @@ static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
 	ret = prep_phy_channel(plchan, txd);
 	if (ret) {
 		/*
-		 * No physical channel available, we will
-		 * stack up the memcpy channels until there is a channel
-		 * available to handle it whereas slave transfers may
-		 * have been denied due to platform channel muxing restrictions
-		 * and since there is no guarantee that this will ever be
-		 * resolved, and since the signal must be acquired AFTER
-		 * acquiring the physical channel, we will let them be NACK:ed
-		 * with -EBUSY here. The drivers can alway retry the prep()
-		 * call if they are eager on doing this using DMA.
+		 * No physical channel was available.
+		 *
+		 * memcpy transfers can be sorted out at submission time.
+		 *
+		 * Slave transfers may have been denied due to platform
+		 * channel muxing restrictions.  Since there is no guarantee
+		 * that this will ever be resolved, and the signal must be
+		 * acquired AFTER acquiring the physical channel, we will let
+		 * them be NACK:ed with -EBUSY here. The drivers can retry
+		 * the prep() call if they are eager on doing this using DMA.
 		 */
 		if (plchan->slave) {
 			pl08x_free_txd_list(pl08x, plchan);
+			pl08x_free_txd(pl08x, txd);
 			spin_unlock_irqrestore(&plchan->lock, plchan->lockflags);
 			return -EBUSY;
 		}
-		/* Do this memcpy whenever there is a channel ready */
-		plchan->state = PL08X_CHAN_WAITING;
-		plchan->waiting = txd;
 	} else
 		/*
 		 * Else we're all set, paused and ready to roll,
-- 
1.6.2.5
