From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:46:01 +0100
Subject: [RFC 32/34] dmaengine: PL08x: get rid of pl08x_prep_channel_resources
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZJ05-00070z-Eq@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function is now unnecessary; we can move its internals inline
instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   32 +++++++++-----------------------
 1 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index a8f2b20..9132993 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1345,25 +1345,6 @@ static void pl08x_issue_pending(struct dma_chan *chan)
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
@@ -1423,9 +1404,11 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
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
@@ -1539,9 +1522,12 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
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
