From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 28 Sep 2018 15:01:54 +0200
Subject: [PATCH v3 6/7] dmaengine: stm32-dma: enable descriptor_reuse
In-Reply-To: <1538139715-24406-1-git-send-email-pierre-yves.mordret@st.com>
References: <1538139715-24406-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1538139715-24406-7-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable client to resubmit already processed descriptors
in order to save descriptor creation time.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v3:
    v2:
    v1:
       * Initial
---
---
 drivers/dma/stm32-dma.c | 84 +++++++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 85e81c4..ba79051 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -836,34 +836,8 @@ static int stm32_dma_mdma_start(struct stm32_dma_chan *chan,
 {
 	struct stm32_dma_mdma *mchan = &chan->mchan;
 	struct stm32_dma_mdma_desc *m_desc = &sg_req->m_desc;
-	struct dma_slave_config config;
 	int ret;
 
-	/* Configure MDMA channel */
-	memset(&config, 0, sizeof(config));
-	if (mchan->dir == DMA_MEM_TO_DEV)
-		config.dst_addr = mchan->sram_buf;
-	else
-		config.src_addr = mchan->sram_buf;
-
-	ret = dmaengine_slave_config(mchan->chan, &config);
-	if (ret < 0)
-		goto error;
-
-	 /* Prepare MDMA descriptor */
-	m_desc->desc = dmaengine_prep_slave_sg(mchan->chan, m_desc->sgt.sgl,
-					       m_desc->sgt.nents, mchan->dir,
-					       DMA_PREP_INTERRUPT);
-	if (!m_desc->desc) {
-		ret = -EINVAL;
-		goto error;
-	}
-
-	if (mchan->dir != DMA_MEM_TO_DEV) {
-		m_desc->desc->callback_result = stm32_mdma_chan_complete;
-		m_desc->desc->callback_param = chan;
-	}
-
 	ret = dma_submit_error(dmaengine_submit(m_desc->desc));
 	if (ret < 0) {
 		dev_err(chan2dev(chan), "MDMA submit failed\n");
@@ -1001,6 +975,7 @@ static void stm32_dma_start_transfer(struct stm32_dma_chan *chan)
 
 	chan->next_sg++;
 
+	reg->dma_scr &= ~STM32_DMA_SCR_EN;
 	stm32_dma_write(dmadev, STM32_DMA_SCR(chan->id), reg->dma_scr);
 	stm32_dma_write(dmadev, STM32_DMA_SPAR(chan->id), reg->dma_spar);
 	stm32_dma_write(dmadev, STM32_DMA_SM0AR(chan->id), reg->dma_sm0ar);
@@ -1238,9 +1213,11 @@ static void stm32_dma_clear_reg(struct stm32_dma_chan_reg *regs)
 
 static int stm32_dma_mdma_prep_slave_sg(struct stm32_dma_chan *chan,
 					struct scatterlist *sgl, u32 sg_len,
-					struct stm32_dma_desc *desc)
+					struct stm32_dma_desc *desc,
+					unsigned long flags)
 {
 	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
+	struct stm32_dma_mdma *mchan = &chan->mchan;
 	struct scatterlist *sg, *m_sg;
 	dma_addr_t dma_buf;
 	u32 len, num_sgs, sram_period;
@@ -1256,12 +1233,13 @@ static int stm32_dma_mdma_prep_slave_sg(struct stm32_dma_chan *chan,
 
 	for_each_sg(sgl, sg, sg_len, i) {
 		struct stm32_dma_mdma_desc *m_desc = &desc->sg_req[i].m_desc;
+		struct dma_slave_config config;
 
 		len = sg_dma_len(sg);
 		desc->sg_req[i].stm32_sgl_req = *sg;
 		num_sgs = 1;
 
-		if (chan->mchan.dir == DMA_MEM_TO_DEV) {
+		if (mchan->dir == DMA_MEM_TO_DEV) {
 			if (len > chan->sram_size) {
 				dev_err(chan2dev(chan),
 					"max buf size = %d bytes\n",
@@ -1293,6 +1271,38 @@ static int stm32_dma_mdma_prep_slave_sg(struct stm32_dma_chan *chan,
 			dma_buf += bytes;
 			len -= bytes;
 		}
+
+		/* Configure MDMA channel */
+		memset(&config, 0, sizeof(config));
+		if (mchan->dir == DMA_MEM_TO_DEV)
+			config.dst_addr = desc->dma_buf;
+		else
+			config.src_addr = desc->dma_buf;
+
+		ret = dmaengine_slave_config(mchan->chan, &config);
+		if (ret < 0)
+			goto err;
+
+		/* Prepare MDMA descriptor */
+		m_desc->desc = dmaengine_prep_slave_sg(mchan->chan,
+						       m_desc->sgt.sgl,
+						       m_desc->sgt.nents,
+						       mchan->dir,
+						       DMA_PREP_INTERRUPT);
+
+		if (!m_desc->desc) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		if (flags & DMA_CTRL_REUSE)
+			dmaengine_desc_set_reuse(m_desc->desc);
+
+		if (mchan->dir != DMA_MEM_TO_DEV) {
+			m_desc->desc->callback_result =
+				stm32_mdma_chan_complete;
+			m_desc->desc->callback_param = chan;
+		}
 	}
 
 	chan->mchan.sram_buf = desc->dma_buf;
@@ -1302,8 +1312,12 @@ static int stm32_dma_mdma_prep_slave_sg(struct stm32_dma_chan *chan,
 	return 0;
 
 err:
-	for (j = 0; j < i; j++)
+	for (j = 0; j < i; j++) {
+		struct stm32_dma_mdma_desc *m_desc = &desc->sg_req[j].m_desc;
+
+		m_desc->desc = NULL;
 		sg_free_table(&desc->sg_req[j].m_desc.sgt);
+	}
 free_alloc:
 	gen_pool_free(dmadev->sram_pool, (unsigned long)desc->dma_buf_cpu,
 		      chan->sram_size);
@@ -1385,7 +1399,8 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_slave_sg(
 		struct scatterlist *s, *_sgl;
 
 		chan->mchan.dir = direction;
-		ret = stm32_dma_mdma_prep_slave_sg(chan, sgl, sg_len, desc);
+		ret = stm32_dma_mdma_prep_slave_sg(chan, sgl, sg_len, desc,
+						   flags);
 		if (ret < 0)
 			return NULL;
 
@@ -1791,6 +1806,14 @@ static void stm32_dma_desc_free(struct virt_dma_desc *vdesc)
 	int i;
 
 	if (chan->use_mdma) {
+		struct stm32_dma_mdma_desc *m_desc;
+
+		for (i = 0; i < desc->num_sgs; i++) {
+			m_desc = &desc->sg_req[i].m_desc;
+			dmaengine_desc_free(m_desc->desc);
+			m_desc->desc = NULL;
+		}
+
 		for (i = 0; i < desc->num_sgs; i++)
 			sg_free_table(&desc->sg_req[i].m_desc.sgt);
 
@@ -1934,6 +1957,7 @@ static int stm32_dma_probe(struct platform_device *pdev)
 	dd->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	dd->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	dd->max_burst = STM32_DMA_MAX_BURST;
+	dd->descriptor_reuse = true;
 	dd->dev = &pdev->dev;
 	INIT_LIST_HEAD(&dd->channels);
 
-- 
2.7.4
