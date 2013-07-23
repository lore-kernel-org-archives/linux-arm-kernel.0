From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 23 Jul 2013 09:06:39 -0300
Subject: [PATCH v2] ARM: Do not run dummy_flush_tlb_a15_erratum() on
 non-Cortex-A15
Message-ID: <1374581199-8277-1-git-send-email-festevam@gmail.com>
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

To avoid this issue, only call dummy_flush_tlb_a15_erratum() inside 
check_and_switch_context() if erratum_a15_798181() returns true, which means
that we are really running on a Cortex-A15.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Add 'if (erratum_a15_798181())' inside check_and_switch_context()

 arch/arm/include/asm/tlbflush.h | 16 ++++++++++++++++
 arch/arm/kernel/smp_tlb.c       | 17 -----------------
 arch/arm/mm/context.c           |  3 ++-
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index fdbb9e3..f467e9b 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -443,7 +443,18 @@ static inline void local_flush_bp_all(void)
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
 	/*
@@ -453,6 +464,11 @@ static inline void dummy_flush_tlb_a15_erratum(void)
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
index a98b62d..c2edfff 100644
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
diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index b55b101..4a05444 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -245,7 +245,8 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
 	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending)) {
 		local_flush_bp_all();
 		local_flush_tlb_all();
-		dummy_flush_tlb_a15_erratum();
+		if (erratum_a15_798181())
+			dummy_flush_tlb_a15_erratum();
 	}
 
 	atomic64_set(&per_cpu(active_asids, cpu), asid);
-- 
1.8.1.2
