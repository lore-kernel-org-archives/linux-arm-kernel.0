From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:36:09 +0000
Subject: [PATCH 18/48] ARM: PL08x: consolidate physical channel release code
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt0b-0001P7-PT@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Consolidate duplicated channel release code into release_phy_channel()

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index d47255e..e8967ff 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1058,6 +1058,18 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
 	return 0;
 }
 
+static void release_phy_channel(struct pl08x_dma_chan *plchan)
+{
+	struct pl08x_driver_data *pl08x = plchan->host;
+
+	if ((plchan->phychan->signal >= 0) && pl08x->pd->put_signal) {
+		pl08x->pd->put_signal(plchan);
+		plchan->phychan->signal = -1;
+	}
+	pl08x_put_phy_channel(pl08x, plchan->phychan);
+	plchan->phychan = NULL;
+}
+
 static dma_cookie_t pl08x_tx_submit(struct dma_async_tx_descriptor *tx)
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(tx->chan);
@@ -1522,13 +1534,7 @@ static int pl08x_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 			 * Mark physical channel as free and free any slave
 			 * signal
 			 */
-			if ((plchan->phychan->signal >= 0) &&
-			    pl08x->pd->put_signal) {
-				pl08x->pd->put_signal(plchan);
-				plchan->phychan->signal = -1;
-			}
-			pl08x_put_phy_channel(pl08x, plchan->phychan);
-			plchan->phychan = NULL;
+			release_phy_channel(plchan);
 		}
 		/* Dequeue jobs and free LLIs */
 		if (plchan->at) {
@@ -1590,7 +1596,6 @@ static void pl08x_ensure_on(struct pl08x_driver_data *pl08x)
 static void pl08x_tasklet(unsigned long data)
 {
 	struct pl08x_dma_chan *plchan = (struct pl08x_dma_chan *) data;
-	struct pl08x_phy_chan *phychan = plchan->phychan;
 	struct pl08x_driver_data *pl08x = plchan->host;
 	unsigned long flags;
 
@@ -1642,12 +1647,7 @@ static void pl08x_tasklet(unsigned long data)
 		 * No more jobs, so free up the physical channel
 		 * Free any allocated signal on slave transfers too
 		 */
-		if ((phychan->signal >= 0) && pl08x->pd->put_signal) {
-			pl08x->pd->put_signal(plchan);
-			phychan->signal = -1;
-		}
-		pl08x_put_phy_channel(pl08x, phychan);
-		plchan->phychan = NULL;
+		release_phy_channel(plchan);
 		plchan->state = PL08X_CHAN_IDLE;
 
 		/*
-- 
1.6.2.5
