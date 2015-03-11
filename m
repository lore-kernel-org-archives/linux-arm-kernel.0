From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 11 Mar 2015 20:39:42 +0800
Subject: [PATCH v10 16/21] irqchip: Add GICv2 specific ACPI boot support
In-Reply-To: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1426077587-1561-17-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

ACPI kernel uses MADT table for proper GIC initialization. It needs to
parse GIC related subtables, collect CPU interface and distributor
addresses and call driver initialization function (which is hardware
abstraction agnostic). In a similar way, FDT initialize GICv1/2.

NOTE: This commit allow to initialize GICv1/2 basic functionality.
While now simple GICv2 init call is used, any further GIC features
require generic infrastructure for proper ACPI irqchip initialization.
That mechanism and stacked irqdomains to support GICv2 MSI/virtualization
extension, GICv3/4 and its ITS are considered as next steps.

CC: Jason Cooper <jason@lakedaemon.net>
CC: Marc Zyngier <marc.zyngier@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Yijing Wang <wangyijing@huawei.com>
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
Tested-by: Jon Masters <jcm@redhat.com>
Tested-by: Timur Tabi <timur@codeaurora.org>
Tested-by: Robert Richter <rrichter@cavium.com>
Acked-by: Robert Richter <rrichter@cavium.com>
Reviewed-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/acpi.h        |   2 +
 arch/arm64/include/asm/irq.h         |  13 +++++
 arch/arm64/kernel/acpi.c             |  25 +++++++++
 drivers/irqchip/irq-gic.c            | 102 +++++++++++++++++++++++++++++++++++
 drivers/irqchip/irqchip.c            |   3 ++
 include/linux/acpi_irq.h             |  10 ++++
 include/linux/irqchip/arm-gic-acpi.h |  31 +++++++++++
 7 files changed, 186 insertions(+)
 create mode 100644 include/linux/acpi_irq.h
 create mode 100644 include/linux/irqchip/arm-gic-acpi.h

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index eea0bc3..59c05d8 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -13,6 +13,8 @@
 #define _ASM_ACPI_H
 
 #include <linux/mm.h>
+#include <linux/irqchip/arm-gic-acpi.h>
+
 #include <asm/cputype.h>
 #include <asm/smp_plat.h>
 
diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index 94c5367..bbb251b 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_IRQ_H
 #define __ASM_IRQ_H
 
+#include <linux/irqchip/arm-gic-acpi.h>
+
 #include <asm-generic/irq.h>
 
 struct pt_regs;
@@ -8,4 +10,15 @@ struct pt_regs;
 extern void migrate_irqs(void);
 extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 
+static inline void acpi_irq_init(void)
+{
+	/*
+	 * Hardcode ACPI IRQ chip initialization to GICv2 for now.
+	 * Proper irqchip infrastructure will be implemented along with
+	 * incoming  GICv2m|GICv3|ITS bits.
+	 */
+	acpi_gic_init();
+}
+#define acpi_irq_init acpi_irq_init
+
 #endif
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index dec6f8a..6468f88 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -359,3 +359,28 @@ void __init acpi_boot_table_init(void)
 		pr_err("Can't find FADT\n");
 	}
 }
+
+void __init acpi_gic_init(void)
+{
+	struct acpi_table_header *table;
+	acpi_status status;
+	acpi_size tbl_size;
+	int err;
+
+	if (acpi_disabled)
+		return;
+
+	status = acpi_get_table_with_size(ACPI_SIG_MADT, 0, &table, &tbl_size);
+	if (ACPI_FAILURE(status)) {
+		const char *msg = acpi_format_exception(status);
+
+		pr_err("Failed to get MADT table, %s\n", msg);
+		return;
+	}
+
+	err = gic_v2_acpi_init(table);
+	if (err)
+		pr_err("Failed to initialize GIC IRQ controller");
+
+	early_acpi_os_unmap_memory((char *)table, tbl_size);
+}
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4634cf7..929d668 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -33,12 +33,14 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/acpi.h>
 #include <linux/irqdomain.h>
 #include <linux/interrupt.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/arm-gic.h>
+#include <linux/irqchip/arm-gic-acpi.h>
 
 #include <asm/cputype.h>
 #include <asm/irq.h>
@@ -1086,3 +1088,103 @@ IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
 IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
 
 #endif
