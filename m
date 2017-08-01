From: jiaheng.fan@nxp.com (jiaheng.fan)
Date: Tue, 1 Aug 2017 10:14:09 +0800
Subject: [PATCH v1 4/6] dma: fsl-qdma: add workaround for TKT329166
In-Reply-To: <1501553651-7203-1-git-send-email-jiaheng.fan@nxp.com>
References: <1501553651-7203-1-git-send-email-jiaheng.fan@nxp.com>
Message-ID: <1501553651-7203-5-git-send-email-jiaheng.fan@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The qDMA completion queue has a Status Enqueue Required (SER) bit per
entry to indicate if a DMA job needs to enqueue over the QMan DCP
portal. This bit is first set when the completion queue entry is
allocated and the descriptor SER bit is also set. An entry is ready to
be enqueued when the DMA engine completes the DMA transfer for that job.
After a completion entry enqueues, the SER bit is cleared to indicate
that the entry can be removed which is done by shifting the queue. It is
possible that an earlier allocated entry is ready to shift (enqueued
previous cycle) while an entry is performing an enqueue
which requires clearing the SER bit next cycle. During the shift of the
queue, the SER bit is not cleared properly and will remain set which
causes an additional enqueue to occur for the same job.

Workaround:  In the software, if the duplicate status notification is
seen, then discard it (calling ?check duplicate status and discard? ).

