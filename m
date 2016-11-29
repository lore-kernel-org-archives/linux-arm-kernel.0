From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 29 Nov 2016 17:23:36 +0000
Subject: [PATCH] crypto: arm/aesbs - fix brokenness after skcipher conversion
Message-ID: <1480440216-341-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CBC encryption routine should use the encryption round keys, not
the decryption round keys.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

Another fix for the queued changes, this time for 32-bit ARM.

I must say, I'm not impressed with the level of testing that has been
carried out after applying these changes. If you had cc'd me on these
patches, I would have been happy to test/review.

 arch/arm/crypto/aesbs-glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/crypto/aesbs-glue.c b/arch/arm/crypto/aesbs-glue.c
index f5eafce10557..d8e06de72ef3 100644
--- a/arch/arm/crypto/aesbs-glue.c
+++ b/arch/arm/crypto/aesbs-glue.c
@@ -113,7 +113,7 @@ static inline void aesbs_encrypt_one(struct crypto_skcipher *tfm,
 {
 	struct aesbs_cbc_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	AES_encrypt(src, dst, &ctx->dec.rk);
+	AES_encrypt(src, dst, &ctx->enc);
 }
 
 static int aesbs_cbc_encrypt(struct skcipher_request *req)
-- 
2.7.4
