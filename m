From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Apr 2013 10:12:38 +0100
Subject: [RFC PATCH 07/11] arm: perf: treat PMUs as CPU affine
In-Reply-To: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
References: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1365671562-2403-8-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In multi-cluster systems, the PMUs can be different across clusters, and
so our logical PMU may not be able to schedule events on all CPUs.

This patch adds a cpumask to encode which CPUs a PMU driver supports
controlling events for, and limits the driver to scheduling events on
those CPUs. Currently the cpumask is set to match all CPUs.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pmu.h       |  1 +
 arch/arm/kernel/perf_event.c     | 20 ++++++++++++++++++++
 arch/arm/kernel/perf_event_cpu.c | 10 +++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 56724b2..4688692 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -65,6 +65,7 @@ struct pmu_hw_events {
 struct arm_pmu {
 	struct pmu	pmu;
 	cpumask_t	active_irqs;
+	cpumask_t	supported_cpus;
 	char		*name;
 	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
 	void		(*enable)(struct perf_event *event);
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 5bcd8ac..ebcd123 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -12,6 +12,7 @@
  */
 #define pr_fmt(fmt) "hw perfevents: " fmt
 
+#include <linux/cpumask.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -21,6 +22,11 @@
 #include <asm/pmu.h>
 #include <asm/stacktrace.h>
 
+static bool cpu_supported(struct arm_pmu *armpmu, int cpu)
+{
+	return cpumask_test_cpu(cpu, &armpmu->supported_cpus);
+}
+
 static int
 armpmu_map_cache_event(const unsigned (*cache_map)
 				      [PERF_COUNT_HW_CACHE_MAX]
@@ -221,6 +227,10 @@ armpmu_add(struct perf_event *event, int flags)
 	int idx;
 	int err = 0;
 
+	/* An event following a process won't be stopped earlier */
+	if (!cpu_supported(armpmu, smp_processor_id()))
+		return -ENOENT;
+
 	perf_pmu_disable(event->pmu);
 
 	/* If we don't have a space for the counter then finish early. */
@@ -417,6 +427,16 @@ static int armpmu_event_init(struct perf_event *event)
 	int err = 0;
 	atomic_t *active_events = &armpmu->active_events;
 
+	/*
+	 * Reject CPU-affine events for CPUs that are of a different class to
+	 * that which this PMU handles. Process-following events (where
+	 * event->cpu == -1) can be migrated between CPUs, and thus we have to
+	 * reject them later (in armpmu_add) if they're scheduled on a
+	 * different class of CPU.
+	 */
+	if (event->cpu != -1 && !cpu_supported(armpmu, event->cpu))
+		return -ENOENT;
+
 	/* does not support taken branch sampling */
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index ae5be75..c1a9880c 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -168,7 +168,8 @@ static void cpu_pmu_init(struct cpu_pmu *cpu_pmu)
 
 	/* Ensure the PMU has sane values out of reset. */
 	if (arm_pmu->reset)
-		on_each_cpu(arm_pmu->reset, arm_pmu, 1);
+		on_each_cpu_mask(&arm_pmu->supported_cpus, arm_pmu->reset,
+				 arm_pmu, 1);
 }
 
 /*
@@ -180,9 +181,13 @@ static void cpu_pmu_init(struct cpu_pmu *cpu_pmu)
 static int __cpuinit cpu_pmu_notify(struct notifier_block *b,
 				    unsigned long action, void *hcpu)
 {
+	int cpu = (long)hcpu;
 	if ((action & ~CPU_TASKS_FROZEN) != CPU_STARTING)
 		return NOTIFY_DONE;
 
+	if (!cpumask_test_cpu(cpu, &cpu_pmu->supported_cpus))
+		return NOTIFY_DONE;
+
 	if (cpu_pmu && cpu_pmu->reset)
 		cpu_pmu->reset(cpu_pmu);
 	else
@@ -296,6 +301,9 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
 		goto out_pmu;
 	}
 
+	/* Assume by default that we're on a homogeneous system */
+	cpumask_setall(&pmu->armpmu.supported_cpus);
+
 	if (node && (of_id = of_match_node(cpu_pmu_of_device_ids, pdev->dev.of_node))) {
 		init_fn = of_id->data;
 		ret = init_fn(&pmu->armpmu);
-- 
1.8.1.1
