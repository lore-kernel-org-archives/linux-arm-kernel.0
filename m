From: romain.perier@free-electrons.com (Romain Perier)
Date: Tue,  4 Oct 2016 14:57:20 +0200
Subject: [PATCH v3 2/2] crypto: marvell - Don't break chain for computable
 last ahash requests
In-Reply-To: <20161004125720.3347-1-romain.perier@free-electrons.com>
References: <20161004125720.3347-1-romain.perier@free-electrons.com>
Message-ID: <20161004125720.3347-3-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the driver breaks chain for all kind of hash requests in order to
don't override intermediate states of partial ahash updates. However, some final
ahash requests can be directly processed by the engine, and so without
intermediate state. This is typically the case for most for the HMAC requests
processed via IPSec.

This commits adds a TDMA descriptor to copy context for these of requests
into the "op" dma pool, then it allow to chain these requests at the DMA level.
The 'complete' operation is also updated to retrieve the MAC digest from the
right location.

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
---

Changes in v3:
 - Copy the whole context back to RAM and not just the digest. Also
   fixed a rebase issue ^^ (whoops)

Changes in v2:
 - Replaced BUG_ON by an error
 - Add a variable "break_chain", with "type" to break the chain

   with ahash requests. It improves code readability.
 drivers/crypto/marvell/hash.c | 79 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/marvell/hash.c b/drivers/crypto/marvell/hash.c
index 9f28468..b36f196 100644
--- a/drivers/crypto/marvell/hash.c
+++ b/drivers/crypto/marvell/hash.c
@@ -312,24 +312,53 @@ static void mv_cesa_ahash_complete(struct crypto_async_request *req)
 	int i;
 
 	digsize = crypto_ahash_digestsize(crypto_ahash_reqtfm(ahashreq));
-	for (i = 0; i < digsize / 4; i++)
-		creq->state[i] = readl_relaxed(engine->regs + CESA_IVDIG(i));
 
-	if (creq->last_req) {
+	if (mv_cesa_req_get_type(&creq->base) == CESA_DMA_REQ &&
+	    !(creq->base.chain.last->flags & CESA_TDMA_BREAK_CHAIN)) {
+		struct mv_cesa_tdma_desc *tdma = NULL;
+		__le32 *data = NULL;
+
+		for (tdma = creq->base.chain.first; tdma; tdma = tdma->next) {
+			u32 type = tdma->flags & CESA_TDMA_TYPE_MSK;
+			if (type ==  CESA_TDMA_RESULT)
+				break;
+		}
+
+		if (!tdma) {
+			dev_err(cesa_dev->dev, "Failed to retrieve tdma "
+					       "descriptor for outer data\n");
+			return;
+		}
+
 		/*
-		 * Hardware's MD5 digest is in little endian format, but
-		 * SHA in big endian format
+		 * Result is already in the correct endianess when the SA is
+		 * used
 		 */
-		if (creq->algo_le) {
-			__le32 *result = (void *)ahashreq->result;
+		data = tdma->op->ctx.hash.hash;
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
 
@@ -504,6 +533,12 @@ mv_cesa_ahash_dma_last_req(struct mv_cesa_tdma_chain *chain,
 						CESA_SA_DESC_CFG_LAST_FRAG,
 				      CESA_SA_DESC_CFG_FRAG_MSK);
 
+		ret = mv_cesa_dma_add_result_op(chain,
+						CESA_SA_CFG_SRAM_OFFSET,
+						CESA_SA_DATA_SRAM_OFFSET,
+						CESA_TDMA_SRC_IN_SRAM, flags);
+		if (ret)
+			return ERR_PTR(-ENOMEM);
 		return op;
 	}
 
@@ -564,6 +599,8 @@ static int mv_cesa_ahash_dma_req_init(struct ahash_request *req)
 	struct mv_cesa_op_ctx *op = NULL;
 	unsigned int frag_len;
 	int ret;
+	u32 type;
+	bool break_chain = true;
 
 	basereq->chain.first = NULL;
 	basereq->chain.last = NULL;
@@ -635,6 +672,16 @@ static int mv_cesa_ahash_dma_req_init(struct ahash_request *req)
 		goto err_free_tdma;
 	}
 
+	/*
+	 * If results are copied via DMA, this means that this
+	 * request can be directly processed by the engine,
+	 * without partial updates. So we can chain it at the
+	 * DMA level with other requests.
+	 */
+	type = basereq->chain.last->flags & CESA_TDMA_TYPE_MSK;
+	if (type == CESA_TDMA_RESULT)
+		break_chain = false;
+
 	if (op) {
 		/* Add dummy desc to wait for crypto operation end */
 		ret = mv_cesa_dma_add_dummy_end(&basereq->chain, flags);
@@ -648,8 +695,10 @@ static int mv_cesa_ahash_dma_req_init(struct ahash_request *req)
 	else
 		creq->cache_ptr = 0;
 
-	basereq->chain.last->flags |= (CESA_TDMA_END_OF_REQ |
-				       CESA_TDMA_BREAK_CHAIN);
+	basereq->chain.last->flags |= CESA_TDMA_END_OF_REQ;
+
+	if (break_chain)
+		basereq->chain.last->flags |= CESA_TDMA_BREAK_CHAIN;
 
 	return 0;
 
-- 
2.9.3
