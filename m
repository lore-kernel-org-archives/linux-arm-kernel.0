From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 14 Nov 2016 12:57:46 +0000
Subject: [PATCH 2/2] ARM: rename is_smp()
Message-ID: <E1c6GpW-0008DO-BD@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

is_smp() is causing some confusion - rename it to indicate that it's a
property of the CPU that we're running on, which is not the same as the
system.  Document what and why it is being used at most sites.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
Some people are reporting that "is_smp()" is broken wrt Cortex-A15 CPUs
when they integrate a single Cortex-A15 SMP capable CPU into a
uniprocessor system.  This is most likely because of a misunderstanding
about what is_smp() is really detected from: it's detected from the CPU
capabilities, not from the system capabilities.  If the CPU says that it
is SMP capable (and it's not a broken Cortex-A9 core) we will make use
of various instructions which appear on SMP cores, and we set is_smp()
to follow that.  So, is_smp() is more of a CPU capability rather than a
system capability.

Trying to use it as a system capability will lead to problems.
Arguably, the use of it in arch_irq_work_has_interrupt() is wrong,
because we don't know whether the GIC is SMP capable or not, but it's
currently the best we can do.

I felt the other two sites I left undocumented (which read the MPIDR)
were rather obvious - a uniprocessor only capable CPU doesn't have a
MPIDR.

Really, !cpu_smp() is an indication that the CPU is UP-only, not that
it is _S_MP capable, so even this is lightly misleading.  I suppose
we could replace it with cpu_up_only() but I think that makes the code
harder to understand (due to double-negatives appearing in places.)

 arch/arm/include/asm/cputype.h  |  2 +-
 arch/arm/include/asm/irq_work.h |  2 +-
 arch/arm/include/asm/smp_plat.h | 11 +++++++----
 arch/arm/kernel/devtree.c       |  2 +-
 arch/arm/kernel/module.c        | 10 +++++++++-
 arch/arm/kernel/setup.c         |  7 ++++---
 arch/arm/mach-mvebu/coherency.c |  4 ++--
 arch/arm/mm/mmu.c               | 13 ++++++++++++-
 8 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 522b5feb4eaa..8c82e6b4961d 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -109,7 +109,7 @@ extern unsigned int processor_id;
 
 /*
  * The memory clobber prevents gcc 4.5 from reordering the mrc before
- * any is_smp() tests, which can cause undefined instruction aborts on
+ * any cpu_smp() tests, which can cause undefined instruction aborts on
  * ARM1136 r0 due to the missing extended CP15 registers.
  */
 #define read_cpuid_ext(ext_reg)						\
diff --git a/arch/arm/include/asm/irq_work.h b/arch/arm/include/asm/irq_work.h
index 712d03e5973a..2dc8d7995b48 100644
--- a/arch/arm/include/asm/irq_work.h
+++ b/arch/arm/include/asm/irq_work.h
@@ -5,7 +5,7 @@
 
 static inline bool arch_irq_work_has_interrupt(void)
 {
-	return is_smp();
+	return cpu_smp();
 }
 
 #endif /* _ASM_ARM_IRQ_WORK_H */
diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index 43f246b73ce7..bdba301d01e4 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -12,9 +12,10 @@
 #include <asm/cputype.h>
 
 /*
- * Return true if we are running on a SMP platform
+ * Return true if we are running on a CPU which supports SMP, and the
+ * kernel supports SMP.
  */
-static inline bool is_smp(void)
+static inline bool cpu_smp(void)
 {
 #ifndef CONFIG_SMP
 	return false;
@@ -43,7 +44,8 @@ static inline unsigned int smp_cpuid_part(int cpu)
 #else
 static inline int tlb_ops_need_broadcast(void)
 {
-	if (!is_smp())
+	/* Non-SMP CPUs don't need to check for broadcast */
+	if (!cpu_smp())
 		return 0;
 
 	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 2;
@@ -55,7 +57,8 @@ static inline int tlb_ops_need_broadcast(void)
 #else
 static inline int cache_ops_need_broadcast(void)
 {
-	if (!is_smp())
+	/* Non-SMP CPUs don't need to check for broadcast */
+	if (!cpu_smp())
 		return 0;
 
 	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 1;
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index f676febbb270..19a9653df6d2 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -78,7 +78,7 @@ void __init arm_dt_init_cpu_maps(void)
 	struct device_node *cpu, *cpus;
 	int found_method = 0;
 	u32 i, j, cpuidx = 1;
-	u32 mpidr = is_smp() ? read_cpuid_mpidr() & MPIDR_HWID_BITMASK : 0;
+	u32 mpidr = cpu_smp() ? read_cpuid_mpidr() & MPIDR_HWID_BITMASK : 0;
 
 	u32 tmp_map[NR_CPUS] = { [0 ... NR_CPUS-1] = MPIDR_INVALID };
 	bool bootcpu_valid = false;
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 4f14b5ce6535..0b49aa426180 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -374,12 +374,20 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
 		fixup_pv_table((void *)s->sh_addr, s->sh_size);
 #endif
 	s = find_mod_section(hdr, sechdrs, ".alt.smp.init");
-	if (s && !is_smp())
+	if (s && !cpu_smp()) {
+		/*
+		 * Modules running on non-SMP capable CPUs must not use SMP
+		 * instructions, as they may cause undefined instruction
+		 * exceptions.  This means we have to fix up the SMP
+		 * alternatives on SMP-on-UP modules, and are unable to load
+		 * modules built for SMP-only configurations.
+		 */
 #ifdef CONFIG_SMP_ON_UP
 		fixup_smp((void *)s->sh_addr, s->sh_size);
 #else
 		return -EINVAL;
 #endif
+	}
 	return 0;
 }
 
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 80f45b01fbaa..cdf71941c129 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -584,7 +584,7 @@ u32 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = MPIDR_INVALID };
 void __init smp_setup_processor_id(void)
 {
 	int i;
-	u32 mpidr = is_smp() ? read_cpuid_mpidr() & MPIDR_HWID_BITMASK : 0;
+	u32 mpidr = cpu_smp() ? read_cpuid_mpidr() & MPIDR_HWID_BITMASK : 0;
 	u32 cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 
 	cpu_logical_map(0) = cpu;
@@ -1112,7 +1112,8 @@ void __init setup_arch(char **cmdline_p)
 	arm_dt_init_cpu_maps();
 	psci_dt_init();
 #ifdef CONFIG_SMP
-	if (is_smp()) {
+	if (cpu_smp()) {
+		/* Ignore SMP on non-SMP capable CPUs */
 		if (!mdesc->smp_init || !mdesc->smp_init()) {
 			if (psci_smp_available())
 				smp_set_ops(&psci_smp_ops);
@@ -1124,7 +1125,7 @@ void __init setup_arch(char **cmdline_p)
 	}
 #endif
 
-	if (!is_smp())
+	if (!cpu_smp())
 		hyp_mode_check();
 
 	reserve_crashkernel();
diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index ae2a018b9305..fe4b1e15ebb8 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -216,7 +216,7 @@ static int coherency_type(void)
 	 *
 	 * Note that this means that on Armada 370, there is currently
 	 * no way to use hardware I/O coherency, because even when
-	 * CONFIG_SMP is enabled, is_smp() returns false due to the
+	 * CONFIG_SMP is enabled, cpu_smp() returns false due to the
 	 * Armada 370 being a single-core processor. To lift this
 	 * limitation, we would have to find a way to make the cache
 	 * policy set to write-allocate (on all Armada SoCs), and to
@@ -226,7 +226,7 @@ static int coherency_type(void)
 	 * where we don't know yet on which SoC we are running.
 
 	 */
-	if (!is_smp())
+	if (!cpu_smp())
 		return COHERENCY_FABRIC_TYPE_NONE;
 
 	np = of_find_matching_node_and_match(NULL, of_coherency_table, &match);
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4001dd15818d..d3dc758d5391 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -449,11 +449,22 @@ static void __init build_mem_type_table(void)
 		ecc_mask = 0;
 	}
 
-	if (is_smp()) {
+	if (cpu_smp()) {
+		/*
+		 * SMP requires a write-allocate cache policy for proper
+		 * functioning of the coherency protocol.  If the CPU supports
+		 * MP extensions, assume we are part of a SMP system.
+		 */
 		if (cachepolicy != CPOLICY_WRITEALLOC) {
 			pr_warn("Forcing write-allocate cache policy for SMP\n");
 			cachepolicy = CPOLICY_WRITEALLOC;
 		}
+
+		/*
+		 * SMP systems depend on the S bit being shared for coherency
+		 * between the CPUs.  However, setting this for non-SMP CPUs
+		 * may result in the mappings being treated as uncached.
+		 */
 		if (!(initial_pmd_value & PMD_SECT_S)) {
 			pr_warn("Forcing shared mappings for SMP\n");
 			initial_pmd_value |= PMD_SECT_S;
-- 
2.7.4
