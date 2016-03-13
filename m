From: jeremy.linton@arm.com (Jeremy Linton)
Date: Sun, 13 Mar 2016 18:23:18 -0500
Subject: [PATCH 4/4] arm64: pmu: add A72 cpu type, support multiple PMU types
In-Reply-To: <1457911398-22412-1-git-send-email-jeremy.linton@arm.com>
References: <1457911398-22412-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1457911398-22412-5-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM big/little machines can have PMU's with differing PMU counters.
ACPI systems should be able to support this as well. Also add support
for A72 PMU counters.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/cputype.h |   1 +
 arch/arm64/kernel/perf_event.c   |   1 +
 drivers/perf/arm_pmu.c           |  54 +++++++--
 drivers/perf/arm_pmu_acpi.c      | 229 +++++++++++++++++++++++++++------------
 4 files changed, 204 insertions(+), 81 deletions(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 87e1985..1e40799 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -74,6 +74,7 @@
 
 #define ARM_CPU_PART_AEM_V8		0xD0F
 #define ARM_CPU_PART_FOUNDATION		0xD00
+#define ARM_CPU_PART_CORTEX_A72		0xD08
 #define ARM_CPU_PART_CORTEX_A57		0xD07
 #define ARM_CPU_PART_CORTEX_A53		0xD03
 
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 03e0957..b3ea97f 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -904,6 +904,7 @@ static const struct of_device_id armv8_pmu_of_device_ids[] = {
 static const struct pmu_probe_info armv8_pmu_probe_table[] = {
 	ARMV8_PMU_PART_PROBE(ARM_CPU_PART_CORTEX_A53, armv8_a53_pmu_init),
 	ARMV8_PMU_PART_PROBE(ARM_CPU_PART_CORTEX_A57, armv8_a57_pmu_init),
+	ARMV8_PMU_PART_PROBE(ARM_CPU_PART_CORTEX_A72, armv8_a72_pmu_init),
 	PMU_PROBE(0, 0, armv8_pmuv3_init), /* if all else fails... */
 	{ /* sentinel value */ }
 };
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 0f33c96..87f975f 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -11,6 +11,7 @@
  */
 #define pr_fmt(fmt) "hw perfevents: " fmt
 
+#include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
@@ -24,6 +25,7 @@
 #include <linux/irq.h>
 #include <linux/irqdesc.h>
 
+#include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/irq_regs.h>
 
@@ -853,25 +855,51 @@ static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
 }
 
 /*
- * CPU PMU identification and probing.
+ * CPU PMU identification and probing. Its possible to have
+ * multiple CPU types in an ARM machine. Assure that we are
+ * picking the right PMU types based on the CPU in question
  */
-static int probe_current_pmu(struct arm_pmu *pmu,
-			     const struct pmu_probe_info *info)
+static int probe_plat_pmu(struct arm_pmu *pmu,
+			     const struct pmu_probe_info *info,
+			     unsigned int pmuid)
 {
-	int cpu = get_cpu();
-	unsigned int cpuid = read_cpuid_id();
 	int ret = -ENODEV;
+	int cpu;
+	int aff_ctr = 0;
+	struct platform_device *pdev = pmu->plat_device;
+	int irq = platform_get_irq(pdev, 0);
 
-	pr_info("probing PMU on CPU %d\n", cpu);
+	if (irq >= 0 && !irq_is_percpu(irq)) {
+		pmu->irq_affinity = kcalloc(pdev->num_resources, sizeof(int),
+					    GFP_KERNEL);
+		if (!pmu->irq_affinity)
+			return -ENOMEM;
+	}
 
+	for_each_possible_cpu(cpu) {
+		struct cpuinfo_arm64 *cinfo = per_cpu_ptr(&cpu_data, cpu);
+		unsigned int cpuid = cinfo->reg_midr;
+
+		if (cpuid == pmuid) {
+			cpumask_set_cpu(cpu, &pmu->supported_cpus);
+			pr_devel("enable pmu on cpu %d\n", cpu);
+			if (pmu->irq_affinity) {
+				pmu->irq_affinity[aff_ctr] = cpu;
+				aff_ctr++;
+			}
+		}
+	}
+
+	pr_debug("probing PMU %X\n", pmuid);
+	/* find the type of PMU given the CPU */
 	for (; info->init != NULL; info++) {
-		if ((cpuid & info->mask) != info->cpuid)
+		if ((pmuid & info->mask) != info->cpuid)
 			continue;
+		pr_devel("Found PMU\n");
 		ret = info->init(pmu);
 		break;
 	}
 
-	put_cpu();
 	return ret;
 }
 
@@ -997,8 +1025,14 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 		if (!ret)
 			ret = init_fn(pmu);
 	} else {
-		cpumask_setall(&pmu->supported_cpus);
-		ret = probe_current_pmu(pmu, probe_table);
+		if (acpi_disabled) {
+			/* use the boot cpu. */
+			struct cpuinfo_arm64 *cinfo = per_cpu_ptr(&cpu_data, 0);
+			unsigned int cpuid = cinfo->reg_midr;
+
+			ret = probe_plat_pmu(pmu, probe_table, cpuid);
+		} else
+			ret = probe_plat_pmu(pmu, probe_table, pdev->id);
 	}
 
 	if (ret) {
diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 722f4ca..793092c 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -2,6 +2,7 @@
  * PMU support
  *
  * Copyright (C) 2015 Red Hat Inc.
+ * Copyright (C) 2016 ARM Ltd.
  * Author: Mark Salter <msalter@redhat.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2.  See
@@ -9,21 +10,35 @@
  *
  */
 
+#define pr_fmt(fmt) "ACPI-PMU: " fmt
 #include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
 #include <linux/irq.h>
 #include <linux/irqdesc.h>
 
+#include <asm/cpu.h>
+
 #define PMU_PDEV_NAME "armv8-pmu"
 
 struct pmu_irq {
-	int gsi;
-	int trigger;
+	int  gsi;
+	int  trigger;
+	bool registered;
+};
+
+struct pmu_types {
+	int cpu_type;
+	int cpu_count;
 };
 
 static struct pmu_irq pmu_irqs[NR_CPUS] __initdata;
 
+/*
+ * called from acpi_map_gic_cpu_interface()'s MADT parsing callback during boot
+ * this routine saves off the GSI's and their trigger state for use when we are
+ * ready to build the PMU platform device.
+*/
 void __init arm_pmu_parse_acpi(int cpu, struct acpi_madt_generic_interrupt *gic)
 {
 	pmu_irqs[cpu].gsi = gic->performance_interrupt;
@@ -31,95 +46,167 @@ void __init arm_pmu_parse_acpi(int cpu, struct acpi_madt_generic_interrupt *gic)
 		pmu_irqs[cpu].trigger = ACPI_EDGE_SENSITIVE;
 	else
 		pmu_irqs[cpu].trigger = ACPI_LEVEL_SENSITIVE;
+	pr_info("Assign CPU %d girq %d level %d\n", cpu, pmu_irqs[cpu].gsi,
+						   pmu_irqs[cpu].trigger);
 }
 
-#ifndef CONFIG_SMP
-/*
- * In !SMP case, we parse for boot CPU IRQ here.
- */
-static int __init acpi_parse_pmu_irqs(struct acpi_subtable_header *header,
-				      const unsigned long end)
-{
-	struct acpi_madt_generic_interrupt *gic;
-
-	gic = (struct acpi_madt_generic_interrupt *)header;
-
-	if (cpu_logical_map(0) == (gic->arm_mpidr & MPIDR_HWID_BITMASK))
-		arm_pmu_parse_acpi(0, gic);
-
-	return 0;
-}
-
-static void __init acpi_parse_boot_cpu(void)
+/* count number and type of CPU's in system */
+static void __init arm_pmu_acpi_determine_cpu_types(struct pmu_types *pmus)
 {
-	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
-				      acpi_parse_pmu_irqs, 0);
+	int i, j;
+
+	for_each_possible_cpu(i) {
+		struct cpuinfo_arm64 *cinfo = per_cpu_ptr(&cpu_data, i);
+
+		pr_devel("Present CPU %d is a %X\n", i,
+					       MIDR_PARTNUM(cinfo->reg_midr));
+		for (j = 0; j < NR_CPUS; j++) {
+			if (pmus[j].cpu_type == MIDR_PARTNUM(cinfo->reg_midr)) {
+				pmus[j].cpu_count++;
+				break;
+			}
+			if (pmus[j].cpu_count == 0) {
+				pmus[j].cpu_type = MIDR_PARTNUM(cinfo->reg_midr);
+				pmus[j].cpu_count++;
+				break;
+			}
+		}
+	}
 }
