From: linyongting@gmail.com (Lin Yongting)
Date: Thu, 20 Nov 2014 01:06:05 +0800
Subject: [PATCH] ARM: Add unwinding support for __memzero function
Message-ID: <1416416765-10217-1-git-send-email-linyongting@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __memzero function never had unwinding annotations added.
Currently, when accessing invalid pointer by __memzero occurs the
backtrace shown will stop at __memzero or some completely unrelated
function. Add unwinding annotations in hopes of getting a more
useful backtrace in following cases:
1. die on accessing invalid pointer by __memzero
2. kprobe trapped at any instruction within __memzero
3. interrupted at any instruction within __memzero

Signed-off-by: Lin Yongting <linyongting@gmail.com>
---
 arch/arm/lib/memzero.S |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/lib/memzero.S b/arch/arm/lib/memzero.S
index 385ccb3..0eded95 100644
--- a/arch/arm/lib/memzero.S
+++ b/arch/arm/lib/memzero.S
@@ -9,6 +9,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/unwind.h>
 
 	.text
 	.align	5
@@ -18,6 +19,7 @@
  * mis-aligned by, and r1 is the number of bytes.  If r1 < 4, then we
  * don't bother; we use byte stores instead.
  */
+UNWIND(	.fnstart			)
 1:	subs	r1, r1, #4		@ 1 do we have enough
 	blt	5f			@ 1 bytes to align with?
 	cmp	r3, #2			@ 1
@@ -47,6 +49,9 @@ ENTRY(__memzero)
  * use the LR
  */
 	str	lr, [sp, #-4]!		@ 1
+UNWIND(	.fnend				)
+UNWIND(	.fnstart			)
+UNWIND(	.save 	{lr}			)
 	mov	ip, r2			@ 1
 	mov	lr, r2			@ 1
 
@@ -66,6 +71,7 @@ ENTRY(__memzero)
 	tst	r1, #16			@ 1 16 bytes or more?
 	stmneia	r0!, {r2, r3, ip, lr}	@ 4
 	ldr	lr, [sp], #4		@ 1
+UNWIND(	.fnend				)
 
 #else
 
@@ -75,6 +81,9 @@ ENTRY(__memzero)
  */
 
 	stmfd	sp!, {r4-r7, lr}
+UNWIND(	.fnend		       )
+UNWIND(	.fnstart	       )
+UNWIND(	.save 	{r4-r7, lr}    )
 	mov	r4, r2
 	mov	r5, r2
 	mov	r6, r2
@@ -105,9 +114,11 @@ ENTRY(__memzero)
 	tst	r1, #16
 	stmneia	r0!, {r4-r7}
 	ldmfd	sp!, {r4-r7, lr}
+UNWIND(	.fnend		       )
 
 #endif
 
+UNWIND(	.fnstart			)
 4:	tst	r1, #8			@ 1 8 bytes or more?
 	stmneia	r0!, {r2, r3}		@ 2
 	tst	r1, #4			@ 1 4 bytes or more?
@@ -122,4 +133,5 @@ ENTRY(__memzero)
 	tst	r1, #1			@ 1 a byte left over
 	strneb	r2, [r0], #1		@ 1
 	ret	lr			@ 1
+UNWIND(	.fnend				)
 ENDPROC(__memzero)
-- 
1.7.9.5
