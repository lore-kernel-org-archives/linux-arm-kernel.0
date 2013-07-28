From: robherring2@gmail.com (Rob Herring)
Date: Sun, 28 Jul 2013 16:14:08 -0500
Subject: [PATCH v2] ARM: Add check for Cortex-A15 errata 798181 ECO
Message-ID: <1375046048-25853-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

The work-around for A15 errata 798181 is not needed if appropriate ECO
fixes have been applied to r3p2 and earlier core revisions. This can be
checked by reading REVIDR register bits 4 and 9. If only bit 4 is set,
then the IPI broadcast can be skipped.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
v2:
- Determine the work-around needed and save in a static varible instead
  of re-reading the ID registers.

 arch/arm/include/asm/cputype.h |  1 +
 arch/arm/kernel/smp_tlb.c      | 31 +++++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 8c25dc4..e5952b7 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -10,6 +10,7 @@
 #define CPUID_TLBTYPE	3
 #define CPUID_MPUIR	4
 #define CPUID_MPIDR	5
+#define CPUID_REVIDR	6
 
 #ifdef CONFIG_CPU_V7M
 #define CPUID_EXT_PFR0	0x40
diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
index a98b62d..da20db1 100644
--- a/arch/arm/kernel/smp_tlb.c
+++ b/arch/arm/kernel/smp_tlb.c
@@ -73,12 +73,29 @@ static inline void ipi_flush_bp_all(void *ignored)
 #ifdef CONFIG_ARM_ERRATA_798181
 static int erratum_a15_798181(void)
 {
-	unsigned int midr = read_cpuid_id();
-
-	/* Cortex-A15 r0p0..r3p2 affected */
-	if ((midr & 0xff0ffff0) != 0x410fc0f0 || midr > 0x413fc0f2)
-		return 0;
-	return 1;
+	static int errata_fix_needed = -1;
+
+	if (unlikely(errata_fix_needed == -1)) {
+		unsigned int midr = read_cpuid_id();
+		unsigned int revidr = read_cpuid(CPUID_REVIDR);
+
+		/* Cortex-A15 r0p0..r3p2 w/o ECO fix affected */
+		if ((midr & 0xff0ffff0) != 0x410fc0f0 || midr > 0x413fc0f2 ||
+		    (revidr & 0x210) == 0x210) {
+			errata_fix_needed = 0;	/* No work-around needed */
+			return 0;
+		}
+		if (revidr & 0x10)
+			errata_fix_needed = 1;	/* Only TLB flush needed */
+		else
+			errata_fix_needed = 2;	/* IPI broadcast needed */
+	}
+
+	if (errata_fix_needed)
+		dummy_flush_tlb_a15_erratum();
+
+	/* Return 1 if IPI broadcast to other cores is needed */
+	return (errata_fix_needed == 2) ? 1: 0;
 }
 #else
 static int erratum_a15_798181(void)
@@ -97,7 +114,6 @@ static void broadcast_tlb_a15_erratum(void)
 	if (!erratum_a15_798181())
 		return;
 
-	dummy_flush_tlb_a15_erratum();
 	smp_call_function(ipi_flush_tlb_a15_erratum, NULL, 1);
 }
 
@@ -109,7 +125,6 @@ static void broadcast_tlb_mm_a15_erratum(struct mm_struct *mm)
 	if (!erratum_a15_798181())
 		return;
 
-	dummy_flush_tlb_a15_erratum();
 	this_cpu = get_cpu();
 	a15_erratum_get_cpumask(this_cpu, mm, &mask);
 	smp_call_function_many(&mask, ipi_flush_tlb_a15_erratum, NULL, 1);
-- 
1.8.1.2
