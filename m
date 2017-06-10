From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 10 Jun 2017 16:22:50 +0000
Subject: [PATCH 04/12] crypto: arm64/crc32 - add non-SIMD scalar fallback
In-Reply-To: <1497111778-4210-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1497111778-4210-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1497111778-4210-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 kernel will shortly disallow nested kernel mode NEON, so
add a fallback to scalar C code that can be invoked in that case.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/crc32-ce-glue.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/crypto/crc32-ce-glue.c b/arch/arm64/crypto/crc32-ce-glue.c
index eccb1ae90064..624f4137918c 100644
--- a/arch/arm64/crypto/crc32-ce-glue.c
+++ b/arch/arm64/crypto/crc32-ce-glue.c
@@ -1,7 +1,7 @@
 /*
  * Accelerated CRC32(C) using arm64 NEON and Crypto Extensions instructions
  *
- * Copyright (C) 2016 Linaro Ltd <ard.biesheuvel@linaro.org>
+ * Copyright (C) 2016 - 2017 Linaro Ltd <ard.biesheuvel@linaro.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -19,6 +19,7 @@
 
 #include <asm/hwcap.h>
 #include <asm/neon.h>
+#include <asm/simd.h>
 #include <asm/unaligned.h>
 
 #define PMULL_MIN_LEN		64L	/* minimum size of buffer
@@ -105,10 +106,10 @@ static int crc32_pmull_update(struct shash_desc *desc, const u8 *data,
 		length -= l;
 	}
 
-	if (length >= PMULL_MIN_LEN) {
+	if (length >= PMULL_MIN_LEN && may_use_simd()) {
 		l = round_down(length, SCALE_F);
 
-		kernel_neon_begin_partial(10);
+		kernel_neon_begin();
 		*crc = crc32_pmull_le(data, l, *crc);
 		kernel_neon_end();
 
@@ -137,10 +138,10 @@ static int crc32c_pmull_update(struct shash_desc *desc, const u8 *data,
 		length -= l;
 	}
 
-	if (length >= PMULL_MIN_LEN) {
+	if (length >= PMULL_MIN_LEN && may_use_simd()) {
 		l = round_down(length, SCALE_F);
 
-		kernel_neon_begin_partial(10);
+		kernel_neon_begin();
 		*crc = crc32c_pmull_le(data, l, *crc);
 		kernel_neon_end();
 
-- 
2.7.4
