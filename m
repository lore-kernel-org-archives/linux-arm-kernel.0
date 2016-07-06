From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  6 Jul 2016 15:33:47 +0100
Subject: [PATCH v2] drivers/perf: arm-pmu: Handle per-interrupt affinity mask
Message-ID: <1467815627-4061-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On a big-little system, PMUs can be wired to CPUs using per CPU
interrups (PPI). In this case, it is important to make sure that
the enable/disable do happen on the right set of CPUs.

So instead of relying on the interrupt-affinity property, we can
use the actual percpu affinity that DT exposes as part of the
interrupt specifier. The DT binding is also updated to reflect
the fact that the interrupt-affinity property shouldn't be used
in that case.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
* From v1:
  - propagate the error if irq_get_percpu_devid_partition fails

 Documentation/devicetree/bindings/arm/pmu.txt |  4 +++-
 drivers/perf/arm_pmu.c                        | 27 ++++++++++++++++++++++-----
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
index 74d5417..61c8b46 100644
--- a/Documentation/devicetree/bindings/arm/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/pmu.txt
@@ -39,7 +39,9 @@ Optional properties:
                        When using a PPI, specifies a list of phandles to CPU
 		       nodes corresponding to the set of CPUs which have
 		       a PMU of this type signalling the PPI listed in the
-		       interrupts property.
+		       interrupts property, unless this is already specified
+		       by the PPI interrupt specifier itself (in which case
+		       the interrupt-affinity property shouldn't be present).
 
                        This property should be present when there is more than
 		       a single SPI.
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 140436a..8e4d7f5 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -603,7 +603,8 @@ static void cpu_pmu_free_irq(struct arm_pmu *cpu_pmu)
 
 	irq = platform_get_irq(pmu_device, 0);
 	if (irq >= 0 && irq_is_percpu(irq)) {
-		on_each_cpu(cpu_pmu_disable_percpu_irq, &irq, 1);
+		on_each_cpu_mask(&cpu_pmu->supported_cpus,
+				 cpu_pmu_disable_percpu_irq, &irq, 1);
 		free_percpu_irq(irq, &hw_events->percpu_pmu);
 	} else {
 		for (i = 0; i < irqs; ++i) {
@@ -645,7 +646,9 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 				irq);
 			return err;
 		}
-		on_each_cpu(cpu_pmu_enable_percpu_irq, &irq, 1);
+
+		on_each_cpu_mask(&cpu_pmu->supported_cpus,
+				 cpu_pmu_enable_percpu_irq, &irq, 1);
 	} else {
 		for (i = 0; i < irqs; ++i) {
 			int cpu = i;
@@ -961,9 +964,23 @@ static int of_pmu_irq_cfg(struct arm_pmu *pmu)
 		i++;
 	} while (1);
 
-	/* If we didn't manage to parse anything, claim to support all CPUs */
-	if (cpumask_weight(&pmu->supported_cpus) == 0)
-		cpumask_setall(&pmu->supported_cpus);
+	/* If we didn't manage to parse anything, try the interrupt affinity */
+	if (cpumask_weight(&pmu->supported_cpus) == 0) {
+		if (!using_spi) {
+			/* If using PPIs, check the affinity of the partition */
+			int ret, irq;
+
+			irq = platform_get_irq(pdev, 0);
+			ret = irq_get_percpu_devid_partition(irq, &pmu->supported_cpus);
+			if (ret) {
+				kfree(irqs);
+				return ret;
+			}
+		} else {
+			/* Otherwise default to all CPUs */
+			cpumask_setall(&pmu->supported_cpus);
+		}
+	}
 
 	/* If we matched up the IRQ affinities, use them to route the SPIs */
 	if (using_spi && i == pdev->num_resources)
-- 
2.1.4
