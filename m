From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 18 Apr 2016 17:09:44 +0200
Subject: [PATCH 4/8] arm64: introduce mov_q macro to move a constant into a
 64-bit register
In-Reply-To: <1460992188-23295-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1460992188-23295-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1460992188-23295-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement a macro mov_q that can be used to move an immediate constant
into a 64-bit register, using between 2 and 4 movz/movk instructions
(depending on the operand)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/assembler.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 70f7b9e04598..9ea846ded55c 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -233,4 +233,24 @@ lr	.req	x30		// link register
 	.long	\sym\()_hi32
 	.endm
 
+	/*
+	 * mov_q - move an immediate constant into a 64-bit register using
+	 *         between 2 and 4 movz/movk instructions (depending on the
+	 *         magnitude and sign of the operand)
+	 */
+	.macro	mov_q, reg, val
+	.if (((\val) >> 31) == 0 || ((\val) >> 31) == 0x1ffffffff)
+	movz	\reg, :abs_g1_s:\val
+	.else
+	.if (((\val) >> 47) == 0 || ((\val) >> 47) == 0x1ffff)
+	movz	\reg, :abs_g2_s:\val
+	.else
+	movz	\reg, :abs_g3:\val
+	movk	\reg, :abs_g2_nc:\val
+	.endif
+	movk	\reg, :abs_g1_nc:\val
+	.endif
+	movk	\reg, :abs_g0_nc:\val
+	.endm
+
 #endif	/* __ASM_ASSEMBLER_H */
-- 
2.5.0
