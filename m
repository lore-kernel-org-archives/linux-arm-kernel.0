From: apinski@cavium.com (Andrew Pinski)
Date: Sat, 19 Dec 2015 16:11:18 -0800
Subject: [PATCH] ARM64: Improve copy_page for 128 cache line sizes.
Message-ID: <1450570278-19404-1-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding a check for the cache line size is not much overhead.
Special case 128 byte cache line size.
This improves copy_page by 85% on ThunderX compared to the
original implementation.

For LMBench, it improves between 4-10%.

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/lib/copy_page.S |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/lib/copy_page.S b/arch/arm64/lib/copy_page.S
index 512b9a7..4c28789 100644
--- a/arch/arm64/lib/copy_page.S
+++ b/arch/arm64/lib/copy_page.S
@@ -18,6 +18,7 @@
 #include <linux/const.h>
 #include <asm/assembler.h>
 #include <asm/page.h>
+#include <asm/cachetype.h>
 
 /*
  * Copy a page from src to dest (both are page aligned)
@@ -27,8 +28,17 @@
  *	x1 - src
  */
 ENTRY(copy_page)
+	/* Special case 128 byte or more cache lines */
+	mrs	x2, ctr_el0
+	lsr	x2, x2, CTR_CWG_SHIFT
+	and	w2, w2, CTR_CWG_MASK
+	cmp	w2, 5
+	b.ge    2f
+
 	/* Assume cache line size is 64 bytes. */
 	prfm	pldl1strm, [x1, #64]
+	/* Align the loop is it fits in one cache line. */
+	.balign 64
 1:	ldp	x2, x3, [x1]
 	ldp	x4, x5, [x1, #16]
 	ldp	x6, x7, [x1, #32]
@@ -43,4 +53,33 @@ ENTRY(copy_page)
 	tst	x1, #(PAGE_SIZE - 1)
 	b.ne	1b
 	ret
+
+2:
+	/* The cache line size is at least 128 bytes. */
+	prfm	pldl1strm, [x1, #128]
+	/* Align the loop so it fits in one cache line  */
+	.balign 128
+1:	prfm	pldl1strm, [x1, #256]
+	ldp	x2, x3, [x1]
+	ldp	x4, x5, [x1, #16]
+	ldp	x6, x7, [x1, #32]
+	ldp	x8, x9, [x1, #48]
+	stnp	x2, x3, [x0]
+	stnp	x4, x5, [x0, #16]
+	stnp	x6, x7, [x0, #32]
+	stnp	x8, x9, [x0, #48]
+
+	ldp	x2, x3, [x1, #64]
+	ldp	x4, x5, [x1, #80]
+	ldp	x6, x7, [x1, #96]
+	ldp	x8, x9, [x1, #112]
+	add	x1, x1, #128
+	stnp	x2, x3, [x0, #64]
+	stnp	x4, x5, [x0, #80]
+	stnp	x6, x7, [x0, #96]
+	stnp	x8, x9, [x0, #112]
+	add	x0, x0, #128
+	tst	x1, #(PAGE_SIZE - 1)
+	b.ne	1b
+	ret
 ENDPROC(copy_page)
-- 
1.7.2.5
