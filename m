From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  1 Nov 2017 14:12:38 +0000
Subject: [PATCH 4/5] arm_pmu: note IRQs/PMUs per-cpu
In-Reply-To: <20171101141239.45340-1-mark.rutland@arm.com>
References: <20171101141239.45340-1-mark.rutland@arm.com>
Message-ID: <20171101141239.45340-5-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current way we manage IRQs forces the ACPI PMU driver to request
IRQs in the cpu bringup path, which isn't safe due to implicit memory
allocations in the request_irq() path.

To solve that, we need to decouple requesting IRQs from PMU management,
requesting IRQs up-front, before we know the associated PMU. We will
separately (and perhaps later) associate each IRQ with its PMU.

This patch allows the IRQ handlers to be registered without a PMU dev
argument, using a percpu pointer instead.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c       | 93 ++++++++++++++++++++++++++++----------------
 include/linux/perf/arm_pmu.h |  3 +-
 2 files changed, 62 insertions(+), 34 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index e0242103d904..287b3edfb4cc 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -26,6 +26,9 @@
 
 #include <asm/irq_regs.h>
 
+static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
+static DEFINE_PER_CPU(int, cpu_irq);
+
 static int
 armpmu_map_cache_event(const unsigned (*cache_map)
 				      [PERF_COUNT_HW_CACHE_MAX]
@@ -334,13 +337,9 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 	int ret;
 	u64 start_clock, finish_clock;
 
-	/*
-	 * we request the IRQ with a (possibly percpu) struct arm_pmu**, but
-	 * the handlers expect a struct arm_pmu*. The percpu_irq framework will
-	 * do any necessary shifting, we just need to perform the first
-	 * dereference.
-	 */
-	armpmu = *(void **)dev;
+	armpmu = this_cpu_read(cpu_armpmu);
+	if (WARN_ON_ONCE(!armpmu))
+		return IRQ_NONE;
 
 	plat = armpmu_get_platdata(armpmu);
 
@@ -531,40 +530,56 @@ int perf_num_counters(void)
 }
 EXPORT_SYMBOL_GPL(perf_num_counters);
 
-void armpmu_free_irq(struct arm_pmu *armpmu, int cpu)
+int armpmu_count_irq_users(const int irq)
 {
-	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
-	int irq = per_cpu(hw_events->irq, cpu);
+	int cpu, count = 0;
+
+	for_each_possible_cpu(cpu) {
+		if (per_cpu(cpu_irq, cpu) == irq)
+			count++;
+	}
+
+	return count;
+}
 
-	if (!cpumask_test_and_clear_cpu(cpu, &armpmu->active_irqs))
+void __armpmu_free_irq(int irq, int cpu)
+{
+	if (per_cpu(cpu_irq, cpu) == 0)
+		return;
+	if (WARN_ON(irq != per_cpu(cpu_irq, cpu)))
 		return;
 
 	if (irq_is_percpu_devid(irq)) {
-		free_percpu_irq(irq, &hw_events->percpu_pmu);
-		cpumask_clear(&armpmu->active_irqs);
-		return;
+		if (armpmu_count_irq_users(irq) == 1)
+			free_percpu_irq(irq, &cpu_armpmu);
+	} else {
+		free_irq(irq, NULL);
 	}
 
-	free_irq(irq, per_cpu_ptr(&hw_events->percpu_pmu, cpu));
+	per_cpu(cpu_irq, cpu) = 0;
 }
 
-int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
+void armpmu_free_irq(struct arm_pmu *armpmu, int cpu)
 {
-	int err = 0;
 	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
-	const irq_handler_t handler = armpmu_dispatch_irq;
 	int irq = per_cpu(hw_events->irq, cpu);
+
+	__armpmu_free_irq(irq, cpu);
+	per_cpu(cpu_armpmu, cpu) = NULL;
+}
+
+int armpmu_request_irq_flags(int irq, unsigned long irq_flags, int cpu)
+{
+	int err = 0;
+	const irq_handler_t handler = armpmu_dispatch_irq;
 	if (!irq)
 		return 0;
 
 	if (irq_is_percpu_devid(irq)) {
-		if (cpumask_empty(&armpmu->active_irqs))
+		if (armpmu_count_irq_users(irq) == 0)
 			err = request_percpu_irq(irq, handler, "arm-pmu",
-						 &hw_events->percpu_pmu);
+						 &cpu_armpmu);
 	} else {
-		struct arm_pmu_platdata *platdata = armpmu_get_platdata(armpmu);
-		unsigned long irq_flags;
-
 		err = irq_force_affinity(irq, cpumask_of(cpu));
 
 		if (err && num_possible_cpus() > 1) {
@@ -573,22 +588,14 @@ int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
 			goto err_out;
 		}
 
-		if (platdata && platdata->irq_flags) {
-			irq_flags = platdata->irq_flags;
-		} else {
-			irq_flags = IRQF_PERCPU |
-				    IRQF_NOBALANCING |
-				    IRQF_NO_THREAD;
-		}
-
 		err = request_irq(irq, handler, irq_flags, "arm-pmu",
-				  per_cpu_ptr(&hw_events->percpu_pmu, cpu));
+				  NULL);
 	}
 
 	if (err)
 		goto err_out;
 
-	cpumask_set_cpu(cpu, &armpmu->active_irqs);
+	per_cpu(cpu_irq, cpu) = irq;
 	return 0;
 
 err_out:
@@ -596,6 +603,26 @@ int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
 	return err;
 }
 
+int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
+{
+	struct arm_pmu_platdata *platdata = armpmu_get_platdata(armpmu);
+	unsigned long irq_flags;
+	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
+	int irq = per_cpu(hw_events->irq, cpu);
+	if (!irq)
+		return 0;
+
+	if (platdata && platdata->irq_flags) {
+		irq_flags = platdata->irq_flags;
+	} else {
+		irq_flags = ARM_PMU_IRQ_FLAGS;
+	}
+
+	per_cpu(cpu_armpmu, cpu) = armpmu;
+
+	return armpmu_request_irq_flags(irq, irq_flags, cpu);
+}
+
 static int armpmu_get_cpu_irq(struct arm_pmu *pmu, int cpu)
 {
 	struct pmu_hw_events __percpu *hw_events = pmu->hw_events;
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 52e6d56a6a4e..2ce6db4e00b2 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -92,7 +92,6 @@ enum armpmu_attr_groups {
 
 struct arm_pmu {
 	struct pmu	pmu;
-	cpumask_t	active_irqs;
 	cpumask_t	supported_cpus;
 	char		*name;
 	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
@@ -179,6 +178,8 @@ int armpmu_register(struct arm_pmu *pmu);
 int armpmu_request_irq(struct arm_pmu *armpmu, int cpu);
 void armpmu_free_irq(struct arm_pmu *armpmu, int cpu);
 
+#define ARM_PMU_IRQ_FLAGS (IRQF_PERCPU | IRQF_NOBALANCING | IRQF_NO_THREAD)
+
 #define ARMV8_PMU_PDEV_NAME "armv8-pmu"
 
 #endif /* CONFIG_ARM_PMU */
-- 
2.11.0
