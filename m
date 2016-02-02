From: will.deacon@arm.com (Will Deacon)
Date: Tue,  2 Feb 2016 12:46:26 +0000
Subject: [PATCH 4/4] arm64: lib: patch in prfm for copy_page if requested
In-Reply-To: <1454417186-21828-1-git-send-email-will.deacon@arm.com>
References: <1454417186-21828-1-git-send-email-will.deacon@arm.com>
Message-ID: <1454417186-21828-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

On ThunderX T88 pass 1 and pass 2, there is no hardware prefetching so
we need to patch in explicit software prefetching instructions

Prefetching improves this code by 60% over the original code and 2x
over the code without prefetching for the affected hardware using the
benchmark code at https://github.com/apinski-cavium/copy_page_benchmark

Signed-off-by: Andrew Pinski <apinski@cavium.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/lib/copy_page.S | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/lib/copy_page.S b/arch/arm64/lib/copy_page.S
index 2534533ceb1d..4c1e700840b6 100644
--- a/arch/arm64/lib/copy_page.S
+++ b/arch/arm64/lib/copy_page.S
@@ -18,6 +18,8 @@
 #include <linux/const.h>
 #include <asm/assembler.h>
 #include <asm/page.h>
+#include <asm/cpufeature.h>
+#include <asm/alternative.h>
 
 /*
  * Copy a page from src to dest (both are page aligned)
@@ -27,6 +29,15 @@
  *	x1 - src
  */
 ENTRY(copy_page)
+alternative_if_not ARM64_HAS_NO_HW_PREFETCH
+	nop
+	nop
+alternative_else
+	# Prefetch two cache lines ahead.
+	prfm    pldl1strm, [x1, #128]
+	prfm    pldl1strm, [x1, #256]
+alternative_endif
+
 	ldp	x2, x3, [x1]
 	ldp	x4, x5, [x1, #16]
 	ldp	x6, x7, [x1, #32]
@@ -41,6 +52,12 @@ ENTRY(copy_page)
 1:
 	subs	x18, x18, #128
 
+alternative_if_not ARM64_HAS_NO_HW_PREFETCH
+	nop
+alternative_else
+	prfm    pldl1strm, [x1, #384]
+alternative_endif
+
 	stnp	x2, x3, [x0]
 	ldp	x2, x3, [x1]
 	stnp	x4, x5, [x0, #16]
-- 
2.1.4
