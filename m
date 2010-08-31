From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 31 Aug 2010 14:12:10 +0200
Subject: [PATCH 08/12] DMAENGINE: be more explicit when freeing PL08X signals
In-Reply-To: <1283256734-3408-8-git-send-email-linus.walleij@stericsson.com>
References: <1283256734-3408-1-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-2-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-3-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-4-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-5-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-6-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-7-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-8-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1283256734-3408-9-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The signals connected to the PL08X physical channels shall not
be tangled up with the physical channels themselves. This gets
some reference counting right.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/dma/amba-pl08x.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index a99ad19..a7ce08e 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -449,7 +449,6 @@ static inline void pl08x_put_phy_channel(struct pl08x_driver_data *pl08x,
 	/* Mark it as free */
 	spin_lock_irqsave(&ch->lock, flags);
 	ch->serving = NULL;
-	ch->signal = -1;
 	spin_unlock_irqrestore(&ch->lock, flags);
 }
 
@@ -1100,8 +1099,10 @@ static void pl08x_tasklet(unsigned long data)
 		 * No more jobs, so free up the physical channel
 		 * Free any allocated signal on slave transfers too
 		 */
-		if ((phychan->signal >= 0) && pl08x->pd->put_signal)
+		if ((phychan->signal >= 0) && pl08x->pd->put_signal) {
 			pl08x->pd->put_signal(plchan);
+			phychan->signal = -1;
+		}
 		pl08x_put_phy_channel(pl08x, phychan);
 		plchan->phychan = NULL;
 	}
@@ -1193,6 +1194,7 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
 	 */
 	if ((txd->direction == DMA_FROM_DEVICE ||
 	     txd->direction == DMA_TO_DEVICE) &&
+	    ch->signal < 0 &&
 	    pl08x->pd->get_signal) {
 		ret = pl08x->pd->get_signal(plchan);
 		if (ret < 0) {
@@ -1653,8 +1655,10 @@ static int pl08x_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 			 * signal
 			 */
 			if ((plchan->phychan->signal >= 0) &&
-			    pl08x->pd->put_signal)
+			    pl08x->pd->put_signal) {
 				pl08x->pd->put_signal(plchan);
+				plchan->phychan->signal = -1;
+			}
 			pl08x_put_phy_channel(pl08x, plchan->phychan);
 			plchan->phychan = NULL;
 		}
-- 
1.6.3.3
