From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun,  8 May 2011 13:51:21 +0100
Subject: [PATCH v5 02/19] ARM: LPAE: add ISBs around MMU enabling code
In-Reply-To: <1304859098-10760-1-git-send-email-catalin.marinas@arm.com>
References: <1304859098-10760-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1304859098-10760-3-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

Before we enable the MMU, we must ensure that the TTBR registers contain
sane values. After the MMU has been enabled, we jump to the *virtual*
address of the following function, so we also need to ensure that the
SCTLR write has taken effect.

This patch adds ISB instructions around the SCTLR write to ensure the
visibility of the above.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/assembler.h |   11 +++++++++++
 arch/arm/kernel/head.S           |    2 ++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index bc2d2d7..2bcc456 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -184,6 +184,17 @@
 #endif
 
 /*
+ * Instruction barrier
+ */
+	.macro	instr_sync
+#if __LINUX_ARM_ARCH__ >= 7
+	isb
+#elif __LINUX_ARM_ARCH__ == 6
+	mcr	p15, 0, r0, c7, c5, 4
+#endif
+	.endm
+
+/*
  * SMP data memory barrier
  */
 	.macro	smp_dmb mode
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index c9173cf..ea8fae7 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -385,8 +385,10 @@ ENDPROC(__enable_mmu)
 	.align	5
 __turn_mmu_on:
 	mov	r0, r0
+	instr_sync
 	mcr	p15, 0, r0, c1, c0, 0		@ write control reg
 	mrc	p15, 0, r3, c0, c0, 0		@ read id reg
+	instr_sync
 	mov	r3, r3
 	mov	r3, r13
 	mov	pc, r3
