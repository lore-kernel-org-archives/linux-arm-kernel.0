From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 18 Mar 2016 12:50:07 +0100
Subject: [PATCH v3 1/5] dmaengine: sun6i: Simplify and fix lli setting
In-Reply-To: <cover.1458311540.git.moinejf@free.fr>
References: <cover.1458311540.git.moinejf@free.fr>
Message-ID: <2654a93049f1c7a459e7fb5a4ac112e9d2d30787.1458311540.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Checking the DMA config before setting the lli list avoids to do tests
inside the setting loop.
Also, in case of audio streaming, the sound PCM DMA engine sets only
the burst and bus width of the device. Set the lacking memory values
to system values while checking the config.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/dma/sun6i-dma.c | 116 +++++++++++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 55 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 3579ee7..ce1e4d6 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -276,45 +276,6 @@ static void *sun6i_dma_lli_add(struct sun6i_dma_lli *prev,
 	return next;
 }
 
-static inline int sun6i_dma_cfg_lli(struct sun6i_dma_lli *lli,
-				    dma_addr_t src,
-				    dma_addr_t dst, u32 len,
-				    struct dma_slave_config *config)
-{
-	s8 src_width, dst_width, src_burst, dst_burst;
-
-	if (!config)
-		return -EINVAL;
-
-	src_burst = convert_burst(config->src_maxburst);
-	if (src_burst < 0)
-		return src_burst;
-
-	dst_burst = convert_burst(config->dst_maxburst);
-	if (dst_burst < 0)
-		return dst_burst;
-
-	src_width = convert_buswidth(config->src_addr_width);
-	if (src_width < 0)
-		return src_width;
-
-	dst_width = convert_buswidth(config->dst_addr_width);
-	if (dst_width < 0)
-		return dst_width;
-
-	lli->cfg = DMA_CHAN_CFG_SRC_BURST(src_burst) |
-		DMA_CHAN_CFG_SRC_WIDTH(src_width) |
-		DMA_CHAN_CFG_DST_BURST(dst_burst) |
-		DMA_CHAN_CFG_DST_WIDTH(dst_width);
-
-	lli->src = src;
-	lli->dst = dst;
-	lli->len = len;
-	lli->para = NORMAL_WAIT;
-
-	return 0;
-}
-
 static inline void sun6i_dma_dump_lli(struct sun6i_vchan *vchan,
 				      struct sun6i_dma_lli *lli)
 {
@@ -502,6 +463,49 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
 	return ret;
 }
 
+static int set_config(struct sun6i_dma_dev *sdev,
+			struct dma_slave_config *sconfig,
+			enum dma_transfer_direction direction,
+			u32 *p_cfg)
+{
+	s8 src_width, dst_width, src_burst, dst_burst;
+
+	if (direction == DMA_MEM_TO_DEV) {
+		src_burst = convert_burst(sconfig->src_maxburst ?
+					sconfig->src_maxburst : 8);
+		src_width = convert_buswidth(sconfig->src_addr_width !=
+						DMA_SLAVE_BUSWIDTH_UNDEFINED ?
+				sconfig->src_addr_width :
+				DMA_SLAVE_BUSWIDTH_4_BYTES);
+		dst_burst = convert_burst(sconfig->dst_maxburst);
+		dst_width = convert_buswidth(sconfig->dst_addr_width);
+	} else {	/* DMA_DEV_TO_MEM */
+		src_burst = convert_burst(sconfig->src_maxburst);
+		src_width = convert_buswidth(sconfig->src_addr_width);
+		dst_burst = convert_burst(sconfig->dst_maxburst ?
+					sconfig->dst_maxburst : 8);
+		dst_width = convert_buswidth(sconfig->dst_addr_width !=
+						DMA_SLAVE_BUSWIDTH_UNDEFINED ?
+				sconfig->dst_addr_width :
+				DMA_SLAVE_BUSWIDTH_4_BYTES);
+	}
+	if (src_burst < 0)
+		return src_burst;
+	if (src_width < 0)
+		return src_width;
+	if (dst_burst < 0)
+		return dst_burst;
+	if (dst_width < 0)
+		return dst_width;
+
+	*p_cfg = DMA_CHAN_CFG_SRC_BURST(src_burst) |
+		DMA_CHAN_CFG_SRC_WIDTH(src_width) |
+		DMA_CHAN_CFG_DST_BURST(dst_burst) |
+		DMA_CHAN_CFG_DST_WIDTH(dst_width);
+
+	return 0;
+}
+
 static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
 		struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		size_t len, unsigned long flags)
@@ -569,6 +573,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 	struct sun6i_desc *txd;
 	struct scatterlist *sg;
 	dma_addr_t p_lli;
+	u32 lli_cfg;
 	int i, ret;
 
 	if (!sgl)
@@ -579,6 +584,12 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 		return NULL;
 	}
 
+	ret = set_config(sdev, sconfig, dir, &lli_cfg);
+	if (ret) {
+		dev_err(chan2dev(chan), "Invalid DMA configuration\n");
+		return NULL;
+	}
+
 	txd = kzalloc(sizeof(*txd), GFP_NOWAIT);
 	if (!txd)
 		return NULL;
@@ -588,14 +599,14 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 		if (!v_lli)
 			goto err_lli_free;
 
-		if (dir == DMA_MEM_TO_DEV) {
-			ret = sun6i_dma_cfg_lli(v_lli, sg_dma_address(sg),
-						sconfig->dst_addr, sg_dma_len(sg),
-						sconfig);
-			if (ret)
-				goto err_cur_lli_free;
+		v_lli->len = sg_dma_len(sg);
+		v_lli->para = NORMAL_WAIT;
 
-			v_lli->cfg |= DMA_CHAN_CFG_DST_IO_MODE |
+		if (dir == DMA_MEM_TO_DEV) {
+			v_lli->src = sg_dma_address(sg);
+			v_lli->dst = sconfig->dst_addr;
+			v_lli->cfg = lli_cfg |
+				DMA_CHAN_CFG_DST_IO_MODE |
 				DMA_CHAN_CFG_SRC_LINEAR_MODE |
 				DMA_CHAN_CFG_SRC_DRQ(DRQ_SDRAM) |
 				DMA_CHAN_CFG_DST_DRQ(vchan->port);
@@ -607,13 +618,10 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 				sg_dma_len(sg), flags);
 
 		} else {
-			ret = sun6i_dma_cfg_lli(v_lli, sconfig->src_addr,
-						sg_dma_address(sg), sg_dma_len(sg),
-						sconfig);
-			if (ret)
-				goto err_cur_lli_free;
-
-			v_lli->cfg |= DMA_CHAN_CFG_DST_LINEAR_MODE |
+			v_lli->src = sconfig->src_addr;
+			v_lli->dst = sg_dma_address(sg);
+			v_lli->cfg = lli_cfg |
+				DMA_CHAN_CFG_DST_LINEAR_MODE |
 				DMA_CHAN_CFG_SRC_IO_MODE |
 				DMA_CHAN_CFG_DST_DRQ(DRQ_SDRAM) |
 				DMA_CHAN_CFG_SRC_DRQ(vchan->port);
@@ -634,8 +642,6 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 
 	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
 
-err_cur_lli_free:
-	dma_pool_free(sdev->pool, v_lli, p_lli);
 err_lli_free:
 	for (prev = txd->v_lli; prev; prev = prev->v_lli_next)
 		dma_pool_free(sdev->pool, prev, virt_to_phys(prev));
-- 
2.7.4
