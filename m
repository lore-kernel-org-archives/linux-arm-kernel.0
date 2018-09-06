From: keescook@chromium.org (Kees Cook)
Date: Thu,  6 Sep 2018 15:58:52 -0700
Subject: [PATCH v2 2/4] crypto: skcipher - Enforce non-ASYNC for on-stack
 requests
In-Reply-To: <20180906225854.40989-1-keescook@chromium.org>
References: <20180906225854.40989-1-keescook@chromium.org>
Message-ID: <20180906225854.40989-3-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check at use-time whether an skcipher request is on the stack. If it
is, enforce that it must be backed by a synchronous algorithm, as is
required:

  https://www.redhat.com/archives/dm-devel/2018-January/msg00087.html

Co-developed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/crypto/skcipher.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
index 6e954d398e0f..3aabd5d098ed 100644
--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -19,6 +19,7 @@
 
 /**
  *	struct skcipher_request - Symmetric key cipher request
+ *	@__onstack: 1 if the request was allocated by SKCIPHER_REQUEST_ON_STACK
  *	@cryptlen: Number of bytes to encrypt or decrypt
  *	@iv: Initialisation Vector
  *	@src: Source SG list
@@ -27,6 +28,7 @@
  *	@__ctx: Start of private context data
  */
 struct skcipher_request {
+	unsigned char __onstack;
 	unsigned int cryptlen;
 
 	u8 *iv;
@@ -139,9 +141,12 @@ struct skcipher_alg {
 	struct crypto_alg base;
 };
 
+/*
+ * This must only ever be used with synchronous algorithms.
+ */
 #define SKCIPHER_REQUEST_ON_STACK(name, tfm) \
 	char __##name##_desc[sizeof(struct skcipher_request) + \
-		crypto_skcipher_reqsize(tfm)] CRYPTO_MINALIGN_ATTR; \
+		crypto_skcipher_reqsize(tfm)] CRYPTO_MINALIGN_ATTR = { 1 }; \
 	struct skcipher_request *name = (void *)__##name##_desc
 
 /**
@@ -437,6 +442,12 @@ static inline struct crypto_skcipher *crypto_skcipher_reqtfm_check(
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 
+	if (req->__onstack) {
+		if (WARN_ON(crypto_skcipher_alg(tfm)->base.cra_flags &
+				CRYPTO_ALG_ASYNC))
+			return ERR_PTR(-EINVAL);
+	}
+
 	if (crypto_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
 		return ERR_PTR(-ENOKEY);
 
-- 
2.17.1
