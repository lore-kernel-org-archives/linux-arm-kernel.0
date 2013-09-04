From: robherring2@gmail.com (Rob Herring)
Date: Wed,  4 Sep 2013 14:31:43 -0500
Subject: [PATCH v5] ARM: Add check for Cortex-A15 errata 798181 ECO
Message-ID: <1378323103-5940-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

The work-around for A15 errata 798181 is not needed if appropriate ECO
fixes have been applied to r3p2 and earlier core revisions. This can be
checked by reading REVIDR register bits 4 and 9. If only bit 4 is set,
then the IPI broadcast can be skipped.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---

v5:
- Rebase on Russell's devel-stable 
- Fix !SMP builds (add back #ifdefs)
- Compiled on !SMP and SMP with and without errata work-around enabled.

v4:
- Move code from setup.c back to smp_tlb.c
- Use IS_ENABLED macro

v3:
- Rebase to v3.11-rc5 due to commit 1f49856 (ARM: 7789/1: Do not run
 dummy_flush_tlb_a15_erratum() on non-Cortex-A15)
- Move the revision checking out of line and use function ptrs.

v2: 
- Determine the work-around needed and save in a static varible instead 
of re-reading the ID registers. 


 arch/arm/include/asm/cputype.h  |  1 +
 arch/arm/include/asm/tlbflush.h | 34 +++++++++-------------------------
 arch/arm/kernel/setup.c         |  2 ++
 arch/arm/kernel/smp_tlb.c       | 36 ++++++++++++++++++++++++++++++++++--
 4 files changed, 46 insertions(+), 27 deletions(-)

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
index 3896026..dfad966 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -560,36 +560,20 @@ static inline void __flush_bp_all(void)
 		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero));
 }
 
-#include <asm/cputype.h>
 #ifdef CONFIG_ARM_ERRATA_798181
-static inline int erratum_a15_798181(void)
-{
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
-	dsb(ish);
-}
+extern void erratum_a15_798181_init(void);
 #else
-static inline int erratum_a15_798181(void)
-{
-	return 0;
-}
+static inline void erratum_a15_798181_init(void) {}
+#endif
+extern bool (*erratum_a15_798181_handler)(void);
 
-static inline void dummy_flush_tlb_a15_erratum(void)
+static inline bool erratum_a15_798181(void)
 {
+	if (unlikely(IS_ENABLED(CONFIG_ARM_ERRATA_798181) &&
+		erratum_a15_798181_handler))
+		return erratum_a15_798181_handler();
+	return false;
 }
-#endif
 
 /*
  *	flush_pmd_entry
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index afc2489..f3030e3 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -599,6 +599,8 @@ static void __init setup_processor(void)
 	elf_hwcap &= ~(HWCAP_THUMB | HWCAP_IDIVT);
 #endif
 
+	erratum_a15_798181_init();
+
 	feat_v6_fixup();
 
 	cacheid_init();
diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
index 83ccca3..95d0636 100644
--- a/arch/arm/kernel/smp_tlb.c
+++ b/arch/arm/kernel/smp_tlb.c
@@ -70,6 +70,40 @@ static inline void ipi_flush_bp_all(void *ignored)
 	local_flush_bp_all();
 }
 
+#ifdef CONFIG_ARM_ERRATA_798181
+bool (*erratum_a15_798181_handler)(void);
+
+static bool erratum_a15_798181_partial(void)
+{
+	asm("mcr p15, 0, %0, c8, c3, 1" : : "r" (0));
+	dsb(ish);
+	return false;
+}
+
+static bool erratum_a15_798181_broadcast(void)
+{
+	asm("mcr p15, 0, %0, c8, c3, 1" : : "r" (0));
+	dsb(ish);
+	return true;
+}
+
+void erratum_a15_798181_init(void)
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
+#endif
+
 static void ipi_flush_tlb_a15_erratum(void *arg)
 {
 	dmb();
@@ -80,7 +114,6 @@ static void broadcast_tlb_a15_erratum(void)
 	if (!erratum_a15_798181())
 		return;
 
-	dummy_flush_tlb_a15_erratum();
 	smp_call_function(ipi_flush_tlb_a15_erratum, NULL, 1);
 }
 
@@ -92,7 +125,6 @@ static void broadcast_tlb_mm_a15_erratum(struct mm_struct *mm)
 	if (!erratum_a15_798181())
 		return;
 
-	dummy_flush_tlb_a15_erratum();
 	this_cpu = get_cpu();
 	a15_erratum_get_cpumask(this_cpu, mm, &mask);
 	smp_call_function_many(&mask, ipi_flush_tlb_a15_erratum, NULL, 1);
-- 
1.8.1.2
