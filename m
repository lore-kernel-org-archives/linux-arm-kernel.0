From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 10 Mar 2017 11:04:45 +0000
Subject: [PATCH 08/14] drivers/perf: arm_pmu: split cpu-local irq request/free
In-Reply-To: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1489143891-11596-9-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we have functions to request/free all IRQs for a given PMU.
While this works today, this won't work for ACPI, where we don't know
the full set of IRQs up front, and need to request them separately.

To enable supporting ACPI, this patch splits out the cpu-local
request/free into new functions, allowing us to request/free individual
IRQs.

As this makes it possible/necessary to request a PPI once per cpu, an
additional check is added to detect mismatched PPIs. This shouldn't
matter for the DT / platform case, as we check this when parsing.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c | 88 +++++++++++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 36 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index a39cf55..5e5ea12 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -527,65 +527,81 @@ int perf_num_counters(void)
 }
 EXPORT_SYMBOL_GPL(perf_num_counters);
 
-static void armpmu_free_irqs(struct arm_pmu *armpmu)
+static void armpmu_free_irq(struct arm_pmu *armpmu, int cpu)
 {
-	int cpu;
 	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
+	int irq = per_cpu(hw_events->irq, cpu);
 
-	for_each_cpu(cpu, &armpmu->supported_cpus) {
-		int irq = per_cpu(hw_events->irq, cpu);
-		if (!irq)
-			continue;
+	if (!cpumask_test_and_clear_cpu(cpu, &armpmu->active_irqs))
+		return;
 
-		if (irq_is_percpu(irq)) {
-			free_percpu_irq(irq, &hw_events->percpu_pmu);
-			break;
-		}
+	if (irq_is_percpu(irq)) {
+		free_percpu_irq(irq, &hw_events->percpu_pmu);
+		cpumask_clear(&armpmu->active_irqs);
+		return;
+	}
 
-		if (!cpumask_test_and_clear_cpu(cpu, &armpmu->active_irqs))
-			continue;
+	free_irq(irq, per_cpu_ptr(&hw_events->percpu_pmu, cpu));
+}
 
-		free_irq(irq, per_cpu_ptr(&hw_events->percpu_pmu, cpu));
-	}
+static void armpmu_free_irqs(struct arm_pmu *armpmu)
+{
+	int cpu;
+
+	for_each_cpu(cpu, &armpmu->supported_cpus)
+		armpmu_free_irq(armpmu, cpu);
 }
 
-static int armpmu_request_irqs(struct arm_pmu *armpmu)
+static int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
 {
-	int cpu, err;
+	int err = 0;
 	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
 	const irq_handler_t handler = armpmu_dispatch_irq;
+	int irq = per_cpu(hw_events->irq, cpu);
+	if (!irq)
+		return 0;
 
-	for_each_cpu(cpu, &armpmu->supported_cpus) {
-		int irq = per_cpu(hw_events->irq, cpu);
-		if (!irq)
-			continue;
+	if (irq_is_percpu(irq) && cpumask_empty(&armpmu->active_irqs)) {
+		err = request_percpu_irq(irq, handler, "arm-pmu",
+					 &hw_events->percpu_pmu);
+	} else if (irq_is_percpu(irq)) {
+		int other_cpu = cpumask_first(&armpmu->active_irqs);
+		int other_irq = per_cpu(hw_events->irq, other_cpu);
 
-		if (irq_is_percpu(irq)) {
-			err = request_percpu_irq(irq, handler, "arm-pmu",
-						 &hw_events->percpu_pmu);
-			if (err) {
-				pr_err("unable to request IRQ%d for ARM PMU counters\n",
-					irq);
-			}
-
-			return err;
+		if (irq != other_irq) {
+			pr_warn("mismatched PPIs detected.\n");
+			err = -EINVAL;
 		}
-
+	} else {
 		err = request_irq(irq, handler,
 				  IRQF_NOBALANCING | IRQF_NO_THREAD, "arm-pmu",
 				  per_cpu_ptr(&hw_events->percpu_pmu, cpu));
-		if (err) {
-			pr_err("unable to request IRQ%d for ARM PMU counters\n",
-				irq);
-			return err;
-		}
+	}
 
-		cpumask_set_cpu(cpu, &armpmu->active_irqs);
+	if (err) {
+		pr_err("unable to request IRQ%d for ARM PMU counters\n",
+			irq);
+		return err;
 	}
 
+	cpumask_set_cpu(cpu, &armpmu->active_irqs);
+
 	return 0;
 }
 
+static int armpmu_request_irqs(struct arm_pmu *armpmu)
+{
+	int cpu, err;
+
+	for_each_cpu(cpu, &armpmu->supported_cpus) {
+		err = armpmu_request_irq(armpmu, cpu);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
 int armpmu_get_cpu_irq(struct arm_pmu *pmu, int cpu)
 {
 	struct pmu_hw_events __percpu *hw_events = pmu->hw_events;
-- 
1.9.1
