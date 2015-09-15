From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 15 Sep 2015 15:29:27 +0200
Subject: [PATCH 1/4] dmaengine: at_xdmac: handle numf > 1
In-Reply-To: <1442323770-20266-1-git-send-email-ludovic.desroches@atmel.com>
References: <1442323770-20266-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1442323770-20266-2-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

Handle 'numf > 1' case for interleaved mode.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/dma/at_xdmac.c | 104 ++++++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 54 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index a165b4b..0190d1c 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -929,13 +929,19 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
 {
 	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
 	struct at_xdmac_desc	*prev = NULL, *first = NULL;
-	struct data_chunk	*chunk, *prev_chunk = NULL;
 	dma_addr_t		dst_addr, src_addr;
-	size_t			dst_skip, src_skip, len = 0;
-	size_t			prev_dst_icg = 0, prev_src_icg = 0;
+	size_t			src_skip = 0, dst_skip = 0, len = 0;
+	struct data_chunk	*chunk;
 	int			i;
 
-	if (!xt || (xt->numf != 1) || (xt->dir != DMA_MEM_TO_MEM))
+	if (!xt || !xt->numf || (xt->dir != DMA_MEM_TO_MEM))
+		return NULL;
+
+	/*
+	 * TODO: Handle the case where we have to repeat a chain of
+	 * descriptors...
+	 */
+	if ((xt->numf > 1) && (xt->frame_size > 1))
 		return NULL;
 
 	dev_dbg(chan2dev(chan), "%s: src=0x%08x, dest=0x%08x, numf=%d, frame_size=%d, flags=0x%lx\n",
@@ -945,66 +951,56 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
 	src_addr = xt->src_start;
 	dst_addr = xt->dst_start;
 
-	for (i = 0; i < xt->frame_size; i++) {
-		struct at_xdmac_desc *desc;
-		size_t src_icg, dst_icg;
-
-		chunk = xt->sgl + i;
+	if (xt->numf > 1) {
+		first = at_xdmac_interleaved_queue_desc(chan, atchan,
+							NULL,
+							src_addr, dst_addr,
+							xt, xt->sgl);
+		for (i = 0; i < xt->numf; i++)
+			at_xdmac_increment_block_count(chan, first);
+	} else {
+		for (i = 0; i < xt->frame_size; i++) {
+			size_t src_icg = 0, dst_icg = 0;
+			struct at_xdmac_desc *desc;
 
-		dst_icg = dmaengine_get_dst_icg(xt, chunk);
-		src_icg = dmaengine_get_src_icg(xt, chunk);
+			chunk = xt->sgl + i;
 
-		src_skip = chunk->size + src_icg;
-		dst_skip = chunk->size + dst_icg;
+			dst_icg = dmaengine_get_dst_icg(xt, chunk);
+			src_icg = dmaengine_get_src_icg(xt, chunk);
 
-		dev_dbg(chan2dev(chan),
-			"%s: chunk size=%d, src icg=%d, dst icg=%d\n",
-			__func__, chunk->size, src_icg, dst_icg);
+			src_skip = chunk->size + src_icg;
+			dst_skip = chunk->size + dst_icg;
 
-		/*
-		 * Handle the case where we just have the same
-		 * transfer to setup, we can just increase the
-		 * block number and reuse the same descriptor.
-		 */
-		if (prev_chunk && prev &&
-		    (prev_chunk->size == chunk->size) &&
-		    (prev_src_icg == src_icg) &&
-		    (prev_dst_icg == dst_icg)) {
 			dev_dbg(chan2dev(chan),
-				"%s: same configuration that the previous chunk, merging the descriptors...\n",
-				__func__);
-			at_xdmac_increment_block_count(chan, prev);
-			continue;
-		}
-
-		desc = at_xdmac_interleaved_queue_desc(chan, atchan,
-						       prev,
-						       src_addr, dst_addr,
-						       xt, chunk);
-		if (!desc) {
-			list_splice_init(&first->descs_list,
-					 &atchan->free_descs_list);
-			return NULL;
-		}
+				"%s: chunk size=%d, src icg=%d, dst icg=%d\n",
+				__func__, chunk->size, src_icg, dst_icg);
+
+			desc = at_xdmac_interleaved_queue_desc(chan, atchan,
+							       prev,
+							       src_addr, dst_addr,
+							       xt, chunk);
+			if (!desc) {
+				list_splice_init(&first->descs_list,
+						 &atchan->free_descs_list);
+				return NULL;
+			}
 
-		if (!first)
-			first = desc;
+			if (!first)
+				first = desc;
 
-		dev_dbg(chan2dev(chan), "%s: add desc 0x%p to descs_list 0x%p\n",
-			__func__, desc, first);
-		list_add_tail(&desc->desc_node, &first->descs_list);
+			dev_dbg(chan2dev(chan), "%s: add desc 0x%p to descs_list 0x%p\n",
+				__func__, desc, first);
+			list_add_tail(&desc->desc_node, &first->descs_list);
 
-		if (xt->src_sgl)
-			src_addr += src_skip;
+			if (xt->src_sgl)
+				src_addr += src_skip;
 
-		if (xt->dst_sgl)
-			dst_addr += dst_skip;
+			if (xt->dst_sgl)
+				dst_addr += dst_skip;
 
-		len += chunk->size;
-		prev_chunk = chunk;
-		prev_dst_icg = dst_icg;
-		prev_src_icg = src_icg;
-		prev = desc;
+			len += chunk->size;
+			prev = desc;
+		}
 	}
 
 	first->tx_dma_desc.cookie = -EBUSY;
-- 
2.5.0
