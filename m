From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:41:34 +0000
Subject: [PATCH 34/48] ARM: PL08x: move callback outside spinlock'd region
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt5q-0003Rc-40@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calling the callback handler with spinlocks in the tasklet held leads
to deadlock when dmaengine functions are called:

BUG: spinlock lockup on CPU#0, sh/417, c1870a08
Backtrace:
...
[<c017b408>] (do_raw_spin_lock+0x0/0x154) from [<c02c4b98>] (_raw_spin_lock_irqsave+0x54/0x60)
[<c02c4b44>] (_raw_spin_lock_irqsave+0x0/0x60) from [<c01f5828>] (pl08x_prep_channel_resources+0x718/0x8b4)
[<c01f5110>] (pl08x_prep_channel_resources+0x0/0x8b4) from [<c01f5bb4>] (pl08x_prep_slave_sg+0x120/0x19c)
[<c01f5a94>] (pl08x_prep_slave_sg+0x0/0x19c) from [<c01be7a0>] (pl011_dma_tx_refill+0x164/0x224)
[<c01be63c>] (pl011_dma_tx_refill+0x0/0x224) from [<c01bf1c8>] (pl011_dma_tx_callback+0x7c/0xc4)
[<c01bf14c>] (pl011_dma_tx_callback+0x0/0xc4) from [<c01f4d34>] (pl08x_tasklet+0x60/0x368)
[<c01f4cd4>] (pl08x_tasklet+0x0/0x368) from [<c004d978>] (tasklet_action+0xa0/0x100)

Dan quoted the documentation:
> 2/ Completion callback routines cannot submit new operations. ?This
> ? ?results in recursion in the synchronous case and spin_locks being
> ? ?acquired twice in the asynchronous case.

but then followed up to say:
> I should clarify, this is the async_memcpy() api requirement which is
> not used outside of md/raid5.  DMA drivers can and do allow new
> submissions from callbacks, and the ones that do so properly move the
> callback outside of the driver lock.

So let's fix it by moving the callback out of the spinlocked region.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 986c127..660165d 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1540,32 +1540,29 @@ static void pl08x_tasklet(unsigned long data)
 {
 	struct pl08x_dma_chan *plchan = (struct pl08x_dma_chan *) data;
 	struct pl08x_driver_data *pl08x = plchan->host;
+	struct pl08x_txd *txd;
+	dma_async_tx_callback callback = NULL;
+	void *callback_param = NULL;
 	unsigned long flags;
 
 	spin_lock_irqsave(&plchan->lock, flags);
 
-	if (plchan->at) {
-		dma_async_tx_callback callback =
-			plchan->at->tx.callback;
-		void *callback_param =
-			plchan->at->tx.callback_param;
+	txd = plchan->at;
+	plchan->at = NULL;
 
-		/*
-		 * Update last completed
-		 */
-		plchan->lc = plchan->at->tx.cookie;
+	if (txd) {
+		callback = txd->tx.callback;
+		callback_param = txd->tx.callback_param;
 
 		/*
-		 * Callback to signal completion
+		 * Update last completed
 		 */
-		if (callback)
-			callback(callback_param);
+		plchan->lc = txd->tx.cookie;
 
 		/*
 		 * Free the descriptor
 		 */
-		pl08x_free_txd(pl08x, plchan->at);
-		plchan->at = NULL;
+		pl08x_free_txd(pl08x, txd);
 	}
 	/*
 	 * If a new descriptor is queued, set it up
@@ -1616,6 +1613,10 @@ static void pl08x_tasklet(unsigned long data)
 	}
 
 	spin_unlock_irqrestore(&plchan->lock, flags);
+
+	/* Callback to signal completion */
+	if (callback)
+		callback(callback_param);
 }
 
 static irqreturn_t pl08x_irq(int irq, void *dev)
-- 
1.6.2.5
