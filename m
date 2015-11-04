From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Wed,  4 Nov 2015 21:13:37 +0100
Subject: [PATCH 5/7] crypto: picoxcell: check return value of sg_nents_for_len
In-Reply-To: <1446668045-8620-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1446668045-8620-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <1446668045-8620-5-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sg_nents_for_len() function could fail, this patch add a check for
its return value.
In the same time, we remove sg_count() as it is used as an alias of
sg_nents_for_len.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/crypto/picoxcell_crypto.c | 48 +++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/picoxcell_crypto.c b/drivers/crypto/picoxcell_crypto.c
index da36de2..1b16eb28 100644
--- a/drivers/crypto/picoxcell_crypto.c
+++ b/drivers/crypto/picoxcell_crypto.c
@@ -272,12 +272,6 @@ static unsigned spacc_load_ctx(struct spacc_generic_ctx *ctx,
 	return indx;
 }
 
-/* Count the number of scatterlist entries in a scatterlist. */
-static inline int sg_count(struct scatterlist *sg_list, int nbytes)
-{
-	return sg_nents_for_len(sg_list, nbytes);
-}
-
 static inline void ddt_set(struct spacc_ddt *ddt, dma_addr_t phys, size_t len)
 {
 	ddt->p = phys;
@@ -300,7 +294,11 @@ static struct spacc_ddt *spacc_sg_to_ddt(struct spacc_engine *engine,
 	struct spacc_ddt *ddt;
 	int i;
 
-	nents = sg_count(payload, nbytes);
+	nents = sg_nents_for_len(payload, nbytes);
+	if (nents < 0) {
+		dev_err(engine->dev, "Invalid numbers of SG.\n");
+		return NULL;
+	}
 	mapped_ents = dma_map_sg(engine->dev, payload, nents, dir);
 
 	if (mapped_ents + 1 > MAX_DDT_LEN)
@@ -336,13 +334,21 @@ static int spacc_aead_make_ddts(struct aead_request *areq)
 	if (req->is_encrypt)
 		total += crypto_aead_authsize(aead);
 
-	src_nents = sg_count(areq->src, total);
+	src_nents = sg_nents_for_len(areq->src, total);
+	if (src_nents < 0) {
+		dev_err(engine->dev, "Invalid numbers of src SG.\n");
+		return src_nents;
+	}
 	if (src_nents + 1 > MAX_DDT_LEN)
 		return -E2BIG;
 
 	dst_nents = 0;
 	if (areq->src != areq->dst) {
-		dst_nents = sg_count(areq->dst, total);
+		dst_nents = sg_nents_for_len(areq->dst, total);
+		if (dst_nents < 0) {
+			dev_err(engine->dev, "Invalid numbers of dst SG.\n");
+			return dst_nents;
+		}
 		if (src_nents + 1 > MAX_DDT_LEN)
 			return -E2BIG;
 	}
@@ -422,13 +428,22 @@ static void spacc_aead_free_ddts(struct spacc_req *req)
 			 (req->is_encrypt ? crypto_aead_authsize(aead) : 0);
 	struct spacc_aead_ctx *aead_ctx = crypto_aead_ctx(aead);
 	struct spacc_engine *engine = aead_ctx->generic.engine;
-	unsigned nents = sg_count(areq->src, total);
+	int nents = sg_nents_for_len(areq->src, total);
+
+	/* sg_nents_for_len should not fail since it works when mapping sg */
+	if (unlikely(nents < 0)) {
+		dev_err(engine->dev, "Invalid numbers of src SG.\n");
+		return;
+	}
 
 	if (areq->src != areq->dst) {
 		dma_unmap_sg(engine->dev, areq->src, nents, DMA_TO_DEVICE);
-		dma_unmap_sg(engine->dev, areq->dst,
-			     sg_count(areq->dst, total),
-			     DMA_FROM_DEVICE);
+		nents = sg_nents_for_len(areq->dst, total);
+		if (unlikely(nents < 0)) {
+			dev_err(engine->dev, "Invalid numbers of dst SG.\n");
+			return;
+		}
+		dma_unmap_sg(engine->dev, areq->dst, nents, DMA_FROM_DEVICE);
 	} else
 		dma_unmap_sg(engine->dev, areq->src, nents, DMA_BIDIRECTIONAL);
 
@@ -440,7 +455,12 @@ static void spacc_free_ddt(struct spacc_req *req, struct spacc_ddt *ddt,
 			   dma_addr_t ddt_addr, struct scatterlist *payload,
 			   unsigned nbytes, enum dma_data_direction dir)
 {
-	unsigned nents = sg_count(payload, nbytes);
+	int nents = sg_nents_for_len(payload, nbytes);
+
+	if (nents < 0) {
+		dev_err(req->engine->dev, "Invalid numbers of SG.\n");
+		return;
+	}
 
 	dma_unmap_sg(req->engine->dev, payload, nents, dir);
 	dma_pool_free(req->engine->req_pool, ddt, ddt_addr);
-- 
2.4.10
