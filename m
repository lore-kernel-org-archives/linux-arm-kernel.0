From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Sat, 5 Oct 2013 19:36:20 +0200 (CEST)
Subject: [PATCH] DMA: extend documentation to provide more API details
Message-ID: <Pine.LNX.4.64.1310051925170.8097@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends dmaengine documentation to provide more details
on descriptor prepare stage, transaction completion requirements
and DMA error processing.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

These extensions reflect my understanding of some aspects of the dmaengine 
API. If it is wrong, I'd be happy if someone could correct me. If or where 
I'm right, I think, those aspects might want an update. Once we understand 
exactly the situation we can think about improvements to the API.

 Documentation/dmaengine.txt |   58 ++++++++++++++++++++++++++++++++++++------
 1 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/Documentation/dmaengine.txt b/Documentation/dmaengine.txt
index 879b6e3..21bb72d 100644
--- a/Documentation/dmaengine.txt
+++ b/Documentation/dmaengine.txt
@@ -133,8 +133,17 @@ The slave DMA usage consists of following steps:
 	locks before calling the callback function which may cause a
 	deadlock.
 
-	Note that callbacks will always be invoked from the DMA
-	engines tasklet, never from interrupt context.
+	Note that callbacks will always be invoked from the DMA engine's
+	interrupt processing bottom half, never from interrupt context.
+
+   Note 2:
+	A DMA transaction descriptor, returned to the user by one of "prep"
+	methods is considered as belogning to the user until it is submitted
+	to the dmaengine driver for transfer. However, it is recommended, that
+	the dmaengine driver keeps references to prepared descriptors too,
+	because if dmaengine_terminate_all() is called at that time, the driver
+	will have to recycle all allocated descriptors for the respective
+	channel.
 
 4. Submit the transaction
 
@@ -150,15 +159,27 @@ The slave DMA usage consists of following steps:
    dmaengine_submit() will not start the DMA operation, it merely adds
    it to the pending queue.  For this, see step 5, dma_async_issue_pending.
 
-5. Issue pending DMA requests and wait for callback notification
+5. Issue pending DMA requests and (optionally) request callback notification
 
-   The transactions in the pending queue can be activated by calling the
-   issue_pending API. If channel is idle then the first transaction in
-   queue is started and subsequent ones queued up.
+   Dmaengine drivers accumulate submitted transactions on a pending queue.
+   After this call all such pending transactions are activated. Transactions,
+   submitted after this call will be queued again in a deactivated state until
+   this function is called again. If at the time of this call the channel is
+   idle then the first transaction in queue is started and subsequent ones are
+   queued up.
 
-   On completion of each DMA operation, the next in queue is started and
-   a tasklet triggered. The tasklet will then call the client driver
-   completion callback routine for notification, if set.
+   On completion of each DMA operation, the next active transaction in queue is
+   started and the ISR bottom half, e.g. a tasklet or a kernel thread is
+   triggered. The tasklet will then call the client driver completion callback
+   routine for notification, if set.
+
+   The dmaengine driver also has to check the DMA_CTRL_ACK flag by calling
+   async_tx_test_ack() on the transaction. If the function returns true, i.e.
+   if the transaction either has been flagged from the very beginning, or
+   the user has flagged it later, then the transaction descriptor can be
+   recycled immediately by the dmaengine driver. If the function returns
+   false, the descriptor cannot be recycled yet and the dmaengine driver has
+   to keep polling the descriptor until it is acknowledged by the user.
 
    Interface:
 	void dma_async_issue_pending(struct dma_chan *chan);
@@ -171,6 +192,14 @@ Further APIs:
    discard data in the DMA FIFO which hasn't been fully transferred.
    No callback functions will be called for any incomplete transfers.
 
+   Note:
+	Transactions, aborted by this call are considered as failed. However,
+	if the user requests their status, using dma_async_is_complete() /
+	dma_async_is_complete(), as described below, one of DMA_IN_PROGRESS and
+	DMA_SUCCESS will be returned. So, drivers are advised not to use those
+	calls on transactions, submitted before a call to
+	dmaengine_terminate_all().
+
 2. int dmaengine_pause(struct dma_chan *chan)
 
    This pauses activity on the DMA channel without data loss.
@@ -196,3 +225,14 @@ Further APIs:
 	a running DMA channel.  It is recommended that DMA engine users
 	pause or stop (via dmaengine_terminate_all) the channel before
 	using this API.
+
+DMA error handling
+
+1. If a DMA error occurs, usually the DMA driver has to abort the transaction in
+   progress. Since transactions, queued after the aborted one can depend on it,
+   they usually have to be dropped too. There is currently no way to notify
+   users about such a problem, so, users should normally start all DMA
+   transactions with a timeout handler. If a timeout occurs, the user shall
+   assume, that the DMA transaction failed. However, due to the same reason, as
+   described in a note to the dmaengine_terminate_all() description above,
+   enquiring status of timed out transactions is unreliable.
-- 
1.7.2.5
