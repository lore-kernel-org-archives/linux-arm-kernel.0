From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Apr 2013 10:12:37 +0100
Subject: [RFC PATCH 06/11] arm: perf: dynamically allocate cpu hardware data
In-Reply-To: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
References: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1365671562-2403-7-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To support multiple PMUs, each PMU will need its own accounting data.
As we don't know how (in general) many PMUs we'll have to support at
compile-time, we must allocate the data at runtime dynamically

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_cpu.c | 73 ++++++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 22 deletions(-)

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 80f1a26..ae5be75 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -33,9 +33,25 @@
 /* Set at runtime when we know what CPU type we are. */
 static struct arm_pmu *cpu_pmu;
 
-static DEFINE_PER_CPU(struct perf_event * [ARMPMU_MAX_HWEVENTS], hw_events);
-static DEFINE_PER_CPU(unsigned long [BITS_TO_LONGS(ARMPMU_MAX_HWEVENTS)], used_mask);
-static DEFINE_PER_CPU(struct pmu_hw_events, cpu_hw_events);
+/*
+ * All of the dynamically sized pmu_hw data for the number of events supported
+ * by CPU PMUs, aggregated together for easier allocation / freeing.
+ */
+struct cpu_pmu_hw {
+	struct pmu_hw_events cpu_hw_events;
+	struct perf_event *hw_events[ARMPMU_MAX_HWEVENTS];
+	unsigned long used_mask[BITS_TO_LONGS(ARMPMU_MAX_HWEVENTS)];
+};
+
+/*
+ * For mapping between an arm_pmu for a CPU and its CPU-affine data.
+ */
+struct cpu_pmu {
+	struct arm_pmu armpmu;
+	struct cpu_pmu_hw __percpu *cpu_hw;
+};
+
+#define to_cpu_pmu(p) (container_of(p, struct cpu_pmu, armpmu))
 
 /*
  * Despite the names, these two functions are CPU-specific and are used
@@ -68,7 +84,9 @@ EXPORT_SYMBOL_GPL(perf_num_counters);
 
 static struct pmu_hw_events *cpu_pmu_get_cpu_events(struct arm_pmu *pmu)
 {
-	return &__get_cpu_var(cpu_hw_events);
+	struct cpu_pmu *cpu_pmu = to_cpu_pmu(pmu);
+	struct cpu_pmu_hw *hw = this_cpu_ptr(cpu_pmu->cpu_hw);
+	return &hw->cpu_hw_events;
 }
 
 static void cpu_pmu_free_irq(struct arm_pmu *cpu_pmu)
@@ -132,23 +150,25 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 	return 0;
 }
 
-static void cpu_pmu_init(struct arm_pmu *cpu_pmu)
+static void cpu_pmu_init(struct cpu_pmu *cpu_pmu)
 {
 	int cpu;
+	struct arm_pmu *arm_pmu = &cpu_pmu->armpmu;
+
 	for_each_possible_cpu(cpu) {
-		struct pmu_hw_events *events = &per_cpu(cpu_hw_events, cpu);
-		events->events = per_cpu(hw_events, cpu);
-		events->used_mask = per_cpu(used_mask, cpu);
-		raw_spin_lock_init(&events->pmu_lock);
+		struct cpu_pmu_hw *cpu_hw = per_cpu_ptr(cpu_pmu->cpu_hw, cpu);
+		cpu_hw->cpu_hw_events.events = cpu_hw->hw_events;
+		cpu_hw->cpu_hw_events.used_mask = cpu_hw->used_mask;
+		raw_spin_lock_init(&cpu_hw->cpu_hw_events.pmu_lock);
 	}
 
-	cpu_pmu->get_hw_events	= cpu_pmu_get_cpu_events;
-	cpu_pmu->request_irq	= cpu_pmu_request_irq;
-	cpu_pmu->free_irq	= cpu_pmu_free_irq;
+	arm_pmu->get_hw_events	= cpu_pmu_get_cpu_events;
+	arm_pmu->request_irq	= cpu_pmu_request_irq;
+	arm_pmu->free_irq	= cpu_pmu_free_irq;
 
 	/* Ensure the PMU has sane values out of reset. */
-	if (cpu_pmu->reset)
-		on_each_cpu(cpu_pmu->reset, cpu_pmu, 1);
+	if (arm_pmu->reset)
+		on_each_cpu(arm_pmu->reset, arm_pmu, 1);
 }
 
 /*
@@ -255,7 +275,7 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id;
 	int (*init_fn)(struct arm_pmu *);
 	struct device_node *node = pdev->dev.of_node;
-	struct arm_pmu *pmu;
+	struct cpu_pmu *pmu;
 	int ret = -ENODEV;
 
 	if (cpu_pmu) {
@@ -263,34 +283,43 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
 		return -ENOSPC;
 	}
 
-	pmu = kzalloc(sizeof(struct arm_pmu), GFP_KERNEL);
+	pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
 	if (!pmu) {
 		pr_info("failed to allocate PMU device!");
 		return -ENOMEM;
 	}
 
+	pmu->cpu_hw = alloc_percpu(struct cpu_pmu_hw);
+	if (!pmu->cpu_hw) {
+		pr_info("failed to allocate PMU hw data!\n");
+		ret = -ENOMEM;
+		goto out_pmu;
+	}
+
 	if (node && (of_id = of_match_node(cpu_pmu_of_device_ids, pdev->dev.of_node))) {
 		init_fn = of_id->data;
-		ret = init_fn(pmu);
+		ret = init_fn(&pmu->armpmu);
 	} else {
-		ret = probe_current_pmu(pmu);
+		ret = probe_current_pmu(&pmu->armpmu);
 	}
 
 	if (ret) {
 		pr_info("failed to probe PMU!");
-		goto out_free;
+		goto out_hw;
 	}
 
-	cpu_pmu = pmu;
+	cpu_pmu = &pmu->armpmu;
 	cpu_pmu->plat_device = pdev;
-	cpu_pmu_init(cpu_pmu);
+	cpu_pmu_init(pmu);
 	ret = armpmu_register(cpu_pmu, -1);
 
 	if (!ret)
 		return 0;
 
-out_free:
+out_hw:
+	free_percpu(pmu->cpu_hw);
 	pr_info("failed to register PMU devices!");
+out_pmu:
 	kfree(pmu);
 	return ret;
 }
-- 
1.8.1.1
