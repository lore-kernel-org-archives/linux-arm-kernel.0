From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Apr 2013 10:12:41 +0100
Subject: [RFC PATCH 10/11] arm: perf: allow multiple CPU PMUs to be registered
In-Reply-To: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
References: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1365671562-2403-11-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In systems with multiple clusters, the CPUs may be different in each
cluster, and their PMUs may not be entirely compatible. As they cannot
be managed as one logical homogeneous unit, we will have to support each
set of compatible PMUs separately. To do so, we need to be able to
register and use multiple PMUs simultaneously.

This patch replaces the global cpu_pmu pointer with a list of cpu_pmus,
enabling multiple PMUs to be registered and used simultaneously.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm/kernel/perf_event_cpu.c | 61 +++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 6d8cbb1..4d6bfbb 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -37,7 +37,7 @@ struct cpu_pmu_irq {
 };
 
 /* Set at runtime when we know what CPU type we are. */
-static struct arm_pmu *cpu_pmu;
+static LIST_HEAD(pmus_list);
 
 /*
  * All of the dynamically sized pmu_hw data for the number of events supported
@@ -57,20 +57,28 @@ struct cpu_pmu {
 	struct cpu_pmu_hw __percpu *cpu_hw;
 	struct cpu_pmu_irq *interrupts;
 	int nr_irqs;
+	struct list_head list;
 };
 
 #define to_cpu_pmu(p) (container_of(p, struct cpu_pmu, armpmu))
 
+static void cpu_pmu_add(struct cpu_pmu *pmu)
+{
+	list_add_tail(&pmu->list, &pmus_list);
+}
+
 /*
  * Despite the names, these two functions are CPU-specific and are used
  * by the OProfile/perf code.
  */
 const char *perf_pmu_name(void)
 {
-	if (!cpu_pmu)
+	struct cpu_pmu *pmu = list_first_entry(&pmus_list,
+					       struct cpu_pmu, list);
+	if (!pmu)
 		return NULL;
 
-	return cpu_pmu->name;
+	return pmu->armpmu.name;
 }
 EXPORT_SYMBOL_GPL(perf_pmu_name);
 
@@ -78,8 +86,10 @@ int perf_num_counters(void)
 {
 	int max_events = 0;
 
-	if (cpu_pmu != NULL)
-		max_events = cpu_pmu->num_events;
+	struct cpu_pmu *pmu = list_first_entry(&pmus_list,
+					       struct cpu_pmu, list);
+	if (pmu != NULL)
+		max_events = pmu->armpmu.num_events;
 
 	return max_events;
 }
@@ -186,18 +196,26 @@ static int __cpuinit cpu_pmu_notify(struct notifier_block *b,
 				    unsigned long action, void *hcpu)
 {
 	int cpu = (long)hcpu;
+	int ret = NOTIFY_DONE;
+	struct cpu_pmu *cpu_pmu;
+
 	if ((action & ~CPU_TASKS_FROZEN) != CPU_STARTING)
-		return NOTIFY_DONE;
+		return ret;
 
-	if (!cpumask_test_cpu(cpu, &cpu_pmu->supported_cpus))
-		return NOTIFY_DONE;
+	list_for_each_entry(cpu_pmu, &pmus_list, list) {
+		struct arm_pmu *arm_pmu = &cpu_pmu->armpmu;
 
-	if (cpu_pmu && cpu_pmu->reset)
-		cpu_pmu->reset(cpu_pmu);
-	else
-		return NOTIFY_DONE;
+		if (!arm_pmu->reset)
+			continue;
+
+		if (!cpumask_test_cpu(cpu, &arm_pmu->supported_cpus))
+			continue;
 
-	return NOTIFY_OK;
+		arm_pmu->reset(arm_pmu);
+		ret = NOTIFY_OK;
+	}
+
+	return ret;
 }
 
 static struct notifier_block __cpuinitdata cpu_pmu_hotplug_notifier = {
@@ -360,11 +378,6 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
 	struct cpu_pmu *pmu;
 	int ret = -ENODEV;
 
-	if (cpu_pmu) {
-		pr_info("attempt to register multiple PMU devices!");
-		return -ENOSPC;
-	}
-
 	pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
 	if (!pmu) {
 		pr_info("failed to allocate PMU device!");
@@ -396,13 +409,15 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
 		goto out_hw;
 	}
 
-	cpu_pmu = &pmu->armpmu;
-	cpu_pmu->plat_device = pdev;
+	pmu->armpmu.plat_device = pdev;
 	cpu_pmu_init(pmu);
-	ret = armpmu_register(cpu_pmu, -1);
 
-	if (!ret)
-		return 0;
+	ret = armpmu_register(&pmu->armpmu, -1);
+	if (ret)
+		goto out_hw;
+
+	cpu_pmu_add(pmu);
+	return 0;
 
 out_hw:
 	free_percpu(pmu->cpu_hw);
-- 
1.8.1.1
