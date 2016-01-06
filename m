From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  6 Jan 2016 11:05:26 +0000
Subject: [PATCH 1/2] arm64: add macro to handle large immediates
Message-ID: <1452078327-9635-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometimes we want to be able to load values greater than 0xff into a
register, without placing said values in a literal pool. Arranging for
the value to be split up across a number of movz and movk instructions
is tedious and error-prone.

Following the example of {adr,str,ldr}_l, this patch adds a new mov_l
macro which can be used to load immediate values of up to 64 bits into a
register.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/assembler.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 12eff92..64fd0a2 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -193,6 +193,19 @@ lr	.req	x30		// link register
 	str	\src, [\tmp, :lo12:\sym]
 	.endm
 
+	/*
+	 * Move a large immediate up to 64-bits.
+	 *
+	 * @dst: destination register (64 bit wide)
+	 * @val: value
+	 */
+	.macro	mov_l, dst, val
+	movz	\dst, :abs_g0_nc:\val
+	movk	\dst, :abs_g1_nc:\val
+	movk	\dst, :abs_g2_nc:\val
+	movk	\dst, :abs_g3:\val
+	.endm
+
 /*
  * Annotate a function as position independent, i.e., safe to be called before
  * the kernel virtual mapping is activated.
-- 
1.9.1
