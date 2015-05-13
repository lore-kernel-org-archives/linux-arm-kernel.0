From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 13 May 2015 17:12:25 +0100
Subject: [PATCH 3/7] arm: perf: treat PMUs as CPU affine
In-Reply-To: <1431533549-27715-1-git-send-email-mark.rutland@arm.com>
References: <1431533549-27715-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1431533549-27715-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In multi-cluster systems, the PMUs can be different across clusters, and
so our logical PMU may not be able to schedule events on all CPUs.

This patch adds a cpumask to encode which CPUs a PMU driver supports
controlling events for, and limits the driver to scheduling events on
those CPUs, and enabling and disabling the physical PMUs on those CPUs.
The cpumask is built based on the interrupt-affinity property, and in
the absence of such a property a homogenous system is assumed.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pmu.h       |  1 +
 arch/arm/kernel/perf_event.c     | 25 +++++++++++++++++++++++++
 arch/arm/kernel/perf_event_cpu.c | 15 ++++++++++++---
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 675e4ab..ecad26e 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -92,6 +92,7 @@ struct pmu_hw_events {
 struct arm_pmu {
 	struct pmu	pmu;
 	cpumask_t	active_irqs;
+	cpumask_t	supported_cpus;
 	int		*irq_affinity;
 	char		*name;
 	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 4a86a01..9b536be 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -11,6 +11,7 @@
  */
 #define pr_fmt(fmt) "hw perfevents: " fmt
 
+#include <linux/cpumask.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -229,6 +230,10 @@ armpmu_add(struct perf_event *event, int flags)
 	int idx;
 	int err = 0;
 
+	/* An event following a process won't be stopped earlier */
+	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
+		return -ENOENT;
+
 	perf_pmu_disable(event->pmu);
 
 	/* If we don't have a space for the counter then finish early. */
@@ -454,6 +459,17 @@ static int armpmu_event_init(struct perf_event *event)
 	int err = 0;
 	atomic_t *active_events = &armpmu->active_events;
 
+	/*
+	 * Reject CPU-affine events for CPUs that are of a different class to
+	 * that which this PMU handles. Process-following events (where
+	 * event->cpu == -1) can be migrated between CPUs, and thus we have to
+	 * reject them later (in armpmu_add) if they're scheduled on a
+	 * different class of CPU.
+	 */
+	if (event->cpu != -1 &&
+		!cpumask_test_cpu(event->cpu, &armpmu->supported_cpus))
+		return -ENOENT;
+
 	/* does not support taken branch sampling */
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
@@ -489,6 +505,10 @@ static void armpmu_enable(struct pmu *pmu)
 	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
 	int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
 
+	/* For task-bound events we may be called on other CPUs */
+	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
+		return;
+
 	if (enabled)
 		armpmu->start(armpmu);
 }
@@ -496,6 +516,11 @@ static void armpmu_enable(struct pmu *pmu)
 static void armpmu_disable(struct pmu *pmu)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(pmu);
+
+	/* For task-bound events we may be called on other CPUs */
+	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
+		return;
+
 	armpmu->stop(armpmu);
 }
 
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 2a9003e..9602d31 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -179,11 +179,15 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 static int cpu_pmu_notify(struct notifier_block *b, unsigned long action,
 			  void *hcpu)
 {
+	int cpu = (unsigned long)hcpu;
 	struct arm_pmu *pmu = container_of(b, struct arm_pmu, hotplug_nb);
 
 	if ((action & ~CPU_TASKS_FROZEN) != CPU_STARTING)
 		return NOTIFY_DONE;
 
+	if (!cpumask_test_cpu(cpu, &pmu->supported_cpus))
+		return NOTIFY_DONE;
+
 	if (pmu->reset)
 		pmu->reset(pmu);
 	else
@@ -219,7 +223,8 @@ static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
 
 	/* Ensure the PMU has sane values out of reset. */
 	if (cpu_pmu->reset)
-		on_each_cpu(cpu_pmu->reset, cpu_pmu, 1);
+		on_each_cpu_mask(&cpu_pmu->supported_cpus, cpu_pmu->reset,
+			 cpu_pmu, 1);
 
 	/* If no interrupts available, set the corresponding capability flag */
 	if (!platform_get_irq(cpu_pmu->plat_device, 0))
@@ -334,12 +339,15 @@ static int of_pmu_irq_cfg(struct arm_pmu *pmu)
 		}
 
 		irqs[i] = cpu;
+		cpumask_set_cpu(cpu, &pmu->supported_cpus);
 	}
 
-	if (i == pdev->num_resources)
+	if (i == pdev->num_resources) {
 		pmu->irq_affinity = irqs;
-	else
+	} else {
 		kfree(irqs);
+		cpumask_setall(&pmu->supported_cpus);
+	}
 
 	return 0;
 }
@@ -374,6 +382,7 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
 			ret = init_fn(pmu);
 	} else {
 		ret = probe_current_pmu(pmu);
+		cpumask_setall(&pmu->supported_cpus);
 	}
 
 	if (ret) {
-- 
1.9.1
