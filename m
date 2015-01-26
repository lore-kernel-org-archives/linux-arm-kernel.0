From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Jan 2015 17:54:16 +0000
Subject: [PATCH 2/4] arm64: pmu: add support for interrupt-affinity property
In-Reply-To: <1422294858-28100-1-git-send-email-will.deacon@arm.com>
References: <1422294858-28100-1-git-send-email-will.deacon@arm.com>
Message-ID: <1422294858-28100-2-git-send-email-will.deacon@arm.com>
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
 Documentation/devicetree/bindings/arm/pmu.txt |  6 +++
 arch/arm64/include/asm/pmu.h                  |  1 +
 arch/arm64/kernel/perf_event.c                | 57 +++++++++++++++++++++++++--
 3 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
index 75ef91d08f3b..a9281fc48743 100644
--- a/Documentation/devicetree/bindings/arm/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/pmu.txt
@@ -24,6 +24,12 @@ Required properties:
 
 Optional properties:
 
+- interrupt-affinity : Valid only when using SPIs, specifies a list of phandles
+                       to CPU nodes corresponding directly to the affinity of
+		       the SPIs listed in the interrupts property. If absent,
+		       the interrupts are assumed to be listed in logical CPU
+		       order.
+
 - qcom,no-pc-write : Indicates that this PMU doesn't support the 0xc and 0xd
                      events.
 
diff --git a/arch/arm64/include/asm/pmu.h b/arch/arm64/include/asm/pmu.h
index e6f087806aaf..b7710a59672c 100644
--- a/arch/arm64/include/asm/pmu.h
+++ b/arch/arm64/include/asm/pmu.h
@@ -44,6 +44,7 @@ struct pmu_hw_events {
 struct arm_pmu {
 	struct pmu		pmu;
 	cpumask_t		active_irqs;
+	int			*irq_affinity;
 	const char		*name;
 	irqreturn_t		(*handle_irq)(int irq_num, void *dev);
 	void			(*enable)(struct hw_perf_event *evt, int idx);
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 25a5308744b1..19821d936e75 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -25,8 +25,10 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
+#include <linux/of.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
 
@@ -396,7 +398,12 @@ armpmu_release_hardware(struct arm_pmu *armpmu)
 		free_percpu_irq(irq, &cpu_hw_events);
 	} else {
 		for (i = 0; i < irqs; ++i) {
-			if (!cpumask_test_and_clear_cpu(i, &armpmu->active_irqs))
+			int cpu = i;
+
+			if (arm_pmu->irq_affinity)
+				cpu = arm_pmu->irq_affinity[i];
+
+			if (!cpumask_test_and_clear_cpu(cpu, &armpmu->active_irqs))
 				continue;
 			irq = platform_get_irq(pmu_device, i);
 			if (irq > 0)
@@ -450,19 +457,24 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
 		on_each_cpu(armpmu_enable_percpu_irq, &irq, 1);
 	} else {
 		for (i = 0; i < irqs; ++i) {
+			int cpu = i;
+
 			err = 0;
 			irq = platform_get_irq(pmu_device, i);
 			if (irq <= 0)
 				continue;
 
+			if (armpmu->irq_affinity)
+				cpu = armpmu->irq_affinity[i];
+
 			/*
 			 * If we have a single PMU interrupt that we can't shift,
 			 * assume that we're running on a uniprocessor machine and
 			 * continue. Otherwise, continue without this interrupt.
 			 */
-			if (irq_set_affinity(irq, cpumask_of(i)) && irqs > 1) {
+			if (irq_set_affinity(irq, cpumask_of(cpu)) && irqs > 1) {
 				pr_warning("unable to set irq affinity (irq=%d, cpu=%u)\n",
-						irq, i);
+						irq, cpu);
 				continue;
 			}
 
@@ -476,7 +488,7 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
 				return err;
 			}
 
-			cpumask_set_cpu(i, &armpmu->active_irqs);
+			cpumask_set_cpu(cpu, &armpmu->active_irqs);
 		}
 	}
 
@@ -1289,9 +1301,46 @@ static const struct of_device_id armpmu_of_device_ids[] = {
 
 static int armpmu_device_probe(struct platform_device *pdev)
 {
+	int i, *irqs;
+
 	if (!cpu_pmu)
 		return -ENODEV;
 
+	irqs = kcalloc(pdev->num_resources, sizeof(*irqs), GFP_KERNEL);
+	if (!irqs)
+		return -ENOMEM;
+
+	for (i = 0; i < pdev->num_resources; ++i) {
+		struct device_node *dn;
+		int cpu = -1;
+
+		dn = of_parse_phandle(pdev->dev.of_node, "interrupt-affinity",
+				      i);
+		if (!dn) {
+			pr_warn("Failed to parse interrupt-affinity for idx %d\n",
+				i);
+			break;
+		}
+
+		for_each_possible_cpu(cpu)
+			if (arch_find_n_match_cpu_physical_id(dn, cpu, NULL))
+				break;
+
+		if (cpu == -1) {
+			pr_warn("Failed to find logical CPU for %s\n",
+				dn->name);
+			break;
+		}
+
+		irqs[i] = cpu;
+		of_node_put(dn);
+	}
+
+	if (i == pdev->num_resources)
+		cpu_pmu->irq_affinity = irqs;
+	else
+		kfree(irqs);
+
 	cpu_pmu->plat_device = pdev;
 	return 0;
 }
-- 
2.1.4
