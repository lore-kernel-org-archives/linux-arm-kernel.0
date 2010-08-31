From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 31 Aug 2010 14:12:06 +0200
Subject: [PATCH 04/12] DMAENGINE: use GFP_NOWAIT for PL08X allocations
In-Reply-To: <1283256734-3408-4-git-send-email-linus.walleij@stericsson.com>
References: <1283256734-3408-1-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-2-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-3-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-4-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1283256734-3408-5-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since DMA jobs can be prepared and fired in IRQ context, request
GFP_NOWAIT memory for the structs.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/dma/amba-pl08x.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 506749b..d1a4813 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -628,7 +628,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 		return 0;
 	}
 
-	txd->llis_va = dma_pool_alloc(pl08x->pool, GFP_KERNEL,
+	txd->llis_va = dma_pool_alloc(pl08x->pool, GFP_NOWAIT,
 				      &txd->llis_bus);
 	if (!txd->llis_va) {
 		dev_err(&pl08x->adev->dev, "%s no memory for llis\n", __func__);
@@ -1564,7 +1564,7 @@ struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	dev_dbg(&pl08x->adev->dev, "%s prepare transaction of %d bytes from %s\n",
 		__func__, sgl->length, plchan->name);
 
-	txd = kzalloc(sizeof(struct pl08x_txd), GFP_KERNEL);
+	txd = kzalloc(sizeof(struct pl08x_txd), GFP_NOWAIT);
 	if (!txd) {
 		dev_err(&pl08x->adev->dev, "%s no txd\n", __func__);
 		return NULL;
-- 
1.6.3.3
