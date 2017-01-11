From: apinski@cavium.com (Andrew Pinski)
Date: Tue, 10 Jan 2017 17:27:48 -0800
Subject: [PATCH] arm64: lib: patch in prfm for copy_template if requested
In-Reply-To: <1484098068-30433-1-git-send-email-apinski@cavium.com>
References: <1484098068-30433-1-git-send-email-apinski@cavium.com>
Message-ID: <1484098068-30433-2-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ThunderX T88 pass 1 and pass 2, there is no hardware prefetching so
we need to patch in explicit software prefetching instructions.

This speeds up copy_to_user and copy_from_user for large size.
The main use of large sizes is I/O read/writes.

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/lib/copy_template.S | 9 ++++++++-
 arch/arm64/lib/memcpy.S        | 3 +++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/lib/copy_template.S b/arch/arm64/lib/copy_template.S
index 410fbdb..ef99f686a 100644
--- a/arch/arm64/lib/copy_template.S
+++ b/arch/arm64/lib/copy_template.S
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2013 ARM Ltd.
+ * Copfrigt (C) 2013 ARM Ltd.
  * Copyright (C) 2013 Linaro.
  *
  * This code is based on glibc cortex strings work originally authored by Linaro
@@ -163,12 +163,19 @@ D_h	.req	x14
 	*/
 	.p2align	L1_CACHE_SHIFT
 .Lcpy_body_large:
+alternative_if ARM64_HAS_NO_HW_PREFETCH
+	prfm	pldl1strm, [src, #128]
+	prfm	pldl1strm, [src, #256]
+alternative_else_nop_endif
 	/* pre-get 64 bytes data. */
 	ldp1	A_l, A_h, src, #16
 	ldp1	B_l, B_h, src, #16
 	ldp1	C_l, C_h, src, #16
 	ldp1	D_l, D_h, src, #16
 1:
+alternative_if ARM64_HAS_NO_HW_PREFETCH
+	prfm	pldl1strm, [src, #384]
+alternative_else_nop_endif
 	/*
 	* interlace the load of next 64 bytes data block with store of the last
 	* loaded 64 bytes data.
diff --git a/arch/arm64/lib/memcpy.S b/arch/arm64/lib/memcpy.S
index 6761393..ee30fd5 100644
--- a/arch/arm64/lib/memcpy.S
+++ b/arch/arm64/lib/memcpy.S
@@ -25,6 +25,9 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/cache.h>
+#include <asm/alternative.h>
+#include <asm/cpufeature.h>
+
 
 /*
  * Copy a buffer from src to dest (alignment handled by the hardware)
-- 
2.7.4
