From: romain.perier@free-electrons.com (Romain Perier)
Date: Thu, 18 Aug 2016 14:12:14 +0200
Subject: [PATCH 2/2] crypto: marvell - Don't break chain for computable last
 ahash requests
In-Reply-To: <1471522334-24839-1-git-send-email-romain.perier@free-electrons.com>
References: <1471522334-24839-1-git-send-email-romain.perier@free-electrons.com>
Message-ID: <1471522334-24839-3-git-send-email-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the driver breaks chain for all kind of hash requests in order
to don't override intermediate states of partial ahash updates. However,
some final ahash requests can be directly processed by the engine, and
so without intermediate state. This is typically the case for most for
the HMAC requests processed via IPSec.

This commits adds a TDMA descriptor to copy outer results for thise kind
of request into the "result" dma pool, then it allow to chain these
requests at the DMA level. The 'complete' operation is also updated to
retrieve the MAC digest from the right location.

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
---
 drivers/crypto/marvell/hash.c | 69 +++++++++++++++++++++++++++++++++----------
 1 file changed, 54 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/marvell/hash.c b/drivers/crypto/marvell/hash.c
index 9f28468..1a91662 100644
--- a/drivers/crypto/marvell/hash.c
+++ b/drivers/crypto/marvell/hash.c
@@ -312,24 +312,48 @@ static void mv_cesa_ahash_complete(struct crypto_async_request *req)
 	int i;
 
 	digsize = crypto_ahash_digestsize(crypto_ahash_reqtfm(ahashreq));
-	for (i = 0; i < digsize / 4; i++)
-		creq->state[i] = readl_relaxed(engine->regs + CESA_IVDIG(i));
 
-	if (creq->last_req) {
+	if (mv_cesa_req_get_type(&creq->base) == CESA_DMA_REQ &&
+	    !(creq->base.chain.last->flags & CESA_TDMA_BREAK_CHAIN)) {
+		struct mv_cesa_tdma_desc *tdma = NULL;
+
+		for (tdma = creq->base.chain.first; tdma; tdma = tdma->next) {
+			u32 type = tdma->flags & CESA_TDMA_TYPE_MSK;
+			if (type ==  CESA_TDMA_RESULT)
+				break;
+		}
+
+		BUG_ON(!tdma);
+
 		/*
-		 * Hardware's MD5 digest is in little endian format, but
-		 * SHA in big endian format
+		 * Result is already in the correct endianess when the SA is
+		 * used
 		 */
-		if (creq->algo_le) {
-			__le32 *result = (void *)ahashreq->result;
+		__le32 *data = tdma->data + 0x40;
+		for (i = 0; i < digsize / 4; i++)
+			creq->state[i] = cpu_to_le32(data[i]);
 
-			for (i = 0; i < digsize / 4; i++)
-				result[i] = cpu_to_le32(creq->state[i]);
-		} else {
-			__be32 *result = (void *)ahashreq->result;
+		memcpy(ahashreq->result, data, digsize);
+	} else {
+		for (i = 0; i < digsize / 4; i++)
+			creq->state[i] = readl_relaxed(engine->regs +
+						       CESA_IVDIG(i));
+		if (creq->last_req) {
+			/*
+			* Hardware's MD5 digest is in little endian format, but
+			* SHA in big endian format
+			*/
+			if (creq->algo_le) {
+				__le32 *result = (void *)ahashreq->result;
+
+				for (i = 0; i < digsize / 4; i++)
+					result[i] = cpu_to_le32(creq->state[i]);
+			} else {
+				__be32 *result = (void *)ahashreq->result;
 
-			for (i = 0; i < digsize / 4; i++)
-				result[i] = cpu_to_be32(creq->state[i]);
+				for (i = 0; i < digsize / 4; i++)
+					result[i] = cpu_to_be32(creq->state[i]);
+			}
 		}
 	}
 
@@ -504,6 +528,11 @@ mv_cesa_ahash_dma_last_req(struct mv_cesa_tdma_chain *chain,
 						CESA_SA_DESC_CFG_LAST_FRAG,
 				      CESA_SA_DESC_CFG_FRAG_MSK);
 
+		ret = mv_cesa_dma_add_result_op(chain,
+						CESA_SA_MAC_IIV_SRAM_OFFSET, 96,
+						CESA_TDMA_SRC_IN_SRAM, flags);
+		if (ret)
+			return ERR_PTR(-ENOMEM);
 		return op;
 	}
 
@@ -564,6 +593,7 @@ static int mv_cesa_ahash_dma_req_init(struct ahash_request *req)
 	struct mv_cesa_op_ctx *op = NULL;
 	unsigned int frag_len;
 	int ret;
+	u32 type;
 
 	basereq->chain.first = NULL;
 	basereq->chain.last = NULL;
@@ -635,6 +665,8 @@ static int mv_cesa_ahash_dma_req_init(struct ahash_request *req)
 		goto err_free_tdma;
 	}
 
+	type = basereq->chain.last->flags & CESA_TDMA_TYPE_MSK;
+
 	if (op) {
 		/* Add dummy desc to wait for crypto operation end */
 		ret = mv_cesa_dma_add_dummy_end(&basereq->chain, flags);
@@ -648,8 +680,15 @@ static int mv_cesa_ahash_dma_req_init(struct ahash_request *req)
 	else
 		creq->cache_ptr = 0;
 
-	basereq->chain.last->flags |= (CESA_TDMA_END_OF_REQ |
-				       CESA_TDMA_BREAK_CHAIN);
+	basereq->chain.last->flags |= CESA_TDMA_END_OF_REQ;
+	/*
+	 * If results are copied via DMA, this means that this
+	 * request can be directly processed by the engine,
+	 * without partial updates. So we can chain it at the
+	 * DMA level with other requests.
+	 */
+	if (type != CESA_TDMA_RESULT)
+		basereq->chain.last->flags |= CESA_TDMA_BREAK_CHAIN;
 
 	return 0;
 
-- 
2.8.1
