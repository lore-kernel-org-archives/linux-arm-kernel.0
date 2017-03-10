From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 10 Mar 2017 11:04:44 +0000
Subject: [PATCH 07/14] drivers/perf: arm_pmu: rename irq request/free functions
In-Reply-To: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1489143891-11596-8-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For historical reasons, portions of the arm_pmu code use a cpu_pmu_
prefix rather than an armpmu_ prefix. While a minor annoyance, this
hasn't been a problem thusfar.

However, to enable ACPI support, we'll need to expose a few things in
header files, and we should aim to keep those consistently namespaced.
In preparation for exporting our IRQ request/free functions, rename
these to have an armpmu_ prefix. For consistency, the 'cpu_pmu'
parameter is also renamed to 'armpmu'.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 02fc70e..a39cf55 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -527,12 +527,12 @@ int perf_num_counters(void)
 }
 EXPORT_SYMBOL_GPL(perf_num_counters);
 
-static void cpu_pmu_free_irqs(struct arm_pmu *cpu_pmu)
+static void armpmu_free_irqs(struct arm_pmu *armpmu)
 {
 	int cpu;
-	struct pmu_hw_events __percpu *hw_events = cpu_pmu->hw_events;
+	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
 
-	for_each_cpu(cpu, &cpu_pmu->supported_cpus) {
+	for_each_cpu(cpu, &armpmu->supported_cpus) {
 		int irq = per_cpu(hw_events->irq, cpu);
 		if (!irq)
 			continue;
@@ -542,20 +542,20 @@ static void cpu_pmu_free_irqs(struct arm_pmu *cpu_pmu)
 			break;
 		}
 
-		if (!cpumask_test_and_clear_cpu(cpu, &cpu_pmu->active_irqs))
+		if (!cpumask_test_and_clear_cpu(cpu, &armpmu->active_irqs))
 			continue;
 
 		free_irq(irq, per_cpu_ptr(&hw_events->percpu_pmu, cpu));
 	}
 }
 
-static int cpu_pmu_request_irqs(struct arm_pmu *cpu_pmu)
+static int armpmu_request_irqs(struct arm_pmu *armpmu)
 {
 	int cpu, err;
-	struct pmu_hw_events __percpu *hw_events = cpu_pmu->hw_events;
+	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
 	const irq_handler_t handler = armpmu_dispatch_irq;
 
-	for_each_cpu(cpu, &cpu_pmu->supported_cpus) {
+	for_each_cpu(cpu, &armpmu->supported_cpus) {
 		int irq = per_cpu(hw_events->irq, cpu);
 		if (!irq)
 			continue;
@@ -580,7 +580,7 @@ static int cpu_pmu_request_irqs(struct arm_pmu *cpu_pmu)
 			return err;
 		}
 
-		cpumask_set_cpu(cpu, &cpu_pmu->active_irqs);
+		cpumask_set_cpu(cpu, &armpmu->active_irqs);
 	}
 
 	return 0;
@@ -742,7 +742,7 @@ static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	int err;
 
-	err = cpu_pmu_request_irqs(cpu_pmu);
+	err = armpmu_request_irqs(cpu_pmu);
 	if (err)
 		goto out;
 
@@ -761,7 +761,7 @@ static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
 	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_STARTING,
 					    &cpu_pmu->node);
 out:
-	cpu_pmu_free_irqs(cpu_pmu);
+	armpmu_free_irqs(cpu_pmu);
 	return err;
 }
 
-- 
1.9.1
