From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 10 Jun 2017 16:22:51 +0000
Subject: [PATCH 05/12] crypto: arm64/sha1-ce - add non-SIMD generic fallback
In-Reply-To: <1497111778-4210-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1497111778-4210-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1497111778-4210-6-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 kernel will shortly disallow nested kernel mode NEON, so
add a fallback to scalar C code that can be invoked in that case.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/Kconfig        |  3 ++-
 arch/arm64/crypto/sha1-ce-glue.c | 18 ++++++++++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 7d75a363e317..5d5953545dad 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -18,8 +18,9 @@ config CRYPTO_SHA512_ARM64
 
 config CRYPTO_SHA1_ARM64_CE
 	tristate "SHA-1 digest algorithm (ARMv8 Crypto Extensions)"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
+	select CRYPTO_SHA1
 
 config CRYPTO_SHA2_ARM64_CE
 	tristate "SHA-224/SHA-256 digest algorithm (ARMv8 Crypto Extensions)"
diff --git a/arch/arm64/crypto/sha1-ce-glue.c b/arch/arm64/crypto/sha1-ce-glue.c
index aefda9868627..058cbe299dd6 100644
--- a/arch/arm64/crypto/sha1-ce-glue.c
+++ b/arch/arm64/crypto/sha1-ce-glue.c
@@ -1,7 +1,7 @@
 /*
  * sha1-ce-glue.c - SHA-1 secure hash using ARMv8 Crypto Extensions
  *
- * Copyright (C) 2014 Linaro Ltd <ard.biesheuvel@linaro.org>
+ * Copyright (C) 2014 - 2017 Linaro Ltd <ard.biesheuvel@linaro.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -9,6 +9,7 @@
  */
 
 #include <asm/neon.h>
+#include <asm/simd.h>
 #include <asm/unaligned.h>
 #include <crypto/internal/hash.h>
 #include <crypto/sha.h>
@@ -37,8 +38,11 @@ static int sha1_ce_update(struct shash_desc *desc, const u8 *data,
 {
 	struct sha1_ce_state *sctx = shash_desc_ctx(desc);
 
+	if (!may_use_simd())
+		return crypto_sha1_update(desc, data, len);
+
 	sctx->finalize = 0;
-	kernel_neon_begin_partial(16);
+	kernel_neon_begin();
 	sha1_base_do_update(desc, data, len,
 			    (sha1_block_fn *)sha1_ce_transform);
 	kernel_neon_end();
@@ -57,13 +61,16 @@ static int sha1_ce_finup(struct shash_desc *desc, const u8 *data,
 	ASM_EXPORT(sha1_ce_offsetof_finalize,
 		   offsetof(struct sha1_ce_state, finalize));
 
+	if (!may_use_simd())
+		return crypto_sha1_finup(desc, data, len, out);
+
 	/*
 	 * Allow the asm code to perform the finalization if there is no
 	 * partial data and the input is a round multiple of the block size.
 	 */
 	sctx->finalize = finalize;
 
-	kernel_neon_begin_partial(16);
+	kernel_neon_begin();
 	sha1_base_do_update(desc, data, len,
 			    (sha1_block_fn *)sha1_ce_transform);
 	if (!finalize)
@@ -76,8 +83,11 @@ static int sha1_ce_final(struct shash_desc *desc, u8 *out)
 {
 	struct sha1_ce_state *sctx = shash_desc_ctx(desc);
 
+	if (!may_use_simd())
+		return crypto_sha1_finup(desc, NULL, 0, out);
+
 	sctx->finalize = 0;
-	kernel_neon_begin_partial(16);
+	kernel_neon_begin();
 	sha1_base_do_finalize(desc, (sha1_block_fn *)sha1_ce_transform);
 	kernel_neon_end();
 	return sha1_base_finish(desc, out);
-- 
2.7.4
