From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 26 Jan 2018 20:15:33 +0100
Subject: [PATCH v2 5/6] crypto: stm32-hash: convert to the new crypto engine
 API
In-Reply-To: <20180126191534.17569-1-clabbe.montjoie@gmail.com>
References: <20180126191534.17569-1-clabbe.montjoie@gmail.com>
Message-ID: <20180126191534.17569-6-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch convert the stm32-hash driver to the new crypto engine API.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Tested-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/crypto/stm32/stm32-hash.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index 4ca4a264a833..89b0c2490d80 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -122,6 +122,7 @@ enum stm32_hash_data_format {
 #define HASH_DMA_THRESHOLD		50
 
 struct stm32_hash_ctx {
+	struct crypto_engine_ctx enginectx;
 	struct stm32_hash_dev	*hdev;
 	unsigned long		flags;
 
@@ -828,15 +829,19 @@ static int stm32_hash_hw_init(struct stm32_hash_dev *hdev,
 	return 0;
 }
 
+static int stm32_hash_one_request(struct crypto_engine *engine, void *areq);
+static int stm32_hash_prepare_req(struct crypto_engine *engine, void *areq);
+
 static int stm32_hash_handle_queue(struct stm32_hash_dev *hdev,
 				   struct ahash_request *req)
 {
 	return crypto_transfer_hash_request_to_engine(hdev->engine, req);
 }
 
-static int stm32_hash_prepare_req(struct crypto_engine *engine,
-				  struct ahash_request *req)
+static int stm32_hash_prepare_req(struct crypto_engine *engine, void *areq)
 {
+	struct ahash_request *req = container_of(areq, struct ahash_request,
+						 base);
 	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
 	struct stm32_hash_dev *hdev = stm32_hash_find_dev(ctx);
 	struct stm32_hash_request_ctx *rctx;
@@ -854,9 +859,10 @@ static int stm32_hash_prepare_req(struct crypto_engine *engine,
 	return stm32_hash_hw_init(hdev, rctx);
 }
 
-static int stm32_hash_one_request(struct crypto_engine *engine,
-				  struct ahash_request *req)
+static int stm32_hash_one_request(struct crypto_engine *engine, void *areq)
 {
+	struct ahash_request *req = container_of(areq, struct ahash_request,
+						 base);
 	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
 	struct stm32_hash_dev *hdev = stm32_hash_find_dev(ctx);
 	struct stm32_hash_request_ctx *rctx;
@@ -1033,6 +1039,9 @@ static int stm32_hash_cra_init_algs(struct crypto_tfm *tfm,
 	if (algs_hmac_name)
 		ctx->flags |= HASH_FLAGS_HMAC;
 
+	ctx->enginectx.op.do_one_request = stm32_hash_one_request;
+	ctx->enginectx.op.prepare_request = stm32_hash_prepare_req;
+	ctx->enginectx.op.unprepare_request = NULL;
 	return 0;
 }
 
@@ -1493,9 +1502,6 @@ static int stm32_hash_probe(struct platform_device *pdev)
 		goto err_engine;
 	}
 
-	hdev->engine->prepare_hash_request = stm32_hash_prepare_req;
-	hdev->engine->hash_one_request = stm32_hash_one_request;
-
 	ret = crypto_engine_start(hdev->engine);
 	if (ret)
 		goto err_engine_start;
-- 
2.13.6
