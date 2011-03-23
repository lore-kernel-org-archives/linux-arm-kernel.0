From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Mar 2011 15:46:44 +0000
Subject: [PATCH v2] ARM: perf: reset counters on all CPUs during initialisation
Message-ID: <1300895204-10544-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv7 dictates that the interrupt-enable and count-enable registers for
each PMU counter are UNKNOWN following core reset.

This patch adds a new (optional) function pointer to struct arm_pmu for
resetting the PMU state during init. The reset function is called on
each CPU via an arch_initcall in the generic ARM perf_event code and
allows the PMU backend to write sane values to any UNKNOWN registers.

Cc: Jean Pihet <jean.pihet@ti.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Hi Jean, here's the updated patch following the discussion on the list.

Please let me know what you think.

Will

 arch/arm/kernel/perf_event.c    |   14 ++++++++++++++
 arch/arm/kernel/perf_event_v7.c |   22 ++++++++++++++++------
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 53f6068..b23a364 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -79,6 +79,7 @@ struct arm_pmu {
 	void		(*write_counter)(int idx, u32 val);
 	void		(*start)(void);
 	void		(*stop)(void);
+	void		(*reset)(void *);
 	const unsigned	(*cache_map)[PERF_COUNT_HW_CACHE_MAX]
 				    [PERF_COUNT_HW_CACHE_OP_MAX]
 				    [PERF_COUNT_HW_CACHE_RESULT_MAX];
@@ -612,6 +613,19 @@ static struct pmu pmu = {
 #include "perf_event_v6.c"
 #include "perf_event_v7.c"
 
+/*
+ * Ensure the PMU has sane values out of reset.
+ * This requires SMP to be available, so exists as a separate initcall.
+ */
+static int __init
+armpmu_reset(void)
+{
+	if (armpmu && armpmu->reset)
+		return on_each_cpu(armpmu->reset, NULL, 1);
+	return 0;
+}
+arch_initcall(armpmu_reset);
+
 static int __init
 init_hw_perf_events(void)
 {
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 2aa83c2..4960686 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -849,6 +849,18 @@ static int armv7pmu_get_event_idx(struct cpu_hw_events *cpuc,
 	}
 }
 
+static void armv7pmu_reset(void *info)
+{
+	u32 idx, nb_cnt = armpmu->num_events;
+
+	/* The counter and interrupt enable registers are unknown at reset. */
+	for (idx = 1; idx < nb_cnt; ++idx)
+		armv7pmu_disable_event(NULL, idx);
+
+	/* Initialize & Reset PMNC: C and P bits */
+	armv7_pmnc_write(ARMV7_PMNC_P | ARMV7_PMNC_C);
+}
+
 static struct arm_pmu armv7pmu = {
 	.handle_irq		= armv7pmu_handle_irq,
 	.enable			= armv7pmu_enable_event,
@@ -858,17 +870,15 @@ static struct arm_pmu armv7pmu = {
 	.get_event_idx		= armv7pmu_get_event_idx,
 	.start			= armv7pmu_start,
 	.stop			= armv7pmu_stop,
+	.reset			= armv7pmu_reset,
 	.raw_event_mask		= 0xFF,
 	.max_period		= (1LLU << 32) - 1,
 };
 
-static u32 __init armv7_reset_read_pmnc(void)
+static u32 __init armv7_read_num_pmnc_events(void)
 {
 	u32 nb_cnt;
 
-	/* Initialize & Reset PMNC: C and P bits */
-	armv7_pmnc_write(ARMV7_PMNC_P | ARMV7_PMNC_C);
-
 	/* Read the nb of CNTx counters supported from PMNC */
 	nb_cnt = (armv7_pmnc_read() >> ARMV7_PMNC_N_SHIFT) & ARMV7_PMNC_N_MASK;
 
@@ -882,7 +892,7 @@ static const struct arm_pmu *__init armv7_a8_pmu_init(void)
 	armv7pmu.name		= "ARMv7 Cortex-A8";
 	armv7pmu.cache_map	= &armv7_a8_perf_cache_map;
 	armv7pmu.event_map	= &armv7_a8_perf_map;
-	armv7pmu.num_events	= armv7_reset_read_pmnc();
+	armv7pmu.num_events	= armv7_read_num_pmnc_events();
 	return &armv7pmu;
 }
 
@@ -892,7 +902,7 @@ static const struct arm_pmu *__init armv7_a9_pmu_init(void)
 	armv7pmu.name		= "ARMv7 Cortex-A9";
 	armv7pmu.cache_map	= &armv7_a9_perf_cache_map;
 	armv7pmu.event_map	= &armv7_a9_perf_map;
-	armv7pmu.num_events	= armv7_reset_read_pmnc();
+	armv7pmu.num_events	= armv7_read_num_pmnc_events();
 	return &armv7pmu;
 }
 #else
-- 
1.7.0.4
