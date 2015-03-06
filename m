From: will.deacon@arm.com (Will Deacon)
Date: Fri,  6 Mar 2015 11:54:09 +0000
Subject: [PATCH v3 2/4] ARM: pmu: add support for interrupt-affinity property
In-Reply-To: <1425642851-27450-1-git-send-email-will.deacon@arm.com>
References: <1425642851-27450-1-git-send-email-will.deacon@arm.com>
Message-ID: <1425642851-27450-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Historically, the PMU devicetree bindings have expected SPIs to be
listed in order of *logical* CPU number. This is problematic for
bootloaders, especially when the boot CPU (logical ID 0) isn't listed
first in the devicetree.

This patch adds a new optional property, interrupt-affinity, to the
PMU node which allows the interrupt affinity to be described using
a list of phandled to CPU nodes, with each entry in the list
corresponding to the SPI at the same index in the interrupts property.

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pmu.h       |  1 +
 arch/arm/kernel/perf_event_cpu.c | 69 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index b1596bd59129..675e4ab79f68 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -92,6 +92,7 @@ struct pmu_hw_events {
 struct arm_pmu {
 	struct pmu	pmu;
 	cpumask_t	active_irqs;
+	int		*irq_affinity;
 	char		*name;
 	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
 	void		(*enable)(struct perf_event *event);
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 61b53c46edfa..51ad167983e5 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -92,11 +92,16 @@ static void cpu_pmu_free_irq(struct arm_pmu *cpu_pmu)
 		free_percpu_irq(irq, &hw_events->percpu_pmu);
 	} else {
 		for (i = 0; i < irqs; ++i) {
-			if (!cpumask_test_and_clear_cpu(i, &cpu_pmu->active_irqs))
+			int cpu = i;
+
+			if (cpu_pmu->irq_affinity)
+				cpu = cpu_pmu->irq_affinity[i];
+
+			if (!cpumask_test_and_clear_cpu(cpu, &cpu_pmu->active_irqs))
 				continue;
 			irq = platform_get_irq(pmu_device, i);
 			if (irq >= 0)
-				free_irq(irq, per_cpu_ptr(&hw_events->percpu_pmu, i));
+				free_irq(irq, per_cpu_ptr(&hw_events->percpu_pmu, cpu));
 		}
 	}
 }
@@ -128,32 +133,37 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 		on_each_cpu(cpu_pmu_enable_percpu_irq, &irq, 1);
 	} else {
 		for (i = 0; i < irqs; ++i) {
+			int cpu = i;
+
 			err = 0;
 			irq = platform_get_irq(pmu_device, i);
 			if (irq < 0)
 				continue;
 
+			if (cpu_pmu->irq_affinity)
+				cpu = cpu_pmu->irq_affinity[i];
+
 			/*
 			 * If we have a single PMU interrupt that we can't shift,
 			 * assume that we're running on a uniprocessor machine and
 			 * continue. Otherwise, continue without this interrupt.
 			 */
-			if (irq_set_affinity(irq, cpumask_of(i)) && irqs > 1) {
+			if (irq_set_affinity(irq, cpumask_of(cpu)) && irqs > 1) {
 				pr_warn("unable to set irq affinity (irq=%d, cpu=%u)\n",
-					irq, i);
+					irq, cpu);
 				continue;
 			}
 
 			err = request_irq(irq, handler,
 					  IRQF_NOBALANCING | IRQF_NO_THREAD, "arm-pmu",
-					  per_cpu_ptr(&hw_events->percpu_pmu, i));
+					  per_cpu_ptr(&hw_events->percpu_pmu, cpu));
 			if (err) {
 				pr_err("unable to request IRQ%d for ARM PMU counters\n",
 					irq);
 				return err;
 			}
 
-			cpumask_set_cpu(i, &cpu_pmu->active_irqs);
+			cpumask_set_cpu(cpu, &cpu_pmu->active_irqs);
 		}
 	}
 
@@ -289,6 +299,48 @@ static int probe_current_pmu(struct arm_pmu *pmu)
 	return ret;
 }
 
+static int of_pmu_irq_cfg(struct platform_device *pdev)
+{
+	int i;
+	int *irqs = kcalloc(pdev->num_resources, sizeof(*irqs), GFP_KERNEL);
+
+	if (!irqs)
+		return -ENOMEM;
+
+	for (i = 0; i < pdev->num_resources; ++i) {
+		struct device_node *dn;
+		int cpu;
+
+		dn = of_parse_phandle(pdev->dev.of_node, "interrupt-affinity",
+				      i);
+		if (!dn) {
+			pr_warn("Failed to parse %s/interrupt-affinity[%d]\n",
+				of_node_full_name(dn), i);
+			break;
+		}
+
+		for_each_possible_cpu(cpu)
+			if (arch_find_n_match_cpu_physical_id(dn, cpu, NULL))
+				break;
+
+		of_node_put(dn);
+		if (cpu >= nr_cpu_ids) {
+			pr_warn("Failed to find logical CPU for %s\n",
+				dn->name);
+			break;
+		}
+
+		irqs[i] = cpu;
+	}
+
+	if (i == pdev->num_resources)
+		cpu_pmu->irq_affinity = irqs;
+	else
+		kfree(irqs);
+
+	return 0;
+}
+
 static int cpu_pmu_device_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id;
@@ -313,7 +365,10 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
 
 	if (node && (of_id = of_match_node(cpu_pmu_of_device_ids, pdev->dev.of_node))) {
 		init_fn = of_id->data;
-		ret = init_fn(pmu);
+
+		ret = of_pmu_irq_cfg(pdev);
+		if (!ret)
+			ret = init_fn(pmu);
 	} else {
 		ret = probe_current_pmu(pmu);
 	}
-- 
2.1.4
