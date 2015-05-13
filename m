From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 13 May 2015 17:12:28 +0100
Subject: [PATCH 6/7] arm: perf: remove singleton PMU restriction
In-Reply-To: <1431533549-27715-1-git-send-email-mark.rutland@arm.com>
References: <1431533549-27715-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1431533549-27715-7-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we can describe PMUs in heterogeneous systems, the only item in
the way of perf support for big.LITTLE is the singleton cpu_pmu variable
used for OProfile compatibility.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_cpu.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 9602d31..50f245b 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -33,7 +33,7 @@
 #include <asm/pmu.h>
 
 /* Set at runtime when we know what CPU type we are. */
-static struct arm_pmu *cpu_pmu;
+static struct arm_pmu *__oprofile_cpu_pmu;
 
 /*
  * Despite the names, these two functions are CPU-specific and are used
@@ -41,10 +41,10 @@ static struct arm_pmu *cpu_pmu;
  */
 const char *perf_pmu_name(void)
 {
-	if (!cpu_pmu)
+	if (!__oprofile_cpu_pmu)
 		return NULL;
 
-	return cpu_pmu->name;
+	return __oprofile_cpu_pmu->name;
 }
 EXPORT_SYMBOL_GPL(perf_pmu_name);
 
@@ -52,8 +52,8 @@ int perf_num_counters(void)
 {
 	int max_events = 0;
 
-	if (cpu_pmu != NULL)
-		max_events = cpu_pmu->num_events;
+	if (__oprofile_cpu_pmu != NULL)
+		max_events = __oprofile_cpu_pmu->num_events;
 
 	return max_events;
 }
@@ -360,19 +360,16 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
 	struct arm_pmu *pmu;
 	int ret = -ENODEV;
 
-	if (cpu_pmu) {
-		pr_info("attempt to register multiple PMU devices!\n");
-		return -ENOSPC;
-	}
-
 	pmu = kzalloc(sizeof(struct arm_pmu), GFP_KERNEL);
 	if (!pmu) {
 		pr_info("failed to allocate PMU device!\n");
 		return -ENOMEM;
 	}
 
-	cpu_pmu = pmu;
-	cpu_pmu->plat_device = pdev;
+	if (!__oprofile_cpu_pmu)
+		__oprofile_cpu_pmu = pmu;
+
+	pmu->plat_device = pdev;
 
 	if (node && (of_id = of_match_node(cpu_pmu_of_device_ids, pdev->dev.of_node))) {
 		init_fn = of_id->data;
@@ -390,18 +387,18 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
 		goto out_free;
 	}
 
-	ret = cpu_pmu_init(cpu_pmu);
+	ret = cpu_pmu_init(pmu);
 	if (ret)
 		goto out_free;
 
-	ret = armpmu_register(cpu_pmu, -1);
+	ret = armpmu_register(pmu, -1);
 	if (ret)
 		goto out_destroy;
 
 	return 0;
 
 out_destroy:
-	cpu_pmu_destroy(cpu_pmu);
+	cpu_pmu_destroy(pmu);
 out_free:
 	pr_info("failed to register PMU devices!\n");
 	kfree(pmu);
-- 
1.9.1
