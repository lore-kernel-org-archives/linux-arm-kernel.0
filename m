From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:40:59 +0100
Subject: [RFC 17/34] dmaengine: PL08x: split DMA signal muxing from channel
 alloc
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZIvD-0006zq-NT@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split the DMA request mux signal handling from the physical channel
allocation code.  The physical channel has very little to do with the
DMA request input which will be used, so these should be two separate
operations.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   43 ++++++++++++++++++++++++++++++++++++-------
 1 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index fa1f9d2..7156d49 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -292,6 +292,39 @@ static inline struct pl08x_txd *to_pl08x_txd(struct dma_async_tx_descriptor *tx)
 }
 
 /*
+ * Mux handling.
+ *
+ * This gives us the DMA request input to the PL08x primecell which the
+ * peripheral described by the channel data will be routed to, possibly
+ * via a board/SoC specific external MUX.  One important point to note
+ * here is that this does not depend on the physical channel.
+ */
+static int pl08x_request_mux(struct pl08x_dma_chan *plchan, struct pl08x_phy_chan *ch)
+{
+	const struct pl08x_platform_data *pd = plchan->host->pd;
+	int ret;
+
+	if (pd->get_signal) {
+		ret = pd->get_signal(plchan->cd);
+		if (ret < 0)
+			return ret;
+
+		ch->signal = ret;
+	}
+	return 0;
+}
+
+static void pl08x_release_mux(struct pl08x_dma_chan *plchan)
+{
+	const struct pl08x_platform_data *pd = plchan->host->pd;
+
+	if (plchan->phychan->signal >= 0 && pd->put_signal) {
+		pd->put_signal(plchan->cd, plchan->phychan->signal);
+		plchan->phychan->signal = -1;
+	}
+}
+
+/*
  * Physical channel handling
  */
 
@@ -995,8 +1028,8 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
 	 * need, but for slaves the physical signals may be muxed!
 	 * Can the platform allow us to use this channel?
 	 */
-	if (plchan->slave && pl08x->pd->get_signal) {
-		ret = pl08x->pd->get_signal(plchan->cd);
+	if (plchan->slave) {
+		ret = pl08x_request_mux(plchan, ch);
 		if (ret < 0) {
 			dev_dbg(&pl08x->adev->dev,
 				"unable to use physical channel %d for transfer on %s due to platform restrictions\n",
@@ -1005,7 +1038,6 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
 			pl08x_put_phy_channel(pl08x, ch);
 			return -EBUSY;
 		}
-		ch->signal = ret;
 	}
 
 	plchan->phychan = ch;
@@ -1030,10 +1062,7 @@ static void release_phy_channel(struct pl08x_dma_chan *plchan)
 {
 	struct pl08x_driver_data *pl08x = plchan->host;
 
-	if ((plchan->phychan->signal >= 0) && pl08x->pd->put_signal) {
-		pl08x->pd->put_signal(plchan->cd, plchan->phychan->signal);
-		plchan->phychan->signal = -1;
-	}
+	pl08x_release_mux(plchan);
 	pl08x_put_phy_channel(pl08x, plchan->phychan);
 	plchan->phychan = NULL;
 }
-- 
1.7.4.4
