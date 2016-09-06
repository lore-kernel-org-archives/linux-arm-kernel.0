From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  6 Sep 2016 18:25:15 +0100
Subject: [PATCH] drivers/perf: arm_pmu: Always consider IRQ0 as an error
Message-ID: <1473182715-18953-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As declared by the chief penguin, and enforced by the NO_IRQ brigade,
IRQ0 doesn't exist, and is considered as an error (no irq).

Unfortunately, the arm_pmu driver still considers it as valid in
a large number of cases. Let's fix this.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/perf/arm_pmu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index f5e1008..2c2754a 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -602,7 +602,7 @@ static void cpu_pmu_free_irq(struct arm_pmu *cpu_pmu)
 	irqs = min(pmu_device->num_resources, num_possible_cpus());
 
 	irq = platform_get_irq(pmu_device, 0);
-	if (irq >= 0 && irq_is_percpu(irq)) {
+	if (irq > 0 && irq_is_percpu(irq)) {
 		on_each_cpu_mask(&cpu_pmu->supported_cpus,
 				 cpu_pmu_disable_percpu_irq, &irq, 1);
 		free_percpu_irq(irq, &hw_events->percpu_pmu);
@@ -616,7 +616,7 @@ static void cpu_pmu_free_irq(struct arm_pmu *cpu_pmu)
 			if (!cpumask_test_and_clear_cpu(cpu, &cpu_pmu->active_irqs))
 				continue;
 			irq = platform_get_irq(pmu_device, i);
-			if (irq >= 0)
+			if (irq > 0)
 				free_irq(irq, per_cpu_ptr(&hw_events->percpu_pmu, cpu));
 		}
 	}
@@ -638,7 +638,7 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 	}
 
 	irq = platform_get_irq(pmu_device, 0);
-	if (irq >= 0 && irq_is_percpu(irq)) {
+	if (irq > 0 && irq_is_percpu(irq)) {
 		err = request_percpu_irq(irq, handler, "arm-pmu",
 					 &hw_events->percpu_pmu);
 		if (err) {
@@ -919,7 +919,7 @@ static int of_pmu_irq_cfg(struct arm_pmu *pmu)
 
 		/* Check the IRQ type and prohibit a mix of PPIs and SPIs */
 		irq = platform_get_irq(pdev, i);
-		if (irq >= 0) {
+		if (irq > 0) {
 			bool spi = !irq_is_percpu(irq);
 
 			if (i > 0 && spi != using_spi) {
@@ -970,7 +970,7 @@ static int of_pmu_irq_cfg(struct arm_pmu *pmu)
 	if (cpumask_weight(&pmu->supported_cpus) == 0) {
 		int irq = platform_get_irq(pdev, 0);
 
-		if (irq >= 0 && irq_is_percpu(irq)) {
+		if (irq > 0 && irq_is_percpu(irq)) {
 			/* If using PPIs, check the affinity of the partition */
 			int ret;
 
-- 
2.1.4
