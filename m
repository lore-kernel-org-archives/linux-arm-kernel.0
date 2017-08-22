From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 22 Aug 2017 10:08:10 +0200
Subject: [PATCH 03/11] crypto: ccp - Use GCM IV size constant
In-Reply-To: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
References: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
Message-ID: <20170822080818.12486-4-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replace GCM IV size value by their constant name.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/crypto/ccp/ccp-crypto-aes-galois.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-crypto-aes-galois.c b/drivers/crypto/ccp/ccp-crypto-aes-galois.c
index 52313524a4dd..ff02b713c6f6 100644
--- a/drivers/crypto/ccp/ccp-crypto-aes-galois.c
+++ b/drivers/crypto/ccp/ccp-crypto-aes-galois.c
@@ -19,13 +19,12 @@
 #include <crypto/algapi.h>
 #include <crypto/aes.h>
 #include <crypto/ctr.h>
+#include <crypto/gcm.h>
 #include <crypto/scatterwalk.h>
 #include <linux/delay.h>
 
 #include "ccp-crypto.h"
 
-#define	AES_GCM_IVSIZE	12
-
 static int ccp_aes_gcm_complete(struct crypto_async_request *async_req, int ret)
 {
 	return ret;
@@ -95,9 +94,9 @@ static int ccp_aes_gcm_crypt(struct aead_request *req, bool encrypt)
 	 */
 
 	/* Prepare the IV: 12 bytes + an integer (counter) */
-	memcpy(rctx->iv, req->iv, AES_GCM_IVSIZE);
+	memcpy(rctx->iv, req->iv, GCM_AES_IV_SIZE);
 	for (i = 0; i < 3; i++)
-		rctx->iv[i + AES_GCM_IVSIZE] = 0;
+		rctx->iv[i + GCM_AES_IV_SIZE] = 0;
 	rctx->iv[AES_BLOCK_SIZE - 1] = 1;
 
 	/* Set up a scatterlist for the IV */
@@ -160,7 +159,7 @@ static struct aead_alg ccp_aes_gcm_defaults = {
 	.encrypt = ccp_aes_gcm_encrypt,
 	.decrypt = ccp_aes_gcm_decrypt,
 	.init = ccp_aes_gcm_cra_init,
-	.ivsize = AES_GCM_IVSIZE,
+	.ivsize = GCM_AES_IV_SIZE,
 	.maxauthsize = AES_BLOCK_SIZE,
 	.base = {
 		.cra_flags	= CRYPTO_ALG_TYPE_ABLKCIPHER |
-- 
2.13.0
