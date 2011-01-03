From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:35:49 +0000
Subject: [PATCH 17/48] ARM: PL08x: consolidate common txd initialization
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt0H-0001P1-B8@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Consolidate code which allocates and initializes txds.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index fada978..d47255e 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1363,6 +1363,18 @@ static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
 	return 0;
 }
 
+static struct pl08x_txd *pl08x_get_txd(struct pl08x_dma_chan *plchan)
+{
+	struct pl08x_txd *txd = kzalloc(sizeof(struct pl08x_txd), GFP_NOWAIT);
+
+	if (txd) {
+		dma_async_tx_descriptor_init(&txd->tx, &plchan->chan);
+		txd->tx.tx_submit = pl08x_tx_submit;
+		INIT_LIST_HEAD(&txd->node);
+	}
+	return txd;
+}
+
 /*
  * Initialize a descriptor to be used by memcpy submit
  */
@@ -1375,14 +1387,13 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 	struct pl08x_txd *txd;
 	int ret;
 
-	txd = kzalloc(sizeof(struct pl08x_txd), GFP_NOWAIT);
+	txd = pl08x_get_txd(plchan);
 	if (!txd) {
 		dev_err(&pl08x->adev->dev,
 			"%s no memory for descriptor\n", __func__);
 		return NULL;
 	}
 
-	dma_async_tx_descriptor_init(&txd->tx, chan);
 	txd->direction = DMA_NONE;
 	txd->srcbus.addr = src;
 	txd->dstbus.addr = dest;
@@ -1391,12 +1402,8 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 	txd->cd = &pl08x->pd->memcpy_channel;
 	/* Both to be incremented or the code will break */
 	txd->cd->cctl |= PL080_CONTROL_SRC_INCR | PL080_CONTROL_DST_INCR;
-	txd->tx.tx_submit = pl08x_tx_submit;
-	txd->tx.callback = NULL;
-	txd->tx.callback_param = NULL;
 	txd->len = len;
 
-	INIT_LIST_HEAD(&txd->node);
 	ret = pl08x_prep_channel_resources(plchan, txd);
 	if (ret)
 		return NULL;
@@ -1430,14 +1437,12 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	dev_dbg(&pl08x->adev->dev, "%s prepare transaction of %d bytes from %s\n",
 		__func__, sgl->length, plchan->name);
 
-	txd = kzalloc(sizeof(struct pl08x_txd), GFP_NOWAIT);
+	txd = pl08x_get_txd(plchan);
 	if (!txd) {
 		dev_err(&pl08x->adev->dev, "%s no txd\n", __func__);
 		return NULL;
 	}
 
-	dma_async_tx_descriptor_init(&txd->tx, chan);
-
 	if (direction != plchan->runtime_direction)
 		dev_err(&pl08x->adev->dev, "%s DMA setup does not match "
 			"the direction configured for the PrimeCell\n",
@@ -1467,11 +1472,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 		return NULL;
 	}
 	txd->cd = plchan->cd;
-	txd->tx.tx_submit = pl08x_tx_submit;
-	txd->tx.callback = NULL;
-	txd->tx.callback_param = NULL;
 	txd->len = sgl->length;
-	INIT_LIST_HEAD(&txd->node);
 
 	ret = pl08x_prep_channel_resources(plchan, txd);
 	if (ret)
-- 
1.6.2.5
