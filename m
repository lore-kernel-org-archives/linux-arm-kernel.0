From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 27 Oct 2014 12:06:39 +0000
Subject: [PATCHv2 9/9] arm: perf: fold hotplug notifier into arm_pmu
In-Reply-To: <1414411599-1938-1-git-send-email-mark.rutland@arm.com>
References: <1414411599-1938-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1414411599-1938-10-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Handling multiple PMUs using a single hotplug notifier requires a list
of PMUs to be maintained, with synchronisation in the probe, remove, and
notify paths. This is error-prone and makes the code much harder to
maintain.

Instead of using a single notifier, we can dynamically allocate a
notifier block per-PMU. The end result is the same, but the list of PMUs
is implicit in the hotplug notifier list rather than within a perf-local
data structure, which makes the code far easier to handle.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm/include/asm/pmu.h       |  1 +
 arch/arm/kernel/perf_event_cpu.c | 69 ++++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index cc01498..b1596bd 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -116,6 +116,7 @@ struct arm_pmu {
 	u64		max_period;
 	struct platform_device	*plat_device;
 	struct pmu_hw_events	__percpu *hw_events;
+	struct notifier_block	hotplug_nb;
 };
 
 #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 6e550cf..4a70f94 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -160,8 +160,31 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 	return 0;
 }
 
+/*
+ * PMU hardware loses all context when a CPU goes offline.
+ * When a CPU is hotplugged back in, since some hardware registers are
+ * UNKNOWN at reset, the PMU must be explicitly reset to avoid reading
+ * junk values out of them.
+ */
+static int cpu_pmu_notify(struct notifier_block *b, unsigned long action,
+			  void *hcpu)
+{
+	struct arm_pmu *pmu = container_of(b, struct arm_pmu, hotplug_nb);
+
+	if ((action & ~CPU_TASKS_FROZEN) != CPU_STARTING)
+		return NOTIFY_DONE;
+
+	if (pmu->reset)
+		pmu->reset(pmu);
+	else
+		return NOTIFY_DONE;
+
+	return NOTIFY_OK;
+}
+
 static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
 {
+	int err;
 	int cpu;
 	struct pmu_hw_events __percpu *cpu_hw_events;
 
@@ -169,6 +192,11 @@ static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
 	if (!cpu_hw_events)
 		return -ENOMEM;
 
+	cpu_pmu->hotplug_nb.notifier_call = cpu_pmu_notify;
+	err = register_cpu_notifier(&cpu_pmu->hotplug_nb);
+	if (err)
+		goto out_hw_events;
+
 	for_each_possible_cpu(cpu) {
 		struct pmu_hw_events *events = per_cpu_ptr(cpu_hw_events, cpu);
 		raw_spin_lock_init(&events->pmu_lock);
@@ -188,38 +216,19 @@ static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
 		cpu_pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
 
 	return 0;
+
+out_hw_events:
+	free_percpu(cpu_hw_events);
+	return err;
 }
 
 static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
 {
 	free_percpu(cpu_pmu->hw_events);
+	unregister_cpu_notifier(&cpu_pmu->hotplug_nb);
 }
 
 /*
- * PMU hardware loses all context when a CPU goes offline.
- * When a CPU is hotplugged back in, since some hardware registers are
- * UNKNOWN at reset, the PMU must be explicitly reset to avoid reading
- * junk values out of them.
- */
-static int cpu_pmu_notify(struct notifier_block *b, unsigned long action,
-			  void *hcpu)
-{
-	if ((action & ~CPU_TASKS_FROZEN) != CPU_STARTING)
-		return NOTIFY_DONE;
-
-	if (cpu_pmu && cpu_pmu->reset)
-		cpu_pmu->reset(cpu_pmu);
-	else
-		return NOTIFY_DONE;
-
-	return NOTIFY_OK;
-}
-
-static struct notifier_block cpu_pmu_hotplug_notifier = {
-	.notifier_call = cpu_pmu_notify,
-};
-
-/*
  * PMU platform driver and devicetree bindings.
  */
 static struct of_device_id cpu_pmu_of_device_ids[] = {
@@ -344,16 +353,6 @@ static struct platform_driver cpu_pmu_driver = {
 
 static int __init register_pmu_driver(void)
 {
-	int err;
-
-	err = register_cpu_notifier(&cpu_pmu_hotplug_notifier);
-	if (err)
-		return err;
-
-	err = platform_driver_register(&cpu_pmu_driver);
-	if (err)
-		unregister_cpu_notifier(&cpu_pmu_hotplug_notifier);
-
-	return err;
+	return platform_driver_register(&cpu_pmu_driver);
 }
 device_initcall(register_pmu_driver);
-- 
1.9.1
