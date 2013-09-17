From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Tue, 17 Sep 2013 15:56:08 +0200
Subject: [[PATCH] 3/3] dma: imx-dma: fix callback path in tasklet
In-Reply-To: <1379426168-31989-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1379426168-31989-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1379426168-31989-4-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to free the ld_active list head before jumping into the callback
routine. Otherwise the callback could run into issue_pending and change
our ld_active list head we just going to free. This will run the channel
list into an currupted and undefined state.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/dma/imx-dma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 247aa7c..55852c0 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -627,13 +627,11 @@ static void imxdma_tasklet(unsigned long data)
 
 	if (list_empty(&imxdmac->ld_active)) {
 		/* Someone might have called terminate all */
-		goto out;
+		spin_unlock_irqrestore(&imxdma->lock, flags);
+		return;
 	}
 	desc = list_first_entry(&imxdmac->ld_active, struct imxdma_desc, node);
 
-	if (desc->desc.callback)
-		desc->desc.callback(desc->desc.callback_param);
-
 	/* If we are dealing with a cyclic descriptor, keep it on ld_active
 	 * and dont mark the descriptor as complete.
 	 * Only in non-cyclic cases it would be marked as complete
@@ -661,6 +659,10 @@ static void imxdma_tasklet(unsigned long data)
 	}
 out:
 	spin_unlock_irqrestore(&imxdma->lock, flags);
+
+	if (desc->desc.callback)
+		desc->desc.callback(desc->desc.callback_param);
+
 }
 
 static int imxdma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
-- 
1.8.4.rc3
