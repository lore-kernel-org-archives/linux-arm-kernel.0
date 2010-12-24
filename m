From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Dec 2010 10:08:25 +0000
Subject: [PATCH 07/11] ARM: PL08x: don't try to use llis_bus as a pointer
In-Reply-To: <20101224100550.GB20587@n2100.arm.linux.org.uk>
References: <20101224100550.GB20587@n2100.arm.linux.org.uk>
Message-ID: <E1PW4ZV-0006De-6b@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

llis_bus is the DMA address of the LLI array.  Casting it to be a
pointer just to be able to use pointer arithmetic on it is not nice.
We can trivially deal with the places where we do arithmetic on it,
and it's actually cleaner this way.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 04c3350..29890b1 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -555,7 +555,7 @@ int pl08x_fill_lli_for_desc(struct pl08x_driver_data *pl08x,
 			    u32 cctl, u32 *remainder)
 {
 	struct lli *llis_va = txd->llis_va;
-	struct lli *llis_bus = (struct lli *) txd->llis_bus;
+	dma_addr_t llis_bus = txd->llis_bus;
 
 	BUG_ON(num_llis >= MAX_NUM_TSFR_LLIS);
 
@@ -572,8 +572,7 @@ int pl08x_fill_lli_for_desc(struct pl08x_driver_data *pl08x,
 	 * memory. So we don't manipulate this bit currently.
 	 */
 
-	llis_va[num_llis].lli =
-		(dma_addr_t)((u32) &(llis_bus[num_llis + 1]));
+	llis_va[num_llis].lli = llis_bus + (num_llis + 1) * sizeof(struct lli);
 
 	if (cctl & PL080_CONTROL_SRC_INCR)
 		txd->srcbus.addr += len;
@@ -617,7 +616,6 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	int max_bytes_per_lli;
 	int total_bytes = 0;
 	struct lli *llis_va;
-	struct lli *llis_bus;
 
 	if (!txd) {
 		dev_err(&pl08x->adev->dev, "%s no descriptor\n", __func__);
@@ -932,15 +930,13 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	 * Decide whether this is a loop or a terminated transfer
 	 */
 	llis_va = txd->llis_va;
-	llis_bus = (struct lli *) txd->llis_bus;
 
 	if (cd->circular_buffer) {
 		/*
 		 * Loop the circular buffer so that the next element
 		 * points back to the beginning of the LLI.
 		 */
-		llis_va[num_llis - 1].lli =
-			(dma_addr_t)((unsigned int)&(llis_bus[0]));
+		llis_va[num_llis - 1].lli = txd->llis_bus;
 	} else {
 		/*
 		 * On non-circular buffers, the final LLI terminates
@@ -995,8 +991,7 @@ static void pl08x_free_txd(struct pl08x_driver_data *pl08x,
 			__func__);
 
 	/* Free the LLI */
-	dma_pool_free(pl08x->pool, txd->llis_va,
-		      txd->llis_bus);
+	dma_pool_free(pl08x->pool, txd->llis_va, txd->llis_bus);
 
 	pl08x->pool_ctr--;
 
-- 
1.6.2.5
