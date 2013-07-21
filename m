From: joelf@ti.com (Joel Fernandes)
Date: Sun, 21 Jul 2013 01:57:56 -0500
Subject: [RFC 1/5] dma: edma: Setup parameters to DMA MAX_SG_NR at a time
Message-ID: <1374389876-32500-1-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes are made here for configuring existing parameters to support
DMA'ing them out in batches as needed.

Also allocate as many as slots as needed by the SG list, but not more
than MAX_SG_NR. Then these slots will be reused accordingly.
For ex, if MAX_SG_NR=10, and number of SG entries is 40, still only
10 slots will be allocated to DMA the entire SG list of size 40.

Also enable TC interrupts for slots that are a last in a current
iteration, or that fall on a MAX_SG_NR boundary.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 drivers/dma/edma.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 083ecff..9b9954e 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -223,9 +223,11 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 	enum dma_slave_buswidth dev_width;
 	u32 burst;
 	struct scatterlist *sg;
-	int i;
+
 	int acnt, bcnt, ccnt, src, dst, cidx;
 	int src_bidx, dst_bidx, src_cidx, dst_cidx;
+	int i, ret;
+	int num_slots_needed;
 
 	if (unlikely(!echan || !sgl || !sg_len))
 		return NULL;
@@ -257,8 +259,11 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 
 	edesc->pset_nr = sg_len;
 
-	for_each_sg(sgl, sg, sg_len, i) {
-		/* Allocate a PaRAM slot, if needed */
+	/* Allocate a PaRAM slot, if needed */
+
+	num_slots_needed = sg_len > MAX_NR_SG ? MAX_NR_SG : sg_len;
+
+	for (i = 0; i < num_slots_needed; i++) {
 		if (echan->slot[i] < 0) {
 			echan->slot[i] =
 				edma_alloc_slot(EDMA_CTLR(echan->ch_num),
@@ -268,6 +273,10 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 				return NULL;
 			}
 		}
+	}
+
+	/* Configure PaRAM sets for each SG */
+	for_each_sg(sgl, sg, sg_len, i) {
 
 		acnt = dev_width;
 
@@ -325,6 +334,12 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 		/* Configure A or AB synchronized transfers */
 		if (edesc->absync)
 			edesc->pset[i].opt |= SYNCDIM;
+
+		/* If this is the last in a current SG set of transactions,
+		   enable interrupts so that next set is processed */
+		if (!((i+1) % MAX_NR_SG))
+			edesc->pset[i].opt |= TCINTEN;
+
 		/* If this is the last set, enable completion interrupt flag */
 		if (i == sg_len - 1)
 			edesc->pset[i].opt |= TCINTEN;
-- 
1.7.9.5
