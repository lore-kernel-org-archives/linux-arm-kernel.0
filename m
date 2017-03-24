From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 24 Mar 2017 12:15:27 +0000
Subject: [PATCH 2/4] arm64: perf: Abstract system register accesses away
In-Reply-To: <20170324121529.22603-1-marc.zyngier@arm.com>
References: <20170324121529.22603-1-marc.zyngier@arm.com>
Message-ID: <20170324121529.22603-3-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we want to enable 32bit support, we need to distanciate the
PMUv3 driver from the AArch64 system register names.

This patch moves all system register accesses to an architecture
specific include file, allowing the 32bit counterpart to be
slotted in at a later time.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/arm_pmuv3.h | 102 +++++++++++++++++++++++++++++++++++++
 drivers/perf/arm_pmuv3.c           |  35 +++++++------
 include/linux/perf/arm_pmuv3.h     |   2 +
 3 files changed, 121 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm64/include/asm/arm_pmuv3.h

diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
new file mode 100644
index 000000000000..7b01787fb8fd
--- /dev/null
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -0,0 +1,102 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ASM_PMUV3_H
+#define __ASM_PMUV3_H
+
+#include <asm/sysreg.h>
+
+static inline void write_pmcr(u32 val)
+{
+	write_sysreg(val, pmcr_el0);
+}
+
+static inline u32 read_pmcr(void)
+{
+	return read_sysreg(pmcr_el0);
+}
+
+static inline void write_pmselr(u32 val)
+{
+	write_sysreg(val, pmselr_el0);
+}
+
+static inline void write_pmccntr(u64 val)
+{
+	write_sysreg(val, pmccntr_el0);
+}
+
+static inline u64 read_pmccntr(void)
+{
+	return read_sysreg(pmccntr_el0);
+}
+
+static inline void write_pmxevcntr(u32 val)
+{
+	write_sysreg(val, pmxevcntr_el0);
+}
+
+static inline u32 read_pmxevcntr(void)
+{
+	return read_sysreg(pmxevcntr_el0);
+}
+
+static inline void write_pmxevtyper(u32 val)
+{
+	write_sysreg(val, pmxevtyper_el0);
+}
+
+static inline void write_pmcntenset(u32 val)
+{
+	write_sysreg(val, pmcntenset_el0);
+}
+
+static inline void write_pmcntenclr(u32 val)
+{
+	write_sysreg(val, pmcntenclr_el0);
+}
+
+static inline void write_pmintenset(u32 val)
+{
+	write_sysreg(val, pmintenset_el1);
+}
+
+static inline void write_pmintenclr(u32 val)
+{
+	write_sysreg(val, pmintenclr_el1);
+}
+
+static inline void write_pmovsclr(u32 val)
+{
+	write_sysreg(val, pmovsclr_el0);
+}
+
+static inline u32 read_pmovsclr(void)
+{
+	return read_sysreg(pmovsclr_el0);
+}
+
+static inline u32 read_pmceid0(void)
+{
+	return read_sysreg(pmceid0_el0);
+}
+
+static inline u32 read_pmceid1(void)
+{
+	return read_sysreg(pmceid1_el0);
+}
+
+#endif
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index ac4e6dfc9486..55486dcd2d5b 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -21,7 +21,6 @@
 
 #include <asm/irq_regs.h>
 #include <asm/perf_event.h>
-#include <asm/sysreg.h>
 #include <asm/virt.h>
 
 #include <linux/acpi.h>
