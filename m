From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Mar 2011 15:38:17 +0000
Subject: [PATCH 1/2] ARM: perf: reset counters on all CPUs during
	initialisation
Message-ID: <1300289898-2720-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv7 dictates that the interrupt-enable and count-enable registers for
each PMU counter are UNKNOWN following core reset.

This patch adds an arch_initcall to the ARMv7 perf events backend which
disables the counters on each CPU prior to setting the Enable bit in the
PMCR.

Cc: Jean Pihet <jean.pihet@newoldbits.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_v7.c |   27 +++++++++++++++++++++++----
 1 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 2e14025..3f42473 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -860,12 +860,31 @@ static struct arm_pmu armv7pmu = {
 	.max_period		= (1LLU << 32) - 1,
 };
 
-static u32 __init armv7_reset_read_pmnc(void)
+static void armv7_reset_pmnc(void *info)
 {
-	u32 nb_cnt;
+	u32 idx, nb_cnt = armv7pmu.num_events;
+
+	/* The counter and interrupt enable registers are unknown@reset. */
+	for (idx = 1; idx < nb_cnt; ++idx)
+		armv7pmu_disable_event(NULL, idx);
 
 	/* Initialize & Reset PMNC: C and P bits */
 	armv7_pmnc_write(ARMV7_PMNC_P | ARMV7_PMNC_C);
+}
+
+static int __init armv7_pmnc_init(void)
+{
+	/*
+	 * Reset the counter status on each CPU so that we don't receive
+	 * spurious interrupts when we set the E bit.
+	 */
+	return on_each_cpu(armv7_reset_pmnc, NULL, 1);
+}
+arch_initcall(armv7_pmnc_init);
+
+static u32 __init armv7_read_num_pmnc_events(void)
+{
+	u32 nb_cnt;
 
 	/* Read the nb of CNTx counters supported from PMNC */
 	nb_cnt = (armv7_pmnc_read() >> ARMV7_PMNC_N_SHIFT) & ARMV7_PMNC_N_MASK;
@@ -880,7 +899,7 @@ static const struct arm_pmu *__init armv7_a8_pmu_init(void)
 	armv7pmu.name		= "ARMv7 Cortex-A8";
 	armv7pmu.cache_map	= &armv7_a8_perf_cache_map;
 	armv7pmu.event_map	= &armv7_a8_perf_map;
-	armv7pmu.num_events	= armv7_reset_read_pmnc();
+	armv7pmu.num_events	= armv7_read_num_pmnc_events();
 	return &armv7pmu;
 }
 
@@ -890,7 +909,7 @@ static const struct arm_pmu *__init armv7_a9_pmu_init(void)
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
