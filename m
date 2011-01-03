From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:37:10 +0000
Subject: [PATCH 21/48] ARM: PL08x: don't try to use llis_bus as a pointer
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt1a-0001PJ-PU@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

llis_bus is the DMA address of the LLI array.  Casting it to be a
pointer just to be able to use pointer arithmetic on it is not nice.
We can trivially deal with the places where we do arithmetic on it,
and it's actually cleaner this way.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 1081165..760b71e 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -559,7 +559,7 @@ static int pl08x_fill_lli_for_desc(struct pl08x_driver_data *pl08x,
 			    u32 cctl, u32 *remainder)
 {
 	struct pl08x_lli *llis_va = txd->llis_va;
-	struct pl08x_lli *llis_bus = (struct pl08x_lli *) txd->llis_bus;
+	dma_addr_t llis_bus = txd->llis_bus;
 
 	BUG_ON(num_llis >= MAX_NUM_TSFR_LLIS);
 
@@ -576,8 +576,7 @@ static int pl08x_fill_lli_for_desc(struct pl08x_driver_data *pl08x,
 	 * memory. So we don't manipulate this bit currently.
 	 */
 
-	llis_va[num_llis].next =
-		(dma_addr_t)((u32) &(llis_bus[num_llis + 1]));
+	llis_va[num_llis].next = llis_bus + (num_llis + 1) * sizeof(struct pl08x_lli);
 
 	if (cctl & PL080_CONTROL_SRC_INCR)
 		txd->srcbus.addr += len;
@@ -621,7 +620,6 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	int max_bytes_per_lli;
 	int total_bytes = 0;
 	struct pl08x_lli *llis_va;
-	struct pl08x_lli *llis_bus;
 
 	txd->llis_va = dma_pool_alloc(pl08x->pool, GFP_NOWAIT,
 				      &txd->llis_bus);
@@ -971,8 +969,7 @@ static void pl08x_free_txd(struct pl08x_driver_data *pl08x,
 			   struct pl08x_txd *txd)
 {
 	/* Free the LLI */
-	dma_pool_free(pl08x->pool, txd->llis_va,
-		      txd->llis_bus);
+	dma_pool_free(pl08x->pool, txd->llis_va, txd->llis_bus);
 
 	pl08x->pool_ctr--;
 
-- 
1.6.2.5
