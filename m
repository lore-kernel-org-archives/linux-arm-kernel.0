From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 10 Mar 2016 11:21:34 +0100
Subject: [PATCH 5/5] dmaengine: sun6i: Add cyclic capability
In-Reply-To: <cover.1457606136.git.moinejf@free.fr>
References: <cover.1457606136.git.moinejf@free.fr>
Message-ID: <350ad364b3e46f53159ff71aa611c432b4c588e0.1457606136.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA cyclic transfers are required by audio streaming.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/dma/sun6i-dma.c | 144 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 136 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index c27d572..06d0306 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -146,6 +146,8 @@ struct sun6i_vchan {
 	struct dma_slave_config	cfg;
 	struct sun6i_pchan	*phy;
 	u8			port;
+	u8			irq_type;
+	bool			cyclic;
 };
 
 struct sun6i_dma_dev {
@@ -256,6 +258,30 @@ static inline s8 convert_buswidth(enum dma_slave_buswidth addr_width)
 	return addr_width >> 1;
 }
 
+static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
+{
+	struct sun6i_desc *txd = pchan->desc;
+	struct sun6i_dma_lli *lli;
+	size_t bytes;
+	dma_addr_t pos;
+
+	pos = readl(pchan->base + DMA_CHAN_LLI_ADDR);
+	bytes = readl(pchan->base + DMA_CHAN_CUR_CNT);
+
+	if (pos == LLI_LAST_ITEM)
+		return bytes;
+
+	for (lli = txd->v_lli; lli; lli = lli->v_lli_next) {
+		if (lli->p_lli_next == pos) {
+			for (lli = lli->v_lli_next; lli; lli = lli->v_lli_next)
+				bytes += lli->len;
+			break;
+		}
+	}
+
+	return bytes;
+}
+
 static void *sun6i_dma_lli_add(struct sun6i_dma_lli *prev,
 			       struct sun6i_dma_lli *next,
 			       dma_addr_t next_phy,
@@ -395,8 +421,12 @@ static int sun6i_dma_start_desc(struct sun6i_vchan *vchan)
 	irq_reg = pchan->idx / DMA_IRQ_CHAN_NR;
 	irq_offset = pchan->idx % DMA_IRQ_CHAN_NR;
 
+	vchan->irq_type = vchan->cyclic ? DMA_IRQ_PKG : DMA_IRQ_QUEUE;
+
 	irq_val = readl(sdev->base + DMA_IRQ_EN(irq_reg));
-	irq_val |= DMA_IRQ_QUEUE << (irq_offset * DMA_IRQ_CHAN_WIDTH);
+	irq_val &= ~((DMA_IRQ_HALF | DMA_IRQ_PKG | DMA_IRQ_QUEUE) <<
+			(irq_offset * DMA_IRQ_CHAN_WIDTH));
+	irq_val |= vchan->irq_type << (irq_offset * DMA_IRQ_CHAN_WIDTH);
 	writel(irq_val, sdev->base + DMA_IRQ_EN(irq_reg));
 
 	writel(pchan->desc->p_lli, pchan->base + DMA_CHAN_LLI_ADDR);
@@ -493,11 +523,12 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
 		writel(status, sdev->base + DMA_IRQ_STAT(i));
 
 		for (j = 0; (j < DMA_IRQ_CHAN_NR) && status; j++) {
-			if (status & DMA_IRQ_QUEUE) {
-				pchan = sdev->pchans + j;
-				vchan = pchan->vchan;
-
-				if (vchan) {
+			pchan = sdev->pchans + j;
+			vchan = pchan->vchan;
+			if (vchan && (status & vchan->irq_type)) {
+				if (vchan->cyclic) {
+					vchan_cyclic_callback(&pchan->desc->vd);
+				} else {
 					spin_lock(&vchan->vc.lock);
 					vchan_cookie_complete(&pchan->desc->vd);
 					pchan->done = pchan->desc;
@@ -657,6 +688,76 @@ err_lli_free:
 	return NULL;
 }
 
+static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_cyclic(
+					struct dma_chan *chan,
+					dma_addr_t buf_addr,
+					size_t buf_len,
+					size_t period_len,
+					enum dma_transfer_direction dir,
+					unsigned long flags)
+{
+	struct sun6i_dma_dev *sdev = to_sun6i_dma_dev(chan->device);
+	struct sun6i_vchan *vchan = to_sun6i_vchan(chan);
+	struct dma_slave_config *sconfig = &vchan->cfg;
+	struct sun6i_dma_lli *v_lli, *prev = NULL;
+	struct sun6i_desc *txd;
+	dma_addr_t p_lli;
+	unsigned int i, periods = buf_len / period_len;
+	int ret;
+
+	if (vchan->cyclic && vchan->phy && vchan->phy->desc)
+		return NULL;
+
+	txd = kzalloc(sizeof(*txd), GFP_NOWAIT);
+	if (!txd)
+		return NULL;
+
+	for (i = 0; i < periods; i++){
+		v_lli = dma_pool_alloc(sdev->pool, GFP_NOWAIT, &p_lli);
+		if (!v_lli) {
+			dev_err(sdev->slave.dev, "Failed to alloc lli memory\n");
+			goto err_lli_free;
+		}
+		if (dir == DMA_MEM_TO_DEV) {
+			ret = sun6i_dma_cfg_lli(v_lli,
+						buf_addr + period_len * i,
+						sconfig->dst_addr,
+						period_len, sconfig);
+			v_lli->cfg |= DMA_CHAN_CFG_DST_IO_MODE |
+					DMA_CHAN_CFG_SRC_LINEAR_MODE |
+					DMA_CHAN_CFG_SRC_DRQ(DRQ_SDRAM) |
+					DMA_CHAN_CFG_DST_DRQ(vchan->port);
+		} else {
+			ret = sun6i_dma_cfg_lli(v_lli,
+						sconfig->src_addr,
+						buf_addr + period_len * i,
+						period_len, sconfig);
+			v_lli->cfg |= DMA_CHAN_CFG_DST_LINEAR_MODE |
+					DMA_CHAN_CFG_SRC_IO_MODE |
+					DMA_CHAN_CFG_DST_DRQ(DRQ_SDRAM) |
+					DMA_CHAN_CFG_SRC_DRQ(vchan->port);
+		}
+		if (ret < 0)
+			goto err_cur_lli_free;
+
+		prev = sun6i_dma_lli_add(prev, v_lli, p_lli, txd);
+	}
+
+	prev->p_lli_next = txd->p_lli;		/* cyclic list */
+
+	vchan->cyclic = true;
+
+	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
+
+err_cur_lli_free:
+	dma_pool_free(sdev->pool, v_lli, p_lli);
+err_lli_free:
+	for (prev = txd->v_lli; prev; prev = prev->v_lli_next)
+		dma_pool_free(sdev->pool, prev, virt_to_phys(prev));
+	kfree(txd);
+	return NULL;
+}
+
 static int sun6i_dma_config(struct dma_chan *chan,
 			    struct dma_slave_config *config)
 {
@@ -726,6 +827,16 @@ static int sun6i_dma_terminate_all(struct dma_chan *chan)
 
 	spin_lock_irqsave(&vchan->vc.lock, flags);
 
+	if (vchan->cyclic) {
+		vchan->cyclic = false;
+		if (pchan && pchan->desc) {
+			struct virt_dma_desc *vd = &pchan->desc->vd;
+			struct virt_dma_chan *vc = &vchan->vc;
+
+			list_add_tail(&vd->node, &vc->desc_completed);
+		}
+	}
+
 	vchan_get_all_descriptors(&vchan->vc, &head);
 
 	if (pchan) {
@@ -773,7 +884,7 @@ static enum dma_status sun6i_dma_tx_status(struct dma_chan *chan,
 	} else if (!pchan || !pchan->desc) {
 		bytes = 0;
 	} else {
-		bytes = readl(pchan->base + DMA_CHAN_CUR_CNT);
+		bytes = sun6i_get_chan_size(pchan);
 	}
 
 	spin_unlock_irqrestore(&vchan->vc.lock, flags);
@@ -792,6 +903,11 @@ static void sun6i_dma_issue_pending(struct dma_chan *chan)
 	spin_lock_irqsave(&vchan->vc.lock, flags);
 
 	if (vchan_issue_pending(&vchan->vc)) {
+		if (vchan->phy && vchan->cyclic) {
+			sun6i_dma_start_desc(vchan);
+			goto out;
+		}
+
 		spin_lock(&sdev->lock);
 
 		if (!vchan->phy && list_empty(&vchan->node)) {
@@ -806,10 +922,19 @@ static void sun6i_dma_issue_pending(struct dma_chan *chan)
 		dev_dbg(chan2dev(chan), "vchan %p: nothing to issue\n",
 			&vchan->vc);
 	}
-
+out:
 	spin_unlock_irqrestore(&vchan->vc.lock, flags);
 }
 
+static int sun6i_dma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct sun6i_vchan *vchan = to_sun6i_vchan(chan);
+
+	vchan->cyclic = false;
+
+	return 0;
+}
+
 static void sun6i_dma_free_chan_resources(struct dma_chan *chan)
 {
 	struct sun6i_dma_dev *sdev = to_sun6i_dma_dev(chan->device);
@@ -977,13 +1102,16 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_PRIVATE, sdc->slave.cap_mask);
 	dma_cap_set(DMA_MEMCPY, sdc->slave.cap_mask);
 	dma_cap_set(DMA_SLAVE, sdc->slave.cap_mask);
+	dma_cap_set(DMA_CYCLIC, sdc->slave.cap_mask);
 
 	INIT_LIST_HEAD(&sdc->slave.channels);
+	sdc->slave.device_alloc_chan_resources	= sun6i_dma_alloc_chan_resources;
 	sdc->slave.device_free_chan_resources	= sun6i_dma_free_chan_resources;
 	sdc->slave.device_tx_status		= sun6i_dma_tx_status;
 	sdc->slave.device_issue_pending		= sun6i_dma_issue_pending;
 	sdc->slave.device_prep_slave_sg		= sun6i_dma_prep_slave_sg;
 	sdc->slave.device_prep_dma_memcpy	= sun6i_dma_prep_dma_memcpy;
+	sdc->slave.device_prep_dma_cyclic	= sun6i_dma_prep_dma_cyclic;
 	sdc->slave.copy_align			= DMAENGINE_ALIGN_4_BYTES;
 	sdc->slave.device_config		= sun6i_dma_config;
 	sdc->slave.device_pause			= sun6i_dma_pause;
-- 
2.7.2
