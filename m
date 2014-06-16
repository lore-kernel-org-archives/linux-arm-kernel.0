From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Jun 2014 12:02:15 +0200
Subject: [PATCH 1/2] arm64/crypto: fix data corruption bug in GHASH algorithm
Message-ID: <1402912936-9137-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a bug in the GHASH algorithm resulting in the calculated hash to be
incorrect if the input is presented in chunks whose size is not a multiple of
16 bytes.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Fixes: fdd2389457b2 ("arm64/crypto: GHASH secure hash using ARMv8 Crypto Extensions")
---
 arch/arm64/crypto/ghash-ce-glue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/crypto/ghash-ce-glue.c b/arch/arm64/crypto/ghash-ce-glue.c
index b92baf3f68c7..ef6aa69c4e0c 100644
--- a/arch/arm64/crypto/ghash-ce-glue.c
+++ b/arch/arm64/crypto/ghash-ce-glue.c
@@ -72,6 +72,7 @@ static int ghash_update(struct shash_desc *desc, const u8 *src,
 				   partial ? ctx->buf : NULL);
 		kernel_neon_end();
 		src += blocks * GHASH_BLOCK_SIZE;
+		partial = 0;
 	}
 	if (len)
 		memcpy(ctx->buf + partial, src, len);
-- 
1.8.3.2
