From: alex.shi@linaro.org (Alex Shi)
Date: Thu,  1 Mar 2018 20:53:44 +0800
Subject: [PATCH 07/45] arm64: Factor out TTBR0_EL1 post-update workaround into
 a specific asm macro
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519908862-11425-8-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Catalin Marinas <catalin.marinas@arm.com>

commit f33bcf03e6 upstream

This patch takes the errata workaround code out of cpu_do_switch_mm into
a dedicated post_ttbr0_update_workaround macro which will be reused in a
subsequent patch.

Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/assembler.h | 13 +++++++++++++
 arch/arm64/mm/proc.S               |  6 +-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 8760300..ab3a179 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -420,4 +420,17 @@ alternative_endif
 	movk	\reg, :abs_g0_nc:\val
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
 #endif	/* __ASM_ASSEMBLER_H */
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 352c73b..c2adb0c 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -136,11 +136,7 @@ ENTRY(cpu_do_switch_mm)
 	bfi	x0, x1, #48, #16		// set the ASID
 	msr	ttbr0_el1, x0			// set TTBR0
 	isb
-alternative_if ARM64_WORKAROUND_CAVIUM_27456
-	ic	iallu
-	dsb	nsh
-	isb
-alternative_else_nop_endif
+	post_ttbr0_update_workaround
 	ret
 ENDPROC(cpu_do_switch_mm)
 
-- 
2.7.4
