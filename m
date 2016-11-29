From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 29 Nov 2016 13:05:30 +0000
Subject: [PATCH 1/4] crypto: arm/aes-ce: fix broken monolithic build
Message-ID: <1480424733-10797-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building the arm64 kernel with both CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
and CONFIG_CRYPTO_AES_ARM64_NEON_BLK=y configured, the build breaks with
the following error:

arch/arm64/crypto/aes-neon-blk.o:(.bss+0x0): multiple definition of `aes_simd_algs'
arch/arm64/crypto/aes-ce-blk.o:(.bss+0x0): first defined here

Fix this by making aes_simd_algs 'static'.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/aes-glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
index 24f6137c1a6e..5c43b92b3714 100644
--- a/arch/arm64/crypto/aes-glue.c
+++ b/arch/arm64/crypto/aes-glue.c
@@ -343,7 +343,7 @@ static struct skcipher_alg aes_algs[] = { {
 	.decrypt	= xts_decrypt,
 } };
 
-struct simd_skcipher_alg *aes_simd_algs[ARRAY_SIZE(aes_algs)];
+static struct simd_skcipher_alg *aes_simd_algs[ARRAY_SIZE(aes_algs)];
 
 static void aes_exit(void)
 {
-- 
2.7.4
