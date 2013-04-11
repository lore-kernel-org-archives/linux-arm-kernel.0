From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Apr 2013 10:12:40 +0100
Subject: [RFC PATCH 09/11] arm: perf: parse cpu affinity from dt
In-Reply-To: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
References: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1365671562-2403-10-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current way we read interrupts form devicetree assumes that
interrupts are in increasing order of logical cpu id (MPIDR.Aff{2,1,0}),
and that these logical ids are in a contiguous block. This may not be
the case in general - after a kexec cpu ids may be arbitrarily assigned,
and multi-cluster systems do not have a contiguous range of cpu ids.

This patch parses cpu affinity information for interrupts from an
optional "interrupts-affinity" devicetree property described in the
devicetree binding document. Currently only SPIs are supported.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/devicetree/bindings/arm/pmu.txt |   7 ++
 arch/arm/kernel/perf_event_cpu.c              | 136 ++++++++++++++++++++------
 2 files changed, 115 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
index 343781b..0caf968 100644
--- a/Documentation/devicetree/bindings/arm/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/pmu.txt
@@ -17,6 +17,13 @@ Required properties:
 	"arm,arm1136-pmu"
 - interrupts : 1 combined interrupt or 1 per core.
 
+Optional properties:
+
+- interrupts-affinity : a list of phandles to topology nodes as described in
+                        Documentation/devicetree/bindings/arm/topology.txt.
+			Each phandle describes the affinity of the element in
+			the interrupts property at the same index.
+
 Example:
 
 pmu {
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index c1a9880c..6d8cbb1 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -27,9 +27,15 @@
 #include <linux/spinlock.h>
 
 #include <asm/cputype.h>
+#include <asm/dt_affinity.h>
 #include <asm/irq_regs.h>
 #include <asm/pmu.h>
 
+struct cpu_pmu_irq {
+	int irq;
+	int cpu;
+};
+
 /* Set at runtime when we know what CPU type we are. */
 static struct arm_pmu *cpu_pmu;
 
@@ -49,6 +55,8 @@ struct cpu_pmu_hw {
 struct cpu_pmu {
 	struct arm_pmu armpmu;
 	struct cpu_pmu_hw __percpu *cpu_hw;
+	struct cpu_pmu_irq *interrupts;
+	int nr_irqs;
 };
 
 #define to_cpu_pmu(p) (container_of(p, struct cpu_pmu, armpmu))
@@ -89,62 +97,58 @@ static struct pmu_hw_events *cpu_pmu_get_cpu_events(struct arm_pmu *pmu)
 	return &hw->cpu_hw_events;
 }
 
-static void cpu_pmu_free_irq(struct arm_pmu *cpu_pmu)
+static void cpu_pmu_free_irq(struct arm_pmu *pmu)
 {
-	int i, irq, irqs;
-	struct platform_device *pmu_device = cpu_pmu->plat_device;
+	int i, irq, irqs, cpu;
+	struct cpu_pmu *cpu_pmu = container_of(pmu, struct cpu_pmu, armpmu);
 
-	irqs = min(pmu_device->num_resources, num_possible_cpus());
+	irqs = cpu_pmu->nr_irqs;
 
 	for (i = 0; i < irqs; ++i) {
-		if (!cpumask_test_and_clear_cpu(i, &cpu_pmu->active_irqs))
+		cpu = cpu_pmu->interrupts[i].cpu;
+		irq = cpu_pmu->interrupts[i].irq;
+		if (irq < 0 || cpu < 0)
+			continue;
+		if (!cpumask_test_and_clear_cpu(cpu, &pmu->active_irqs))
 			continue;
-		irq = platform_get_irq(pmu_device, i);
 		if (irq >= 0)
-			free_irq(irq, cpu_pmu);
+			free_irq(irq, pmu);
 	}
 }
 
-static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
+static int cpu_pmu_request_irq(struct arm_pmu *pmu, irq_handler_t handler)
 {
-	int i, err, irq, irqs;
-	struct platform_device *pmu_device = cpu_pmu->plat_device;
+	int err, i, irq, irqs, cpu;
+	struct cpu_pmu *cpu_pmu = container_of(pmu, struct cpu_pmu, armpmu);
 
-	if (!pmu_device)
-		return -ENODEV;
+	irqs = cpu_pmu->nr_irqs;
 
-	irqs = min(pmu_device->num_resources, num_possible_cpus());
-	if (irqs < 1) {
-		pr_err("no irqs for PMUs defined\n");
-		return -ENODEV;
-	}
+	for (i = 0; i < irqs; i++) {
+		irq = cpu_pmu->interrupts[i].irq;
+		cpu = cpu_pmu->interrupts[i].cpu;
 
-	for (i = 0; i < irqs; ++i) {
-		err = 0;
-		irq = platform_get_irq(pmu_device, i);
-		if (irq < 0)
+		if (irq < 0 || cpu < 0)
 			continue;
-
 		/*
 		 * If we have a single PMU interrupt that we can't shift,
 		 * assume that we're running on a uniprocessor machine and
 		 * continue. Otherwise, continue without this interrupt.
 		 */
-		if (irq_set_affinity(irq, cpumask_of(i)) && irqs > 1) {
+		if (irq_set_affinity(irq, cpumask_of(cpu)) && irqs > 1) {
 			pr_warning("unable to set irq affinity (irq=%d, cpu=%u)\n",
-				    irq, i);
+				    irq, cpu);
 			continue;
 		}
 
 		err = request_irq(irq, handler, IRQF_NOBALANCING, "arm-pmu",
-				  cpu_pmu);
+				  pmu);
 		if (err) {
 			pr_err("unable to request IRQ%d for ARM PMU counters\n",
 				irq);
 			return err;
 		}
 
-		cpumask_set_cpu(i, &cpu_pmu->active_irqs);
+		cpumask_set_cpu(cpu, &pmu->active_irqs);
 	}
 
 	return 0;
@@ -275,6 +279,79 @@ static int probe_current_pmu(struct arm_pmu *pmu)
 	return ret;
 }
 
+static int parse_platdata(struct cpu_pmu *cpu_pmu, struct platform_device *pdev)
+{
+	int err;
+	cpumask_var_t tmp_mask;
+	struct cpu_pmu_irq *interrupts;
+	int i, irqs = pdev->num_resources;
+	struct device_node *node;
+	bool affine;
+
+	node = pdev->dev.of_node;
+	affine = node && of_get_property(node, "interrupts-affinity", NULL);
+
+	if (!affine)
+		irqs = min(pdev->num_resources, num_possible_cpus());
+
+	if (irqs < 1)
+		return -ENODEV;
+
+	cpu_pmu->nr_irqs = irqs;
+
+	interrupts = kzalloc(sizeof(*interrupts) * irqs, GFP_KERNEL);
+	if (!interrupts)
+		return -ENOMEM;
+
+	if (!alloc_cpumask_var(&tmp_mask, GFP_KERNEL)) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < irqs; i++) {
+		int cpu = i;
+
+		interrupts[i].irq = platform_get_irq(pdev, i);
+		if (interrupts[i].irq < 0) {
+			interrupts[i].cpu = -1;
+			continue;
+		}
+
+		if (affine) {
+			if (!arm_dt_affine_is_single(node,
+				"interrupts-affinity", i)) {
+				pr_err("PPIs not supported (%s[%d])\n",
+					node->full_name, i);
+				err = -EINVAL;
+				goto out;
+			}
+			cpumask_clear(tmp_mask);
+			err = arm_dt_affine_get_mask(node,
+				"interrupts-affinity", i, tmp_mask);
+			if (err)
+				goto out;
+
+			if (cpumask_weight(tmp_mask) <= 0) {
+				interrupts[i].cpu = -1;
+				continue;
+			}
+
+			cpu = cpumask_first(tmp_mask);
+		}
+
+		interrupts[i].cpu = cpu;
+		cpumask_set_cpu(cpu, &cpu_pmu->armpmu.supported_cpus);
+	}
+
+	cpu_pmu->interrupts = interrupts;
+
+out:
+	free_cpumask_var(tmp_mask);
+	if (err)
+		kfree(interrupts);
+	return err;
+}
+
 static int cpu_pmu_device_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id;
@@ -301,8 +378,11 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
 		goto out_pmu;
 	}
 
-	/* Assume by default that we're on a homogeneous system */
-	cpumask_setall(&pmu->armpmu.supported_cpus);
+	ret = parse_platdata(pmu, pdev);
+	if (ret) {
+		pr_info("Could not parse irq information\n");
+		goto out_hw;
+	}
 
 	if (node && (of_id = of_match_node(cpu_pmu_of_device_ids, pdev->dev.of_node))) {
 		init_fn = of_id->data;
-- 
1.8.1.1
