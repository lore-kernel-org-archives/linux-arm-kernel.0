From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue, 23 Aug 2016 15:47:59 -0500
Subject: [PATCH v7 8/9] arm64: pmu: Detect and enable multiple PMUs in an ACPI
 system
In-Reply-To: <1471985280-2243-1-git-send-email-jeremy.linton@arm.com>
References: <1471985280-2243-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1471985280-2243-9-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Its possible that an ACPI system has multiple CPU types in it
with differing PMU counters. Iterate the CPU's and make a determination
about how many of each type exist in the system. Then take and create
a PMU platform device for each type, and assign it the interrupts parsed
from the MADT. Creating a platform device is necessary because the PMUs
are not described as devices in the DSDT table.

This code is loosely based on earlier work by Mark Salter.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/perf/arm_pmu.c      |   7 +-
 drivers/perf/arm_pmu_acpi.c | 164 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index ee9e301..98a037a 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -1063,7 +1063,12 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 		if (!ret)
 			ret = init_fn(pmu);
 	} else if (probe_table) {
-		ret = probe_plat_pmu(pmu, probe_table, read_cpuid_id());
+		if (acpi_disabled) {
+			/* use the current cpu. */
+			ret = probe_plat_pmu(pmu, probe_table,
+					     read_cpuid_id());
+		} else
+			ret = probe_plat_pmu(pmu, probe_table, pdev->id);
 	}
 
 	if (ret) {
diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index e784714..c0d6888 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -2,13 +2,17 @@
  * ARM ACPI PMU support
  *
  * Copyright (C) 2015 Red Hat Inc.
+ * Copyright (C) 2016 ARM Ltd.
  * Author: Mark Salter <msalter@redhat.com>
+ *         Jeremy Linton <jeremy.linton@arm.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2.  See
  * the COPYING file in the top-level directory.
  *
  */
 
+#define pr_fmt(fmt) "ACPI-PMU: " fmt
+
 #include <asm/cpu.h>
 #include <linux/acpi.h>
 #include <linux/irq.h>
@@ -23,6 +27,12 @@ struct pmu_irq {
 	bool registered;
 };
 
+struct pmu_types {
+	struct list_head list;
+	int		 cpu_type;
+	int		 cpu_count;
+};
+
 static struct pmu_irq pmu_irqs[NR_CPUS] __initdata;
 
 /*
@@ -39,13 +49,167 @@ void __init arm_pmu_parse_acpi(int cpu, struct acpi_madt_generic_interrupt *gic)
 		pmu_irqs[cpu].trigger = ACPI_LEVEL_SENSITIVE;
 }
 
+/* Count number and type of CPU cores in the system. */
+static void __init arm_pmu_acpi_determine_cpu_types(struct list_head *pmus)
+{
+	int i;
+	bool alloc_failure = false;
+
+	for_each_possible_cpu(i) {
+		struct cpuinfo_arm64 *cinfo = per_cpu_ptr(&cpu_data, i);
+		u32 partnum = MIDR_PARTNUM(cinfo->reg_midr);
+		struct pmu_types *pmu;
+
+		list_for_each_entry(pmu, pmus, list) {
+			if (pmu->cpu_type == partnum) {
+				pmu->cpu_count++;
+				break;
+			}
+		}
+
+		/* we didn't find the CPU type, add an entry to identify it */
+		if ((&pmu->list == pmus) && (!alloc_failure)) {
+			pmu = kzalloc(sizeof(struct pmu_types), GFP_KERNEL);
+			if (!pmu) {
+				pr_warn("Unable to allocate pmu_types\n");
+				/*
+				 * continue to count cpus for any pmu_types
+				 * already allocated, but don't allocate any
+				 * more pmu_types. This avoids undercounting.
+				 */
+				alloc_failure = true;
+			} else {
+				pmu->cpu_type = partnum;
+				pmu->cpu_count++;
+				list_add_tail(&pmu->list, pmus);
+			}
+		}
+	}
+}
+
+/*
+ * Registers the group of PMU interfaces which correspond to the 'last_cpu_id'.
+ * This group utilizes 'count' resources in the 'res'.
+ */
+static int __init arm_pmu_acpi_register_pmu(int count, struct resource *res,
+					    int last_cpu_id)
+{
+	int i;
+	int err = -ENOMEM;
+	bool free_gsi = false;
+	struct platform_device *pdev;
+
+	if (count) {
+		pdev = platform_device_alloc(ARMV8_PMU_PDEV_NAME, last_cpu_id);
+		if (pdev) {
+			err = platform_device_add_resources(pdev, res, count);
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
+
+	/* unmark (and possibly unregister) registered GSIs */
+	for_each_possible_cpu(i) {
+		if (pmu_irqs[i].registered) {
+			if (free_gsi)
+				acpi_unregister_gsi(pmu_irqs[i].gsi);
+			pmu_irqs[i].registered = false;
+		}
+	}
+
+	return err;
+}
+
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
+	/* lets group all the PMU's from similar CPU's together */
+	count = 0;
+	for_each_possible_cpu(i) {
+		struct cpuinfo_arm64 *cinfo = per_cpu_ptr(&cpu_data, i);
+
+		if (pmus->cpu_type == MIDR_PARTNUM(cinfo->reg_midr)) {
+			if (pmu_irqs[i].gsi == 0)
+				continue;
+
+			irq = acpi_register_gsi(NULL, pmu_irqs[i].gsi,
+						pmu_irqs[i].trigger,
+						ACPI_ACTIVE_HIGH);
+
+			res[count].start = res[count].end = irq;
+			res[count].flags = IORESOURCE_IRQ;
+
+			if (pmu_irqs[i].trigger == ACPI_EDGE_SENSITIVE)
+				res[count].flags |= IORESOURCE_IRQ_HIGHEDGE;
+			else
+				res[count].flags |= IORESOURCE_IRQ_HIGHLEVEL;
+
+			pmu_irqs[i].registered = true;
+			count++;
+			(*last_cpu_id) = cinfo->reg_midr;
+		}
+	}
+	return count;
+}
+
 static int __init pmu_acpi_init(void)
 {
+	struct resource	*res;
 	int err = -ENOMEM;
+	int count, cpu_id;
+	struct pmu_types *pmu, *safe_temp;
+	LIST_HEAD(pmus);
 
 	if (acpi_disabled)
 		return 0;
 
+	arm_pmu_acpi_determine_cpu_types(&pmus);
+
+	list_for_each_entry_safe(pmu, safe_temp, &pmus, list) {
+		res = kcalloc(pmu->cpu_count,
+			      sizeof(struct resource), GFP_KERNEL);
+
+		/* for a given PMU type collect all the GSIs. */
+		if (res) {
+			count = arm_pmu_acpi_gsi_res(pmu, res,
+						     &cpu_id);
+			/*
+			 * register this set of interrupts
+			 * with a new PMU device
+			 */
+			err = arm_pmu_acpi_register_pmu(count, res, cpu_id);
+			if (!err)
+				pr_info("Registered %d devices for %X\n",
+					count, pmu->cpu_type);
+			kfree(res);
+		} else
+			pr_warn("PMU unable to allocate interrupt resource space\n");
+
+		list_del(&pmu->list);
+		kfree(pmu);
+	}
+
 	return err;
 }
+
 arch_initcall(pmu_acpi_init);
-- 
2.5.5
