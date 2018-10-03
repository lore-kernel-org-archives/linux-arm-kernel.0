From: ebiggers@kernel.org (Eric Biggers)
Date: Tue,  2 Oct 2018 22:22:15 -0700
Subject: [PATCH] crypto: arm64/aes - fix handling sub-block CTS-CBC inputs
Message-ID: <20181003052215.22468-1-ebiggers@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Biggers <ebiggers@google.com>

In the new arm64 CTS-CBC implementation, return an error code rather
than crashing on inputs shorter than AES_BLOCK_SIZE bytes.  Also set
cra_blocksize to AES_BLOCK_SIZE (like is done in the cts template) to
indicate the minimum input size.

Fixes: dd597fb33ff0 ("crypto: arm64/aes-blk - add support for CTS-CBC mode")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm64/crypto/aes-glue.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
index 26d2b0263ba63..1e676625ef33f 100644
--- a/arch/arm64/crypto/aes-glue.c
+++ b/arch/arm64/crypto/aes-glue.c
@@ -243,8 +243,11 @@ static int cts_cbc_encrypt(struct skcipher_request *req)
 
 	skcipher_request_set_tfm(&rctx->subreq, tfm);
 
-	if (req->cryptlen == AES_BLOCK_SIZE)
+	if (req->cryptlen <= AES_BLOCK_SIZE) {
+		if (req->cryptlen < AES_BLOCK_SIZE)
+			return -EINVAL;
 		cbc_blocks = 1;
+	}
 
 	if (cbc_blocks > 0) {
 		unsigned int blocks;
@@ -305,8 +308,11 @@ static int cts_cbc_decrypt(struct skcipher_request *req)
 
 	skcipher_request_set_tfm(&rctx->subreq, tfm);
 
-	if (req->cryptlen == AES_BLOCK_SIZE)
+	if (req->cryptlen <= AES_BLOCK_SIZE) {
+		if (req->cryptlen < AES_BLOCK_SIZE)
+			return -EINVAL;
 		cbc_blocks = 1;
+	}
 
 	if (cbc_blocks > 0) {
 		unsigned int blocks;
@@ -486,14 +492,13 @@ static struct skcipher_alg aes_algs[] = { {
 		.cra_driver_name	= "__cts-cbc-aes-" MODE,
 		.cra_priority		= PRIO,
 		.cra_flags		= CRYPTO_ALG_INTERNAL,
-		.cra_blocksize		= 1,
+		.cra_blocksize		= AES_BLOCK_SIZE,
 		.cra_ctxsize		= sizeof(struct crypto_aes_ctx),
 		.cra_module		= THIS_MODULE,
 	},
 	.min_keysize	= AES_MIN_KEY_SIZE,
 	.max_keysize	= AES_MAX_KEY_SIZE,
 	.ivsize		= AES_BLOCK_SIZE,
-	.chunksize	= AES_BLOCK_SIZE,
 	.walksize	= 2 * AES_BLOCK_SIZE,
 	.setkey		= skcipher_aes_setkey,
 	.encrypt	= cts_cbc_encrypt,
-- 
2.19.0
