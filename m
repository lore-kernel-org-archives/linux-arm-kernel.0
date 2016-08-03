From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  3 Aug 2016 17:38:43 +0200
Subject: [PATCH 1/8] ARM: assembler: introduce adr_l, ldr_l and str_l macros
In-Reply-To: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1470238730-30038-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Like arm64, ARM supports position independent code sequences that
produce symbol references with a greater reach than the ordinary
adr/ldr instructions.

Introduce adr_l, that takes the address of a symbol in a PC relative
manner, and ldr_l/str_l that perform a 32-bit loads/stores from a
PC-relative offset.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/assembler.h | 59 ++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 4eaea2173bf8..e1450889f96b 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -512,4 +512,63 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 #endif
 	.endm
 
+/*
+ * Pseudo-ops for PC-relative adr/ldr/str <reg>, <symbol> operations
+ */
+
+	/*
+	 * @dst: destination register
+	 * @sym: name of the symbol
+	 */
+	.macro	adr_l, dst, sym
+#ifdef CONFIG_THUMB2_KERNEL
+	movw	\dst, #:lower16:(\sym) - (. + 12)
+	movt	\dst, #:upper16:(\sym) - (. + 8)
+	add	\dst, \dst, pc
+#else
+	add	\dst, pc, #:pc_g0_nc:(\sym) - 8
+	add	\dst, \dst, #:pc_g1_nc:(\sym) - 4
+	add	\dst, \dst, #:pc_g2:(\sym)
+#endif
+	.endm
+
+	/*
+	 * @dst: destination register
+	 * @sym: name of the symbol
+	 * @tmp: optional scratch register to be used if <dst> == sp, which
+	 *       is not allowed in a Thumb2 ldr instruction
+	 */
+	.macro	ldr_l, dst, sym, tmp
+#ifdef CONFIG_THUMB2_KERNEL
+	.ifnb	\tmp
+	adr_l	\tmp, \sym
+	ldr	\dst, [\tmp]
+	.else
+	adr_l	\dst, \sym
+	ldr	\dst, [\dst]
+	.endif
+#else
+	add	\dst, pc, #:pc_g0_nc:(\sym) - 8
+	add	\dst, \dst, #:pc_g1_nc:(\sym) - 4
+	ldr	\dst, [\dst, #:pc_g2:(\sym)]
+#endif
+	.endm
+
+	/*
+	 * @src: source register
+	 * @sym: name of the symbol
+	 * @tmp: mandatory scratch register to calculate the address
+	 *       while <src> needs to be preserved.
+	 */
+	.macro	str_l, src, sym, tmp:req
+#ifdef CONFIG_THUMB2_KERNEL
+	adr_l	\tmp, \sym
+	str	\src, [\tmp]
+#else
+	add	\tmp, pc, #:pc_g0_nc:(\sym) - 8
+	add	\tmp, \tmp, #:pc_g1_nc:(\sym) - 4
+	str	\src, [\tmp, #:pc_g2:(\sym)]
+#endif
+	.endm
+
 #endif /* __ASM_ASSEMBLER_H__ */
-- 
2.7.4
