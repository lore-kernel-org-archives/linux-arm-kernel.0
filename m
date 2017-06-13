From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 13 Jun 2017 15:28:33 +0100
Subject: [PATCH v2 1/5] arm64: perf: Move PMUv3 driver to drivers/perf
In-Reply-To: <20170613142837.29738-1-marc.zyngier@arm.com>
References: <20170613142837.29738-1-marc.zyngier@arm.com>
Message-ID: <20170613142837.29738-2-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having the ARM PMUv3 driver sitting in arch/arm64/kernel is getting
in the way of being able to use perf on ARMv8 cores running a 32bit
kernel, such as 32bit KVM guests.

This patch moves it into drivers/perf/arm_pmuv3.c, with an include
file in include/linux/perf/arm_pmuv3.h. The only thing left in
arch/arm64 is some mundane perf stuff.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/perf_event.h                | 55 ----------------
 arch/arm64/kernel/Makefile                         |  1 -
 drivers/perf/Kconfig                               |  8 +++
 drivers/perf/Makefile                              |  1 +
 .../perf_event.c => drivers/perf/arm_pmuv3.c       |  1 +
 include/kvm/arm_pmu.h                              |  2 +-
 include/linux/perf/arm_pmuv3.h                     | 75 ++++++++++++++++++++++
 7 files changed, 86 insertions(+), 57 deletions(-)
 rename arch/arm64/kernel/perf_event.c => drivers/perf/arm_pmuv3.c (99%)
 create mode 100644 include/linux/perf/arm_pmuv3.h

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index 8d5cbec17d80..91b6be092ce2 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -19,61 +19,6 @@
 
 #include <asm/stack_pointer.h>
 
-#define	ARMV8_PMU_MAX_COUNTERS	32
-#define	ARMV8_PMU_COUNTER_MASK	(ARMV8_PMU_MAX_COUNTERS - 1)
-
-/*
- * Per-CPU PMCR: config reg
- */
-#define ARMV8_PMU_PMCR_E	(1 << 0) /* Enable all counters */
-#define ARMV8_PMU_PMCR_P	(1 << 1) /* Reset all counters */
-#define ARMV8_PMU_PMCR_C	(1 << 2) /* Cycle counter reset */
-#define ARMV8_PMU_PMCR_D	(1 << 3) /* CCNT counts every 64th cpu cycle */
-#define ARMV8_PMU_PMCR_X	(1 << 4) /* Export to ETM */
-#define ARMV8_PMU_PMCR_DP	(1 << 5) /* Disable CCNT if non-invasive debug*/
-#define ARMV8_PMU_PMCR_LC	(1 << 6) /* Overflow on 64 bit cycle counter */
-#define	ARMV8_PMU_PMCR_N_SHIFT	11	 /* Number of counters supported */
-#define	ARMV8_PMU_PMCR_N_MASK	0x1f
-#define	ARMV8_PMU_PMCR_MASK	0x7f	 /* Mask for writable bits */
-
-/*
- * PMOVSR: counters overflow flag status reg
- */
-#define	ARMV8_PMU_OVSR_MASK		0xffffffff	/* Mask for writable bits */
-#define	ARMV8_PMU_OVERFLOWED_MASK	ARMV8_PMU_OVSR_MASK
-
-/*
- * PMXEVTYPER: Event selection reg
- */
-#define	ARMV8_PMU_EVTYPE_MASK	0xc800ffff	/* Mask for writable bits */
-#define	ARMV8_PMU_EVTYPE_EVENT	0xffff		/* Mask for EVENT bits */
-
-/*
- * PMUv3 event types: required events
- */
-#define ARMV8_PMUV3_PERFCTR_SW_INCR				0x00
-#define ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL			0x03
-#define ARMV8_PMUV3_PERFCTR_L1D_CACHE				0x04
-#define ARMV8_PMUV3_PERFCTR_BR_MIS_PRED				0x10
-#define ARMV8_PMUV3_PERFCTR_CPU_CYCLES				0x11
-#define ARMV8_PMUV3_PERFCTR_BR_PRED				0x12
-
-/*
- * Event filters for PMUv3
- */
-#define	ARMV8_PMU_EXCLUDE_EL1	(1 << 31)
-#define	ARMV8_PMU_EXCLUDE_EL0	(1 << 30)
-#define	ARMV8_PMU_INCLUDE_EL2	(1 << 27)
-
-/*
- * PMUSERENR: user enable reg
- */
-#define ARMV8_PMU_USERENR_MASK	0xf		/* Mask for writable bits */
-#define ARMV8_PMU_USERENR_EN	(1 << 0) /* PMU regs can be accessed at EL0 */
-#define ARMV8_PMU_USERENR_SW	(1 << 1) /* PMSWINC can be written at EL0 */
-#define ARMV8_PMU_USERENR_CR	(1 << 2) /* Cycle counter can be read at EL0 */
-#define ARMV8_PMU_USERENR_ER	(1 << 3) /* Event counter can be read@EL0 */
-
 #ifdef CONFIG_PERF_EVENTS
 struct pt_regs;
 extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 1dcb69d3d0e5..9d348eacfc0a 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -33,7 +33,6 @@ arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
 arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
-arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
 arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 arm64-obj-$(CONFIG_CPU_PM)		+= sleep.o suspend.o
 arm64-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index aa587edaf9ea..f4dc1f3cbb18 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -16,6 +16,14 @@ config ARM_PMU_ACPI
 	depends on ARM_PMU && ACPI
 	def_bool y
 
