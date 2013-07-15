From: robherring2@gmail.com (Rob Herring)
Date: Mon, 15 Jul 2013 15:42:23 -0500
Subject: [PATCH] ARM: Add check for Cortex-A15 errata 798181 ECO
Message-ID: <1373920943-18308-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

The work-around for A15 errata 798181 is not needed if appropriate ECO
fixes have been applied to r3p2 and earlier core revisions. This can be
checked by reading REVIDR register bits 4 and 9. If only bit 4 is set,
then the IPI broadcast can be skipped.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---

Compile tested only.

 arch/arm/include/asm/cputype.h |  1 +
 arch/arm/kernel/smp_tlb.c      | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index ec635ff..ac1c46a 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -9,6 +9,7 @@
 #define CPUID_TCM	2
 #define CPUID_TLBTYPE	3
 #define CPUID_MPIDR	5
+#define CPUID_REVIDR	6
 
 #ifdef CONFIG_CPU_V7M
 #define CPUID_EXT_PFR0	0x40
diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
index 9a52a07..7fd64b7 100644
--- a/arch/arm/kernel/smp_tlb.c
+++ b/arch/arm/kernel/smp_tlb.c
@@ -74,10 +74,21 @@ static inline void ipi_flush_bp_all(void *ignored)
 static int erratum_a15_798181(void)
 {
 	unsigned int midr = read_cpuid_id();
+	unsigned int revidr;
 
 	/* Cortex-A15 r0p0..r3p2 affected */
 	if ((midr & 0xff0ffff0) != 0x410fc0f0 || midr > 0x413fc0f2)
 		return 0;
+
+	/* Check for Cortex A15 <= r3p2 with ECO fix */
+	revidr = read_cpuid(CPUID_REVIDR);
+	if ((revidr & 0x210) == 0x210)
+		return 0;
+
+	dummy_flush_tlb_a15_erratum();
+	if (revidr & 0x10)
+		return 0;
+
 	return 1;
 }
 #else
@@ -97,7 +108,6 @@ static void broadcast_tlb_a15_erratum(void)
 	if (!erratum_a15_798181())
 		return;
 
-	dummy_flush_tlb_a15_erratum();
 	smp_call_function(ipi_flush_tlb_a15_erratum, NULL, 1);
 }
 
@@ -109,7 +119,6 @@ static void broadcast_tlb_mm_a15_erratum(struct mm_struct *mm)
 	if (!erratum_a15_798181())
 		return;
 
-	dummy_flush_tlb_a15_erratum();
 	this_cpu = get_cpu();
 	for_each_online_cpu(cpu) {
 		if (cpu == this_cpu)
-- 
1.8.1.2
