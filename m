From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 10 Mar 2018 15:21:55 +0000
Subject: [PATCH v5 10/23] arm64: assembler: add utility macros to push/pop
 stack frames
In-Reply-To: <20180310152208.10369-1-ard.biesheuvel@linaro.org>
References: <20180310152208.10369-1-ard.biesheuvel@linaro.org>
Message-ID: <20180310152208.10369-11-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are going to add code to all the NEON crypto routines that will
turn them into non-leaf functions, so we need to manage the stack
frames. To make this less tedious and error prone, add some macros
that take the number of callee saved registers to preserve and the
extra size to allocate in the stack frame (for locals) and emit
the ldp/stp sequences.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/assembler.h | 70 ++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 053d83e8db6f..eef1fd2c1c0b 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -555,6 +555,19 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 #endif
 	.endm
 
+/*
+ * Errata workaround post TTBR0_EL1 update.
+ */
+	.macro	post_ttbr0_update_workaround
+#ifdef CONFIG_CAVIUM_ERRATUM_27456
+alternative_if ARM64_WORKAROUND_CAVIUM_27456
+	ic	iallu
+	dsb	nsh
+	isb
+alternative_else_nop_endif
+#endif
+	.endm
+
 /**
  * Errata workaround prior to disable MMU. Insert an ISB immediately prior
  * to executing the MSR that will change SCTLR_ELn[M] from a value of 1 to 0.
@@ -565,4 +578,61 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 #endif
 	.endm
 
+	/*
+	 * frame_push - Push @regcount callee saved registers to the stack,
+	 *              starting at x19, as well as x29/x30, and set x29 to
+	 *              the new value of sp. Add @extra bytes of stack space
+	 *              for locals.
+	 */
+	.macro		frame_push, regcount:req, extra
+	__frame		st, \regcount, \extra
+	.endm
+
+	/*
+	 * frame_pop  - Pop the callee saved registers from the stack that were
+	 *              pushed in the most recent call to frame_push, as well
+	 *              as x29/x30 and any extra stack space that may have been
+	 *              allocated.
+	 */
+	.macro		frame_pop
+	__frame		ld
+	.endm
+
+	.macro		__frame_regs, reg1, reg2, op, num
+	.if		.Lframe_regcount == \num
+	\op\()r		\reg1, [sp, #(\num + 1) * 8]
+	.elseif		.Lframe_regcount > \num
+	\op\()p		\reg1, \reg2, [sp, #(\num + 1) * 8]
+	.endif
+	.endm
+
+	.macro		__frame, op, regcount, extra=0
+	.ifc		\op, st
+	.if		(\regcount) < 0 || (\regcount) > 10
+	.error		"regcount should be in the range [0 ... 10]"
+	.endif
+	.if		((\extra) % 16) != 0
+	.error		"extra should be a multiple of 16 bytes"
+	.endif
+	.set		.Lframe_regcount, \regcount
+	.set		.Lframe_extra, \extra
+	.set		.Lframe_local_offset, ((\regcount + 3) / 2) * 16
+	stp		x29, x30, [sp, #-.Lframe_local_offset - .Lframe_extra]!
+	mov		x29, sp
+	.elseif		.Lframe_regcount == -1 // && op == 'ld'
+	.error		"frame_push/frame_pop may not be nested"
+	.endif
+
+	__frame_regs	x19, x20, \op, 1
+	__frame_regs	x21, x22, \op, 3
+	__frame_regs	x23, x24, \op, 5
+	__frame_regs	x25, x26, \op, 7
+	__frame_regs	x27, x28, \op, 9
+
+	.ifc		\op, ld
+	ldp		x29, x30, [sp], #.Lframe_local_offset + .Lframe_extra
+	.set		.Lframe_regcount, -1
+	.endif
+	.endm
+
 #endif	/* __ASM_ASSEMBLER_H */
-- 
2.15.1
