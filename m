From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:41:19 +0100
Subject: [RFC 18/34] dmaengine: PL08x: move DMA signal muxing into
 pl08x_dma_chan struct
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZIvX-0006zu-R9@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the signal handling out of the physical channel structure into
the virtual channel structure, where it should belong as it has more
to do with the virtual channel than the physical one.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 7156d49..e5b13e6 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -132,8 +132,6 @@ struct pl08x_bus_data {
  * struct pl08x_phy_chan - holder for the physical channels
  * @id: physical index to this channel
  * @lock: a lock to use when altering an instance of this struct
- * @signal: the physical signal (aka channel) serving this physical channel
- * right now
  * @serving: the virtual channel currently being served by this physical
  * channel
  */
@@ -141,7 +139,6 @@ struct pl08x_phy_chan {
 	unsigned int id;
 	void __iomem *base;
 	spinlock_t lock;
-	int signal;
 	struct pl08x_dma_chan *serving;
 };
 
@@ -222,6 +219,7 @@ enum pl08x_dma_chan_state {
  * @slave: whether this channel is a device (slave) or for memcpy
  * @waiting: a TX descriptor on this channel which is waiting for a physical
  * channel to become available
+ * @signal: the physical DMA request signal which this channel is using
  */
 struct pl08x_dma_chan {
 	struct dma_chan chan;
@@ -238,6 +236,7 @@ struct pl08x_dma_chan {
 	enum pl08x_dma_chan_state state;
 	bool slave;
 	struct pl08x_txd *waiting;
+	int signal;
 };
 
 /**
@@ -299,7 +298,7 @@ static inline struct pl08x_txd *to_pl08x_txd(struct dma_async_tx_descriptor *tx)
  * via a board/SoC specific external MUX.  One important point to note
  * here is that this does not depend on the physical channel.
  */
-static int pl08x_request_mux(struct pl08x_dma_chan *plchan, struct pl08x_phy_chan *ch)
+static int pl08x_request_mux(struct pl08x_dma_chan *plchan)
 {
 	const struct pl08x_platform_data *pd = plchan->host->pd;
 	int ret;
@@ -309,7 +308,7 @@ static int pl08x_request_mux(struct pl08x_dma_chan *plchan, struct pl08x_phy_cha
 		if (ret < 0)
 			return ret;
 
-		ch->signal = ret;
+		plchan->signal = ret;
 	}
 	return 0;
 }
@@ -318,9 +317,9 @@ static void pl08x_release_mux(struct pl08x_dma_chan *plchan)
 {
 	const struct pl08x_platform_data *pd = plchan->host->pd;
 
-	if (plchan->phychan->signal >= 0 && pd->put_signal) {
-		pd->put_signal(plchan->cd, plchan->phychan->signal);
-		plchan->phychan->signal = -1;
+	if (plchan->signal >= 0 && pd->put_signal) {
+		pd->put_signal(plchan->cd, plchan->signal);
+		plchan->signal = -1;
 	}
 }
 
@@ -545,7 +544,6 @@ pl08x_get_phy_channel(struct pl08x_driver_data *pl08x,
 
 		if (!ch->serving) {
 			ch->serving = virt_chan;
-			ch->signal = -1;
 			spin_unlock_irqrestore(&ch->lock, flags);
 			break;
 		}
@@ -1029,7 +1027,7 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
 	 * Can the platform allow us to use this channel?
 	 */
 	if (plchan->slave) {
-		ret = pl08x_request_mux(plchan, ch);
+		ret = pl08x_request_mux(plchan);
 		if (ret < 0) {
 			dev_dbg(&pl08x->adev->dev,
 				"unable to use physical channel %d for transfer on %s due to platform restrictions\n",
@@ -1043,15 +1041,15 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
 	plchan->phychan = ch;
 	dev_dbg(&pl08x->adev->dev, "allocated physical channel %d and signal %d for xfer on %s\n",
 		 ch->id,
-		 ch->signal,
+		 plchan->signal,
 		 plchan->name);
 
 got_channel:
 	/* Assign the flow control signal to this channel */
 	if (txd->direction == DMA_MEM_TO_DEV)
-		txd->ccfg |= ch->signal << PL080_CONFIG_DST_SEL_SHIFT;
+		txd->ccfg |= plchan->signal << PL080_CONFIG_DST_SEL_SHIFT;
 	else if (txd->direction == DMA_DEV_TO_MEM)
-		txd->ccfg |= ch->signal << PL080_CONFIG_SRC_SEL_SHIFT;
+		txd->ccfg |= plchan->signal << PL080_CONFIG_SRC_SEL_SHIFT;
 
 	plchan->phychan_hold++;
 
@@ -1818,6 +1816,7 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 
 		chan->host = pl08x;
 		chan->state = PL08X_CHAN_IDLE;
+		chan->signal = -1;
 
 		if (slave) {
 			chan->cd = &pl08x->pd->slave_channels[i];
@@ -2054,7 +2053,6 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		ch->base = pl08x->base + PL080_Cx_BASE(i);
 		spin_lock_init(&ch->lock);
 		ch->serving = NULL;
-		ch->signal = -1;
 		dev_dbg(&adev->dev, "physical channel %d is %s\n",
 			i, pl08x_phy_channel_busy(ch) ? "BUSY" : "FREE");
 	}
-- 
1.7.4.4
