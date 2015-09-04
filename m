From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  4 Sep 2015 18:06:50 +0100
Subject: [PATCH 3/5] irqchip/gic: Convert the GIC driver to ACPI probing
In-Reply-To: <1441386412-8139-1-git-send-email-marc.zyngier@arm.com>
References: <1441386412-8139-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1441386412-8139-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a basic infrastructure to register irqchips and
call them on discovery of a matching entry in MADT, convert the
GIC driver to this new probing method.

It ends up being a code deletion party, which is a rather good thing.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/acpi.h        |  1 -
 arch/arm64/include/asm/irq.h         |  2 --
 arch/arm64/kernel/acpi.c             | 25 -------------
 drivers/irqchip/irq-gic.c            | 69 ++++++++++++++++++------------------
 drivers/irqchip/irqchip.c            |  3 --
 include/linux/irqchip/arm-gic-acpi.h | 31 ----------------
 6 files changed, 35 insertions(+), 96 deletions(-)
 delete mode 100644 include/linux/irqchip/arm-gic-acpi.h

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 406485e..de97359 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -13,7 +13,6 @@
 #define _ASM_ACPI_H
 
 #include <linux/mm.h>
-#include <linux/irqchip/arm-gic-acpi.h>
 
 #include <asm/cputype.h>
 #include <asm/psci.h>
diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index 1a1037a..94c5367 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_IRQ_H
 #define __ASM_IRQ_H
 
-#include <linux/irqchip/arm-gic-acpi.h>
-
 #include <asm-generic/irq.h>
 
 struct pt_regs;
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 19de753..d6463bb 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -205,28 +205,3 @@ void __init acpi_boot_table_init(void)
 			disable_acpi();
 	}
 }
-
-void __init acpi_gic_init(void)
-{
-	struct acpi_table_header *table;
-	acpi_status status;
-	acpi_size tbl_size;
-	int err;
-
-	if (acpi_disabled)
-		return;
-
-	status = acpi_get_table_with_size(ACPI_SIG_MADT, 0, &table, &tbl_size);
-	if (ACPI_FAILURE(status)) {
-		const char *msg = acpi_format_exception(status);
-
-		pr_err("Failed to get MADT table, %s\n", msg);
-		return;
-	}
-
-	err = gic_v2_acpi_init(table);
-	if (err)
-		pr_err("Failed to initialize GIC IRQ controller");
-
-	early_acpi_os_unmap_memory((char *)table, tbl_size);
-}
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4dd8826..5570f5c 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -40,7 +40,6 @@
 #include <linux/slab.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/arm-gic.h>
-#include <linux/irqchip/arm-gic-acpi.h>
 
 #include <asm/cputype.h>
 #include <asm/irq.h>
@@ -1043,7 +1042,7 @@ IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
 #endif
 
 #ifdef CONFIG_ACPI
-static phys_addr_t dist_phy_base, cpu_phy_base __initdata;
+static phys_addr_t cpu_phy_base __initdata;
 
 static int __init
 gic_acpi_parse_madt_cpu(struct acpi_subtable_header *header,
@@ -1071,60 +1070,56 @@ gic_acpi_parse_madt_cpu(struct acpi_subtable_header *header,
 	return 0;
 }
 
-static int __init
-gic_acpi_parse_madt_distributor(struct acpi_subtable_header *header,
-				const unsigned long end)
+/* The things you have to do to just *count* something... */
+static int __init acpi_dummy_func(struct acpi_subtable_header *header,
+				  const unsigned long end)
 {
-	struct acpi_madt_generic_distributor *dist;
+	return 0;
+}
 
-	dist = (struct acpi_madt_generic_distributor *)header;
+static bool __init acpi_gic_redist_is_present(void)
+{
+	return acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR,
+				     acpi_dummy_func, 0) > 0;
+}
 
-	if (BAD_MADT_ENTRY(dist, end))
-		return -EINVAL;
+static bool __init gic_validate_dist(struct acpi_subtable_header *header,
+				     struct acpi_probe_entry *ape)
+{
+	struct acpi_madt_generic_distributor *dist;
+	dist = (struct acpi_madt_generic_distributor *)header;
 
-	dist_phy_base = dist->base_address;
-	return 0;
+	return (dist->version == ape->driver_data &&
+		(dist->version != ACPI_MADT_GIC_VERSION_NONE ||
+		 !acpi_gic_redist_is_present()));
 }
 
