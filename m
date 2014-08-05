From: anup.patel@linaro.org (Anup Patel)
Date: Tue,  5 Aug 2014 14:54:10 +0530
Subject: [RFC PATCH 1/6] ARM64: Move PMU register related defines to asm/pmu.h
In-Reply-To: <1407230655-28864-1-git-send-email-anup.patel@linaro.org>
References: <1407230655-28864-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1407230655-28864-2-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To use the ARMv8 PMU related register defines from the KVM code,
we move the relevant definitions to asm/pmu.h include file.

We also add #ifndef __ASSEMBLY__ in order to use asm/pmu.h from
assembly code.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm64/include/asm/pmu.h   |   44 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/perf_event.c |   32 -----------------------------
 2 files changed, 44 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/include/asm/pmu.h b/arch/arm64/include/asm/pmu.h
index e6f0878..f49cc72 100644
--- a/arch/arm64/include/asm/pmu.h
+++ b/arch/arm64/include/asm/pmu.h
@@ -19,6 +19,49 @@
 #ifndef __ASM_PMU_H
 #define __ASM_PMU_H
 
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
+#ifndef __ASSEMBLY__
 #ifdef CONFIG_HW_PERF_EVENTS
 
 /* The events for a given PMU register set. */
@@ -79,4 +122,5 @@ int armpmu_event_set_period(struct perf_event *event,
 			    int idx);
 
 #endif /* CONFIG_HW_PERF_EVENTS */
+#endif /* __ASSEMBLY__ */
 #endif /* __ASM_PMU_H */
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index baf5afb..47dfb8b 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -810,38 +810,6 @@ static const unsigned armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
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
1.7.9.5
