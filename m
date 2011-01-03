From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:34:27 +0000
Subject: [PATCH 13/48] ARM: PL08x: remove unnecessary NULL and BUG checks
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZsyx-0001Ol-Ui@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tasklet always is initialized with a non-NULL data argument.  It
is not possible for it to be called with a NULL data argument (unless
something is very wrong in the tasklet code - in which case lots of
stuff will break).  Therefore, as plchan can never be NULL, remove
this unnecessary BUG check.

In pl08x_tasklet(), we've already dereferenced plchan->at, so it can't
be NULL here.  Remove this unnecessary BUG check.

pl08x_fill_llis_for_desc() and pl08x_free_txd() are always called with
a non-NULL txd argument - either as a consequence of the code paths or
as a result of other checks already in place.  We don't need to repeat
the non-NULL check in these functions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   21 ---------------------
 1 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index d22d628..b721ed2 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -623,11 +623,6 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	struct lli *llis_va;
 	struct lli *llis_bus;
 
-	if (!txd) {
-		dev_err(&pl08x->adev->dev, "%s no descriptor\n", __func__);
-		return 0;
-	}
-
 	txd->llis_va = dma_pool_alloc(pl08x->pool, GFP_NOWAIT,
 				      &txd->llis_bus);
 	if (!txd->llis_va) {
@@ -993,11 +988,6 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 static void pl08x_free_txd(struct pl08x_driver_data *pl08x,
 			   struct pl08x_txd *txd)
 {
-	if (!txd)
-		dev_err(&pl08x->adev->dev,
-			"%s no descriptor to free\n",
-			__func__);
-
 	/* Free the LLI */
 	dma_pool_free(pl08x->pool, txd->llis_va,
 		      txd->llis_bus);
@@ -1633,9 +1623,6 @@ static void pl08x_tasklet(unsigned long data)
 	struct pl08x_driver_data *pl08x = plchan->host;
 	unsigned long flags;
 
-	if (!plchan)
-		BUG();
-
 	spin_lock_irqsave(&plchan->lock, flags);
 
 	if (plchan->at) {
@@ -1656,14 +1643,6 @@ static void pl08x_tasklet(unsigned long data)
 			callback(callback_param);
 
 		/*
-		 * Device callbacks should NOT clear
-		 * the current transaction on the channel
-		 * Linus: sometimes they should?
-		 */
-		if (!plchan->at)
-			BUG();
-
-		/*
 		 * Free the descriptor if it's not for a device
 		 * using a circular buffer
 		 */
-- 
1.6.2.5
