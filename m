From: marex@denx.de (Marek Vasut)
Date: Tue, 14 Jan 2014 18:33:49 +0100
Subject: [PATCH 3/3] crypto: Simplify the ahash_finup implementation
In-Reply-To: <1389720829-5963-1-git-send-email-marex@denx.de>
References: <1389720829-5963-1-git-send-email-marex@denx.de>
Message-ID: <1389720829-5963-4-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ahash_def_finup() can make use of the request save/restore functions,
thus make it so. This simplifies the code a little and unifies the code
paths.

Note that the same remark about free()ing the req->priv applies here, the
req->priv can only be free()'d after the original request was restored.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
---
 crypto/ahash.c | 53 ++++++++++++++++++++---------------------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/crypto/ahash.c b/crypto/ahash.c
index 635cd49..561ebaf 100644
--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -350,20 +350,19 @@ static void ahash_def_finup_finish2(struct ahash_request *req, int err)
 	if (!err)
 		memcpy(priv->result, req->result,
 		       crypto_ahash_digestsize(crypto_ahash_reqtfm(req)));
-
-	kzfree(priv);
 }
 
-static void ahash_def_finup_done2(struct crypto_async_request *req, int err)
+static void ahash_def_finup_done2(struct crypto_async_request *areq, int err)
 {
-	struct ahash_request *areq = req->data;
-	struct ahash_request_priv *priv = areq->priv;
-	crypto_completion_t complete = priv->complete;
-	void *data = priv->data;
+	struct ahash_request *req = areq->data;
+	struct crypto_async_request *data;
 
-	ahash_def_finup_finish2(areq, err);
+	ahash_def_finup_finish2(req, err);
 
-	complete(data, err);
+	ahash_restore_req(req);
+
+	data = req->base.data;
+	req->base.complete(data, err);
 }
 
 static int ahash_def_finup_finish1(struct ahash_request *req, int err)
@@ -380,39 +379,27 @@ out:
 	return err;
 }
 
-static void ahash_def_finup_done1(struct crypto_async_request *req, int err)
+static void ahash_def_finup_done1(struct crypto_async_request *areq, int err)
 {
-	struct ahash_request *areq = req->data;
-	struct ahash_request_priv *priv = areq->priv;
-	crypto_completion_t complete = priv->complete;
-	void *data = priv->data;
+	struct ahash_request *req = areq->data;
+	struct crypto_async_request *data;
 
-	err = ahash_def_finup_finish1(areq, err);
+	err = ahash_def_finup_finish1(req, err);
+
+	ahash_restore_req(req);
 
-	complete(data, err);
+	data = req->base.data;
+	req->base.complete(data, err);
 }
 
 static int ahash_def_finup(struct ahash_request *req)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	unsigned long alignmask = crypto_ahash_alignmask(tfm);
-	unsigned int ds = crypto_ahash_digestsize(tfm);
-	struct ahash_request_priv *priv;
-
-	priv = kmalloc(sizeof(*priv) + ahash_align_buffer_size(ds, alignmask),
-		       (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
-		       GFP_KERNEL : GFP_ATOMIC);
-	if (!priv)
-		return -ENOMEM;
-
-	priv->result = req->result;
-	priv->complete = req->base.complete;
-	priv->data = req->base.data;
+	int err;
 
-	req->result = PTR_ALIGN((u8 *)priv->ubuf, alignmask + 1);
-	req->base.complete = ahash_def_finup_done1;
-	req->base.data = req;
-	req->priv = priv;
+	err = ahash_save_req(req, ahash_def_finup_done1);
+	if (err)
+		return err;
 
 	return ahash_def_finup_finish1(req, tfm->update(req));
 }
-- 
1.8.5.2
