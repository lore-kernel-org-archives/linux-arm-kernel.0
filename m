From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 10 Mar 2015 16:39:38 +0100
Subject: [PATCH v4 1/5] arm64: add macros for common adrp usages
In-Reply-To: <1426001982-20047-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426001982-20047-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1426001982-20047-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The adrp instruction is mostly used in combination with either
an add, a ldr or a str instruction with the low bits of the
referenced symbol in the 12-bit immediate of the followup
instruction.

Introduce the macros adr_l, ldr_l and str_l that encapsulate
these common patterns.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/assembler.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 750bac4e637e..f1804d4803fb 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -159,4 +159,33 @@ lr	.req	x30		// link register
 	orr	\rd, \lbits, \hbits, lsl #32
 	.endm
 
+/*
+ * Pseudo-ops for PC-relative adr/ldr/str <reg>, <symbol> where
+ * <symbol> is within the range +/- 4 GB of the PC.
+ */
+	.macro	adr_l, dst, sym, tmp=
+	.ifb	\tmp
+	adrp	\dst, \sym
+	add	\dst, \dst, :lo12:\sym
+	.else
+	adrp	\tmp, \sym
+	add	\dst, \tmp, :lo12:\sym
+	.endif
+	.endm
+
+	.macro	ldr_l, dst, sym, tmp=
+	.ifb	\tmp
+	adrp	\dst, \sym
+	ldr	\dst, [\dst, :lo12:\sym]
+	.else
+	adrp	\tmp, \sym
+	ldr	\dst, [\tmp, :lo12:\sym]
+	.endif
+	.endm
+
+	.macro	str_l, src, sym, tmp
+	adrp	\tmp, \sym
+	str	\src, [\tmp, :lo12:\sym]
+	.endm
+
 #endif	/* __ASM_ASSEMBLER_H */
-- 
1.8.3.2
