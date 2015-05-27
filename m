From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 May 2015 16:01:52 +0200
Subject: [PATCH 1/2] dmaengine: Move icg helpers to global header
In-Reply-To: <1432735313-481-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1432735313-481-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1432735313-481-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we can have ICGs set for both the source and destination (using
the icg field of struct data_chunk) or for only the source or the
destination (using the dst_icg or src_icg respectively), and that these
fields can be ignored depending on other parameters (src_inc, src_sgl,
etc.), the logic to get the actual ICG value can be quite tricky.

The XDMAC driver was already implementing it, but since we will need it in
other drivers, we can move it to the main header file.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/at_xdmac.c    | 46 ++++------------------------------------------
 include/linux/dmaengine.h | 27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 9b602a67d40d..80e46e571bdd 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -862,20 +862,8 @@ at_xdmac_interleaved_queue_desc(struct dma_chan *chan,
 
 	desc->lld.mbr_sa = src;
 	desc->lld.mbr_da = dst;
-
-	if (xt->src_inc && xt->src_sgl) {
-		if (chunk->src_icg)
-			desc->lld.mbr_sus = chunk->src_icg;
-		else
-			desc->lld.mbr_sus = chunk->icg;
-	}
-
-	if (xt->dst_inc && xt->dst_sgl) {
-		if (chunk->dst_icg)
-			desc->lld.mbr_dus = chunk->dst_icg;
-		else
-			desc->lld.mbr_dus = chunk->icg;
-	}
+	desc->lld.mbr_sus = dmaengine_get_src_icg(xt, chunk);
+	desc->lld.mbr_dus = dmaengine_get_dst_icg(xt, chunk);
 
 	desc->lld.mbr_ubc = AT_XDMAC_MBR_UBC_NDV3
 		| AT_XDMAC_MBR_UBC_NDEN
@@ -895,32 +883,6 @@ at_xdmac_interleaved_queue_desc(struct dma_chan *chan,
 	return desc;
 }
 
-static size_t at_xdmac_get_icg(bool inc, bool sgl, size_t icg, size_t dir_icg)
-{
-	if (inc) {
-		if (dir_icg)
-			return dir_icg;
-		else if (sgl)
-			return icg;
-	}
-
-	return 0;
-}
-
-static size_t at_xdmac_get_dst_icg(struct dma_interleaved_template *xt,
-				   struct data_chunk *chunk)
-{
-	return at_xdmac_get_icg(xt->dst_inc, xt->dst_sgl,
-				chunk->icg, chunk->dst_icg);
-}
-
-static size_t at_xdmac_get_src_icg(struct dma_interleaved_template *xt,
-				   struct data_chunk *chunk)
-{
-	return at_xdmac_get_icg(xt->src_inc, xt->src_sgl,
-				chunk->icg, chunk->src_icg);
-}
-
 static struct dma_async_tx_descriptor *
 at_xdmac_prep_interleaved(struct dma_chan *chan,
 			  struct dma_interleaved_template *xt,
@@ -950,8 +912,8 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
 
 		chunk = xt->sgl + i;
 
-		dst_icg = at_xdmac_get_dst_icg(xt, chunk);
-		src_icg = at_xdmac_get_src_icg(xt, chunk);
+		dst_icg = dmaengine_get_dst_icg(xt, chunk);
+		src_icg = dmaengine_get_src_icg(xt, chunk);
 
 		src_skip = chunk->size + src_icg;
 		dst_skip = chunk->size + dst_icg;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 8faf6a2dd9d8..43a9a397b2d7 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -899,6 +899,33 @@ static inline int dma_maxpq(struct dma_device *dma, enum dma_ctrl_flags flags)
 	BUG();
 }
 
+static inline size_t dmaengine_get_icg(bool inc, bool sgl, size_t icg,
+				      size_t dir_icg)
+{
+	if (inc) {
+		if (dir_icg)
+			return dir_icg;
+		else if (sgl)
+			return icg;
+	}
+
+	return 0;
+}
+
+static inline size_t dmaengine_get_dst_icg(struct dma_interleaved_template *xt,
+					   struct data_chunk *chunk)
+{
+	return dmaengine_get_icg(xt->dst_inc, xt->dst_sgl,
+				 chunk->icg, chunk->dst_icg);
+}
+
+static inline size_t dmaengine_get_src_icg(struct dma_interleaved_template *xt,
+					   struct data_chunk *chunk)
+{
+	return dmaengine_get_icg(xt->src_inc, xt->src_sgl,
+				 chunk->icg, chunk->src_icg);
+}
+
 /* --- public DMA engine API --- */
 
 #ifdef CONFIG_DMA_ENGINE
-- 
2.4.1
