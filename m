From: apinski@cavium.com (Andrew Pinski)
Date: Tue, 12 Jan 2016 23:08:19 -0800
Subject: [PATCH 5/5] ARM64: Patch in prefetching in copy_template
In-Reply-To: <1452668899-3553-1-git-send-email-apinski@cavium.com>
References: <1452668899-3553-1-git-send-email-apinski@cavium.com>
Message-ID: <1452668899-3553-6-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For ThunderX T88 pass 1.x and 2.x where there is
no hardware prefetcher, we want to patch in
software prefetching instructions in the copy_template.
This speeds up copy_to_user and copy_from_user for large
size.  The main use of large sizes is I/O read/writes.

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/lib/copy_template.S |   12 ++++++++++++
 arch/arm64/lib/memcpy.S        |    2 ++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/lib/copy_template.S b/arch/arm64/lib/copy_template.S
index 410fbdb..3f3f0a4 100644
--- a/arch/arm64/lib/copy_template.S
+++ b/arch/arm64/lib/copy_template.S
@@ -163,12 +163,24 @@ D_h	.req	x14
 	*/
 	.p2align	L1_CACHE_SHIFT
 .Lcpy_body_large:
+alternative_if_not ARM64_NEEDS_PREFETCH_128
+	nop
+	nop
+alternative_else
+	prfm	pldl1strm, [src, #128]
+	prfm	pldl1strm, [src, #256]
+alternative_endif
 	/* pre-get 64 bytes data. */
 	ldp1	A_l, A_h, src, #16
 	ldp1	B_l, B_h, src, #16
 	ldp1	C_l, C_h, src, #16
 	ldp1	D_l, D_h, src, #16
 1:
+alternative_if_not ARM64_NEEDS_PREFETCH_128
+	nop
+alternative_else
+	prfm	pldl1strm, [src, #384]
+alternative_endif
 	/*
 	* interlace the load of next 64 bytes data block with store of the last
 	* loaded 64 bytes data.
diff --git a/arch/arm64/lib/memcpy.S b/arch/arm64/lib/memcpy.S
index 6761393..3a50cf8b 100644
--- a/arch/arm64/lib/memcpy.S
+++ b/arch/arm64/lib/memcpy.S
@@ -25,6 +25,8 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/cache.h>
+#include <asm/alternative.h>
+#include <asm/cpufeature.h>
 
 /*
  * Copy a buffer from src to dest (alignment handled by the hardware)
-- 
1.7.2.5
