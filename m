From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 2 Apr 2016 11:36:38 +0200
Subject: [PATCH v4 3/3] dmaengine: sun6i: Add cyclic capability
In-Reply-To: <cover.1459590553.git.moinejf@free.fr>
References: <cover.1459590553.git.moinejf@free.fr>
Message-ID: <c91eedd5fe1c0d97ee42a212bf1c2ff0faa14af8.1459590553.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA cyclic transfers are required by audio streaming.

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/dma/sun6i-dma.c | 129 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 122 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 821fc4f..0c1ea8b 100644
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
@@ -254,6 +256,30 @@ static inline s8 convert_buswidth(enum dma_slave_buswidth addr_width)
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
@@ -342,8 +368,12 @@ static int sun6i_dma_start_desc(struct sun6i_vchan *vchan)
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
@@ -440,11 +470,12 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
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
@@ -650,6 +681,78 @@ err_lli_free:
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
+	u32 lli_cfg;
+	unsigned int i, periods = buf_len / period_len;
+	int ret;
+
+	ret = set_config(sdev, sconfig, dir, &lli_cfg);
+	if (ret) {
+		dev_err(chan2dev(chan), "Invalid DMA configuration\n");
+		return NULL;
+	}
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
+
+		v_lli->len = period_len;
+		v_lli->para = NORMAL_WAIT;
+
+		if (dir == DMA_MEM_TO_DEV) {
+			v_lli->src = buf_addr + period_len * i;
+			v_lli->dst = sconfig->dst_addr;
+			v_lli->cfg = lli_cfg |
+				DMA_CHAN_CFG_DST_IO_MODE |
+				DMA_CHAN_CFG_SRC_LINEAR_MODE |
+				DMA_CHAN_CFG_SRC_DRQ(DRQ_SDRAM) |
+				DMA_CHAN_CFG_DST_DRQ(vchan->port);
+		} else {
+			v_lli->src = sconfig->src_addr;
+			v_lli->dst = buf_addr + period_len * i;
+			v_lli->cfg = lli_cfg |
+				DMA_CHAN_CFG_DST_LINEAR_MODE |
+				DMA_CHAN_CFG_SRC_IO_MODE |
+				DMA_CHAN_CFG_DST_DRQ(DRQ_SDRAM) |
+				DMA_CHAN_CFG_SRC_DRQ(vchan->port);
+		}
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
@@ -719,6 +822,16 @@ static int sun6i_dma_terminate_all(struct dma_chan *chan)
 
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
@@ -766,7 +879,7 @@ static enum dma_status sun6i_dma_tx_status(struct dma_chan *chan,
 	} else if (!pchan || !pchan->desc) {
 		bytes = 0;
 	} else {
-		bytes = readl(pchan->base + DMA_CHAN_CUR_CNT);
+		bytes = sun6i_get_chan_size(pchan);
 	}
 
 	spin_unlock_irqrestore(&vchan->vc.lock, flags);
@@ -970,6 +1083,7 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_PRIVATE, sdc->slave.cap_mask);
 	dma_cap_set(DMA_MEMCPY, sdc->slave.cap_mask);
 	dma_cap_set(DMA_SLAVE, sdc->slave.cap_mask);
+	dma_cap_set(DMA_CYCLIC, sdc->slave.cap_mask);
 
 	INIT_LIST_HEAD(&sdc->slave.channels);
 	sdc->slave.device_free_chan_resources	= sun6i_dma_free_chan_resources;
@@ -977,6 +1091,7 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	sdc->slave.device_issue_pending		= sun6i_dma_issue_pending;
 	sdc->slave.device_prep_slave_sg		= sun6i_dma_prep_slave_sg;
 	sdc->slave.device_prep_dma_memcpy	= sun6i_dma_prep_dma_memcpy;
+	sdc->slave.device_prep_dma_cyclic	= sun6i_dma_prep_dma_cyclic;
 	sdc->slave.copy_align			= DMAENGINE_ALIGN_4_BYTES;
 	sdc->slave.device_config		= sun6i_dma_config;
 	sdc->slave.device_pause			= sun6i_dma_pause;
-- 
2.8.0
