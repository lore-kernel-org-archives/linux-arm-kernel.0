From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Wed,  3 Jan 2018 21:11:09 +0100
Subject: [PATCH 6/6] crypto: stm32-cryp: convert to the new crypto engine API
In-Reply-To: <20180103201109.16077-1-clabbe.montjoie@gmail.com>
References: <20180103201109.16077-1-clabbe.montjoie@gmail.com>
Message-ID: <20180103201109.16077-7-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch convert the stm32-cryp driver to the new crypto engine API.
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/crypto/stm32/stm32-cryp.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
index cf1dddbeaa2c..99e0473ef247 100644
--- a/drivers/crypto/stm32/stm32-cryp.c
+++ b/drivers/crypto/stm32/stm32-cryp.c
@@ -91,6 +91,7 @@
 #define _walked_out             (cryp->out_walk.offset - cryp->out_sg->offset)
 
 struct stm32_cryp_ctx {
+	struct crypto_engine_reqctx enginectx;
 	struct stm32_cryp       *cryp;
 	int                     keylen;
 	u32                     key[AES_KEYSIZE_256 / sizeof(u32)];
@@ -494,10 +495,20 @@ static int stm32_cryp_cpu_start(struct stm32_cryp *cryp)
 	return 0;
 }
 
+static int stm32_cryp_cipher_one_req(struct crypto_engine *engine,
+				     void *areq);
+static int stm32_cryp_prepare_cipher_req(struct crypto_engine *engine,
+					 void *areq);
+
 static int stm32_cryp_cra_init(struct crypto_tfm *tfm)
 {
+	struct stm32_cryp_ctx *ctx = crypto_tfm_ctx(tfm);
+
 	tfm->crt_ablkcipher.reqsize = sizeof(struct stm32_cryp_reqctx);
 
+	ctx->enginectx.op.do_one_request = stm32_cryp_cipher_one_req;
+	ctx->enginectx.op.prepare_request = stm32_cryp_prepare_cipher_req;
+	ctx->enginectx.op.unprepare_request = NULL;
 	return 0;
 }
 
@@ -695,14 +706,17 @@ static int stm32_cryp_prepare_req(struct crypto_engine *engine,
 }
 
 static int stm32_cryp_prepare_cipher_req(struct crypto_engine *engine,
-					 struct ablkcipher_request *req)
+					 void *areq)
 {
+	struct ablkcipher_request *req = container_of(areq, struct ablkcipher_request, base);
+
 	return stm32_cryp_prepare_req(engine, req);
 }
 
 static int stm32_cryp_cipher_one_req(struct crypto_engine *engine,
-				     struct ablkcipher_request *req)
+				     void *areq)
 {
+	struct ablkcipher_request *req = container_of(areq, struct ablkcipher_request, base);
 	struct stm32_cryp_ctx *ctx = crypto_ablkcipher_ctx(
 			crypto_ablkcipher_reqtfm(req));
 	struct stm32_cryp *cryp = ctx->cryp;
@@ -1104,9 +1118,6 @@ static int stm32_cryp_probe(struct platform_device *pdev)
 		goto err_engine1;
 	}
 
-	cryp->engine->prepare_cipher_request = stm32_cryp_prepare_cipher_req;
-	cryp->engine->cipher_one_request = stm32_cryp_cipher_one_req;
-
 	ret = crypto_engine_start(cryp->engine);
 	if (ret) {
 		dev_err(dev, "Could not start crypto engine\n");
-- 
2.13.6
