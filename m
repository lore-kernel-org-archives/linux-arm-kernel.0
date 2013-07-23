From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 23 Jul 2013 02:19:34 -0300
Subject: [PATCH] ARM: Do not run dummy_flush_tlb_a15_erratum() on
 non-Cortex-A15
Message-ID: <1374556774-18795-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Commit 93dc688 (ARM: 7684/1: errata: Workaround for Cortex-A15 erratum 798181 
(TLBI/DSB operations)) causes the following undefined instruction error on a
mx53 (Cortex-A8):

Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
CPU: 0 PID: 275 Comm: modprobe Not tainted 3.11.0-rc2-next-20130722-00009-g9b0f371 #881
task: df46cc00 ti: df48e000 task.ti: df48e000
PC is at check_and_switch_context+0x17c/0x4d0
LR is at check_and_switch_context+0xdc/0x4d0

This problem happens because check_and_switch_context() calls 
dummy_flush_tlb_a15_erratum() without checking if we are really running on a 
Cortex-A15 or not. 

To avoid this issue, always check if we are running on a Cortex-A15 or not 
(via erratum_a15_798181()) inside dummy_flush_tlb_a15_erratum(), so that we do 
not need to keep doing the same check in all occurrences of 
dummy_flush_tlb_a15_erratum().

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/include/asm/tlbflush.h | 18 ++++++++++++++++++
 arch/arm/kernel/smp_tlb.c       | 23 -----------------------
 2 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index fdbb9e3..2478b6f 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -443,9 +443,22 @@ static inline void local_flush_bp_all(void)
 		isb();
 }
 
+#include <asm/cputype.h>
 #ifdef CONFIG_ARM_ERRATA_798181
+static inline int erratum_a15_798181(void)
+{
+	unsigned int midr = read_cpuid_id();
+
+	/* Cortex-A15 r0p0..r3p2 affected */
+	if ((midr & 0xff0ffff0) != 0x410fc0f0 || midr > 0x413fc0f2)
+		return 0;
+	return 1;
+}
+
 static inline void dummy_flush_tlb_a15_erratum(void)
 {
+	if (!erratum_a15_798181())
+		return;
 	/*
 	 * Dummy TLBIMVAIS. Using the unmapped address 0 and ASID 0.
 	 */
@@ -453,6 +466,11 @@ static inline void dummy_flush_tlb_a15_erratum(void)
 	dsb();
 }
 #else
+static inline int erratum_a15_798181(void)
+{
+	return 0;
+}
+
 static inline void dummy_flush_tlb_a15_erratum(void)
 {
 }
diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
index a98b62d..29e9038 100644
--- a/arch/arm/kernel/smp_tlb.c
+++ b/arch/arm/kernel/smp_tlb.c
@@ -70,23 +70,6 @@ static inline void ipi_flush_bp_all(void *ignored)
 	local_flush_bp_all();
 }
 
-#ifdef CONFIG_ARM_ERRATA_798181
-static int erratum_a15_798181(void)
-{
-	unsigned int midr = read_cpuid_id();
-
-	/* Cortex-A15 r0p0..r3p2 affected */
-	if ((midr & 0xff0ffff0) != 0x410fc0f0 || midr > 0x413fc0f2)
-		return 0;
-	return 1;
-}
-#else
-static int erratum_a15_798181(void)
-{
-	return 0;
-}
-#endif
-
 static void ipi_flush_tlb_a15_erratum(void *arg)
 {
 	dmb();
@@ -94,9 +77,6 @@ static void ipi_flush_tlb_a15_erratum(void *arg)
 
 static void broadcast_tlb_a15_erratum(void)
 {
-	if (!erratum_a15_798181())
-		return;
-
 	dummy_flush_tlb_a15_erratum();
 	smp_call_function(ipi_flush_tlb_a15_erratum, NULL, 1);
 }
@@ -106,9 +86,6 @@ static void broadcast_tlb_mm_a15_erratum(struct mm_struct *mm)
 	int this_cpu;
 	cpumask_t mask = { CPU_BITS_NONE };
 
-	if (!erratum_a15_798181())
-		return;
-
 	dummy_flush_tlb_a15_erratum();
 	this_cpu = get_cpu();
 	a15_erratum_get_cpumask(this_cpu, mm, &mask);
-- 
1.8.1.2