-#else
-#define acpi_parse_boot_cpu() do {} while (0)
-#endif
 
-static int __init pmu_acpi_init(void)
+static int __init arm_pmu_acpi_register_pmu(int count, struct resource *res,
+					    int last_cpu_id)
 {
-	struct platform_device *pdev;
-	struct pmu_irq *pirq = pmu_irqs;
-	struct resource	*res, *r;
+	int i;
 	int err = -ENOMEM;
-	int i, count, irq;
+	bool free_gsi = false;
+	struct platform_device *pdev;
 
-	if (acpi_disabled)
-		return 0;
+	if (count) {
+		pdev = platform_device_alloc(PMU_PDEV_NAME, last_cpu_id);
+
+		if (pdev) {
+			err = platform_device_add_resources(pdev,
+							    res, count);
+			if (!err) {
+				err = platform_device_add(pdev);
+				if (err) {
+					pr_warn("Unable to register PMU device\n");
+					free_gsi = true;
+				}
+			} else {
+				pr_warn("Unable to add resources to device\n");
+				free_gsi = true;
+				platform_device_put(pdev);
+			}
+		} else {
+			pr_warn("Unable to allocate platform device\n");
+			free_gsi = true;
+		}
+	}
 
-	acpi_parse_boot_cpu();
+	/* unmark (and possibly unregister) registered GSIs */
+	for_each_possible_cpu(i) {
+		if (pmu_irqs[i].registered) {
+			if (free_gsi)
+				acpi_unregister_gsi(pmu_irqs[i].gsi);
+			pmu_irqs[i].registered = false;
+		}
+	}
 
-	/* Must have irq for boot boot cpu, at least */
-	if (pirq->gsi == 0)
-		return -EINVAL;
+	return err;
+}
 
