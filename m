From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 11 Mar 2016 12:06:53 +0100
Subject: [PATCH v2 4/5] dmaengine: sun6i: Set system values to memory burst
 and bus width
In-Reply-To: <cover.1457695169.git.moinejf@free.fr>
References: <cover.1457695169.git.moinejf@free.fr>
Message-ID: <f93e8df4615322cb4b0c54983578096fce2ad0d5.1457695169.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When defining the DMA transfer, the sound PCM DMA engine sets only
the burst and bus width values of the device.
This was making the audio transfers to be rejected because of invalid
values on the memory side.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/dma/sun6i-dma.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 7c98c0d..0563fb3 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -504,6 +504,22 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
 	return ret;
 }
 
+static void sanitize_config(struct dma_slave_config *sconfig,
+			   enum dma_transfer_direction direction)
+{
+	if (direction == DMA_MEM_TO_DEV) {
+		if (sconfig->src_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+			sconfig->src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		if (!sconfig->src_maxburst)
+			sconfig->src_maxburst = 8;
+	} else {	// DMA_DEV_TO_MEM
+		if (sconfig->dst_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+			sconfig->dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		if (!sconfig->dst_maxburst)
+			sconfig->dst_maxburst = 8;
+	}
+}
+
 static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
 		struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		size_t len, unsigned long flags)
@@ -585,6 +601,8 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 	if (!txd)
 		return NULL;
 
+	sanitize_config(sconfig, dir);
+
 	for_each_sg(sgl, sg, sg_len, i) {
 		v_lli = dma_pool_alloc(sdev->pool, GFP_NOWAIT, &p_lli);
 		if (!v_lli)
-- 
2.7.3
