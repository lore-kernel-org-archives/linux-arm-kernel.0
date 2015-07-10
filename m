From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 10 Jul 2015 18:45:07 +0800
Subject: [PATCH v3 1/8] irqchip / GIC: Add GIC version support in ACPI MADT
In-Reply-To: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1436525114-14425-2-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a field added in ACPI 6.0 MADT table to indicate the
GIC version, so parse the table to get its value for later use.

If GIC version presented in MADT is 0, we need to fallback to
hardware discovery to get the GIC version.

In ACPI MADT table there is no compatible strings to indicate
various irqchips and also ACPI doesn't support irqchips which
are not compatible with ARM GIC spec, so GIC version can be used
to load different GIC drivers which is needed for the later patch.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/Kconfig                   |   1 +
 drivers/irqchip/Kconfig              |   3 +
 drivers/irqchip/Makefile             |   1 +
 drivers/irqchip/irq-gic-acpi.c       | 109 +++++++++++++++++++++++++++++++++++
 include/linux/irqchip/arm-gic-acpi.h |   1 +
 5 files changed, 115 insertions(+)
 create mode 100644 drivers/irqchip/irq-gic-acpi.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a77d04f..b0cb9bb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -16,6 +16,7 @@ config ARM64
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
 	select ARM_GIC
+	select ARM_GIC_ACPI if ACPI
 	select AUDIT_ARCH_COMPAT_GENERIC
 	select ARM_GIC_V2M if PCI_MSI
 	select ARM_GIC_V3
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 120d815..557ec2f 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -47,6 +47,9 @@ config ARM_VIC_NR
 	  The maximum number of VICs available in the system, for
 	  power management.
 
+config ARM_GIC_ACPI
+	bool
+
 config ATMEL_AIC_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index b8d4e96..90a7e44 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_ARM_GIC)			+= irq-gic.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o
+obj-$(CONFIG_ARM_GIC_ACPI)		+= irq-gic-acpi.o
 obj-$(CONFIG_ARM_NVIC)			+= irq-nvic.o
 obj-$(CONFIG_ARM_VIC)			+= irq-vic.o
 obj-$(CONFIG_ATMEL_AIC_IRQ)		+= irq-atmel-aic-common.o irq-atmel-aic.o
diff --git a/drivers/irqchip/irq-gic-acpi.c b/drivers/irqchip/irq-gic-acpi.c
new file mode 100644
index 0000000..6537b43
--- /dev/null
+++ b/drivers/irqchip/irq-gic-acpi.c
@@ -0,0 +1,109 @@
+/*
+ * ACPI based support for ARM GIC init
+ *
+ * Copyright (C) 2015, Linaro Ltd.
+ * 	Author: Hanjun Guo <hanjun.guo@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt) "ACPI: GIC: " fmt
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/irqchip/arm-gic-acpi.h>
+#include <linux/irqchip/arm-gic-v3.h>
+
+/* GIC version presented in MADT GIC distributor structure */
+static u8 gic_version __initdata = ACPI_MADT_GIC_VERSION_NONE;
+
+static phys_addr_t dist_phy_base __initdata;
+
+static int __init
+acpi_gic_parse_distributor(struct acpi_subtable_header *header,
+			   const unsigned long end)
+{
+	struct acpi_madt_generic_distributor *dist;
+
+	dist = (struct acpi_madt_generic_distributor *)header;
+
+	if (BAD_MADT_ENTRY(dist, end))
+		return -EINVAL;
+
+	gic_version = dist->version;
+	dist_phy_base = dist->base_address;
+	return 0;
+}
+
+static int __init
+match_gic_redist(struct acpi_subtable_header *header, const unsigned long end)
+{
+	return 0;
+}
+
+static bool __init acpi_gic_redist_is_present(void)
+{
+	int count;
+
+	/* scan MADT table to find if we have redistributor entries */
+	count  =  acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR,
+					match_gic_redist, 0);
+
+	/* that's true if we have at least one GIC redistributor entry */
+	return count > 0;
+}
+
+static int __init acpi_gic_version_init(void)
+{
+	int count;
+	u32 reg;
+	void __iomem *dist_base;
+
+	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR,
+				      acpi_gic_parse_distributor, 0);
+
+	if (count <= 0) {
+		pr_err("No valid GIC distributor entry exists\n");
+		return -ENODEV;
+	}
+
+	if (gic_version >= ACPI_MADT_GIC_VERSION_RESERVED) {
+		pr_err("Invalid GIC version %d in MADT\n", gic_version);
+		return -EINVAL;
+	}
+
+	/*
+	 * when the GIC version is 0, we fallback to hardware discovery.
+	 * this is also needed to keep compatiable with ACPI 5.1,
+	 * which has no gic_version field in distributor structure and
+	 * reserved as 0.
+	 *
+	 * For hardware discovery, the offset for GICv1/2 and GICv3/4 to
+	 * get the GIC version is different (0xFE8 for GICv1/2 and 0xFFE8
+	 * for GICv3/4), so we need to handle it separately.
+	 */
+	if (gic_version	== ACPI_MADT_GIC_VERSION_NONE) {
+		/* it's GICv3/v4 if redistributor is present */
+		if (acpi_gic_redist_is_present()) {
+			dist_base = ioremap(dist_phy_base,
+					    ACPI_GICV3_DIST_MEM_SIZE);
+			if (!dist_base)
+				return -ENOMEM;
+
+			reg = readl_relaxed(dist_base + GICD_PIDR2) &
+					    GIC_PIDR2_ARCH_MASK;
+			if (reg == GIC_PIDR2_ARCH_GICv3)
+				gic_version = ACPI_MADT_GIC_VERSION_V3;
+			else
+				gic_version = ACPI_MADT_GIC_VERSION_V4;
+
+			iounmap(dist_base);
+		} else {
+			gic_version = ACPI_MADT_GIC_VERSION_V2;
+		}
+	}
+
+	return 0;
+}
diff --git a/include/linux/irqchip/arm-gic-acpi.h b/include/linux/irqchip/arm-gic-acpi.h
index de3419e..13bc676 100644
--- a/include/linux/irqchip/arm-gic-acpi.h
+++ b/include/linux/irqchip/arm-gic-acpi.h
@@ -19,6 +19,7 @@
  */
 #define ACPI_GICV2_DIST_MEM_SIZE	(SZ_4K)
 #define ACPI_GIC_CPU_IF_MEM_SIZE	(SZ_8K)
+#define ACPI_GICV3_DIST_MEM_SIZE	(SZ_64K)
 
 struct acpi_table_header;
 
-- 
1.9.1
