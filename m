From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 18 May 2015 20:59:20 +0800
Subject: [PATCH 10/11] irqchip / GICv2 / ACPI: Consolidate GICv2 ACPI related
 init code
In-Reply-To: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org>
References: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1431953961-22706-11-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move GICv2 ACPI related init code in irq-gic.c to irq-gic-acpi.c,
this can make the ACPI related GIC init code slef-contained.

Introduce set_acpi_core_irqdomain() to set acpi_irqdomain then
it will be no need to make gic_data[] as a global value, and
it will save the confilcts with GICv3's gic_data in the later
patch.

acpi_gic_parse_distributor() have the same function as
gic_acpi_parse_madt_distributor() to get the GIC distributor
physical base address, so just remove the duplicate one, and
only get the GIC version when it is unknown.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-acpi.c       |  95 +++++++++++++++++++++++++++++++-
 drivers/irqchip/irq-gic.c            | 103 +----------------------------------
 include/linux/irqchip/arm-gic-acpi.h |   5 ++
 3 files changed, 101 insertions(+), 102 deletions(-)

diff --git a/drivers/irqchip/irq-gic-acpi.c b/drivers/irqchip/irq-gic-acpi.c
index 1388d9e..8463e48 100644
--- a/drivers/irqchip/irq-gic-acpi.c
+++ b/drivers/irqchip/irq-gic-acpi.c
@@ -13,12 +13,16 @@
 
 #include <linux/acpi.h>
 #include <linux/init.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/irqchip/arm-gic-acpi.h>
 #include <linux/irqchip/arm-gic-v3.h>
 
+#include "irqchip.h"
+
 /* GIC version presented in MADT GIC distributor structure */
 static u8 gic_version __initdata = ACPI_MADT_GIC_VER_UNKNOWN;
 
+/* GIC distributor physical base address, which is needed for both GICv2/3 */
 static phys_addr_t dist_phy_base __initdata;
 
 u8 __init acpi_gic_version(void)
@@ -26,6 +30,11 @@ u8 __init acpi_gic_version(void)
 	return gic_version;
 }
 
+void __init set_acpi_core_irqdomain(struct irq_domain *domain)
+{
+	acpi_irq_domain = domain;
+}
+
 static int __init
 acpi_gic_parse_distributor(struct acpi_subtable_header *header,
 				const unsigned long end)
@@ -37,8 +46,9 @@ acpi_gic_parse_distributor(struct acpi_subtable_header *header,
 	if (BAD_MADT_ENTRY(dist, end))
 		return -EINVAL;
 
-	gic_version = dist->gic_version;
 	dist_phy_base = dist->base_address;
+	if (gic_version == ACPI_MADT_GIC_VER_UNKNOWN)
+		gic_version = dist->gic_version;
 	return 0;
 }
 
@@ -114,3 +124,86 @@ int __init acpi_gic_version_init(void)
 
 	return 0;
 }
+
+static phys_addr_t cpu_phy_base __initdata;
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
+gic_v2_acpi_init(struct acpi_table_header *table)
+{
+	void __iomem *cpu_base, *dist_base;
+	int count;
+
+	if (acpi_gic_version() >= ACPI_MADT_GIC_VER_V3)
+		return -ENODEV;
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
+				   acpi_gic_parse_distributor, table,
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
+	gic_init_bases(0, -1, dist_base, cpu_base, 0, NULL);
+
+	acpi_irq_model = ACPI_IRQ_MODEL_GIC;
+	return 0;
+}
+IRQCHIP_ACPI_DECLARE(gic_v2, ACPI_SIG_MADT, gic_v2_acpi_init);
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 869a69f..2f934fe 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -986,6 +986,8 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 	if (WARN_ON(!gic->domain))
 		return;
 
