From: alex.shi@linaro.org (Alex Shi)
Date: Wed, 28 Feb 2018 11:56:36 +0800
Subject: [PATCH 14/29] arm64: entry: Add fake CPU feature for unmapping the
 kernel at EL0
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519790211-16582-15-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

commit ea1e3de85e94 upstream.

Allow explicit disabling of the entry trampoline on the kernel command
line (kpti=off) by adding a fake CPU feature (ARM64_UNMAP_KERNEL_AT_EL0)
that can be used to toggle the alternative sequences in our entry code and
avoid use of the trampoline altogether if desired. This also allows us to
make use of a static key in arm64_kernel_unmapped_at_el0().

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	skip non enabled cpu features in
	arch/arm64/include/asm/cpucaps.h and
	arch/arm64/kernel/cpufeature.c
	using cpus_have_cap instead of cpus_have_const_cap in
	arch/arm64/include/asm/mmu.h
---
 arch/arm64/include/asm/cpucaps.h |  3 ++-
 arch/arm64/include/asm/mmu.h     |  3 ++-
 arch/arm64/kernel/cpufeature.c   | 41 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/entry.S        |  9 +++++----
 4 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 87b4465..7ddf233 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -34,7 +34,8 @@
 #define ARM64_HAS_32BIT_EL0			13
 #define ARM64_HYP_OFFSET_LOW			14
 #define ARM64_MISMATCHED_CACHE_LINE_SIZE	15
+#define ARM64_UNMAP_KERNEL_AT_EL0		16
 
-#define ARM64_NCAPS				16
+#define ARM64_NCAPS				17
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 279e75b..a813edf 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -34,7 +34,8 @@ typedef struct {
 
 static inline bool arm64_kernel_unmapped_at_el0(void)
 {
-	return IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0);
+	return IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0) &&
+	       cpus_have_cap(ARM64_UNMAP_KERNEL_AT_EL0);
 }
 
 extern void paging_init(void);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 3a129d4..74b168c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -746,6 +746,40 @@ static bool hyp_offset_low(const struct arm64_cpu_capabilities *entry,
 	return idmap_addr > GENMASK(VA_BITS - 2, 0) && !is_kernel_in_hyp_mode();
 }
 
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
+
+static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
+				int __unused)
+{
+	/* Forced on command line? */
+	if (__kpti_forced) {
+		pr_info_once("kernel page table isolation forced %s by command line option\n",
+			     __kpti_forced > 0 ? "ON" : "OFF");
+		return __kpti_forced > 0;
+	}
+
+	/* Useful for KASLR robustness */
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
+		return true;
+
+	return false;
+}
+
+static int __init parse_kpti(char *str)
+{
+	bool enabled;
+	int ret = strtobool(str, &enabled);
+
+	if (ret)
+		return ret;
+
+	__kpti_forced = enabled ? 1 : -1;
+	return 0;
+}
+__setup("kpti=", parse_kpti);
+#endif	/* CONFIG_UNMAP_KERNEL_AT_EL0 */
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
@@ -829,6 +863,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.def_scope = SCOPE_SYSTEM,
 		.matches = hyp_offset_low,
 	},
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	{
+		.capability = ARM64_UNMAP_KERNEL_AT_EL0,
+		.def_scope = SCOPE_SYSTEM,
+		.matches = unmap_kernel_at_el0,
+	},
+#endif
 	{},
 };
 
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index eccb6d8..54f35cc 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -73,6 +73,7 @@
 	.macro kernel_ventry, el, label, regsize = 64
 	.align 7
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+alternative_if ARM64_UNMAP_KERNEL_AT_EL0
 	.if	\el == 0
 	.if	\regsize == 64
 	mrs	x30, tpidrro_el0
@@ -81,6 +82,7 @@
 	mov	x30, xzr
 	.endif
 	.endif
+alternative_else_nop_endif
 #endif
 
 	sub	sp, sp, #S_FRAME_SIZE
@@ -208,10 +210,9 @@ alternative_else_nop_endif
 	ldr	lr, [sp, #S_LR]
 	add	sp, sp, #S_FRAME_SIZE		// restore sp
 
-#ifndef CONFIG_UNMAP_KERNEL_AT_EL0
-	eret
-#else
 	.if	\el == 0
+alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	bne	4f
 	msr	far_el1, x30
 	tramp_alias	x30, tramp_exit_native
@@ -219,10 +220,10 @@ alternative_else_nop_endif
 4:
 	tramp_alias	x30, tramp_exit_compat
 	br	x30
+#endif
 	.else
 	eret
 	.endif
-#endif
 	.endm
 
 	.macro	get_thread_info, rd
-- 
2.7.4
