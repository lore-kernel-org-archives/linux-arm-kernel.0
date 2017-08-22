From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 22 Aug 2017 10:08:11 +0200
Subject: [PATCH 04/11] crypto: nx - Use GCM IV size constant
In-Reply-To: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
References: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
Message-ID: <20170822080818.12486-5-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replace GCM IV size value by their constant name.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/crypto/nx/nx-aes-gcm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/nx/nx-aes-gcm.c b/drivers/crypto/nx/nx-aes-gcm.c
index abd465f479c4..a810596b97c2 100644
--- a/drivers/crypto/nx/nx-aes-gcm.c
+++ b/drivers/crypto/nx/nx-aes-gcm.c
@@ -22,6 +22,7 @@
 #include <crypto/internal/aead.h>
 #include <crypto/aes.h>
 #include <crypto/algapi.h>
+#include <crypto/gcm.h>
 #include <crypto/scatterwalk.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -433,7 +434,7 @@ static int gcm_aes_nx_encrypt(struct aead_request *req)
 	struct nx_gcm_rctx *rctx = aead_request_ctx(req);
 	char *iv = rctx->iv;
 
-	memcpy(iv, req->iv, 12);
+	memcpy(iv, req->iv, GCM_AES_IV_SIZE);
 
 	return gcm_aes_nx_crypt(req, 1, req->assoclen);
 }
@@ -443,7 +444,7 @@ static int gcm_aes_nx_decrypt(struct aead_request *req)
 	struct nx_gcm_rctx *rctx = aead_request_ctx(req);
 	char *iv = rctx->iv;
 
-	memcpy(iv, req->iv, 12);
+	memcpy(iv, req->iv, GCM_AES_IV_SIZE);
 
 	return gcm_aes_nx_crypt(req, 0, req->assoclen);
 }
@@ -498,7 +499,7 @@ struct aead_alg nx_gcm_aes_alg = {
 	},
 	.init        = nx_crypto_ctx_aes_gcm_init,
 	.exit        = nx_crypto_ctx_aead_exit,
-	.ivsize      = 12,
+	.ivsize      = GCM_AES_IV_SIZE,
 	.maxauthsize = AES_BLOCK_SIZE,
 	.setkey      = gcm_aes_nx_set_key,
 	.encrypt     = gcm_aes_nx_encrypt,
@@ -516,7 +517,7 @@ struct aead_alg nx_gcm4106_aes_alg = {
 	},
 	.init        = nx_crypto_ctx_aes_gcm_init,
 	.exit        = nx_crypto_ctx_aead_exit,
-	.ivsize      = 8,
+	.ivsize      = GCM_RFC4106_IV_SIZE,
 	.maxauthsize = AES_BLOCK_SIZE,
 	.setkey      = gcm4106_aes_nx_set_key,
 	.setauthsize = gcm4106_aes_nx_setauthsize,
-- 
2.13.0
