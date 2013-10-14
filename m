From: vkale@apm.com (Vinayak Kale)
Date: Mon, 14 Oct 2013 12:16:29 +0530
Subject: [PATCH] arm64: perf: add support for percpu pmu interrupt
Message-ID: <1381733189-2745-1-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for irq registration when pmu interrupt type is PPI.
The patch also fixes ARMV8_EVTYPE_* macros since evtCount field width is
10bits.

Signed-off-by: Vinayak Kale <vkale@apm.com>
Signed-off-by: Tuan Phan <tphan@apm.com>
---
 arch/arm64/kernel/perf_event.c |  108 +++++++++++++++++++++++++++++-----------
 1 file changed, 78 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cea1594..ba3706d 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -363,22 +363,53 @@ validate_group(struct perf_event *event)
 }
 
 static void
+armpmu_disable_percpu_irq(void *data)
+{
+	struct arm_pmu *armpmu = (struct arm_pmu *)data;
+	struct platform_device *pmu_device = armpmu->plat_device;
+	int irq = platform_get_irq(pmu_device, 0);
+
+	cpumask_test_and_clear_cpu(smp_processor_id(), &armpmu->active_irqs);
+	disable_percpu_irq(irq);
+}
+
+static void
 armpmu_release_hardware(struct arm_pmu *armpmu)
 {
 	int i, irq, irqs;
 	struct platform_device *pmu_device = armpmu->plat_device;
 
-	irqs = min(pmu_device->num_resources, num_possible_cpus());
+	irq = platform_get_irq(pmu_device, 0);
 
-	for (i = 0; i < irqs; ++i) {
-		if (!cpumask_test_and_clear_cpu(i, &armpmu->active_irqs))
-			continue;
-		irq = platform_get_irq(pmu_device, i);
-		if (irq >= 0)
-			free_irq(irq, armpmu);
+	if (irq >= 16 && irq <= 31) {
+		on_each_cpu(armpmu_disable_percpu_irq, (void *)armpmu, 1);
+
+		free_percpu_irq(irq, armpmu);
+	} else {
+		irqs = min(pmu_device->num_resources, num_possible_cpus());
+
+		for (i = 0; i < irqs; ++i) {
+			if (!cpumask_test_and_clear_cpu(i, &armpmu->active_irqs))
+				continue;
+			irq = platform_get_irq(pmu_device, i);
+			if (irq >= 0)
+				free_irq(irq, armpmu);
+		}
 	}
 }
 
+static void
+armpmu_enable_percpu_irq(void *data)
+{
+	struct arm_pmu *armpmu = (struct arm_pmu *)data;
+	struct platform_device *pmu_device = armpmu->plat_device;
+	int irq = platform_get_irq(pmu_device, 0);
+
+	enable_percpu_irq(irq, 0);
+
+	cpumask_set_cpu(smp_processor_id(), &armpmu->active_irqs);
+}
+
 static int
 armpmu_reserve_hardware(struct arm_pmu *armpmu)
 {
@@ -396,36 +427,53 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
 		return -ENODEV;
 	}
 
-	for (i = 0; i < irqs; ++i) {
-		err = 0;
-		irq = platform_get_irq(pmu_device, i);
-		if (irq < 0)
-			continue;
+	irq = platform_get_irq(pmu_device, 0);
 
+	if (irq >= 16 && irq <= 31) {
 		/*
-		 * If we have a single PMU interrupt that we can't shift,
-		 * assume that we're running on a uniprocessor machine and
-		 * continue. Otherwise, continue without this interrupt.
+		 * percpu PMU interrupt.
 		 */
-		if (irq_set_affinity(irq, cpumask_of(i)) && irqs > 1) {
-			pr_warning("unable to set irq affinity (irq=%d, cpu=%u)\n",
-				    irq, i);
-			continue;
-		}
-
-		err = request_irq(irq, armpmu->handle_irq,
-				  IRQF_NOBALANCING,
-				  "arm-pmu", armpmu);
+		err = request_percpu_irq(irq, armpmu->handle_irq,
+						"arm-pmu", armpmu);
 		if (err) {
 			pr_err("unable to request IRQ%d for ARM PMU counters\n",
-				irq);
+					irq);
 			armpmu_release_hardware(armpmu);
 			return err;
 		}
 
-		cpumask_set_cpu(i, &armpmu->active_irqs);
+		on_each_cpu(armpmu_enable_percpu_irq, (void *)armpmu, 1);
+	} else {
+		for (i = 0; i < irqs; ++i) {
+			err = 0;
+			irq = platform_get_irq(pmu_device, i);
+			if (irq < 0)
+				continue;
+
+			/*
+			 * If we have a single PMU interrupt that we can't shift,
+			 * assume that we're running on a uniprocessor machine and
+			 * continue. Otherwise, continue without this interrupt.
+			 */
+			if (irq_set_affinity(irq, cpumask_of(i)) && irqs > 1) {
+				pr_warning("unable to set irq affinity (irq=%d, cpu=%u)\n",
+						irq, i);
+				continue;
+			}
+
+			err = request_irq(irq, armpmu->handle_irq,
+					IRQF_NOBALANCING,
+					"arm-pmu", armpmu);
+			if (err) {
+				pr_err("unable to request IRQ%d for ARM PMU counters\n",
+						irq);
+				armpmu_release_hardware(armpmu);
+				return err;
+			}
+
+			cpumask_set_cpu(i, &armpmu->active_irqs);
+		}
 	}
-
 	return 0;
 }
 
@@ -784,8 +832,8 @@ static const unsigned armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 /*
  * PMXEVTYPER: Event selection reg
  */
-#define	ARMV8_EVTYPE_MASK	0xc80000ff	/* Mask for writable bits */
-#define	ARMV8_EVTYPE_EVENT	0xff		/* Mask for EVENT bits */
+#define	ARMV8_EVTYPE_MASK	0xc80003ff	/* Mask for writable bits */
+#define	ARMV8_EVTYPE_EVENT	0x3ff		/* Mask for EVENT bits */
 
 /*
  * Event filters for PMUv3
@@ -1175,7 +1223,7 @@ static void armv8pmu_reset(void *info)
 static int armv8_pmuv3_map_event(struct perf_event *event)
 {
 	return map_cpu_event(event, &armv8_pmuv3_perf_map,
-				&armv8_pmuv3_perf_cache_map, 0xFF);
+				&armv8_pmuv3_perf_cache_map, 0x3FF);
 }
 
 static struct arm_pmu armv8pmu = {
-- 
1.7.9.5
