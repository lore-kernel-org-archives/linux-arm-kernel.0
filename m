From: jeremy.linton@arm.com (Jeremy Linton)
Date: Mon, 29 Aug 2016 16:48:16 -0500
Subject: [PATCH v8 5/9] arm64: pmu: Cache PMU interrupt numbers from MADT parse
In-Reply-To: <1472507300-9844-1-git-send-email-jeremy.linton@arm.com>
References: <1472507300-9844-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1472507300-9844-6-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Salter <msalter@redhat.com>

In the case of ACPI, the PMU IRQ information is contained in the
MADT table. Also, since the PMU does not exist as a device in the
ACPI DSDT table, it is necessary to create a platform device so
that the appropriate driver probing is triggered. Since the platform
device creation needs to happen after the CPU's have been started, and
the MADT parsing needs to happen before, we save off the interrupt
numbers discovered during the parsing.

Signed-off-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/smp.c      |  5 +++++
 drivers/perf/Kconfig         |  4 ++++
 drivers/perf/Makefile        |  1 +
 drivers/perf/arm_pmu_acpi.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/perf/arm_pmu.h |  7 +++++++
 5 files changed, 57 insertions(+)
 create mode 100644 drivers/perf/arm_pmu_acpi.c

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index a6552fe..dc333c6 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -37,6 +37,7 @@
 #include <linux/completion.h>
 #include <linux/of.h>
 #include <linux/irq_work.h>
+#include <linux/perf/arm_pmu.h>
 
 #include <asm/alternative.h>
 #include <asm/atomic.h>
@@ -540,6 +541,7 @@ acpi_verify_and_map_madt(struct acpi_madt_generic_interrupt *processor)
 			return;
 		}
 		bootcpu_valid = true;
+		arm_pmu_parse_acpi(0, processor);
 		return;
 	}
 
@@ -560,6 +562,9 @@ acpi_verify_and_map_madt(struct acpi_madt_generic_interrupt *processor)
 	 */
 	acpi_set_mailbox_entry(cpu_count, processor);
 
+	/* get PMU irq info */
+	arm_pmu_parse_acpi(cpu_count, processor);
+
 	early_map_cpu_to_node(cpu_count, acpi_numa_get_nid(cpu_count, hwid));
 
 	cpu_count++;
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
index 0000000..c1cf00c
--- /dev/null
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -0,0 +1,40 @@
+/*
+ * ARM ACPI PMU support
+ *
+ * Copyright (C) 2015 Red Hat Inc.
+ * Author: Mark Salter <msalter@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#include <asm/cpu.h>
+#include <linux/acpi.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/list.h>
+#include <linux/perf/arm_pmu.h>
+#include <linux/platform_device.h>
+
+struct pmu_irq {
+	int  gsi;
+	int  trigger;
+	bool registered;
+};
+
+static struct pmu_irq pmu_irqs[NR_CPUS] __initdata;
+
+/*
+ * Called from acpi_verify_and_map_madt()'s MADT parsing during boot.
+ * This routine saves off the GSI's and their trigger state for use when we are
+ * ready to build the PMU platform device.
+*/
+void __init arm_pmu_parse_acpi(int cpu, struct acpi_madt_generic_interrupt *gic)
+{
+	pmu_irqs[cpu].gsi = gic->performance_interrupt;
+	if (gic->flags & ACPI_MADT_PERFORMANCE_IRQ_MODE)
+		pmu_irqs[cpu].trigger = ACPI_EDGE_SENSITIVE;
+	else
+		pmu_irqs[cpu].trigger = ACPI_LEVEL_SENSITIVE;
+}
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index eab9014..535c9e2 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -155,4 +155,11 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 
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
2.5.5
