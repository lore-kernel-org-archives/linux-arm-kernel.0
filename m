From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 25 Aug 2013 20:57:13 +0800
Subject: [PATCH] dmaengine: sirf: add dmaengine_prep_slave_single/sg support
Message-ID: <1377435433-23202-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the dma engine of sirfsoc supports interleaved mode, but if we set
xlen=width instead xlen<width, it will work as non-interleaved. as
most clients of sirf dma driver still don't need interleaved mode,
so here we still need to implement prep_slave_sg entry so that users
like uart, spi can use these APIs instead of interleaved API.

the dma engine of sirfsoc doesn't support hardware s/g, so here we
are using the list of desc nodes to do SW s/g. when dma operations
finish, driver will re-start the next desc automatically.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/dma/sirf-dma.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 6aec3ad..c226c79 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -577,6 +577,62 @@ err_dir:
 }
 
 static struct dma_async_tx_descriptor *
+sirfsoc_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+	unsigned int sg_len, enum dma_transfer_direction direction,
+	unsigned long flags, void *context)
+{
+	struct sirfsoc_dma_chan *schan = dma_chan_to_sirfsoc_dma_chan(chan);
+	struct sirfsoc_dma_desc *first_sdesc;
+	struct sirfsoc_dma_desc *sdesc;
+	struct list_head *l;
+	unsigned long iflags;
+	struct scatterlist *sg;
+	int desc_cnt = 0;
+	int i;
+	int ret;
+
+	/*
+	 * the hardware doesn't support sg, here we use software list
+	 * to simulate sg, so make sure we have enough desc nodes
+	 */
+	spin_lock_irqsave(&schan->lock, iflags);
+	list_for_each(l, &schan->free)
+		desc_cnt++;
+	if (desc_cnt < sg_len) {
+		spin_unlock_irqrestore(&schan->lock, iflags);
+		pr_err("sirfsoc DMA channel busy\n");
+		ret = -EBUSY;
+		goto err;
+	}
+
+	first_sdesc = list_first_entry(&schan->free, struct sirfsoc_dma_desc,
+			node);
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		dma_addr_t addr = sg_dma_address(sg);
+		unsigned int len = sg_dma_len(sg);
+
+		sdesc = list_first_entry(&schan->free, struct sirfsoc_dma_desc,
+			node);
+		list_del(&sdesc->node);
+
+		sdesc->addr = addr;
+		sdesc->dir = (direction == DMA_MEM_TO_DEV ? 1 : 0);
+		sdesc->cyclic = 0;
+		sdesc->xlen = len / SIRFSOC_DMA_WORD_LEN;
+		sdesc->width = sdesc->xlen;
+		sdesc->ylen = 0;
+
+		list_add_tail(&sdesc->node, &schan->prepared);
+	}
+	spin_unlock_irqrestore(&schan->lock, iflags);
+
+	return &first_sdesc->desc;
+err:
+	return ERR_PTR(ret);
+}
+
+static struct dma_async_tx_descriptor *
 sirfsoc_dma_prep_cyclic(struct dma_chan *chan, dma_addr_t addr,
 	size_t buf_len, size_t period_len,
 	enum dma_transfer_direction direction, unsigned long flags, void *context)
@@ -711,6 +767,7 @@ static int sirfsoc_dma_probe(struct platform_device *op)
 	dma->device_control = sirfsoc_dma_control;
 	dma->device_tx_status = sirfsoc_dma_tx_status;
 	dma->device_prep_interleaved_dma = sirfsoc_dma_prep_interleaved;
+	dma->device_prep_slave_sg = sirfsoc_dma_prep_slave_sg;
 	dma->device_prep_dma_cyclic = sirfsoc_dma_prep_cyclic;
 
 	INIT_LIST_HEAD(&dma->channels);
-- 
1.8.2.3
