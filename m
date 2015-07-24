From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Jul 2015 11:42:01 +0100
Subject: [PATCH v2 10/20] arm64: bitops: patch in lse instructions when
 supported by the CPU
In-Reply-To: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
Message-ID: <1437734531-10698-11-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On CPUs which support the LSE atomic instructions introduced in ARMv8.1,
it makes sense to use them in preference to ll/sc sequences.

This patch introduces runtime patching of our bitops functions so that
LSE atomic instructions are used instead.

Reviewed-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/lse.h | 23 +++++++++++++++++++++--
 arch/arm64/lib/bitops.S      | 43 ++++++++++++++++++++++++-------------------
 2 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
index d516624a461e..fb3ac56a2cc0 100644
--- a/arch/arm64/include/asm/lse.h
+++ b/arch/arm64/include/asm/lse.h
@@ -4,10 +4,19 @@
 #if defined(CONFIG_AS_LSE) && defined(CONFIG_ARM64_LSE_ATOMICS)
 
 #include <linux/stringify.h>
-
 #include <asm/alternative.h>
 #include <asm/cpufeature.h>
 
+#ifdef __ASSEMBLER__
+
+.arch_extension	lse
+
+.macro alt_lse, llsc, lse
+	alternative_insn "\llsc", "\lse", ARM64_CPU_FEAT_LSE_ATOMICS
+.endm
+
+#else	/* __ASSEMBLER__ */
+
 __asm__(".arch_extension	lse");
 
 /* Move the ll/sc atomics out-of-line */
@@ -22,7 +31,16 @@ __asm__(".arch_extension	lse");
 #define ARM64_LSE_ATOMIC_INSN(llsc, lse)				\
 	ALTERNATIVE(llsc, lse, ARM64_CPU_FEAT_LSE_ATOMICS)
 
-#else
+#endif	/* __ASSEMBLER__ */
+#else	/* CONFIG_AS_LSE && CONFIG_ARM64_LSE_ATOMICS */
+
+#ifdef __ASSEMBLER__
+
+.macro alt_lse, llsc, lse
+	\llsc
+.endm
+
+#else	/* __ASSEMBLER__ */
 
 #define __LL_SC_INLINE		static inline
 #define __LL_SC_PREFIX(x)	x
@@ -30,5 +48,6 @@ __asm__(".arch_extension	lse");
 
 #define ARM64_LSE_ATOMIC_INSN(llsc, lse)	llsc
 
+#endif	/* __ASSEMBLER__ */
 #endif	/* CONFIG_AS_LSE && CONFIG_ARM64_LSE_ATOMICS */
 #endif	/* __ASM_LSE_H */
diff --git a/arch/arm64/lib/bitops.S b/arch/arm64/lib/bitops.S
index 7dac371cc9a2..bc18457c2bba 100644
--- a/arch/arm64/lib/bitops.S
+++ b/arch/arm64/lib/bitops.S
@@ -18,52 +18,57 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/lse.h>
 
 /*
  * x0: bits 5:0  bit offset
  *     bits 31:6 word offset
  * x1: address
  */
-	.macro	bitop, name, instr
+	.macro	bitop, name, llsc, lse
 ENTRY(	\name	)
 	and	w3, w0, #63		// Get bit offset
 	eor	w0, w0, w3		// Clear low bits
 	mov	x2, #1
 	add	x1, x1, x0, lsr #3	// Get word offset
 	lsl	x3, x2, x3		// Create mask
-1:	ldxr	x2, [x1]
-	\instr	x2, x2, x3
-	stxr	w0, x2, [x1]
-	cbnz	w0, 1b
+
+alt_lse	"1:	ldxr	x2, [x1]",		"\lse	x3, [x1]"
+alt_lse	"	\llsc	x2, x2, x3",		"nop"
+alt_lse	"	stxr	w0, x2, [x1]",		"nop"
+alt_lse	"	cbnz	w0, 1b",		"nop"
+
 	ret
 ENDPROC(\name	)
 	.endm
 
-	.macro	testop, name, instr
+	.macro	testop, name, llsc, lse
 ENTRY(	\name	)
 	and	w3, w0, #63		// Get bit offset
 	eor	w0, w0, w3		// Clear low bits
 	mov	x2, #1
 	add	x1, x1, x0, lsr #3	// Get word offset
 	lsl	x4, x2, x3		// Create mask
-1:	ldxr	x2, [x1]
-	lsr	x0, x2, x3		// Save old value of bit
-	\instr	x2, x2, x4		// toggle bit
-	stlxr	w5, x2, [x1]
-	cbnz	w5, 1b
-	dmb	ish
+
+alt_lse	"1:	ldxr	x2, [x1]",		"\lse	x4, x2, [x1]"
+	lsr	x0, x2, x3
+alt_lse	"	\llsc	x2, x2, x4",		"nop"
+alt_lse	"	stlxr	w5, x2, [x1]",		"nop"
+alt_lse	"	cbnz	w5, 1b",		"nop"
+alt_lse	"	dmb	ish",			"nop"
+
 	and	x0, x0, #1
-3:	ret
+	ret
 ENDPROC(\name	)
 	.endm
 
 /*
  * Atomic bit operations.
  */
-	bitop	change_bit, eor
-	bitop	clear_bit, bic
-	bitop	set_bit, orr
+	bitop	change_bit, eor, steor
+	bitop	clear_bit, bic, stclr
+	bitop	set_bit, orr, stset
 
-	testop	test_and_change_bit, eor
-	testop	test_and_clear_bit, bic
-	testop	test_and_set_bit, orr
+	testop	test_and_change_bit, eor, ldeoral
+	testop	test_and_clear_bit, bic, ldclral
+	testop	test_and_set_bit, orr, ldsetal
-- 
2.1.4
