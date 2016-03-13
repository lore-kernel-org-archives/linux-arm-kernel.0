From: jeremy.linton@arm.com (Jeremy Linton)
Date: Sun, 13 Mar 2016 18:23:17 -0500
Subject: [PATCH 3/4] arm64: pmu: Add support for probing with ACPI
In-Reply-To: <1457911398-22412-1-git-send-email-jeremy.linton@arm.com>
References: <1457911398-22412-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1457911398-22412-4-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Salter <msalter@redhat.com>

In the case of ACPI, the PMU IRQ information is contained in the
MADT table. Also, since the PMU does not exist as a device in the
ACPI DSDT table, it is necessary to create a platform device so
that the appropriate driver probing is triggered.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/arm64/kernel/smp.c      |   5 ++
 drivers/perf/Kconfig         |   4 ++
 drivers/perf/Makefile        |   1 +
 drivers/perf/arm_pmu_acpi.c  | 125 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/perf/arm_pmu.h |   7 +++
 5 files changed, 142 insertions(+)
 create mode 100644 drivers/perf/arm_pmu_acpi.c

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b2d5f4e..c6f2c53 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -37,6 +37,7 @@
 #include <linux/completion.h>
 #include <linux/of.h>
 #include <linux/irq_work.h>
+#include <linux/perf/arm_pmu.h>
 
 #include <asm/alternative.h>
 #include <asm/atomic.h>
@@ -502,6 +503,7 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
 			return;
 		}
 		bootcpu_valid = true;
+		arm_pmu_parse_acpi(0, processor);
 		return;
 	}
 
@@ -522,6 +524,9 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
 	 */
 	acpi_set_mailbox_entry(cpu_count, processor);
 
+	/* get PMU irq info */
+	arm_pmu_parse_acpi(cpu_count, processor);
+
 	cpu_count++;
 }
 
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 04e2653..818fa3b 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -12,4 +12,8 @@ config ARM_PMU
 	  Say y if you want to use CPU performance monitors on ARM-based
 	  systems.
 
+config ARM_PMU_ACPI
+	def_bool y
+	depends on ARM_PMU && ACPI
+
 endmenu
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index acd2397..fd8090d 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_ARM_PMU) += arm_pmu.o
+obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
new file mode 100644
index 0000000..722f4ca
--- /dev/null
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -0,0 +1,125 @@
+/*
+ * PMU support
+ *
+ * Copyright (C) 2015 Red Hat Inc.
+ * Author: Mark Salter <msalter@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#include <linux/perf/arm_pmu.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+
+#define PMU_PDEV_NAME "armv8-pmu"
+
+struct pmu_irq {
+	int gsi;
+	int trigger;
+};
+
+static struct pmu_irq pmu_irqs[NR_CPUS] __initdata;
+
+void __init arm_pmu_parse_acpi(int cpu, struct acpi_madt_generic_interrupt *gic)
+{
+	pmu_irqs[cpu].gsi = gic->performance_interrupt;
+	if (gic->flags & ACPI_MADT_PERFORMANCE_IRQ_MODE)
+		pmu_irqs[cpu].trigger = ACPI_EDGE_SENSITIVE;
+	else
+		pmu_irqs[cpu].trigger = ACPI_LEVEL_SENSITIVE;
+}
+
+#ifndef CONFIG_SMP
+/*
+ * In !SMP case, we parse for boot CPU IRQ here.
+ */
+static int __init acpi_parse_pmu_irqs(struct acpi_subtable_header *header,
+				      const unsigned long end)
+{
+	struct acpi_madt_generic_interrupt *gic;
+
+	gic = (struct acpi_madt_generic_interrupt *)header;
+
+	if (cpu_logical_map(0) == (gic->arm_mpidr & MPIDR_HWID_BITMASK))
+		arm_pmu_parse_acpi(0, gic);
+
+	return 0;
+}
+
+static void __init acpi_parse_boot_cpu(void)
+{
+	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
+				      acpi_parse_pmu_irqs, 0);
+}
+#else
+#define acpi_parse_boot_cpu() do {} while (0)
+#endif
+
+static int __init pmu_acpi_init(void)
+{
+	struct platform_device *pdev;
+	struct pmu_irq *pirq = pmu_irqs;
+	struct resource	*res, *r;
+	int err = -ENOMEM;
+	int i, count, irq;
+
+	if (acpi_disabled)
+		return 0;
+
+	acpi_parse_boot_cpu();
+
+	/* Must have irq for boot boot cpu, at least */
+	if (pirq->gsi == 0)
+		return -EINVAL;
+
+	irq = acpi_register_gsi(NULL, pirq->gsi, pirq->trigger,
+				ACPI_ACTIVE_HIGH);
+
+	if (irq_is_percpu(irq))
+		count = 1;
+	else
+		for (i = 1, count = 1; i < NR_CPUS; i++)
+			if (pmu_irqs[i].gsi)
+				++count;
+
+	pdev = platform_device_alloc(PMU_PDEV_NAME, -1);
+	if (!pdev)
+		goto err_free_gsi;
+
+	res = kcalloc(count, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		goto err_free_device;
+
+	for (i = 0, r = res; i < count; i++, pirq++, r++) {
+		if (i)
+			irq = acpi_register_gsi(NULL, pirq->gsi, pirq->trigger,
+						ACPI_ACTIVE_HIGH);
+		r->start = r->end = irq;
+		r->flags = IORESOURCE_IRQ;
+		if (pirq->trigger == ACPI_EDGE_SENSITIVE)
+			r->flags |= IORESOURCE_IRQ_HIGHEDGE;
+		else
+			r->flags |= IORESOURCE_IRQ_HIGHLEVEL;
+	}
+
+	err = platform_device_add_resources(pdev, res, count);
+	if (!err)
+		err = platform_device_add(pdev);
+	kfree(res);
+	if (!err)
+		return 0;
+
+err_free_device:
+	platform_device_put(pdev);
+
+err_free_gsi:
+	for (i = 0; i < count; i++)
+		acpi_unregister_gsi(pmu_irqs[i].gsi);
+
+	return err;
+}
+arch_initcall(pmu_acpi_init);
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 495332f..d002269 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -154,4 +154,11 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 
 #endif /* CONFIG_ARM_PMU */
 
+#ifdef CONFIG_ARM_PMU_ACPI
+struct acpi_madt_generic_interrupt;
+void arm_pmu_parse_acpi(int cpu, struct acpi_madt_generic_interrupt *gic);
+#else
+#define arm_pmu_parse_acpi(a, b) do { } while (0)
+#endif /* CONFIG_ARM_PMU_ACPI */
+
 #endif /* __ARM_PMU_H__ */
-- 
2.4.3
