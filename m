From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 8 Dec 2015 20:47:20 +0800
Subject: [PATCH v6 01/21] ARM64: Move PMU register related defines to asm/pmu.h
In-Reply-To: <1449578860-15808-1-git-send-email-zhaoshenglong@huawei.com>
References: <1449578860-15808-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1449578860-15808-2-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

To use the ARMv8 PMU related register defines from the KVM code,
we move the relevant definitions to asm/pmu.h header file.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 arch/arm64/include/asm/pmu.h   | 64 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/perf_event.c | 36 +-----------------------
 2 files changed, 65 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm64/include/asm/pmu.h

diff --git a/arch/arm64/include/asm/pmu.h b/arch/arm64/include/asm/pmu.h
new file mode 100644
index 0000000..4264ea0
--- /dev/null
+++ b/arch/arm64/include/asm/pmu.h
@@ -0,0 +1,64 @@
+/*
+ * Copyright (C) 2015 Linaro Ltd, Shannon Zhao
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
+#ifndef __ASM_PMU_H
+#define __ASM_PMU_H
+
+#define ARMV8_MAX_COUNTERS      32
+#define ARMV8_COUNTER_MASK      (ARMV8_MAX_COUNTERS - 1)
+
+/*
+ * Per-CPU PMCR: config reg
+ */
+#define ARMV8_PMCR_E		(1 << 0) /* Enable all counters */
+#define ARMV8_PMCR_P		(1 << 1) /* Reset all counters */
+#define ARMV8_PMCR_C		(1 << 2) /* Cycle counter reset */
+#define ARMV8_PMCR_D		(1 << 3) /* CCNT counts every 64th cpu cycle */
+#define ARMV8_PMCR_X		(1 << 4) /* Export to ETM */
+#define ARMV8_PMCR_DP		(1 << 5) /* Disable CCNT if non-invasive debug*/
+#define	ARMV8_PMCR_N_SHIFT	11	 /* Number of counters supported */
+#define	ARMV8_PMCR_N_MASK	0x1f
+#define	ARMV8_PMCR_MASK		0x3f	 /* Mask for writable bits */
+
+/*
+ * PMCNTEN: counters enable reg
+ */
+#define	ARMV8_CNTEN_MASK	0xffffffff	/* Mask for writable bits */
+
+/*
+ * PMINTEN: counters interrupt enable reg
+ */
+#define	ARMV8_INTEN_MASK	0xffffffff	/* Mask for writable bits */
+
+/*
+ * PMOVSR: counters overflow flag status reg
+ */
+#define	ARMV8_OVSR_MASK		0xffffffff	/* Mask for writable bits */
+#define	ARMV8_OVERFLOWED_MASK	ARMV8_OVSR_MASK
+
+/*
+ * PMXEVTYPER: Event selection reg
+ */
+#define	ARMV8_EVTYPE_MASK	0xc80003ff	/* Mask for writable bits */
+#define	ARMV8_EVTYPE_EVENT	0x3ff		/* Mask for EVENT bits */
+
+/*
+ * Event filters for PMUv3
+ */
+#define	ARMV8_EXCLUDE_EL1	(1 << 31)
+#define	ARMV8_EXCLUDE_EL0	(1 << 30)
+#define	ARMV8_INCLUDE_EL2	(1 << 27)
+
+#endif /* __ASM_PMU_H */
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 5b1897e..7eca5dc 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
+#include <asm/pmu.h>
 
 /*
  * ARMv8 PMUv3 Performance Events handling code.
@@ -187,9 +188,6 @@ static const unsigned armv8_a57_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 #define	ARMV8_IDX_COUNTER_LAST(cpu_pmu) \
 	(ARMV8_IDX_CYCLE_COUNTER + cpu_pmu->num_events - 1)
 
-#define	ARMV8_MAX_COUNTERS	32
-#define	ARMV8_COUNTER_MASK	(ARMV8_MAX_COUNTERS - 1)
-
 /*
  * ARMv8 low level PMU access
  */
@@ -200,38 +198,6 @@ static const unsigned armv8_a57_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 #define	ARMV8_IDX_TO_COUNTER(x)	\
 	(((x) - ARMV8_IDX_COUNTER0) & ARMV8_COUNTER_MASK)
 
-/*
- * Per-CPU PMCR: config reg
- */
-#define ARMV8_PMCR_E		(1 << 0) /* Enable all counters */
-#define ARMV8_PMCR_P		(1 << 1) /* Reset all counters */
-#define ARMV8_PMCR_C		(1 << 2) /* Cycle counter reset */
-#define ARMV8_PMCR_D		(1 << 3) /* CCNT counts every 64th cpu cycle */
-#define ARMV8_PMCR_X		(1 << 4) /* Export to ETM */
-#define ARMV8_PMCR_DP		(1 << 5) /* Disable CCNT if non-invasive debug*/
-#define	ARMV8_PMCR_N_SHIFT	11	 /* Number of counters supported */
-#define	ARMV8_PMCR_N_MASK	0x1f
-#define	ARMV8_PMCR_MASK		0x3f	 /* Mask for writable bits */
-
-/*
- * PMOVSR: counters overflow flag status reg
- */
-#define	ARMV8_OVSR_MASK		0xffffffff	/* Mask for writable bits */
-#define	ARMV8_OVERFLOWED_MASK	ARMV8_OVSR_MASK
-
-/*
- * PMXEVTYPER: Event selection reg
- */
-#define	ARMV8_EVTYPE_MASK	0xc80003ff	/* Mask for writable bits */
-#define	ARMV8_EVTYPE_EVENT	0x3ff		/* Mask for EVENT bits */
-
-/*
- * Event filters for PMUv3
- */
-#define	ARMV8_EXCLUDE_EL1	(1 << 31)
-#define	ARMV8_EXCLUDE_EL0	(1 << 30)
-#define	ARMV8_INCLUDE_EL2	(1 << 27)
-
 static inline u32 armv8pmu_pmcr_read(void)
 {
 	u32 val;
-- 
2.0.4