-	irq = acpi_register_gsi(NULL, pirq->gsi, pirq->trigger,
-				ACPI_ACTIVE_HIGH);
+/*
+ * For the given cpu/pmu type, walk all known GSIs, register them, and add
+ * them to the resource structure. Return the number of GSI's contained
+ * in the res structure, and the id of the last CPU/PMU we added.
+ */
+static int __init arm_pmu_acpi_gsi_res(struct pmu_types *pmus,
+				       struct resource *res, int *last_cpu_id)
+{
+	int i, count;
+	int irq;
+
+	pr_info("Setting up %d PMUs for CPU type %X\n", pmus->cpu_count,
+							pmus->cpu_type);
+	/* lets group all the PMU's from similar CPU's together */
+	count = 0;
+	for_each_possible_cpu(i) {
+		struct cpuinfo_arm64 *cinfo = per_cpu_ptr(&cpu_data, i);
+
+		if (pmus->cpu_type == MIDR_PARTNUM(cinfo->reg_midr)) {
+			pr_devel("Setting up CPU %d\n", i);
+			if (pmu_irqs[i].gsi == 0)
+				continue;
+
+			irq = acpi_register_gsi(NULL, pmu_irqs[i].gsi,
+						pmu_irqs[i].trigger,
+						ACPI_ACTIVE_HIGH);
 
-	if (irq_is_percpu(irq))
-		count = 1;
-	else
-		for (i = 1, count = 1; i < NR_CPUS; i++)
-			if (pmu_irqs[i].gsi)
-				++count;
+			res[count].start = res[count].end = irq;
+			res[count].flags = IORESOURCE_IRQ;
 
-	pdev = platform_device_alloc(PMU_PDEV_NAME, -1);
-	if (!pdev)
-		goto err_free_gsi;
+			if (pmu_irqs[i].trigger == ACPI_EDGE_SENSITIVE)
+				res[count].flags |= IORESOURCE_IRQ_HIGHEDGE;
+			else
+				res[count].flags |= IORESOURCE_IRQ_HIGHLEVEL;
 
-	res = kcalloc(count, sizeof(*res), GFP_KERNEL);
-	if (!res)
-		goto err_free_device;
+			pmu_irqs[i].registered = true;
+			count++;
+			(*last_cpu_id) = cinfo->reg_midr;
 
-	for (i = 0, r = res; i < count; i++, pirq++, r++) {
-		if (i)
-			irq = acpi_register_gsi(NULL, pirq->gsi, pirq->trigger,
-						ACPI_ACTIVE_HIGH);
-		r->start = r->end = irq;
-		r->flags = IORESOURCE_IRQ;
-		if (pirq->trigger == ACPI_EDGE_SENSITIVE)
-			r->flags |= IORESOURCE_IRQ_HIGHEDGE;
-		else
-			r->flags |= IORESOURCE_IRQ_HIGHLEVEL;
+			if (irq_is_percpu(irq))
+				pr_debug("PPI detected\n");
+		}
 	}
+	return count;
+}
 
-	err = platform_device_add_resources(pdev, res, count);
-	if (!err)
-		err = platform_device_add(pdev);
-	kfree(res);
-	if (!err)
-		return 0;
+static int __init pmu_acpi_init(void)
+{
+	struct resource	*res;
+	int err = -ENOMEM;
+	int count;
+	int j, last_cpu_id;
+	struct pmu_types *pmus;
 
-err_free_device:
-	platform_device_put(pdev);
+	pr_debug("Prepare registration\n");
+	if (acpi_disabled)
+		return 0;
 
-err_free_gsi:
-	for (i = 0; i < count; i++)
-		acpi_unregister_gsi(pmu_irqs[i].gsi);
+	pmus = kcalloc(NR_CPUS, sizeof(struct pmu_types), GFP_KERNEL);
+
+	if (pmus) {
+		arm_pmu_acpi_determine_cpu_types(pmus);
+
+		for (j = 0; pmus[j].cpu_count; j++) {
+			pr_devel("CPU type %d, count %d\n", pmus[j].cpu_type,
+				 pmus[j].cpu_count);
+			res = kcalloc(pmus[j].cpu_count,
+				      sizeof(struct resource), GFP_KERNEL);
+
+			/* for a given PMU type collect all the GSIs. */
+			if (res) {
+				count = arm_pmu_acpi_gsi_res(&pmus[j], res,
+							     &last_cpu_id);
+				/*
+				 * register this set of interrupts
+				 * with a new PMU device
+				 */
+				err = arm_pmu_acpi_register_pmu(count,
+								res,
+								last_cpu_id);
+				kfree(res);
+			} else
+				pr_warn("PMU unable to allocate interrupt resource space\n");
+		}
+
+		kfree(pmus);
+	} else
+		pr_warn("PMU: Unable to allocate pmu count structures\n");
 
 	return err;
 }
+
 arch_initcall(pmu_acpi_init);
-- 
2.4.3
