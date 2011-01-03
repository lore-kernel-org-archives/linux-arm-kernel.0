From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:43:56 +0000
Subject: [PATCH 41/48] ARM: PL08x: store prep_* flags in async_tx structure
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt88-0003S4-6A@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Like other DMA engine drivers do, store the passed flags into the
async_tx structure, so they can be checked when the operation
completes.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 8d8d33c..00058e3 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1277,12 +1277,14 @@ static u32 pl08x_select_bus(struct pl08x_driver_data *pl08x, u8 src, u8 dst)
 	return cctl;
 }
 
-static struct pl08x_txd *pl08x_get_txd(struct pl08x_dma_chan *plchan)
+static struct pl08x_txd *pl08x_get_txd(struct pl08x_dma_chan *plchan,
+	unsigned long flags)
 {
 	struct pl08x_txd *txd = kzalloc(sizeof(struct pl08x_txd), GFP_NOWAIT);
 
 	if (txd) {
 		dma_async_tx_descriptor_init(&txd->tx, &plchan->chan);
+		txd->tx.flags = flags;
 		txd->tx.tx_submit = pl08x_tx_submit;
 		INIT_LIST_HEAD(&txd->node);
 
@@ -1305,7 +1307,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 	struct pl08x_txd *txd;
 	int ret;
 
-	txd = pl08x_get_txd(plchan);
+	txd = pl08x_get_txd(plchan, flags);
 	if (!txd) {
 		dev_err(&pl08x->adev->dev,
 			"%s no memory for descriptor\n", __func__);
@@ -1363,7 +1365,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	dev_dbg(&pl08x->adev->dev, "%s prepare transaction of %d bytes from %s\n",
 		__func__, sgl->length, plchan->name);
 
-	txd = pl08x_get_txd(plchan);
+	txd = pl08x_get_txd(plchan, flags);
 	if (!txd) {
 		dev_err(&pl08x->adev->dev, "%s no txd\n", __func__);
 		return NULL;
-- 
1.6.2.5
