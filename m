From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon, 24 Apr 2017 16:16:21 +0200
Subject: [PATCH 1/9] crypto: add hmac IPAD/OPAD constant
Message-ID: <20170424141629.27155-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many HMAC users directly use directly 0x36/0x5c values.
It's better with crypto to use a name instead of directly some crypto
constant.

This patch simply add HMAC_IPAD_VALUE/HMAC_OPAD_VALUE defines.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 crypto/hmac.c         | 4 ++--
 include/crypto/hash.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/crypto/hmac.c b/crypto/hmac.c
index 72e38c0..4a997ce 100644
--- a/crypto/hmac.c
+++ b/crypto/hmac.c
@@ -74,8 +74,8 @@ static int hmac_setkey(struct crypto_shash *parent,
 	memcpy(opad, ipad, bs);
 
 	for (i = 0; i < bs; i++) {
-		ipad[i] ^= 0x36;
-		opad[i] ^= 0x5c;
+		ipad[i] ^= HMAC_IPAD_VALUE;
+		opad[i] ^= HMAC_OPAD_VALUE;
 	}
 
 	return crypto_shash_init(shash) ?:
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index b5727bc..0f51ff1 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -922,4 +922,7 @@ static inline void shash_desc_zero(struct shash_desc *desc)
 			 sizeof(*desc) + crypto_shash_descsize(desc->tfm));
 }
 
+#define HMAC_IPAD_VALUE 0x36
+#define HMAC_OPAD_VALUE 0x5c
+
 #endif	/* _CRYPTO_HASH_H */
-- 
2.10.2
