From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  2 Jan 2017 18:21:03 +0000
Subject: [PATCH 1/6] crypto: generic/aes - export encrypt and decrypt entry
 points
In-Reply-To: <1483381268-12987-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1483381268-12987-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1483381268-12987-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic AES code already shares its key schedule generation
routines (and its S-boxes) with other implementations via external
linkage. In the same way, export the core encrypt/decrypt routines
so they may be reused by other drivers as well.

This facility will be used by the bit slicing implementation of AES
in XTS mode for arm64, where using the 8-way cipher (and its ~2 KB
expanded key schedule) to generate the initial tweak is suboptimal.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 crypto/aes_generic.c | 10 ++++++----
 include/crypto/aes.h |  3 +++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/crypto/aes_generic.c b/crypto/aes_generic.c
index 3dd101144a58..26fd7b8c2e5f 100644
--- a/crypto/aes_generic.c
+++ b/crypto/aes_generic.c
@@ -1326,7 +1326,7 @@ EXPORT_SYMBOL_GPL(crypto_aes_set_key);
 	f_rl(bo, bi, 3, k);	\
 } while (0)
 
-static void aes_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
+void crypto_aes_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
 	const struct crypto_aes_ctx *ctx = crypto_tfm_ctx(tfm);
 	const __le32 *src = (const __le32 *)in;
@@ -1366,6 +1366,7 @@ static void aes_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 	dst[2] = cpu_to_le32(b0[2]);
 	dst[3] = cpu_to_le32(b0[3]);
 }
+EXPORT_SYMBOL_GPL(crypto_aes_encrypt);
 
 /* decrypt a block of text */
 
@@ -1398,7 +1399,7 @@ static void aes_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 	i_rl(bo, bi, 3, k);	\
 } while (0)
 
-static void aes_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
+void crypto_aes_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
 	const struct crypto_aes_ctx *ctx = crypto_tfm_ctx(tfm);
 	const __le32 *src = (const __le32 *)in;
@@ -1438,6 +1439,7 @@ static void aes_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 	dst[2] = cpu_to_le32(b0[2]);
 	dst[3] = cpu_to_le32(b0[3]);
 }
+EXPORT_SYMBOL_GPL(crypto_aes_decrypt);
 
 static struct crypto_alg aes_alg = {
 	.cra_name		=	"aes",
@@ -1453,8 +1455,8 @@ static struct crypto_alg aes_alg = {
 			.cia_min_keysize	=	AES_MIN_KEY_SIZE,
 			.cia_max_keysize	=	AES_MAX_KEY_SIZE,
 			.cia_setkey		=	crypto_aes_set_key,
-			.cia_encrypt		=	aes_encrypt,
-			.cia_decrypt		=	aes_decrypt
+			.cia_encrypt		=	crypto_aes_encrypt,
+			.cia_decrypt		=	crypto_aes_decrypt
 		}
 	}
 };
diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index 7524ba3b6f3c..297fbba5d27b 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -32,6 +32,9 @@ extern const u32 crypto_fl_tab[4][256];
 extern const u32 crypto_it_tab[4][256];
 extern const u32 crypto_il_tab[4][256];
 
+void crypto_aes_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in);
+void crypto_aes_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in);
+
 int crypto_aes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
 		unsigned int key_len);
 int crypto_aes_expand_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
-- 
2.7.4