@@ -556,14 +555,14 @@ static struct attribute_group armv8_pmuv3_format_attr_group = {
 
 static inline u32 armv8pmu_pmcr_read(void)
 {
-	return read_sysreg(pmcr_el0);
+	return read_pmcr();
 }
 
 static inline void armv8pmu_pmcr_write(u32 val)
 {
 	val &= ARMV8_PMU_PMCR_MASK;
 	isb();
-	write_sysreg(val, pmcr_el0);
+	write_pmcr(val);
 }
 
 static inline int armv8pmu_has_overflowed(u32 pmovsr)
@@ -585,7 +584,7 @@ static inline int armv8pmu_counter_has_overflowed(u32 pmnc, int idx)
 static inline int armv8pmu_select_counter(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
-	write_sysreg(counter, pmselr_el0);
+	write_pmselr(counter);
 	isb();
 
 	return idx;
@@ -602,9 +601,9 @@ static inline u32 armv8pmu_read_counter(struct perf_event *event)
 		pr_err("CPU%u reading wrong counter %d\n",
 			smp_processor_id(), idx);
 	else if (idx == ARMV8_IDX_CYCLE_COUNTER)
-		value = read_sysreg(pmccntr_el0);
+		value = read_pmccntr();
 	else if (armv8pmu_select_counter(idx) == idx)
-		value = read_sysreg(pmxevcntr_el0);
+		value = read_pmxevcntr();
 
 	return value;
 }
@@ -626,47 +625,47 @@ static inline void armv8pmu_write_counter(struct perf_event *event, u32 value)
 		 */
 		u64 value64 = 0xffffffff00000000ULL | value;
 
-		write_sysreg(value64, pmccntr_el0);
+		write_pmccntr(value64);
 	} else if (armv8pmu_select_counter(idx) == idx)
-		write_sysreg(value, pmxevcntr_el0);
+		write_pmxevcntr(value);
 }
 
 static inline void armv8pmu_write_evtype(int idx, u32 val)
 {
 	if (armv8pmu_select_counter(idx) == idx) {
 		val &= ARMV8_PMU_EVTYPE_MASK;
-		write_sysreg(val, pmxevtyper_el0);
+		write_pmxevtyper(val);
 	}
 }
 
 static inline int armv8pmu_enable_counter(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
-	write_sysreg(BIT(counter), pmcntenset_el0);
+	write_pmcntenset(BIT(counter));
 	return idx;
 }
 
 static inline int armv8pmu_disable_counter(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
-	write_sysreg(BIT(counter), pmcntenclr_el0);
+	write_pmcntenclr(BIT(counter));
 	return idx;
 }
 
 static inline int armv8pmu_enable_intens(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
-	write_sysreg(BIT(counter), pmintenset_el1);
+	write_pmintenset(BIT(counter));
 	return idx;
 }
 
 static inline int armv8pmu_disable_intens(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
-	write_sysreg(BIT(counter), pmintenclr_el1);
+	write_pmintenclr(BIT(counter));
 	isb();
 	/* Clear the overflow flag in case an interrupt is pending. */
-	write_sysreg(BIT(counter), pmovsclr_el0);
+	write_pmovsclr(BIT(counter));
 	isb();
 
 	return idx;
@@ -677,11 +676,11 @@ static inline u32 armv8pmu_getreset_flags(void)
 	u32 value;
 
 	/* Read */
-	value = read_sysreg(pmovsclr_el0);
+	value = read_pmovsclr();
 
 	/* Write to clear flags */
 	value &= ARMV8_PMU_OVSR_MASK;
-	write_sysreg(value, pmovsclr_el0);
+	write_pmovsclr(value);
 
 	return value;
 }
@@ -970,8 +969,8 @@ static void __armv8pmu_probe_pmu(void *info)
 	/* Add the CPU cycles counter */
 	cpu_pmu->num_events += 1;
 
-	pmceid[0] = read_sysreg(pmceid0_el0);
-	pmceid[1] = read_sysreg(pmceid1_el0);
+	pmceid[0] = read_pmceid0();
+	pmceid[1] = read_pmceid1();
 
 	bitmap_from_u32array(cpu_pmu->pmceid_bitmap,
 			     ARMV8_PMUV3_MAX_COMMON_EVENTS, pmceid,
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index 119b0decc392..e0b1ae016fa5 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -17,6 +17,8 @@
 #ifndef __PERF_ARM_PMUV3_H
 #define __PERF_ARM_PMUV3_H
 
+#include <asm/arm_pmuv3.h>
+
 #define	ARMV8_PMU_MAX_COUNTERS	32
 #define	ARMV8_PMU_COUNTER_MASK	(ARMV8_PMU_MAX_COUNTERS - 1)
 
-- 
2.11.0