-int __init
-gic_v2_acpi_init(struct acpi_table_header *table)
+#define ACPI_GICV2_DIST_MEM_SIZE	(SZ_4K)
+#define ACPI_GIC_CPU_IF_MEM_SIZE	(SZ_8K)
+
+static int __init gic_v2_acpi_init(struct acpi_subtable_header *header,
+				   const unsigned long end)
 {
+	struct acpi_madt_generic_distributor *dist;
 	void __iomem *cpu_base, *dist_base;
 	int count;
 
 	/* Collect CPU base addresses */
-	count = acpi_parse_entries(ACPI_SIG_MADT,
-				   sizeof(struct acpi_table_madt),
-				   gic_acpi_parse_madt_cpu, table,
-				   ACPI_MADT_TYPE_GENERIC_INTERRUPT, 0);
+	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
+				      gic_acpi_parse_madt_cpu, 0);
 	if (count <= 0) {
 		pr_err("No valid GICC entries exist\n");
 		return -EINVAL;
 	}
 
-	/*
-	 * Find distributor base address. We expect one distributor entry since
-	 * ACPI 5.1 spec neither support multi-GIC instances nor GIC cascade.
-	 */
-	count = acpi_parse_entries(ACPI_SIG_MADT,
-				   sizeof(struct acpi_table_madt),
-				   gic_acpi_parse_madt_distributor, table,
-				   ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR, 0);
-	if (count <= 0) {
-		pr_err("No valid GICD entries exist\n");
-		return -EINVAL;
-	} else if (count > 1) {
-		pr_err("More than one GICD entry detected\n");
-		return -EINVAL;
-	}
-
 	cpu_base = ioremap(cpu_phy_base, ACPI_GIC_CPU_IF_MEM_SIZE);
 	if (!cpu_base) {
 		pr_err("Unable to map GICC registers\n");
 		return -ENOMEM;
 	}
 
-	dist_base = ioremap(dist_phy_base, ACPI_GICV2_DIST_MEM_SIZE);
+	dist = (struct acpi_madt_generic_distributor *)header;
+	dist_base = ioremap(dist->base_address, ACPI_GICV2_DIST_MEM_SIZE);
 	if (!dist_base) {
 		pr_err("Unable to map GICD registers\n");
 		iounmap(cpu_base);
@@ -1142,4 +1137,10 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 	acpi_irq_model = ACPI_IRQ_MODEL_GIC;
 	return 0;
 }
+IRQCHIP_ACPI_DECLARE(gic_v2, ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR,
+		     gic_validate_dist, ACPI_MADT_GIC_VERSION_V2,
+		     gic_v2_acpi_init);
+IRQCHIP_ACPI_DECLARE(gic_v2_maybe, ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR,
+		     gic_validate_dist, ACPI_MADT_GIC_VERSION_NONE,
+		     gic_v2_acpi_init);
 #endif
diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 0644d17..639fd32 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -27,8 +27,5 @@ extern struct of_device_id __irqchip_of_table[];
 void __init irqchip_init(void)
 {
 	of_irq_init(__irqchip_of_table);
-#if defined(CONFIG_ARM64) && defined(CONFIG_ACPI)
-	acpi_gic_init();	/* Temporary hack */
-#endif
 	acpi_probe_device_table(ACPI_SIG_MADT);
 }
diff --git a/include/linux/irqchip/arm-gic-acpi.h b/include/linux/irqchip/arm-gic-acpi.h
deleted file mode 100644
index de3419e..0000000
--- a/include/linux/irqchip/arm-gic-acpi.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * Copyright (C) 2014, Linaro Ltd.
- *	Author: Tomasz Nowicki <tomasz.nowicki@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef ARM_GIC_ACPI_H_
-#define ARM_GIC_ACPI_H_
-
-#ifdef CONFIG_ACPI
-
-/*
- * Hard code here, we can not get memory size from MADT (but FDT does),
- * Actually no need to do that, because this size can be inferred
- * from GIC spec.
- */
-#define ACPI_GICV2_DIST_MEM_SIZE	(SZ_4K)
-#define ACPI_GIC_CPU_IF_MEM_SIZE	(SZ_8K)
-
-struct acpi_table_header;
-
-int gic_v2_acpi_init(struct acpi_table_header *table);
-void acpi_gic_init(void);
-#else
-static inline void acpi_gic_init(void) { }
-#endif
-
-#endif /* ARM_GIC_ACPI_H_ */
-- 
2.1.4
