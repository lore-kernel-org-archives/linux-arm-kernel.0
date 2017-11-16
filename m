From: hejianet@gmail.com (Jia He)
Date: Thu, 16 Nov 2017 06:27:28 +0000
Subject: [PATCH] drivers/perf: arm_pmu: save/restore cpu cycle counter in
 cpu_pm_pmu_notify
Message-ID: <1510813648-45090-1-git-send-email-hejianet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometimes userspace need a high resolution cycle counter by reading
pmccntr_el0.

In commit da4e4f18afe0 ("drivers/perf: arm_pmu: implement CPU_PM
notifier"), it resets all the counters even when the pmcr_el0.E and
pmcntenset_el0.C are both 1 . That is incorrect.

We need to save the registers and counter before CPU_PM_ENTER and
restore them after CPU_PM_EXIT.

Fixes: da4e4f18afe0 ("drivers/perf: arm_pmu: implement CPU_PM notifier")
Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 drivers/perf/arm_pmu.c | 72 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 7bc5eee..cf55c91 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -26,6 +26,12 @@
 
 #include <asm/irq_regs.h>
 
+#ifdef CONFIG_CPU_PM
+DEFINE_PER_CPU(u32, saved_pmcr_el0);
+DEFINE_PER_CPU(u32, saved_pmcntenset_el0);
+DEFINE_PER_CPU(u64, saved_cycle_cnter);
+#endif
+
 static int
 armpmu_map_cache_event(const unsigned (*cache_map)
 				      [PERF_COUNT_HW_CACHE_MAX]
@@ -719,6 +725,15 @@ static void cpu_pm_pmu_setup(struct arm_pmu *armpmu, unsigned long cmd)
 	}
 }
 
+static int pmc_cycle_counter_enabled(void)
+{
+	if ((read_sysreg(pmcr_el0) & ARMV8_PMU_PMCR_E) &&
+				read_sysreg(pmcntenset_el0) & 1<<31)
+		return 1;
+
+	return 0;
+}
+
 static int cpu_pm_pmu_notify(struct notifier_block *b, unsigned long cmd,
 			     void *v)
 {
@@ -729,16 +744,53 @@ static int cpu_pm_pmu_notify(struct notifier_block *b, unsigned long cmd,
 	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
 		return NOTIFY_DONE;
 
-	/*
-	 * Always reset the PMU registers on power-up even if
-	 * there are no events running.
-	 */
-	if (cmd == CPU_PM_EXIT && armpmu->reset)
-		armpmu->reset(armpmu);
+	if (cmd == CPU_PM_EXIT) {
+		/*
+		 * Always reset the PMU registers on power-up even if
+		 * there are no events running.
+		 */
+		if (armpmu->reset)
+			armpmu->reset(armpmu);
+
+		/*
+		 * Restore the saved pmcr_el0 and pmcntenset_el0
+		 * if pmc cycle counter is enabled, restore the counter
+		 */
+		write_sysreg(get_cpu_var(saved_pmcr_el0), pmcr_el0);
+		write_sysreg(get_cpu_var(saved_pmcntenset_el0),
+				pmcntenset_el0);
+
+		if (pmc_cycle_counter_enabled()) {
+			write_sysreg(get_cpu_var(saved_cycle_cnter),
+					pmccntr_el0);
+			put_cpu_var(saved_cycle_cnter);
+		}
+		put_cpu_var(saved_pmcntenset_el0);
+		put_cpu_var(saved_pmcr_el0);
+	}
+
+	if (cmd == CPU_PM_ENTER) {
+		/* If currently pmc cycle counter is enabled,
+		 * save the counter to percpu section
+		 */
+		if (pmc_cycle_counter_enabled()) {
+			get_cpu_var(saved_cycle_cnter) = read_sysreg(
+							pmccntr_el0);
+			put_cpu_var(saved_cycle_cnter);
+		}
+
+		get_cpu_var(saved_pmcr_el0) = read_sysreg(pmcr_el0);
+
+		get_cpu_var(saved_pmcntenset_el0) = read_sysreg(
+							pmcntenset_el0);
+		put_cpu_var(saved_pmcntenset_el0);
+		put_cpu_var(saved_pmcr_el0);
+	}
 
 	if (!enabled)
 		return NOTIFY_OK;
 
+	/* if any hw_events is used */
 	switch (cmd) {
 	case CPU_PM_ENTER:
 		armpmu->stop(armpmu);
@@ -758,7 +810,15 @@ static int cpu_pm_pmu_notify(struct notifier_block *b, unsigned long cmd,
 
 static int cpu_pm_pmu_register(struct arm_pmu *cpu_pmu)
 {
+	int i;
 	cpu_pmu->cpu_pm_nb.notifier_call = cpu_pm_pmu_notify;
+
+	for_each_possible_cpu(i) {
+		per_cpu(saved_pmcr_el0, i) = 0;
+		per_cpu(saved_pmcntenset_el0, i) = 0;
+		per_cpu(saved_cycle_cnter, i) = 0;
+	}
+
 	return cpu_pm_register_notifier(&cpu_pmu->cpu_pm_nb);
 }
 
-- 
2.7.4
