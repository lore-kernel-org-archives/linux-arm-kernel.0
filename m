From: don.morris@hp.com (Don Morris)
Date: Wed, 29 Feb 2012 12:28:15 -0800
Subject: [PATCH] iop-adma: Corrected array overflow in RAID6 Xscale(R) test.
Message-ID: <1330547295-25615-1-git-send-email-don.morris@hp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reported as: https://bugzilla.kernel.org/show_bug.cgi?id=42677

Test code pq_src array was grown by two elements to correspond with actual
usage (IOP_ADMA_NUM_SRC_TEST+2), stack consumption was kept constant by
modifying the pq_dest two element array which is only used when pq_src
is referenced up to IOP_ADMA_NUM_SRC_TEST elements into the address
of the new last two elements of the pq_src array. This is presumed to
be the original intent but would be reliant on compilers always having
pq_dest contiguous with the final element of pq_src.
---
 drivers/dma/iop-adma.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index 04be90b..58173ee 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -1271,8 +1271,8 @@ iop_adma_pq_zero_sum_self_test(struct iop_adma_device *device)
 	struct page **pq_hw = &pq[IOP_ADMA_NUM_SRC_TEST+2];
 	/* address conversion buffers (dma_map / page_address) */
 	void *pq_sw[IOP_ADMA_NUM_SRC_TEST+2];
-	dma_addr_t pq_src[IOP_ADMA_NUM_SRC_TEST];
-	dma_addr_t pq_dest[2];
+	dma_addr_t pq_src[IOP_ADMA_NUM_SRC_TEST+2];
+	dma_addr_t *pq_dest = &(pq_src[IOP_ADMA_NUM_SRC_TEST]);
 
 	int i;
 	struct dma_async_tx_descriptor *tx;
-- 
1.7.9.111.gf3fb0
