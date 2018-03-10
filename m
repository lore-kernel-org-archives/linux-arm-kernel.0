From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 10 Mar 2018 14:59:29 +0000
Subject: [PATCH] arm64: asm: drop special versions of adr_l/ldr_l/str_l for
 modules
Message-ID: <20180310145929.6797-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we started keeping modules within 4 GB of the core kernel
in all cases, we no longer need to special case the adr_l/ldr_l/str_l
macros for modules to deal with them being loaded farther away.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/assembler.h | 34 ++------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 3c78835bba94..053d83e8db6f 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -202,25 +202,15 @@ lr	.req	x30		// link register
 
 /*
  * Pseudo-ops for PC-relative adr/ldr/str <reg>, <symbol> where
- * <symbol> is within the range +/- 4 GB of the PC when running
- * in core kernel context. In module context, a movz/movk sequence
- * is used, since modules may be loaded far away from the kernel
- * when KASLR is in effect.
+ * <symbol> is within the range +/- 4 GB of the PC.
  */
 	/*
 	 * @dst: destination register (64 bit wide)
 	 * @sym: name of the symbol
 	 */
 	.macro	adr_l, dst, sym
-#ifndef MODULE
 	adrp	\dst, \sym
 	add	\dst, \dst, :lo12:\sym
-#else
-	movz	\dst, #:abs_g3:\sym
-	movk	\dst, #:abs_g2_nc:\sym
-	movk	\dst, #:abs_g1_nc:\sym
-	movk	\dst, #:abs_g0_nc:\sym
-#endif
 	.endm
 
 	/*
@@ -231,7 +221,6 @@ lr	.req	x30		// link register
 	 *       the address
 	 */
 	.macro	ldr_l, dst, sym, tmp=
-#ifndef MODULE
 	.ifb	\tmp
 	adrp	\dst, \sym
 	ldr	\dst, [\dst, :lo12:\sym]
@@ -239,15 +228,6 @@ lr	.req	x30		// link register
 	adrp	\tmp, \sym
 	ldr	\dst, [\tmp, :lo12:\sym]
 	.endif
-#else
-	.ifb	\tmp
-	adr_l	\dst, \sym
-	ldr	\dst, [\dst]
-	.else
-	adr_l	\tmp, \sym
-	ldr	\dst, [\tmp]
-	.endif
-#endif
 	.endm
 
 	/*
@@ -257,28 +237,18 @@ lr	.req	x30		// link register
 	 *       while <src> needs to be preserved.
 	 */
 	.macro	str_l, src, sym, tmp
-#ifndef MODULE
 	adrp	\tmp, \sym
 	str	\src, [\tmp, :lo12:\sym]
-#else
-	adr_l	\tmp, \sym
-	str	\src, [\tmp]
-#endif
 	.endm
 
 	/*
-	 * @dst: Result of per_cpu(sym, smp_processor_id()), can be SP for
-	 *       non-module code
+	 * @dst: Result of per_cpu(sym, smp_processor_id()) (can be SP)
 	 * @sym: The name of the per-cpu variable
 	 * @tmp: scratch register
 	 */
 	.macro adr_this_cpu, dst, sym, tmp
-#ifndef MODULE
 	adrp	\tmp, \sym
 	add	\dst, \tmp, #:lo12:\sym
-#else
-	adr_l	\dst, \sym
-#endif
 alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
 	mrs	\tmp, tpidr_el1
 alternative_else
-- 
2.15.1
