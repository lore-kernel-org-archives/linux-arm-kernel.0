From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 28 Mar 2018 14:41:28 +0200
Subject: [PATCH resend 1/2] arm64: assembler: add utility macros to push/pop
 stack frames
In-Reply-To: <20180328124129.6459-1-ard.biesheuvel@linaro.org>
References: <20180328124129.6459-1-ard.biesheuvel@linaro.org>
Message-ID: <20180328124129.6459-2-ard.biesheuvel@linaro.org>
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
 arch/arm64/include/asm/assembler.h | 58 ++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 053d83e8db6f..d354eb7f2f0c 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -565,4 +565,62 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
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
+	.endif
+
+	__frame_regs	x19, x20, \op, 1
+	__frame_regs	x21, x22, \op, 3
+	__frame_regs	x23, x24, \op, 5
+	__frame_regs	x25, x26, \op, 7
+	__frame_regs	x27, x28, \op, 9
+
+	.ifc		\op, ld
+	.if		.Lframe_regcount == -1
+	.error		"frame_push/frame_pop may not be nested"
+	.endif
+	ldp		x29, x30, [sp], #.Lframe_local_offset + .Lframe_extra
+	.set		.Lframe_regcount, -1
+	.endif
+	.endm
+
 #endif	/* __ASM_ASSEMBLER_H */
-- 
2.11.0
