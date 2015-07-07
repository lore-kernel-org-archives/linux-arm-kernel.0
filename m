From: will.deacon@arm.com (Will Deacon)
Date: Tue,  7 Jul 2015 18:15:05 +0100
Subject: [PATCH] ARM: perf: extend interrupt-affinity property for PPIs
Message-ID: <1436289305-32467-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On systems containing multiple, heterogeneous clusters we need a way to
associate a PMU "device" with the CPU(s) on which it exists. For PMUs
that signal overflow with SPIs, this relationship is determined via the
"interrupt-affinity" property, which contains a list of phandles to CPU
nodes for the PMU. For PMUs using PPIs, the per-cpu nature of the
interrupt isn't enough to determine the set of CPUs which actually
contain the device.

This patch allows the interrupt-affinity property to be specified on a
PMU node irrespective of the interrupt type. For PPIs, it identifies
the set of CPUs signalling the PPI in question.

Tested-by: Stephen Boyd <sboyd@codeaurora.org> # Krait PMU
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 Documentation/devicetree/bindings/arm/pmu.txt | 12 +++--
 arch/arm/kernel/perf_event.c                  | 65 ++++++++++++++++++---------
 2 files changed, 53 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
index 3b5f5d1088c6..435251fa9ce0 100644
--- a/Documentation/devicetree/bindings/arm/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/pmu.txt
@@ -26,13 +26,19 @@ Required properties:
 
 Optional properties:
 
-- interrupt-affinity : Valid only when using SPIs, specifies a list of phandles
-                       to CPU nodes corresponding directly to the affinity of
+- interrupt-affinity : When using SPIs, specifies a list of phandles to CPU
+                       nodes corresponding directly to the affinity of
 		       the SPIs listed in the interrupts property.
 
-		       This property should be present when there is more than
+                       When using a PPI, specifies a list of phandles to CPU
+		       nodes corresponding to the set of CPUs which have
+		       a PMU of this type signalling the PPI listed in the
+		       interrupts property.
+
+                       This property should be present when there is more than
 		       a single SPI.
 
+
 - qcom,no-pc-write : Indicates that this PMU doesn't support the 0xc and 0xd
                      events.
 
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 7d5379c1c443..5a8f17bfcc60 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -790,32 +790,39 @@ static int probe_current_pmu(struct arm_pmu *pmu,
 
 static int of_pmu_irq_cfg(struct arm_pmu *pmu)
 {
-	int i, irq, *irqs;
+	int *irqs, i = 0;
+	bool using_spi = false;
 	struct platform_device *pdev = pmu->plat_device;
 
-	/* Don't bother with PPIs; they're already affine */
-	irq = platform_get_irq(pdev, 0);
-	if (irq >= 0 && irq_is_percpu(irq)) {
-		cpumask_setall(&pmu->supported_cpus);
-		return 0;
-	}
-
 	irqs = kcalloc(pdev->num_resources, sizeof(*irqs), GFP_KERNEL);
 	if (!irqs)
 		return -ENOMEM;
 
-	for (i = 0; i < pdev->num_resources; ++i) {
+	do {
 		struct device_node *dn;
-		int cpu;
+		int cpu, irq;
 
-		dn = of_parse_phandle(pdev->dev.of_node, "interrupt-affinity",
-				      i);
-		if (!dn) {
-			pr_warn("Failed to parse %s/interrupt-affinity[%d]\n",
-				of_node_full_name(pdev->dev.of_node), i);
+		/* See if we have an affinity entry */
+		dn = of_parse_phandle(pdev->dev.of_node, "interrupt-affinity", i);
+		if (!dn)
 			break;
+
+		/* Check the IRQ type and prohibit a mix of PPIs and SPIs */
+		irq = platform_get_irq(pdev, i);
+		if (irq >= 0) {
+			bool spi = !irq_is_percpu(irq);
+
+			if (i > 0 && spi != using_spi) {
+				pr_err("PPI/SPI IRQ type mismatch for %s!\n",
+					dn->name);
+				kfree(irqs);
+				return -EINVAL;
+			}
+
+			using_spi = spi;
 		}
 
+		/* Now look up the logical CPU number */
 		for_each_possible_cpu(cpu)
 			if (arch_find_n_match_cpu_physical_id(dn, cpu, NULL))
 				break;
@@ -824,20 +831,36 @@ static int of_pmu_irq_cfg(struct arm_pmu *pmu)
 			pr_warn("Failed to find logical CPU for %s\n",
 				dn->name);
 			of_node_put(dn);
+			cpumask_setall(&pmu->supported_cpus);
 			break;
 		}
 		of_node_put(dn);
 
-		irqs[i] = cpu;
+		/* For SPIs, we need to track the affinity per IRQ */
+		if (using_spi) {
+			if (i >= pdev->num_resources) {
+				of_node_put(dn);
+				break;
+			}
+
+			irqs[i] = cpu;
+		}
+
+		/* Keep track of the CPUs containing this PMU type */
 		cpumask_set_cpu(cpu, &pmu->supported_cpus);
-	}
+		of_node_put(dn);
+		i++;
+	} while (1);
 
-	if (i == pdev->num_resources) {
+	/* If we didn't manage to parse anything, claim to support all CPUs */
+	if (cpumask_weight(&pmu->supported_cpus) == 0)
+		cpumask_setall(&pmu->supported_cpus);
+
+	/* If we matched up the IRQ affinities, use them to route the SPIs */
+	if (using_spi && i == pdev->num_resources)
 		pmu->irq_affinity = irqs;
-	} else {
+	else
 		kfree(irqs);
-		cpumask_setall(&pmu->supported_cpus);
-	}
 
 	return 0;
 }
-- 
2.1.4
