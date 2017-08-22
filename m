From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 22 Aug 2017 10:08:15 +0200
Subject: [PATCH 08/11] crypto: chelsio - Use GCM IV size constant
In-Reply-To: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
References: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
Message-ID: <20170822080818.12486-9-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replace GCM IV size value by their constant name.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/crypto/chelsio/chcr_algo.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index 0e8160701833..936bdd895efa 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -53,6 +53,7 @@
 #include <crypto/aes.h>
 #include <crypto/algapi.h>
 #include <crypto/hash.h>
+#include <crypto/gcm.h>
 #include <crypto/sha.h>
 #include <crypto/authenc.h>
 #include <crypto/ctr.h>
@@ -2534,9 +2535,9 @@ static struct sk_buff *create_gcm_wr(struct aead_request *req,
 	if (get_aead_subtype(tfm) ==
 	    CRYPTO_ALG_SUB_TYPE_AEAD_RFC4106) {
 		memcpy(reqctx->iv, aeadctx->salt, 4);
-		memcpy(reqctx->iv + 4, req->iv, 8);
+		memcpy(reqctx->iv + 4, req->iv, GCM_RFC4106_IV_SIZE);
 	} else {
-		memcpy(reqctx->iv, req->iv, 12);
+		memcpy(reqctx->iv, req->iv, GCM_AES_IV_SIZE);
 	}
 	*((unsigned int *)(reqctx->iv + 12)) = htonl(0x01);
 
@@ -3385,7 +3386,7 @@ static struct chcr_alg_template driver_algs[] = {
 						sizeof(struct chcr_aead_ctx) +
 						sizeof(struct chcr_gcm_ctx),
 			},
-			.ivsize = 12,
+			.ivsize = GCM_AES_IV_SIZE,
 			.maxauthsize = GHASH_DIGEST_SIZE,
 			.setkey = chcr_gcm_setkey,
 			.setauthsize = chcr_gcm_setauthsize,
@@ -3405,7 +3406,7 @@ static struct chcr_alg_template driver_algs[] = {
 						sizeof(struct chcr_gcm_ctx),
 
 			},
-			.ivsize = 8,
+			.ivsize = GCM_RFC4106_IV_SIZE,
 			.maxauthsize	= GHASH_DIGEST_SIZE,
 			.setkey = chcr_gcm_setkey,
 			.setauthsize	= chcr_4106_4309_setauthsize,
-- 
2.13.0
