From: vkale@apm.com (Vinayak Kale)
Date: Mon, 18 Nov 2013 18:52:29 +0530
Subject: [PATCH V3 2/2] arm64: perf: add support for percpu pmu interrupt
In-Reply-To: <1384780949-10922-1-git-send-email-vkale@apm.com>
References: <1384780949-10922-1-git-send-email-vkale@apm.com>
Message-ID: <1384780949-10922-3-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for irq registration when pmu interrupt is percpu.

Signed-off-by: Vinayak Kale <vkale@apm.com>
Signed-off-by: Tuan Phan <tphan@apm.com>
---
 arch/arm64/kernel/perf_event.c |  102 +++++++++++++++++++++++++++++-----------
 1 file changed, 74 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cea1594..23475f6 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -22,6 +22,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/perf_event.h>
@@ -363,22 +364,51 @@ validate_group(struct perf_event *event)
 }
 
 static void
+armpmu_disable_percpu_irq(void *data)
+{
+	struct arm_pmu *armpmu = data;
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
+	if (irq_to_desc(irq) && irq_is_percpu(irq)) {
+		on_each_cpu(armpmu_disable_percpu_irq, armpmu, 1);
+		free_percpu_irq(irq, &cpu_hw_events);
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
+	struct arm_pmu *armpmu = data;
+	struct platform_device *pmu_device = armpmu->plat_device;
+	int irq = platform_get_irq(pmu_device, 0);
+
+	enable_percpu_irq(irq, 0);
+	cpumask_set_cpu(smp_processor_id(), &armpmu->active_irqs);
+}
+
 static int
 armpmu_reserve_hardware(struct arm_pmu *armpmu)
 {
@@ -396,34 +426,50 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
 		return -ENODEV;
 	}
 
-	for (i = 0; i < irqs; ++i) {
-		err = 0;
-		irq = platform_get_irq(pmu_device, i);
-		if (irq < 0)
-			continue;
+	irq = platform_get_irq(pmu_device, 0);
 
-		/*
-		 * If we have a single PMU interrupt that we can't shift,
-		 * assume that we're running on a uniprocessor machine and
-		 * continue. Otherwise, continue without this interrupt.
-		 */
-		if (irq_set_affinity(irq, cpumask_of(i)) && irqs > 1) {
-			pr_warning("unable to set irq affinity (irq=%d, cpu=%u)\n",
-				    irq, i);
-			continue;
-		}
+	if (irq_to_desc(irq) && irq_is_percpu(irq)) {
+		err = request_percpu_irq(irq, armpmu->handle_irq,
+				"arm-pmu", &cpu_hw_events);
 
-		err = request_irq(irq, armpmu->handle_irq,
-				  IRQF_NOBALANCING,
-				  "arm-pmu", armpmu);
 		if (err) {
-			pr_err("unable to request IRQ%d for ARM PMU counters\n",
-				irq);
+			pr_err("unable to request percpu IRQ%d for ARM PMU counters\n",
+					irq);
 			armpmu_release_hardware(armpmu);
 			return err;
 		}
 
-		cpumask_set_cpu(i, &armpmu->active_irqs);
+		on_each_cpu(armpmu_enable_percpu_irq, armpmu, 1);
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
 
 	return 0;
-- 
1.7.9.5
