From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Jan 2017 15:31:18 +0000
Subject: [PATCH 2/3] drivers/perf: arm_pmu: manage interrupts per-cpu
In-Reply-To: <1485790279-3139-1-git-send-email-mark.rutland@arm.com>
References: <1485790279-3139-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1485790279-3139-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When requesting or freeing interrupts, we use platform_get_irq() to find
relevant irqs, backing this up with additional information in an
optional irq_affinity table.

This means that our irq request and free paths are tied to a
platform_device, and our request path must jump through a number of
hoops in order to determine the required affinity of each interrupt.

Given that the affinity must be static, we can compute the affinity once
up-front at probe time, simplifying the irq request and free paths. By
recording interrupts in a per-cpu data structure, we simplify a few
paths, and permit a subsequent rework of the request and free paths.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c       | 281 +++++++++++++++++++++----------------------
 include/linux/perf/arm_pmu.h |   2 +
 2 files changed, 141 insertions(+), 142 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index dc4c8aa..23976f7 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -616,94 +616,76 @@ static void cpu_pmu_disable_percpu_irq(void *data)
 
 static void cpu_pmu_free_irq(struct arm_pmu *cpu_pmu)
 {
-	int i, irq, irqs;
-	struct platform_device *pmu_device = cpu_pmu->plat_device;
+	int cpu;
 	struct pmu_hw_events __percpu *hw_events = cpu_pmu->hw_events;
 
-	irqs = min(pmu_device->num_resources, num_possible_cpus());
-
-	irq = platform_get_irq(pmu_device, 0);
-	if (irq > 0 && irq_is_percpu(irq)) {
-		on_each_cpu_mask(&cpu_pmu->supported_cpus,
-				 cpu_pmu_disable_percpu_irq, &irq, 1);
-		free_percpu_irq(irq, &hw_events->percpu_pmu);
-	} else {
-		for (i = 0; i < irqs; ++i) {
-			int cpu = i;
-
-			if (cpu_pmu->irq_affinity)
-				cpu = cpu_pmu->irq_affinity[i];
-
-			if (!cpumask_test_and_clear_cpu(cpu, &cpu_pmu->active_irqs))
-				continue;
-			irq = platform_get_irq(pmu_device, i);
-			if (irq > 0)
-				free_irq(irq, per_cpu_ptr(&hw_events->percpu_pmu, cpu));
+	for_each_cpu(cpu, &cpu_pmu->supported_cpus) {
+		int irq = per_cpu(hw_events->irq, cpu);
+		if (!irq)
+			continue;
+
+		if (irq_is_percpu(irq)) {
+			on_each_cpu_mask(&cpu_pmu->supported_cpus,
+					 cpu_pmu_disable_percpu_irq, &irq, 1);
+			free_percpu_irq(irq, &hw_events->percpu_pmu);
+
+			break;
 		}
+
+		if (!cpumask_test_and_clear_cpu(cpu, &cpu_pmu->active_irqs))
+			continue;
+
+		free_irq(irq, per_cpu_ptr(&hw_events->percpu_pmu, cpu));
 	}
 }
 
 static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 {
-	int i, err, irq, irqs;
-	struct platform_device *pmu_device = cpu_pmu->plat_device;
+	int cpu, err;
 	struct pmu_hw_events __percpu *hw_events = cpu_pmu->hw_events;
 
-	if (!pmu_device)
-		return -ENODEV;
-
-	irqs = min(pmu_device->num_resources, num_possible_cpus());
-	if (irqs < 1) {
-		pr_warn_once("perf/ARM: No irqs for PMU defined, sampling events not supported\n");
-		return 0;
-	}
-
-	irq = platform_get_irq(pmu_device, 0);
-	if (irq > 0 && irq_is_percpu(irq)) {
-		err = request_percpu_irq(irq, handler, "arm-pmu",
-					 &hw_events->percpu_pmu);
-		if (err) {
-			pr_err("unable to request IRQ%d for ARM PMU counters\n",
-				irq);
-			return err;
-		}
-
-		on_each_cpu_mask(&cpu_pmu->supported_cpus,
-				 cpu_pmu_enable_percpu_irq, &irq, 1);
-	} else {
-		for (i = 0; i < irqs; ++i) {
-			int cpu = i;
-
-			err = 0;
-			irq = platform_get_irq(pmu_device, i);
-			if (irq < 0)
-				continue;
-
-			if (cpu_pmu->irq_affinity)
-				cpu = cpu_pmu->irq_affinity[i];
-
-			/*
-			 * If we have a single PMU interrupt that we can't shift,
-			 * assume that we're running on a uniprocessor machine and
-			 * continue. Otherwise, continue without this interrupt.
-			 */
-			if (irq_set_affinity(irq, cpumask_of(cpu)) && irqs > 1) {
-				pr_warn("unable to set irq affinity (irq=%d, cpu=%u)\n",
-					irq, cpu);
-				continue;
-			}
+	for_each_cpu(cpu, &cpu_pmu->supported_cpus) {
+		int irq = per_cpu(hw_events->irq, cpu);
+		if (!irq)
+			continue;
 
-			err = request_irq(irq, handler,
-					  IRQF_NOBALANCING | IRQF_NO_THREAD, "arm-pmu",
-					  per_cpu_ptr(&hw_events->percpu_pmu, cpu));
+		if (irq_is_percpu(irq)) {
+			err = request_percpu_irq(irq, handler, "arm-pmu",
+						 &hw_events->percpu_pmu);
 			if (err) {
 				pr_err("unable to request IRQ%d for ARM PMU counters\n",
 					irq);
 				return err;
 			}
 
-			cpumask_set_cpu(cpu, &cpu_pmu->active_irqs);
+			on_each_cpu_mask(&cpu_pmu->supported_cpus,
+					 cpu_pmu_enable_percpu_irq, &irq, 1);
+
+			break;
+		}
+
+		/*
+		 * If we have a single PMU interrupt that we can't shift,
+		 * assume that we're running on a uniprocessor machine and
+		 * continue. Otherwise, continue without this interrupt.
+		 */
+		if (irq_set_affinity(irq, cpumask_of(cpu)) &&
+		    num_possible_cpus() > 1) {
+			pr_warn("unable to set irq affinity (irq=%d, cpu=%u)\n",
+				irq, cpu);
+			continue;
 		}
+
+		err = request_irq(irq, handler,
+				  IRQF_NOBALANCING | IRQF_NO_THREAD, "arm-pmu",
+				  per_cpu_ptr(&hw_events->percpu_pmu, cpu));
+		if (err) {
+			pr_err("unable to request IRQ%d for ARM PMU counters\n",
+				irq);
+			return err;
+		}
+
+		cpumask_set_cpu(cpu, &cpu_pmu->active_irqs);
 	}
 
 	return 0;
@@ -897,98 +879,113 @@ static int probe_current_pmu(struct arm_pmu *pmu,
 	return ret;
 }
 
-static int of_pmu_irq_cfg(struct arm_pmu *pmu)
+static int of_pmu_irq_cfg_ppi(struct arm_pmu *pmu, int irq)
 {
-	int *irqs, i = 0;
-	bool using_spi = false;
-	struct platform_device *pdev = pmu->plat_device;
+	int cpu, ret;
+	struct pmu_hw_events __percpu *hw_events = pmu->hw_events;
 
-	irqs = kcalloc(pdev->num_resources, sizeof(*irqs), GFP_KERNEL);
-	if (!irqs)
-		return -ENOMEM;
+	ret = irq_get_percpu_devid_partition(irq, &pmu->supported_cpus);
+	if (ret)
+		return ret;
 
-	do {
-		struct device_node *dn;
-		int cpu, irq;
+	for_each_cpu(cpu, &pmu->supported_cpus)
+		per_cpu(hw_events->irq, cpu) = irq;
 
-		/* See if we have an affinity entry */
-		dn = of_parse_phandle(pdev->dev.of_node, "interrupt-affinity", i);
-		if (!dn)
-			break;
+	return 0;
+}
 
-		/* Check the IRQ type and prohibit a mix of PPIs and SPIs */
-		irq = platform_get_irq(pdev, i);
-		if (irq > 0) {
-			bool spi = !irq_is_percpu(irq);
-
-			if (i > 0 && spi != using_spi) {
-				pr_err("PPI/SPI IRQ type mismatch for %s!\n",
-					dn->name);
-				of_node_put(dn);
-				kfree(irqs);
-				return -EINVAL;
-			}
+static int of_pmu_parse_irq_affinity(struct device_node *node, int i)
+{
+	struct device_node *dn;
+	int cpu;
 
-			using_spi = spi;
-		}
+	if (!of_find_property(node, "interrupt-affinity", NULL)) {
+		pr_warn("no interrupt-affinity property, guessing IRQ affinity\n");
+		return i;
+	}
 
-		/* Now look up the logical CPU number */
-		for_each_possible_cpu(cpu) {
-			struct device_node *cpu_dn;
+	dn = of_parse_phandle(node, "interrupt-affinity", i);
+	if (!dn) {
+		pr_warn("failed to parse interrupt-affinity[%d] for %s\n",
+			i, node->name);
+		return -EINVAL;
+	}
 
-			cpu_dn = of_cpu_device_node_get(cpu);
-			of_node_put(cpu_dn);
+	/* Now look up the logical CPU number */
+	for_each_possible_cpu(cpu) {
+		struct device_node *cpu_dn;
 
-			if (dn == cpu_dn)
-				break;
-		}
+		cpu_dn = of_cpu_device_node_get(cpu);
+		of_node_put(cpu_dn);
 
-		if (cpu >= nr_cpu_ids) {
-			pr_warn("Failed to find logical CPU for %s\n",
-				dn->name);
-			of_node_put(dn);
-			cpumask_setall(&pmu->supported_cpus);
+		if (dn == cpu_dn)
 			break;
-		}
-		of_node_put(dn);
+	}
 
-		/* For SPIs, we need to track the affinity per IRQ */
-		if (using_spi) {
-			if (i >= pdev->num_resources)
-				break;
+	if (cpu >= nr_cpu_ids) {
+		pr_warn("failed to find logical CPU for %s\n", dn->name);
+	}
 
-			irqs[i] = cpu;
-		}
+	of_node_put(dn);
 
-		/* Keep track of the CPUs containing this PMU type */
-		cpumask_set_cpu(cpu, &pmu->supported_cpus);
-		i++;
-	} while (1);
+	return cpu;
+}
 
-	/* If we didn't manage to parse anything, try the interrupt affinity */
-	if (cpumask_weight(&pmu->supported_cpus) == 0) {
-		int irq = platform_get_irq(pdev, 0);
+static int of_pmu_irq_cfg(struct arm_pmu *pmu)
+{
+	int i = 0, nr_irqs;
+	struct platform_device *pdev = pmu->plat_device;
+	struct pmu_hw_events __percpu *hw_events = pmu->hw_events;
 
-		if (irq > 0 && irq_is_percpu(irq)) {
-			/* If using PPIs, check the affinity of the partition */
-			int ret;
+	nr_irqs = platform_irq_count(pdev);
+	if (nr_irqs < 0) {
+		pr_err("unable to count PMU IRQs\n");
+		return nr_irqs;
+	}
 
-			ret = irq_get_percpu_devid_partition(irq, &pmu->supported_cpus);
-			if (ret) {
-				kfree(irqs);
-				return ret;
-			}
-		} else {
-			/* Otherwise default to all CPUs */
-			cpumask_setall(&pmu->supported_cpus);
+	/*
+	 * In this case we have no idea which CPUs are covered by the PMU.
+	 * To match our prior behaviour, we assume all CPUs in this case.
+	 */
+	if (nr_irqs == 0) {
+		pr_warn("no irqs for PMU, sampling events not supported\n");
+		cpumask_setall(&pmu->supported_cpus);
+		return 0;
+	}
+
+	if (nr_irqs == 1) {
+		int irq = platform_get_irq(pdev, 0);
+		if (irq && irq_is_percpu(irq)) {
+			return of_pmu_irq_cfg_ppi(pmu, irq);
 		}
 	}
 
-	/* If we matched up the IRQ affinities, use them to route the SPIs */
-	if (using_spi && i == pdev->num_resources)
-		pmu->irq_affinity = irqs;
-	else
-		kfree(irqs);
+	for (i = 0; i < nr_irqs; i++) {
+		int cpu, irq;
+
+		irq = platform_get_irq(pdev, i);
+		if (WARN_ON(irq <= 0))
+			continue;
+
+		if (irq_is_percpu(irq)) {
+			pr_warn("multiple PPIs or mismatched SPI/PPI detected\n");
+			return -EINVAL;
+		}
+
+		cpu = of_pmu_parse_irq_affinity(pdev->dev.of_node, i);
+		if (cpu < 0)
+			return cpu;
+		if (cpu >= nr_cpu_ids)
+			continue;
+
+		if (per_cpu(hw_events->irq, cpu)) {
+			pr_warn("multiple PMU IRQs for the same CPU detected\n");
+			return -EINVAL;
+		}
+
+		per_cpu(hw_events->irq, cpu) = irq;
+		cpumask_set_cpu(cpu, &pmu->supported_cpus);
+	}
 
 	return 0;
 }
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 8462da2..99dd863 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -75,6 +75,8 @@ struct pmu_hw_events {
 	 * already have to allocate this struct per cpu.
 	 */
 	struct arm_pmu		*percpu_pmu;
+
+	int irq;
 };
 
 enum armpmu_attr_groups {
-- 
1.9.1
