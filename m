From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 07 Jun 2012 11:55:31 +0100
Subject: [CFT 29/31] dmaengine: PL08x: get rid of pl08x_prep_channel_resources
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Message-ID: <E1ScaNH-0003mO-09@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function is now unnecessary; we can move its internals inline
instead.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   32 +++++++++-----------------------
 1 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index c42c7ef..9297240 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1352,25 +1352,6 @@ static void pl08x_issue_pending(struct dma_chan *chan)
 	spin_unlock_irqrestore(&plchan->vc.lock, flags);
 }
 
-static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
-					struct pl08x_txd *txd)
-{
-	struct pl08x_driver_data *pl08x = plchan->host;
-	int num_llis;
-
-	num_llis = pl08x_fill_llis_for_desc(pl08x, txd);
-	if (!num_llis) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&plchan->vc.lock, flags);
-		pl08x_free_txd(pl08x, txd);
-		spin_unlock_irqrestore(&plchan->vc.lock, flags);
-
-		return -EINVAL;
-	}
-	return 0;
-}
-
 static struct pl08x_txd *pl08x_get_txd(struct pl08x_dma_chan *plchan)
 {
 	struct pl08x_txd *txd = kzalloc(sizeof(*txd), GFP_NOWAIT);
@@ -1430,9 +1411,11 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 		txd->cctl |= pl08x_select_bus(pl08x->mem_buses,
 					      pl08x->mem_buses);
 
-	ret = pl08x_prep_channel_resources(plchan, txd);
-	if (ret)
+	ret = pl08x_fill_llis_for_desc(plchan->host, txd);
+	if (!ret) {
+		pl08x_free_txd(pl08x, txd);
 		return NULL;
+	}
 
 	return vchan_tx_prep(&plchan->vc, &txd->vd, flags);
 }
@@ -1546,9 +1529,12 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 		}
 	}
 
-	ret = pl08x_prep_channel_resources(plchan, txd);
-	if (ret)
+	ret = pl08x_fill_llis_for_desc(plchan->host, txd);
+	if (!ret) {
+		pl08x_release_mux(plchan);
+		pl08x_free_txd(pl08x, txd);
 		return NULL;
+	}
 
 	return vchan_tx_prep(&plchan->vc, &txd->vd, flags);
 }
-- 
1.7.4.4
