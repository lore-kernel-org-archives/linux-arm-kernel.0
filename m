From: robherring2@gmail.com (Rob Herring)
Date: Wed, 14 Aug 2013 18:07:18 -0500
Subject: [PATCH v3] ARM: Add check for Cortex-A15 errata 798181 ECO
Message-ID: <1376521638-24369-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

The work-around for A15 errata 798181 is not needed if appropriate ECO
fixes have been applied to r3p2 and earlier core revisions. This can be
checked by reading REVIDR register bits 4 and 9. If only bit 4 is set,
then the IPI broadcast can be skipped.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
v3:
- Rebase to v3.11-rc5 due to commit 1f49856 (ARM: 7789/1: Do not run
 dummy_flush_tlb_a15_erratum() on non-Cortex-A15)
- Move the revision checking out of line and use function ptrs. I'm open
 to suggestions if there is a better place than setup.c for the init.

 arch/arm/include/asm/cputype.h  |  1 +
 arch/arm/include/asm/tlbflush.h | 30 +++++++-----------------------
 arch/arm/kernel/setup.c         | 38 ++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/smp_tlb.c       |  2 --
 arch/arm/mm/context.c           |  3 +--
 5 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 9672e97..acdde76 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -10,6 +10,7 @@
 #define CPUID_TLBTYPE	3
 #define CPUID_MPUIR	4
 #define CPUID_MPIDR	5
+#define CPUID_REVIDR	6
 
 #ifdef CONFIG_CPU_V7M
 #define CPUID_EXT_PFR0	0x40
diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index f467e9b..5c12ae8 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -443,34 +443,18 @@ static inline void local_flush_bp_all(void)
 		isb();
 }
 
-#include <asm/cputype.h>
 #ifdef CONFIG_ARM_ERRATA_798181
-static inline int erratum_a15_798181(void)
+extern bool (*erratum_a15_798181_handler)(void);
+static inline bool erratum_a15_798181(void)
 {
-	unsigned int midr = read_cpuid_id();
-
-	/* Cortex-A15 r0p0..r3p2 affected */
-	if ((midr & 0xff0ffff0) != 0x410fc0f0 || midr > 0x413fc0f2)
-		return 0;
-	return 1;
-}
-
-static inline void dummy_flush_tlb_a15_erratum(void)
-{
-	/*
-	 * Dummy TLBIMVAIS. Using the unmapped address 0 and ASID 0.
-	 */
-	asm("mcr p15, 0, %0, c8, c3, 1" : : "r" (0));
-	dsb();
+	if (unlikely(erratum_a15_798181_handler))
+		return erratum_a15_798181_handler();
+	return false;
 }
 #else
-static inline int erratum_a15_798181(void)
-{
-	return 0;
-}
-
-static inline void dummy_flush_tlb_a15_erratum(void)
+static inline bool erratum_a15_798181(void)
 {
+	return false;
 }
 #endif
 
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index afc2489..052aa90 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -551,6 +551,42 @@ static void __init smp_build_mpidr_hash(void)
 }
 #endif
 
+#ifdef CONFIG_ARM_ERRATA_798181
+bool (*erratum_a15_798181_handler)(void);
+
+static bool erratum_a15_798181_partial(void)
+{
+	asm("mcr p15, 0, %0, c8, c3, 1" : : "r" (0));
+	dsb();
+	return false;
+}
+
+static bool erratum_a15_798181_broadcast(void)
+{
+	asm("mcr p15, 0, %0, c8, c3, 1" : : "r" (0));
+	dsb();
+	return true;
+}
+
+static void erratum_a15_798181_init(void)
+{
+	unsigned int midr = read_cpuid_id();
+	unsigned int revidr = read_cpuid(CPUID_REVIDR);
+
+	/* Cortex-A15 r0p0..r3p2 w/o ECO fix affected */
+	if ((midr & 0xff0ffff0) != 0x410fc0f0 || midr > 0x413fc0f2 ||
+	    (revidr & 0x210) == 0x210) {
+		return;
+	}
+	if (revidr & 0x10)
+		erratum_a15_798181_handler = erratum_a15_798181_partial;
+	else
+		erratum_a15_798181_handler = erratum_a15_798181_broadcast;
+}
+#else
+static void erratum_a15_798181_init(void) {}
+#endif
+
 static void __init setup_processor(void)
 {
 	struct proc_info_list *list;
@@ -599,6 +635,8 @@ static void __init setup_processor(void)
 	elf_hwcap &= ~(HWCAP_THUMB | HWCAP_IDIVT);
 #endif
 
+	erratum_a15_798181_init();
+
 	feat_v6_fixup();
 
 	cacheid_init();
diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
index c2edfff..94f917d 100644
--- a/arch/arm/kernel/smp_tlb.c
+++ b/arch/arm/kernel/smp_tlb.c
@@ -80,7 +80,6 @@ static void broadcast_tlb_a15_erratum(void)
 	if (!erratum_a15_798181())
 		return;
 
-	dummy_flush_tlb_a15_erratum();
 	smp_call_function(ipi_flush_tlb_a15_erratum, NULL, 1);
 }
 
@@ -92,7 +91,6 @@ static void broadcast_tlb_mm_a15_erratum(struct mm_struct *mm)
 	if (!erratum_a15_798181())
 		return;
 
-	dummy_flush_tlb_a15_erratum();
 	this_cpu = get_cpu();
 	a15_erratum_get_cpumask(this_cpu, mm, &mask);
 	smp_call_function_many(&mask, ipi_flush_tlb_a15_erratum, NULL, 1);
diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 4a05444..28daa1c 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -245,8 +245,7 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
 	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending)) {
 		local_flush_bp_all();
 		local_flush_tlb_all();
-		if (erratum_a15_798181())
-			dummy_flush_tlb_a15_erratum();
+		erratum_a15_798181();
 	}
 
 	atomic64_set(&per_cpu(active_asids, cpu), asid);
-- 
1.8.1.2