+config ARM_PMUV3
+	depends on HW_PERF_EVENTS && ARM64
+	bool "ARM PMUv3 support"
+	default y
+	help
+	  Say y if you want to use CPU performance monitors on ARMv8
+	  systems that implement the PMUv3 architecture.
+
 config QCOM_L2_PMU
 	bool "Qualcomm Technologies L2-cache PMU"
 	depends on ARCH_QCOM && ARM64 && PERF_EVENTS && ACPI
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 6420bd4394d5..1be6ba35debe 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_ARM_PMU) += arm_pmu.o arm_pmu_platform.o
 obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
+obj-$(CONFIG_ARM_PMUV3) += arm_pmuv3.o
 obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
diff --git a/arch/arm64/kernel/perf_event.c b/drivers/perf/arm_pmuv3.c
similarity index 99%
rename from arch/arm64/kernel/perf_event.c
rename to drivers/perf/arm_pmuv3.c
index 83a1b1ad189f..c760ef301ade 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -27,6 +27,7 @@
 #include <linux/acpi.h>
 #include <linux/of.h>
 #include <linux/perf/arm_pmu.h>
+#include <linux/perf/arm_pmuv3.h>
 #include <linux/platform_device.h>
 
 /*
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 1ab4633adf4f..f2ba1bcda0c5 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -19,7 +19,7 @@
 #define __ASM_ARM_KVM_PMU_H
 
 #include <linux/perf_event.h>
-#include <asm/perf_event.h>
+#include <linux/perf/arm_pmuv3.h>
 
 #define ARMV8_PMU_CYCLE_IDX		(ARMV8_PMU_MAX_COUNTERS - 1)
 
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
new file mode 100644
index 000000000000..119b0decc392
--- /dev/null
+++ b/include/linux/perf/arm_pmuv3.h
@@ -0,0 +1,75 @@
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
+#ifndef __PERF_ARM_PMUV3_H
+#define __PERF_ARM_PMUV3_H
+
+#define	ARMV8_PMU_MAX_COUNTERS	32
+#define	ARMV8_PMU_COUNTER_MASK	(ARMV8_PMU_MAX_COUNTERS - 1)
+
+/*
+ * Per-CPU PMCR: config reg
+ */
+#define ARMV8_PMU_PMCR_E	(1 << 0) /* Enable all counters */
+#define ARMV8_PMU_PMCR_P	(1 << 1) /* Reset all counters */
+#define ARMV8_PMU_PMCR_C	(1 << 2) /* Cycle counter reset */
+#define ARMV8_PMU_PMCR_D	(1 << 3) /* CCNT counts every 64th cpu cycle */
+#define ARMV8_PMU_PMCR_X	(1 << 4) /* Export to ETM */
+#define ARMV8_PMU_PMCR_DP	(1 << 5) /* Disable CCNT if non-invasive debug*/
+#define ARMV8_PMU_PMCR_LC	(1 << 6) /* Overflow on 64 bit cycle counter */
+#define	ARMV8_PMU_PMCR_N_SHIFT	11	 /* Number of counters supported */
+#define	ARMV8_PMU_PMCR_N_MASK	0x1f
+#define	ARMV8_PMU_PMCR_MASK	0x7f	 /* Mask for writable bits */
+
+/*
+ * PMOVSR: counters overflow flag status reg
+ */
+#define	ARMV8_PMU_OVSR_MASK		0xffffffff	/* Mask for writable bits */
+#define	ARMV8_PMU_OVERFLOWED_MASK	ARMV8_PMU_OVSR_MASK
+
+/*
+ * PMXEVTYPER: Event selection reg
+ */
+#define	ARMV8_PMU_EVTYPE_MASK	0xc800ffff	/* Mask for writable bits */
+#define	ARMV8_PMU_EVTYPE_EVENT	0xffff		/* Mask for EVENT bits */
+
+/*
+ * PMUv3 event types: required events
+ */
+#define ARMV8_PMUV3_PERFCTR_SW_INCR				0x00
+#define ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL			0x03
+#define ARMV8_PMUV3_PERFCTR_L1D_CACHE				0x04
+#define ARMV8_PMUV3_PERFCTR_BR_MIS_PRED				0x10
+#define ARMV8_PMUV3_PERFCTR_CPU_CYCLES				0x11
+#define ARMV8_PMUV3_PERFCTR_BR_PRED				0x12
+
+/*
+ * Event filters for PMUv3
+ */
+#define	ARMV8_PMU_EXCLUDE_EL1	(1 << 31)
+#define	ARMV8_PMU_EXCLUDE_EL0	(1 << 30)
+#define	ARMV8_PMU_INCLUDE_EL2	(1 << 27)
+
+/*
+ * PMUSERENR: user enable reg
+ */
+#define ARMV8_PMU_USERENR_MASK	0xf		/* Mask for writable bits */
+#define ARMV8_PMU_USERENR_EN	(1 << 0) /* PMU regs can be accessed at EL0 */
+#define ARMV8_PMU_USERENR_SW	(1 << 1) /* PMSWINC can be written at EL0 */
+#define ARMV8_PMU_USERENR_CR	(1 << 2) /* Cycle counter can be read at EL0 */
+#define ARMV8_PMU_USERENR_ER	(1 << 3) /* Event counter can be read@EL0 */
+
+#endif
-- 
2.11.0
