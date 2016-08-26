From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri, 26 Aug 2016 10:23:16 +0100
Subject: [PATCH v2 7/9] arm64: Introduce raw_{d,i}cache_line_size
In-Reply-To: <1472203398-8751-1-git-send-email-suzuki.poulose@arm.com>
References: <1472203398-8751-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1472203398-8751-8-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On systems with mismatched i/d cache min line sizes, we need to use
the smallest size possible across all CPUs. This will be done by fetching
the system wide safe value from CPU feature infrastructure.
However the some special users(e.g kexec, hibernate) would need the line
size on the CPU (rather than the system wide), when either the system
wide feature may not be accessible or it is guranteed that the caller
executes with a gurantee of no migration.
Provide another helper which will fetch cache line size on the current CPU.

Acked-by: James Morse <james.morse@arm.com>
Reviewed-by: Geoff Levand <geoff@infradead.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/assembler.h  | 24 ++++++++++++++++++++----
 arch/arm64/kernel/hibernate-asm.S   |  2 +-
 arch/arm64/kernel/relocate_kernel.S |  2 +-
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index d5025c6..a4bb3f5 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -218,9 +218,10 @@ lr	.req	x30		// link register
 	.endm
 
 /*
- * dcache_line_size - get the minimum D-cache line size from the CTR register.
+ * raw_dcache_line_size - get the minimum D-cache line size on this CPU
+ * from the CTR register.
  */
-	.macro	dcache_line_size, reg, tmp
+	.macro	raw_dcache_line_size, reg, tmp
 	mrs	\tmp, ctr_el0			// read CTR
 	ubfm	\tmp, \tmp, #16, #19		// cache line size encoding
 	mov	\reg, #4			// bytes per word
@@ -228,9 +229,17 @@ lr	.req	x30		// link register
 	.endm
 
 /*
- * icache_line_size - get the minimum I-cache line size from the CTR register.
+ * dcache_line_size - get the safe D-cache line size across all CPUs
  */
-	.macro	icache_line_size, reg, tmp
+	.macro	dcache_line_size, reg, tmp
+	raw_dcache_line_size	\reg, \tmp
+	.endm
+
+/*
+ * raw_icache_line_size - get the minimum I-cache line size on this CPU
+ * from the CTR register.
+ */
+	.macro	raw_icache_line_size, reg, tmp
 	mrs	\tmp, ctr_el0			// read CTR
 	and	\tmp, \tmp, #0xf		// cache line size encoding
 	mov	\reg, #4			// bytes per word
@@ -238,6 +247,13 @@ lr	.req	x30		// link register
 	.endm
 
 /*
+ * icache_line_size - get the safe I-cache line size across all CPUs
+ */
+	.macro	icache_line_size, reg, tmp
+	raw_icache_line_size	\reg, \tmp
+	.endm
+
+/*
  * tcr_set_idmap_t0sz - update TCR.T0SZ so that we can load the ID map
  */
 	.macro	tcr_set_idmap_t0sz, valreg, tmpreg
diff --git a/arch/arm64/kernel/hibernate-asm.S b/arch/arm64/kernel/hibernate-asm.S
index 46f29b6..4ebc6a1 100644
--- a/arch/arm64/kernel/hibernate-asm.S
+++ b/arch/arm64/kernel/hibernate-asm.S
@@ -96,7 +96,7 @@ ENTRY(swsusp_arch_suspend_exit)
 
 	add	x1, x10, #PAGE_SIZE
 	/* Clean the copied page to PoU - based on flush_icache_range() */
-	dcache_line_size x2, x3
+	raw_dcache_line_size x2, x3
 	sub	x3, x2, #1
 	bic	x4, x10, x3
 2:	dc	cvau, x4	/* clean D line / unified line */
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 51b73cd..ce704a4 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -34,7 +34,7 @@ ENTRY(arm64_relocate_new_kernel)
 	/* Setup the list loop variables. */
 	mov	x17, x1				/* x17 = kimage_start */
 	mov	x16, x0				/* x16 = kimage_head */
-	dcache_line_size x15, x0		/* x15 = dcache line size */
+	raw_dcache_line_size x15, x0		/* x15 = dcache line size */
 	mov	x14, xzr			/* x14 = entry ptr */
 	mov	x13, xzr			/* x13 = copy dest */
 
-- 
2.7.4