+	set_acpi_core_irqdomain(gic->domain);
+
 	if (gic_nr == 0) {
 #ifdef CONFIG_SMP
 		set_smp_cross_call(gic_raise_softirq);
@@ -1047,104 +1049,3 @@ IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
 IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
 
 #endif
-
-#ifdef CONFIG_ACPI
-static phys_addr_t dist_phy_base, cpu_phy_base __initdata;
-
-static int __init
-gic_acpi_parse_madt_cpu(struct acpi_subtable_header *header,
-			const unsigned long end)
-{
-	struct acpi_madt_generic_interrupt *processor;
-	phys_addr_t gic_cpu_base;
-	static int cpu_base_assigned;
-
-	processor = (struct acpi_madt_generic_interrupt *)header;
-
-	if (BAD_MADT_ENTRY(processor, end))
-		return -EINVAL;
-
-	/*
-	 * There is no support for non-banked GICv1/2 register in ACPI spec.
-	 * All CPU interface addresses have to be the same.
-	 */
-	gic_cpu_base = processor->base_address;
-	if (cpu_base_assigned && gic_cpu_base != cpu_phy_base)
-		return -EINVAL;
-
-	cpu_phy_base = gic_cpu_base;
-	cpu_base_assigned = 1;
-	return 0;
-}
-
-static int __init
-gic_acpi_parse_madt_distributor(struct acpi_subtable_header *header,
-				const unsigned long end)
-{
-	struct acpi_madt_generic_distributor *dist;
-
-	dist = (struct acpi_madt_generic_distributor *)header;
-
-	if (BAD_MADT_ENTRY(dist, end))
-		return -EINVAL;
-
-	dist_phy_base = dist->base_address;
-	return 0;
-}
-
-static int __init
-gic_v2_acpi_init(struct acpi_table_header *table)
-{
-	void __iomem *cpu_base, *dist_base;
-	int count;
-
-	if (acpi_gic_version() >= ACPI_MADT_GIC_VER_V3)
-		return -ENODEV;
-
-	/* Collect CPU base addresses */
-	count = acpi_parse_entries(ACPI_SIG_MADT,
-				   sizeof(struct acpi_table_madt),
-				   gic_acpi_parse_madt_cpu, table,
-				   ACPI_MADT_TYPE_GENERIC_INTERRUPT, 0);
-	if (count <= 0) {
-		pr_err("No valid GICC entries exist\n");
-		return -EINVAL;
-	}
-
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
-	cpu_base = ioremap(cpu_phy_base, ACPI_GIC_CPU_IF_MEM_SIZE);
-	if (!cpu_base) {
-		pr_err("Unable to map GICC registers\n");
-		return -ENOMEM;
-	}
-
-	dist_base = ioremap(dist_phy_base, ACPI_GICV2_DIST_MEM_SIZE);
-	if (!dist_base) {
-		pr_err("Unable to map GICD registers\n");
-		iounmap(cpu_base);
-		return -ENOMEM;
-	}
-
-	gic_init_bases(0, -1, dist_base, cpu_base, 0, NULL);
-	acpi_irq_domain = gic_data[0].domain;
-
-	acpi_irq_model = ACPI_IRQ_MODEL_GIC;
-	return 0;
-}
-IRQCHIP_ACPI_DECLARE(gic_v2, ACPI_SIG_MADT, gic_v2_acpi_init);
-#endif
diff --git a/include/linux/irqchip/arm-gic-acpi.h b/include/linux/irqchip/arm-gic-acpi.h
index 245386d..f4a17c7 100644
--- a/include/linux/irqchip/arm-gic-acpi.h
+++ b/include/linux/irqchip/arm-gic-acpi.h
@@ -25,5 +25,10 @@ extern struct irq_domain *acpi_irq_domain;
 
 int acpi_gic_version_init(void);
 u8 acpi_gic_version(void);
+
+void set_acpi_core_irqdomain(struct irq_domain *domain);
+#else
+#define set_acpi_core_irqdomain(domain)
 #endif /* CONFIG_ACPI */
+
 #endif /* ARM_GIC_ACPI_H_ */
-- 
1.9.1
