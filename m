From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 14 May 2018 12:01:03 +0100
Subject: [PATCH 1/2][stable-4.4] arm64: introduce mov_q macro to move a
 constant into a 64-bit register
Message-ID: <1526295664-22187-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 30b5ba5cf333cc650e474eaf2cc1ae91bc7cf89f upstream

Implement a macro mov_q that can be used to move an immediate constant
into a 64-bit register, using between 2 and 4 movz/movk instructions
(depending on the operand)

Cc: stable at vger.kernel.org # v4.4
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
  Cherry picked for backport of
  "commit ece1397cbc89c51914fae1aec729539cfd8bd62b upstream"
---
 arch/arm64/include/asm/assembler.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 12eff92..83e2309 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -204,4 +204,24 @@ lr	.req	x30		// link register
 	.size	__pi_##x, . - x;	\
 	ENDPROC(x)
 
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
2.7.4
