From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue, 21 Jun 2016 12:11:47 -0500
Subject: [PATCH 09/11] arm64: pmu: Add routines for detecting differing PMU
 types in the system
In-Reply-To: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
References: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1466529109-21715-10-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for enabling heterogeneous PMUs on ACPI systems
add routines that detect this and group the resulting PMUs and
interrupts.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/perf/arm_pmu_acpi.c | 137 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index a24cdd0..482a54d 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -1,23 +1,36 @@
 /*
- * PMU support
+ * ARM ACPI PMU support
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
+#include <asm/cpu.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
 #include <linux/irq.h>
 #include <linux/irqdesc.h>
+#include <linux/list.h>
 
 struct pmu_irq {
-	int gsi;
-	int trigger;
+	int  gsi;
+	int  trigger;
+	bool registered;
+};
+
+struct pmu_types {
+	struct list_head list;
+	int		 cpu_type;
+	int		 cpu_count;
 };
 
 static struct pmu_irq pmu_irqs[NR_CPUS] __initdata;
@@ -36,6 +49,124 @@ void __init arm_pmu_parse_acpi(int cpu, struct acpi_madt_generic_interrupt *gic)
 		pmu_irqs[cpu].trigger = ACPI_LEVEL_SENSITIVE;
 }
 
+/* Count number and type of CPU cores in the system. */
+void __init arm_pmu_acpi_determine_cpu_types(struct list_head *pmus)
+{
+	int i;
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
+		if (&pmu->list == pmus) {
+			pmu = kcalloc(1, sizeof(struct pmu_types), GFP_KERNEL);
+			if (!pmu) {
+				pr_warn("Unable to allocate pmu_types\n");
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
+int __init arm_pmu_acpi_register_pmu(int count, struct resource *res,
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
+int __init arm_pmu_acpi_gsi_res(struct pmu_types *pmus,
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
 	struct platform_device *pdev;
-- 
2.5.5
