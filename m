From: ashoks@broadcom.com (Ashok Kumar)
Date: Thu, 21 Apr 2016 05:58:43 -0700
Subject: [PATCH v6 5/7] arm64/perf: Access pmu register using
 <read/write>_sys_reg
In-Reply-To: <1461243525-13603-1-git-send-email-ashoks@broadcom.com>
References: <1461243525-13603-1-git-send-email-ashoks@broadcom.com>
Message-ID: <1461243525-13603-6-git-send-email-ashoks@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

changed pmu register access to make use of <read/write>_sys_reg
from sysreg.h instead of accessing them directly.

Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/perf_event.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index d5a02bc..946ce4b 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -21,6 +21,7 @@
 
 #include <asm/irq_regs.h>
 #include <asm/perf_event.h>
+#include <asm/sysreg.h>
 #include <asm/virt.h>
 
 #include <linux/of.h>
@@ -476,16 +477,14 @@ static const struct attribute_group *armv8_pmuv3_attr_groups[] = {
 
 static inline u32 armv8pmu_pmcr_read(void)
 {
-	u32 val;
-	asm volatile("mrs %0, pmcr_el0" : "=r" (val));
-	return val;
+	return read_sysreg(pmcr_el0);
 }
 
 static inline void armv8pmu_pmcr_write(u32 val)
 {
 	val &= ARMV8_PMU_PMCR_MASK;
 	isb();
-	asm volatile("msr pmcr_el0, %0" :: "r" (val));
+	write_sysreg(val, pmcr_el0);
 }
 
 static inline int armv8pmu_has_overflowed(u32 pmovsr)
@@ -507,7 +506,7 @@ static inline int armv8pmu_counter_has_overflowed(u32 pmnc, int idx)
 static inline int armv8pmu_select_counter(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
-	asm volatile("msr pmselr_el0, %0" :: "r" (counter));
+	write_sysreg(counter, pmselr_el0);
 	isb();
 
 	return idx;
@@ -524,9 +523,9 @@ static inline u32 armv8pmu_read_counter(struct perf_event *event)
 		pr_err("CPU%u reading wrong counter %d\n",
 			smp_processor_id(), idx);
 	else if (idx == ARMV8_IDX_CYCLE_COUNTER)
-		asm volatile("mrs %0, pmccntr_el0" : "=r" (value));
+		value = read_sysreg(pmccntr_el0);
 	else if (armv8pmu_select_counter(idx) == idx)
-		asm volatile("mrs %0, pmxevcntr_el0" : "=r" (value));
+		value = read_sysreg(pmxevcntr_el0);
 
 	return value;
 }
@@ -548,47 +547,47 @@ static inline void armv8pmu_write_counter(struct perf_event *event, u32 value)
 		 */
 		u64 value64 = 0xffffffff00000000ULL | value;
 
-		asm volatile("msr pmccntr_el0, %0" :: "r" (value64));
+		write_sysreg(value64, pmccntr_el0);
 	} else if (armv8pmu_select_counter(idx) == idx)
-		asm volatile("msr pmxevcntr_el0, %0" :: "r" (value));
+		write_sysreg(value, pmxevcntr_el0);
 }
 
 static inline void armv8pmu_write_evtype(int idx, u32 val)
 {
 	if (armv8pmu_select_counter(idx) == idx) {
 		val &= ARMV8_PMU_EVTYPE_MASK;
-		asm volatile("msr pmxevtyper_el0, %0" :: "r" (val));
+		write_sysreg(val, pmxevtyper_el0);
 	}
 }
 
 static inline int armv8pmu_enable_counter(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
-	asm volatile("msr pmcntenset_el0, %0" :: "r" (BIT(counter)));
+	write_sysreg(BIT(counter), pmcntenset_el0);
 	return idx;
 }
 
 static inline int armv8pmu_disable_counter(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
-	asm volatile("msr pmcntenclr_el0, %0" :: "r" (BIT(counter)));
+	write_sysreg(BIT(counter), pmcntenclr_el0);
 	return idx;
 }
 
 static inline int armv8pmu_enable_intens(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
-	asm volatile("msr pmintenset_el1, %0" :: "r" (BIT(counter)));
+	write_sysreg(BIT(counter), pmintenset_el1);
 	return idx;
 }
 
 static inline int armv8pmu_disable_intens(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
-	asm volatile("msr pmintenclr_el1, %0" :: "r" (BIT(counter)));
+	write_sysreg(BIT(counter), pmintenclr_el1);
 	isb();
 	/* Clear the overflow flag in case an interrupt is pending. */
-	asm volatile("msr pmovsclr_el0, %0" :: "r" (BIT(counter)));
+	write_sysreg(BIT(counter), pmovsclr_el0);
 	isb();
 
 	return idx;
@@ -599,11 +598,11 @@ static inline u32 armv8pmu_getreset_flags(void)
 	u32 value;
 
 	/* Read */
-	asm volatile("mrs %0, pmovsclr_el0" : "=r" (value));
+	value = read_sysreg(pmovsclr_el0);
 
 	/* Write to clear flags */
 	value &= ARMV8_PMU_OVSR_MASK;
-	asm volatile("msr pmovsclr_el0, %0" :: "r" (value));
+	write_sysreg(value, pmovsclr_el0);
 
 	return value;
 }
-- 
2.1.0
