From: apinski@cavium.com (Andrew Pinski)
Date: Tue, 12 Jan 2016 23:08:18 -0800
Subject: [PATCH 4/5] ARM64: Patch in prefetching for copy_page is requested
In-Reply-To: <1452668899-3553-1-git-send-email-apinski@cavium.com>
References: <1452668899-3553-1-git-send-email-apinski@cavium.com>
Message-ID: <1452668899-3553-5-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ThunderX T88 pass 1 and pass 2, there is no
hardware prefetching so we need to patch in
software prefetching.  Prefetching improves this code
by 60% over the original code and 2x over the code
without prefetching.

Meaured by using the benchmark code at
https://github.com/apinski-cavium/copy_page_benchmark

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/lib/copy_page.S |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/lib/copy_page.S b/arch/arm64/lib/copy_page.S
index dfb0316..876e882 100644
--- a/arch/arm64/lib/copy_page.S
+++ b/arch/arm64/lib/copy_page.S
@@ -18,6 +18,8 @@
 #include <linux/const.h>
 #include <asm/assembler.h>
 #include <asm/page.h>
+#include <asm/cpufeature.h>
+#include <asm/alternative.h>
 
 
 /*
@@ -28,6 +30,15 @@
  *	x1 - src
  */
 ENTRY(copy_page)
+alternative_if_not ARM64_NEEDS_PREFETCH_128
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
@@ -42,6 +53,12 @@ ENTRY(copy_page)
 1:
 	subs	x18, x18, #128
 
+alternative_if_not ARM64_NEEDS_PREFETCH_128
+	nop
+alternative_else
+	prfm    pldl1strm, [x1, #384]
+alternative_endif
+
 	stnp	x2, x3, [x0]
 	ldp	x2, x3, [x1]
 	stnp	x4, x5, [x0, #16]
-- 
1.7.2.5