Signed-off-by: jiaheng.fan <jiaheng.fan@nxp.com>
---
 drivers/dma/fsl-qdma.c | 125 +++++++++++++++++++++++++++++++------------------
 1 file changed, 80 insertions(+), 45 deletions(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 7b9e09a..8c24b40 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -87,6 +87,7 @@
 #define FSL_QDMA_BCQMR_CQ_SIZE(x)	((x) << 16)
 
 #define FSL_QDMA_BCQSR_QF		0x10000
+#define FSL_QDMA_BCQSR_XOFF		0x1
 
 #define FSL_QDMA_BSQMR_EN		0x80000000
 #define FSL_QDMA_BSQMR_DI		0x40000000
@@ -117,6 +118,8 @@
 #define FSL_QDMA_E_DATA_BUFFER		0
 #define FSL_QDMA_F_LAST_ENTRY		1
 
+u64 pre_addr, pre_queue;
+
 struct fsl_qdma_ccdf {
 	u8 status;
 	u32 rev1:22;
@@ -673,67 +676,87 @@ static int fsl_qdma_halt(struct fsl_qdma_engine *fsl_qdma)
 	return 0;
 }
 
-static void fsl_qdma_queue_transfer_complete(struct fsl_qdma_engine *fsl_qdma)
+static int fsl_qdma_queue_transfer_complete(struct fsl_qdma_engine *fsl_qdma)
 {
 	struct fsl_qdma_queue *fsl_queue = fsl_qdma->queue;
 	struct fsl_qdma_queue *fsl_status = fsl_qdma->status;
 	struct fsl_qdma_queue *temp_queue;
 	struct fsl_qdma_comp *fsl_comp;
 	struct fsl_qdma_ccdf *status_addr;
-	void __iomem *ctrl = fsl_qdma->ctrl_base;
+	struct fsl_qdma_csgf *csgf_src;
 	void __iomem *block = fsl_qdma->block_base;
 	u32 reg, i;
-
+	bool duplicate, duplicate_handle;
 
 	while (1) {
-		status_addr = fsl_status->virt_head++;
-		if (fsl_status->virt_head == fsl_status->cq + fsl_status->n_cq)
-			fsl_status->virt_head = fsl_status->cq;
-		/*
-		 * Sacn all the queues.
-		 * Match which queue completed this transfer.
-		 */
-		for (i = 0; i < fsl_qdma->n_queues; i++) {
-			temp_queue = fsl_queue + i;
-			if (list_empty(&temp_queue->comp_used))
-				continue;
+		duplicate = 0;
+		duplicate_handle = 0;
+		reg = qdma_readl(fsl_qdma, block + FSL_QDMA_BSQSR);
+		if (reg & FSL_QDMA_BSQSR_QE)
+			return 0;
+		status_addr = fsl_status->virt_head;
+		if (status_addr->queue == pre_queue &&
+			status_addr->addr == pre_addr)
+			duplicate = 1;
+
+		i = status_addr->queue;
+		pre_queue = status_addr->queue;
+		pre_addr = status_addr->addr;
+		temp_queue = fsl_queue + i;
+		spin_lock(&temp_queue->queue_lock);
+		if (list_empty(&temp_queue->comp_used)) {
+			if (duplicate)
+				duplicate_handle = 1;
+			else {
+				spin_unlock(&temp_queue->queue_lock);
+				return -1;
+			}
+		} else {
 			fsl_comp = list_first_entry(&temp_queue->comp_used,
 							struct fsl_qdma_comp,
 							list);
+			csgf_src = (struct fsl_qdma_csgf *)fsl_comp->virt_addr
+							   + 2;
 			if (fsl_comp->bus_addr + 16 !=
-						(dma_addr_t)status_addr->addr)
-				continue;
-			spin_lock(&temp_queue->queue_lock);
-			list_del(&fsl_comp->list);
-			spin_unlock(&temp_queue->queue_lock);
+					(dma_addr_t)status_addr->addr) {
+				if (duplicate)
+					duplicate_handle = 1;
+				else {
+					spin_unlock(&temp_queue->queue_lock);
+					return -1;
+				}
+			}
+		}
 
+			if (duplicate_handle) {
 			reg = qdma_readl(fsl_qdma, block + FSL_QDMA_BSQMR);
 			reg |= FSL_QDMA_BSQMR_DI;
+			status_addr->addr = 0x0;
+			fsl_status->virt_head++;
+			if (fsl_status->virt_head == fsl_status->cq
+						   + fsl_status->n_cq)
+				fsl_status->virt_head = fsl_status->cq;
 			qdma_writel(fsl_qdma, reg, block + FSL_QDMA_BSQMR);
-
-			spin_lock(&fsl_comp->qchan->vchan.lock);
-			vchan_cookie_complete(&fsl_comp->vdesc);
-			fsl_comp->qchan->status = DMA_COMPLETE;
-			spin_unlock(&fsl_comp->qchan->vchan.lock);
-			break;
-		}
-		reg = qdma_readl(fsl_qdma, block + FSL_QDMA_BSQSR);
-		if (reg & FSL_QDMA_BSQSR_QE)
-			break;
-		if (i == fsl_qdma->n_queues) {
-			/*
-			 * QDMA appeared serious errors.
-			 * Queue and status interrupt will be disabled.
-			 */
-			reg = qdma_readl(fsl_qdma, ctrl + FSL_QDMA_DMR);
-			reg |= FSL_QDMA_DMR_DQD;
-			qdma_writel(fsl_qdma, reg, ctrl + FSL_QDMA_DMR);
-			qdma_writel(fsl_qdma, 0, block + FSL_QDMA_BCQIER(0));
-			dev_err(fsl_qdma->dma_dev.dev,
-				"QDMA: status err! QDMA has be disabled!\n");
-			return;
+			spin_unlock(&temp_queue->queue_lock);
+			continue;
 		}
+		list_del(&fsl_comp->list);
+
+		reg = qdma_readl(fsl_qdma, block + FSL_QDMA_BSQMR);
+		reg |= FSL_QDMA_BSQMR_DI;
+		status_addr->addr = 0x0;
+		fsl_status->virt_head++;
+		if (fsl_status->virt_head == fsl_status->cq + fsl_status->n_cq)
+			fsl_status->virt_head = fsl_status->cq;
+		qdma_writel(fsl_qdma, reg, block + FSL_QDMA_BSQMR);
+		spin_unlock(&temp_queue->queue_lock);
+
+		spin_lock(&fsl_comp->qchan->vchan.lock);
+		vchan_cookie_complete(&fsl_comp->vdesc);
+		fsl_comp->qchan->status = DMA_COMPLETE;
+		spin_unlock(&fsl_comp->qchan->vchan.lock);
 	}
+	return 0;
 }
 
 static irqreturn_t fsl_qdma_error_handler(int irq, void *dev_id)
@@ -754,15 +777,25 @@ static irqreturn_t fsl_qdma_error_handler(int irq, void *dev_id)
 static irqreturn_t fsl_qdma_queue_handler(int irq, void *dev_id)
 {
 	struct fsl_qdma_engine *fsl_qdma = dev_id;
-	unsigned int intr;
+	unsigned int intr, reg;
 	void __iomem *block = fsl_qdma->block_base;
+	void __iomem *ctrl = fsl_qdma->ctrl_base;
 
 	intr = qdma_readl(fsl_qdma, block + FSL_QDMA_BCQIDR(0));
 
 	if ((intr & FSL_QDMA_CQIDR_SQT) != 0)
-		fsl_qdma_queue_transfer_complete(fsl_qdma);
+		intr = fsl_qdma_queue_transfer_complete(fsl_qdma);
+
+	if (intr != 0) {
+		reg = qdma_readl(fsl_qdma, ctrl + FSL_QDMA_DMR);
+		reg |= FSL_QDMA_DMR_DQD;
+		qdma_writel(fsl_qdma, reg, ctrl + FSL_QDMA_DMR);
+		qdma_writel(fsl_qdma, 0, block + FSL_QDMA_BCQIER(0));
+		dev_err(fsl_qdma->dma_dev.dev, "QDMA: status err!\n");
+	}
 
 	qdma_writel(fsl_qdma, 0xffffffff, block + FSL_QDMA_BCQIDR(0));
+
 	return IRQ_HANDLED;
 }
 
@@ -863,7 +896,8 @@ static int fsl_qdma_reg_init(struct fsl_qdma_engine *fsl_qdma)
 	/* Initialize status queue interrupt. */
 	qdma_writel(fsl_qdma, FSL_QDMA_BCQIER_CQTIE,
 			      block + FSL_QDMA_BCQIER(0));
-	qdma_writel(fsl_qdma, FSL_QDMA_BSQICR_ICEN | FSL_QDMA_BSQICR_ICST(1),
+	qdma_writel(fsl_qdma, FSL_QDMA_BSQICR_ICEN | FSL_QDMA_BSQICR_ICST(5)
+						   | 0x8000,
 			      block + FSL_QDMA_BSQICR);
 	qdma_writel(fsl_qdma, FSL_QDMA_CQIER_MEIE | FSL_QDMA_CQIER_TEIE,
 			      block + FSL_QDMA_CQIER);
@@ -922,7 +956,7 @@ static void fsl_qdma_enqueue_desc(struct fsl_qdma_chan *fsl_chan)
 	u32 reg;
 
 	reg = qdma_readl(fsl_chan->qdma, block + FSL_QDMA_BCQSR(fsl_queue->id));
-	if (reg & FSL_QDMA_BCQSR_QF)
+	if (reg & (FSL_QDMA_BCQSR_QF | FSL_QDMA_BCQSR_XOFF))
 		return;
 	vdesc = vchan_next_desc(&fsl_chan->vchan);
 	if (!vdesc)
@@ -935,6 +969,7 @@ static void fsl_qdma_enqueue_desc(struct fsl_qdma_chan *fsl_chan)
 		fsl_queue->virt_head = fsl_queue->cq;
 
 	list_add_tail(&fsl_comp->list, &fsl_queue->comp_used);
+	barrier();
 	reg = qdma_readl(fsl_chan->qdma, block + FSL_QDMA_BCQMR(fsl_queue->id));
 	reg |= FSL_QDMA_BCQMR_EI;
 	qdma_writel(fsl_chan->qdma, reg, block + FSL_QDMA_BCQMR(fsl_queue->id));
-- 
2.7.4
