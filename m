From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 11 Jan 2017 14:54:53 +0000
Subject: [PATCH] arm64: assembler: make adr_l work in modules under KASLR
Message-ID: <1484146493-18460-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_RANDOMIZE_MODULE_REGION_FULL=y, the offset between loaded
modules and the core kernel may exceed 4 GB, putting symbols exported
by the core kernel out of the reach of the ordinary adrp/add instruction
pairs used to generate relative symbol references. So make the adr_l
macro emit a movz/movk sequence instead when executing in module context.

While at it, remove the pointless special case for the stack pointer.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/assembler.h | 36 +++++++++++++++-----
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 446f6c46d4b1..3a4301163e04 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -164,22 +164,25 @@ lr	.req	x30		// link register
 
 /*
  * Pseudo-ops for PC-relative adr/ldr/str <reg>, <symbol> where
- * <symbol> is within the range +/- 4 GB of the PC.
+ * <symbol> is within the range +/- 4 GB of the PC when running
+ * in core kernel context. In module context, a movz/movk sequence
+ * is used, since modules may be loaded far away from the kernel
+ * when KASLR is in effect.
  */
 	/*
 	 * @dst: destination register (64 bit wide)
 	 * @sym: name of the symbol
-	 * @tmp: optional scratch register to be used if <dst> == sp, which
-	 *       is not allowed in an adrp instruction
 	 */
-	.macro	adr_l, dst, sym, tmp=
-	.ifb	\tmp
+	.macro	adr_l, dst, sym
+#ifndef MODULE
 	adrp	\dst, \sym
 	add	\dst, \dst, :lo12:\sym
-	.else
-	adrp	\tmp, \sym
-	add	\dst, \tmp, :lo12:\sym
-	.endif
+#else
+	movz	\dst, #:abs_g3:\sym
+	movk	\dst, #:abs_g2_nc:\sym
+	movk	\dst, #:abs_g1_nc:\sym
+	movk	\dst, #:abs_g0_nc:\sym
+#endif
 	.endm
 
 	/*
@@ -190,6 +193,7 @@ lr	.req	x30		// link register
 	 *       the address
 	 */
 	.macro	ldr_l, dst, sym, tmp=
+#ifndef MODULE
 	.ifb	\tmp
 	adrp	\dst, \sym
 	ldr	\dst, [\dst, :lo12:\sym]
@@ -197,6 +201,15 @@ lr	.req	x30		// link register
 	adrp	\tmp, \sym
 	ldr	\dst, [\tmp, :lo12:\sym]
 	.endif
+#else
+	.ifb	\tmp
+	adr_l	\dst, \sym
+	ldr	\dst, [\dst]
+	.else
+	adr_l	\tmp, \sym
+	ldr	\dst, [\tmp]
+	.endif
+#endif
 	.endm
 
 	/*
@@ -206,8 +219,13 @@ lr	.req	x30		// link register
 	 *       while <src> needs to be preserved.
 	 */
 	.macro	str_l, src, sym, tmp
+#ifndef MODULE
 	adrp	\tmp, \sym
 	str	\src, [\tmp, :lo12:\sym]
+#else
+	adr_l	\tmp, \sym
+	str	\src, [\tmp]
+#endif
 	.endm
 
 	/*
-- 
2.7.4
