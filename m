From: apinski@cavium.com (Andrew Pinski)
Date: Tue, 12 Jan 2016 23:08:16 -0800
Subject: [PATCH 2/5] ARM64 Improve copy_page for 128 byte cache line
In-Reply-To: <1452668899-3553-1-git-send-email-apinski@cavium.com>
References: <1452668899-3553-1-git-send-email-apinski@cavium.com>
Message-ID: <1452668899-3553-3-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For 128 byte cache line, doing 128 bytes unrolled in
the loop is better.
This is adapted from:
https://lkml.org/lkml/2016/1/6/497

Note this removes prefetching as it is harmful for
processors that includes hardware prefetching.
Note the next patch includes patching in software
prefetching for one target.

Signed-off-by: Andrew Pinski <apinski@cavium.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/lib/copy_page.S |   47 ++++++++++++++++++++++++++++++++++++-------
 1 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/lib/copy_page.S b/arch/arm64/lib/copy_page.S
index 512b9a7..dfb0316 100644
--- a/arch/arm64/lib/copy_page.S
+++ b/arch/arm64/lib/copy_page.S
@@ -19,6 +19,7 @@
 #include <asm/assembler.h>
 #include <asm/page.h>
 
+
 /*
  * Copy a page from src to dest (both are page aligned)
  *
@@ -27,20 +28,50 @@
  *	x1 - src
  */
 ENTRY(copy_page)
-	/* Assume cache line size is 64 bytes. */
-	prfm	pldl1strm, [x1, #64]
-1:	ldp	x2, x3, [x1]
+	ldp	x2, x3, [x1]
+	ldp	x4, x5, [x1, #16]
+	ldp	x6, x7, [x1, #32]
+	ldp	x8, x9, [x1, #48]
+	ldp	x10, x11, [x1, #64]
+	ldp	x12, x13, [x1, #80]
+	ldp	x14, x15, [x1, #96]
+	ldp	x16, x17, [x1, #112]
+
+	mov	x18, #(PAGE_SIZE - 128)
+	add	x1, x1, #128
+1:
+	subs	x18, x18, #128
+
+	stnp	x2, x3, [x0]
+	ldp	x2, x3, [x1]
+	stnp	x4, x5, [x0, #16]
 	ldp	x4, x5, [x1, #16]
+	stnp	x6, x7, [x0, #32]
 	ldp	x6, x7, [x1, #32]
+	stnp	x8, x9, [x0, #48]
 	ldp	x8, x9, [x1, #48]
-	add	x1, x1, #64
-	prfm	pldl1strm, [x1, #64]
+	stnp	x10, x11, [x0, #64]
+	ldp	x10, x11, [x1, #64]
+	stnp	x12, x13, [x0, #80]
+	ldp	x12, x13, [x1, #80]
+	stnp	x14, x15, [x0, #96]
+	ldp	x14, x15, [x1, #96]
+	stnp	x16, x17, [x0, #112]
+	ldp	x16, x17, [x1, #112]
+
+	add	x0, x0, #128
+	add	x1, x1, #128
+
+	b.gt	1b
+
 	stnp	x2, x3, [x0]
 	stnp	x4, x5, [x0, #16]
 	stnp	x6, x7, [x0, #32]
 	stnp	x8, x9, [x0, #48]
-	add	x0, x0, #64
-	tst	x1, #(PAGE_SIZE - 1)
-	b.ne	1b
+	stnp	x10, x11, [x0, #64]
+	stnp	x12, x13, [x0, #80]
+	stnp	x14, x15, [x0, #96]
+	stnp	x16, x17, [x0, #112]
+
 	ret
 ENDPROC(copy_page)
-- 
1.7.2.5
