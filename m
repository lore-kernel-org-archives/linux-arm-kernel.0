From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:42:40 +0100
Subject: [RFC 22/34] dmaengine: PL08x: remove waiting descriptor pointer
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZIwq-00070A-AK@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we no longer need to pass a descriptor to prep_phy_channel(), we
don't need to keep track of the descriptor which is waiting for a
channel to become available.  So let's get rid of it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 1554aec..e1922f3 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -216,8 +216,6 @@ enum pl08x_dma_chan_state {
  * @host: a pointer to the host (internal use)
  * @state: whether the channel is idle, paused, running etc
  * @slave: whether this channel is a device (slave) or for memcpy
- * @waiting: a TX descriptor on this channel which is waiting for a physical
- * channel to become available
  * @signal: the physical DMA request signal which this channel is using
  * @mux_use: count of descriptors using this DMA request signal setting
  */
@@ -236,7 +234,6 @@ struct pl08x_dma_chan {
 	struct pl08x_driver_data *host;
 	enum pl08x_dma_chan_state state;
 	bool slave;
-	struct pl08x_txd *waiting;
 	int signal;
 	unsigned mux_use;
 };
@@ -1067,7 +1064,6 @@ static dma_cookie_t pl08x_tx_submit(struct dma_async_tx_descriptor *tx)
 	if (!plchan->slave && !plchan->phychan) {
 		/* Do this memcpy whenever there is a channel ready */
 		plchan->state = PL08X_CHAN_WAITING;
-		plchan->waiting = txd;
 	} else {
 		plchan->phychan_hold--;
 	}
@@ -1686,8 +1682,7 @@ static void pl08x_tasklet(unsigned long data)
 		 */
 		list_for_each_entry(waiting, &pl08x->memcpy.channels,
 				    chan.device_node) {
-			if (waiting->state == PL08X_CHAN_WAITING &&
-				waiting->waiting != NULL) {
+			if (waiting->state == PL08X_CHAN_WAITING) {
 				int ret;
 
 				/* This should REALLY not fail now */
@@ -1695,7 +1690,6 @@ static void pl08x_tasklet(unsigned long data)
 				BUG_ON(ret);
 				waiting->phychan_hold--;
 				waiting->state = PL08X_CHAN_RUNNING;
-				waiting->waiting = NULL;
 				pl08x_issue_pending(&waiting->chan);
 				break;
 			}
-- 
1.7.4.4
