From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Nov 2017 18:21:59 +0000
Subject: [PATCH 16/18] arm64: entry: Add fake CPU feature for mapping the
 kernel at EL0
In-Reply-To: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
Message-ID: <1510942921-12564-17-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow explicit disabling of the entry trampoline on the kernel command
line by adding a fake CPU feature (ARM64_MAP_KERNEL_AT_EL0) that can
be used to apply alternative sequences to our entry code and avoid use
of the trampoline altogether.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cpucaps.h |  3 ++-
 arch/arm64/kernel/cpufeature.c   | 11 +++++++++++
 arch/arm64/kernel/entry.S        |  6 +++++-
 arch/arm64/mm/mmu.c              |  7 +++++++
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 8da621627d7c..f61d85f76683 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -40,7 +40,8 @@
 #define ARM64_WORKAROUND_858921			19
 #define ARM64_WORKAROUND_CAVIUM_30115		20
 #define ARM64_HAS_DCPOP				21
+#define ARM64_MAP_KERNEL_AT_EL0			22
 
-#define ARM64_NCAPS				22
+#define ARM64_NCAPS				23
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 21e2c95d24e7..aa6b90de6591 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -796,6 +796,12 @@ static bool has_no_fpsimd(const struct arm64_cpu_capabilities *entry, int __unus
 					ID_AA64PFR0_FP_SHIFT) < 0;
 }
 
+static bool map_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
+			      int __unused)
+{
+	return arm64_kernel_mapped_at_el0();
+}
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
@@ -883,6 +889,11 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = hyp_offset_low,
 	},
 	{
+		.capability = ARM64_MAP_KERNEL_AT_EL0,
+		.def_scope = SCOPE_SYSTEM,
+		.matches = map_kernel_at_el0,
+	},
+	{
 		/* FP/SIMD is not implemented */
 		.capability = ARM64_HAS_NO_FPSIMD,
 		.def_scope = SCOPE_SYSTEM,
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index a600879939ce..a74253defc5b 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -73,6 +73,7 @@
 	.macro kernel_ventry, el, label, regsize = 64
 	.align 7
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+alternative_if_not ARM64_MAP_KERNEL_AT_EL0
 	.if	\el == 0
 	.if	\regsize == 64
 	mrs	x30, tpidrro_el0
@@ -80,6 +81,7 @@
 	mov	x30, xzr
 	.endif
 	.endif
+alternative_else_nop_endif
 #endif
 
 	sub	sp, sp, #S_FRAME_SIZE
@@ -300,6 +302,7 @@ alternative_if ARM64_WORKAROUND_845719
 alternative_else_nop_endif
 #endif
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+alternative_if_not ARM64_MAP_KERNEL_AT_EL0
 	tramp_alias	x30, tramp_exit_compat
 	b	4f
 3:
@@ -308,6 +311,7 @@ alternative_else_nop_endif
 	tramp_alias	x30, tramp_exit_native
 4:
 	prfm	plil1strm, [x30]
+alternative_else_nop_endif
 #else
 3:
 #endif
@@ -332,7 +336,7 @@ alternative_else_nop_endif
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	.if	\el == 0
-	br	x30
+	alternative_insn "br x30", nop, ARM64_MAP_KERNEL_AT_EL0
 	.endif
 #endif
 	eret
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 5ce5cb1249da..dab987f2912c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -571,6 +571,13 @@ static int __init map_entry_trampoline(void)
 	return 0;
 }
 core_initcall(map_entry_trampoline);
+
+static int __init parse_nokaiser(char *__unused)
+{
+	static_branch_disable(&__unmap_kernel_at_el0);
+	return 0;
+}
+__setup("nokaiser", parse_nokaiser);
 #else
 static void __init add_tramp_vma(void) {}
 #endif
-- 
2.1.4