+
+#ifdef CONFIG_ACPI
+static phys_addr_t dist_phy_base, cpu_phy_base __initdata;
+
+static int __init
+gic_acpi_parse_madt_cpu(struct acpi_subtable_header *header,
+			const unsigned long end)
+{
+	struct acpi_madt_generic_interrupt *processor;
+	phys_addr_t gic_cpu_base;
+	static int cpu_base_assigned;
+
+	processor = (struct acpi_madt_generic_interrupt *)header;
+
+	if (BAD_MADT_ENTRY(processor, end))
+		return -EINVAL;
+
+	/*
+	 * There is no support for non-banked GICv1/2 register in ACPI spec.
+	 * All CPU interface addresses have to be the same.
+	 */
+	gic_cpu_base = processor->base_address;
+	if (cpu_base_assigned && gic_cpu_base != cpu_phy_base)
+		return -EINVAL;
+
+	cpu_phy_base = gic_cpu_base;
+	cpu_base_assigned = 1;
+	return 0;
+}
+
+static int __init
+gic_acpi_parse_madt_distributor(struct acpi_subtable_header *header,
+				const unsigned long end)
+{
+	struct acpi_madt_generic_distributor *dist;
+
+	dist = (struct acpi_madt_generic_distributor *)header;
+
+	if (BAD_MADT_ENTRY(dist, end))
+		return -EINVAL;
+
+	dist_phy_base = dist->base_address;
+	return 0;
+}
+
+int __init
+gic_v2_acpi_init(struct acpi_table_header *table)
+{
+	void __iomem *cpu_base, *dist_base;
+	int count;
+
+	/* Collect CPU base addresses */
+	count = acpi_parse_entries(ACPI_SIG_MADT,
+				   sizeof(struct acpi_table_madt),
+				   gic_acpi_parse_madt_cpu, table,
+				   ACPI_MADT_TYPE_GENERIC_INTERRUPT, 0);
+	if (count <= 0) {
+		pr_err("No valid GICC entries exist\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Find distributor base address. We expect one distributor entry since
+	 * ACPI 5.1 spec neither support multi-GIC instances nor GIC cascade.
+	 */
+	count = acpi_parse_entries(ACPI_SIG_MADT,
+				   sizeof(struct acpi_table_madt),
+				   gic_acpi_parse_madt_distributor, table,
+				   ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR, 0);
+	if (count <= 0) {
+		pr_err("No valid GICD entries exist\n");
+		return -EINVAL;
+	} else if (count > 1) {
+		pr_err("More than one GICD entry detected\n");
+		return -EINVAL;
+	}
+
+	cpu_base = ioremap(cpu_phy_base, ACPI_GIC_CPU_IF_MEM_SIZE);
+	if (!cpu_base) {
+		pr_err("Unable to map GICC registers\n");
+		return -ENOMEM;
+	}
+
+	dist_base = ioremap(dist_phy_base, ACPI_GICV2_DIST_MEM_SIZE);
+	if (!dist_base) {
+		pr_err("Unable to map GICD registers\n");
+		iounmap(cpu_base);
+		return -ENOMEM;
+	}
+
+	/*
+	 * Initialize zero GIC instance (no multi-GIC support). Also, set GIC
+	 * as default IRQ domain to allow for GSI registration and GSI to IRQ
+	 * number translation (see acpi_register_gsi() and acpi_gsi_to_irq()).
+	 */
+	gic_init_bases(0, -1, dist_base, cpu_base, 0, NULL);
+	irq_set_default_host(gic_data[0].domain);
+	return 0;
+}
+#endif
diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 0fe2f71..afd1af3 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -8,6 +8,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/acpi_irq.h>
 #include <linux/init.h>
 #include <linux/of_irq.h>
 #include <linux/irqchip.h>
@@ -26,4 +27,6 @@ extern struct of_device_id __irqchip_of_table[];
 void __init irqchip_init(void)
 {
 	of_irq_init(__irqchip_of_table);
+
+	acpi_irq_init();
 }
diff --git a/include/linux/acpi_irq.h b/include/linux/acpi_irq.h
new file mode 100644
index 0000000..e4e8a81
--- /dev/null
+++ b/include/linux/acpi_irq.h
@@ -0,0 +1,10 @@
+#ifndef _LINUX_ACPI_IRQ_H
+#define _LINUX_ACPI_IRQ_H
+
+#include <asm/irq.h>
+
+#ifndef acpi_irq_init
+static inline void acpi_irq_init(void) { }
+#endif
+
+#endif /* _LINUX_ACPI_IRQ_H */
diff --git a/include/linux/irqchip/arm-gic-acpi.h b/include/linux/irqchip/arm-gic-acpi.h
new file mode 100644
index 0000000..de3419e
--- /dev/null
+++ b/include/linux/irqchip/arm-gic-acpi.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) 2014, Linaro Ltd.
+ *	Author: Tomasz Nowicki <tomasz.nowicki@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef ARM_GIC_ACPI_H_
+#define ARM_GIC_ACPI_H_
+
+#ifdef CONFIG_ACPI
+
+/*
+ * Hard code here, we can not get memory size from MADT (but FDT does),
+ * Actually no need to do that, because this size can be inferred
+ * from GIC spec.
+ */
+#define ACPI_GICV2_DIST_MEM_SIZE	(SZ_4K)
+#define ACPI_GIC_CPU_IF_MEM_SIZE	(SZ_8K)
+
+struct acpi_table_header;
+
+int gic_v2_acpi_init(struct acpi_table_header *table);
+void acpi_gic_init(void);
+#else
+static inline void acpi_gic_init(void) { }
+#endif
+
+#endif /* ARM_GIC_ACPI_H_ */
-- 
1.9.1
