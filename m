From: anup.patel@broadcom.com (Anup Patel)
Date: Mon, 15 May 2017 10:34:53 +0530
Subject: [PATCH v8 2/4] async_tx: Fix DMA_PREP_FENCE usage in
 do_async_gen_syndrome()
In-Reply-To: <1494824695-21797-1-git-send-email-anup.patel@broadcom.com>
References: <1494824695-21797-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1494824695-21797-3-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA_PREP_FENCE is to be used when preparing Tx descriptor if output
of Tx descriptor is to be used by next/dependent Tx descriptor.

The DMA_PREP_FENSE will not be set correctly in do_async_gen_syndrome()
when calling dma->device_prep_dma_pq() under following conditions:
1. ASYNC_TX_FENCE not set in submit->flags
2. DMA_PREP_FENCE not set in dma_flags
3. src_cnt (= (disks - 2)) is greater than dma_maxpq(dma, dma_flags)

This patch fixes DMA_PREP_FENCE usage in do_async_gen_syndrome() taking
inspiration from do_async_xor() implementation.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
---
 crypto/async_tx/async_pq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/crypto/async_tx/async_pq.c b/crypto/async_tx/async_pq.c
index f83de99..56bd612 100644
--- a/crypto/async_tx/async_pq.c
+++ b/crypto/async_tx/async_pq.c
@@ -62,9 +62,6 @@ do_async_gen_syndrome(struct dma_chan *chan,
 	dma_addr_t dma_dest[2];
 	int src_off = 0;
 
-	if (submit->flags & ASYNC_TX_FENCE)
-		dma_flags |= DMA_PREP_FENCE;
-
 	while (src_cnt > 0) {
 		submit->flags = flags_orig;
 		pq_src_cnt = min(src_cnt, dma_maxpq(dma, dma_flags));
@@ -83,6 +80,8 @@ do_async_gen_syndrome(struct dma_chan *chan,
 			if (cb_fn_orig)
 				dma_flags |= DMA_PREP_INTERRUPT;
 		}
+		if (submit->flags & ASYNC_TX_FENCE)
+			dma_flags |= DMA_PREP_FENCE;
 
 		/* Drivers force forward progress in case they can not provide
 		 * a descriptor
-- 
2.7.4
