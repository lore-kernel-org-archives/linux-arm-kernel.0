From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 10 Mar 2017 10:46:13 +0000
Subject: [PATCHv4 1/3] drivers/perf: arm_pmu: rework per-cpu allocation
In-Reply-To: <1489142775-11290-1-git-send-email-mark.rutland@arm.com>
References: <1489142775-11290-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1489142775-11290-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For historical reasons, we allocate per-cpu data associated with a PMU
rather late, in cpu_pmu_init, after we've parsed whatever hardware
information we were provided with.

In order to allow use to store some per-cpu data early in the probe
path, we need to allocate (and initialise) the per-cpu data earlier.
This patch reworks the way we allocate the pmu and associated per-cpu
data in order to make that possible.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c | 66 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 9612b84..dd0f3b2 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -828,29 +828,16 @@ static inline void cpu_pm_pmu_unregister(struct arm_pmu *cpu_pmu) { }
 static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	int err;
-	int cpu;
-	struct pmu_hw_events __percpu *cpu_hw_events;
-
-	cpu_hw_events = alloc_percpu(struct pmu_hw_events);
-	if (!cpu_hw_events)
-		return -ENOMEM;
 
 	err = cpuhp_state_add_instance_nocalls(CPUHP_AP_PERF_ARM_STARTING,
 					       &cpu_pmu->node);
 	if (err)
-		goto out_free;
+		goto out;
 
 	err = cpu_pm_pmu_register(cpu_pmu);
 	if (err)
 		goto out_unregister;
 
-	for_each_possible_cpu(cpu) {
-		struct pmu_hw_events *events = per_cpu_ptr(cpu_hw_events, cpu);
-		raw_spin_lock_init(&events->pmu_lock);
-		events->percpu_pmu = cpu_pmu;
-	}
-
-	cpu_pmu->hw_events	= cpu_hw_events;
 	cpu_pmu->request_irq	= cpu_pmu_request_irq;
 	cpu_pmu->free_irq	= cpu_pmu_free_irq;
 
@@ -876,8 +863,7 @@ static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
 out_unregister:
 	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_STARTING,
 					    &cpu_pmu->node);
-out_free:
-	free_percpu(cpu_hw_events);
+out:
 	return err;
 }
 
@@ -886,7 +872,6 @@ static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
 	cpu_pm_pmu_unregister(cpu_pmu);
 	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_STARTING,
 					    &cpu_pmu->node);
-	free_percpu(cpu_pmu->hw_events);
 }
 
 /*
@@ -1008,6 +993,45 @@ static int of_pmu_irq_cfg(struct arm_pmu *pmu)
 	return 0;
 }
 
+struct arm_pmu *armpmu_alloc(void)
+{
+	struct arm_pmu *pmu;
+	int cpu;
+
+	pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
+	if (!pmu) {
+		pr_info("failed to allocate PMU device!\n");
+		goto out;
+	}
+
+	pmu->hw_events = alloc_percpu(struct pmu_hw_events);
+	if (!pmu->hw_events) {
+		pr_info("failed to allocate per-cpu PMU data.\n");
+		goto out_free_pmu;
+	}
+
+	for_each_possible_cpu(cpu) {
+		struct pmu_hw_events *events;
+
+		events = per_cpu_ptr(pmu->hw_events, cpu);
+		raw_spin_lock_init(&events->pmu_lock);
+		events->percpu_pmu = pmu;
+	}
+
+	return pmu;
+
+out_free_pmu:
+	kfree(pmu);
+out:
+	return NULL;
+}
+
+void armpmu_free(struct arm_pmu *pmu)
+{
+	free_percpu(pmu->hw_events);
+	kfree(pmu);
+}
+
 int arm_pmu_device_probe(struct platform_device *pdev,
 			 const struct of_device_id *of_table,
 			 const struct pmu_probe_info *probe_table)
@@ -1018,11 +1042,9 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 	struct arm_pmu *pmu;
 	int ret = -ENODEV;
 
-	pmu = kzalloc(sizeof(struct arm_pmu), GFP_KERNEL);
-	if (!pmu) {
-		pr_info("failed to allocate PMU device!\n");
+	pmu = armpmu_alloc();
+	if (!pmu)
 		return -ENOMEM;
-	}
 
 	armpmu_init(pmu);
 
@@ -1076,7 +1098,7 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 	pr_info("%s: failed to register PMU devices!\n",
 		of_node_full_name(node));
 	kfree(pmu->irq_affinity);
-	kfree(pmu);
+	armpmu_free(pmu);
 	return ret;
 }
 
-- 
1.9.1
