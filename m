From: tn@semihalf.com (Tomasz Nowicki)
Date: Thu, 15 Oct 2015 16:05:12 +0200
Subject: [PATCH V1 03/10] irqchip, GICv3,
 ACPI: Add redistributor support via GICC structures.
In-Reply-To: <1444917919-21152-1-git-send-email-tn@semihalf.com>
References: <1444917919-21152-1-git-send-email-tn@semihalf.com>
Message-ID: <1444917919-21152-4-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On systems supporting GICv3 and above, in MADT GICC structures, the
field of GICR Base Address holds the 64-bit physical address of the
associated Redistributor if the GIC Redistributors are not in the
always-on power domain, so instead of init GICR regions via GIC
redistributor structure(s), init it with GICR base address in GICC
structures in that case.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/irqchip/irq-gic-v3.c | 98 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 89 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 0da887c..b27a543 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -39,6 +39,7 @@
 struct redist_region {
 	void __iomem		*redist_base;
 	phys_addr_t		phys_base;
+	bool			single_redist;
 };
 
 struct gic_chip_data {
@@ -476,6 +477,9 @@ static int gic_populate_rdist(void)
 				return 0;
 			}
 
+			if (gic_data.redist_regions[i].single_redist)
+				break;
+
 			if (gic_data.redist_stride) {
 				ptr += gic_data.redist_stride;
 			} else {
@@ -989,6 +993,7 @@ IRQCHIP_DECLARE(gic_v3, "arm,gic-v3", gic_of_init);
 #ifdef CONFIG_ACPI
 static struct redist_region *redist_regs __initdata;
 static u32 nr_redist_regions __initdata;
+static bool single_redist;
 
 static int __init
 gic_acpi_register_redist(phys_addr_t phys_base, u64 size)
@@ -1003,7 +1008,8 @@ gic_acpi_register_redist(phys_addr_t phys_base, u64 size)
 	}
 
 	redist_regs[count].phys_base = phys_base;
-	redist_regs[count++].redist_base = redist_base;
+	redist_regs[count].redist_base = redist_base;
+	redist_regs[count++].single_redist = single_redist;
 	return 0;
 }
 
@@ -1017,6 +1023,48 @@ gic_acpi_parse_madt_redist(struct acpi_subtable_header *header,
 	return gic_acpi_register_redist(redist->base_address, redist->length);
 }
 
+static int __init
+gic_acpi_parse_madt_gicc(struct acpi_subtable_header *header,
+			 const unsigned long end)
+{
+	struct acpi_madt_generic_interrupt *gicc;
+	void __iomem *redist_base;
+	u64 typer;
+	u32 size;
+
+	gicc = (struct acpi_madt_generic_interrupt *)header;
+	redist_base = ioremap(gicc->gicr_base_address, SZ_64K * 2);
+	if (!redist_base)
+		return -ENOMEM;
+
+	typer = readq_relaxed(redist_base + GICR_TYPER);
+	/* don't map reserved page as it's buggy to access it */
+	size = (typer & GICR_TYPER_VLPIS) ? SZ_64K * 3 : SZ_64K * 2;
+	iounmap(redist_base);
+	return gic_acpi_register_redist(gicc->gicr_base_address, size);
+}
+
+static int __init gic_acpi_collect_gicr_base(void)
+{
+	acpi_tbl_entry_handler redist_parser;
+	enum acpi_madt_type type;
+
+	if (single_redist) {
+		type = ACPI_MADT_TYPE_GENERIC_INTERRUPT;
+		redist_parser = gic_acpi_parse_madt_gicc;
+	} else {
+		type = ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR;
+		redist_parser = gic_acpi_parse_madt_redist;
+	}
+
+	/* Collect redistributor base addresses in GICR entries */
+	if (acpi_table_parse_madt(type, redist_parser, 0) > 0)
+		return 0;
+
+	pr_info("No valid GICR entries exist\n");
+	return -ENODEV;
+}
+
 static int __init gic_acpi_match_gicr(struct acpi_subtable_header *header,
 				  const unsigned long end)
 {
@@ -1024,6 +1072,42 @@ static int __init gic_acpi_match_gicr(struct acpi_subtable_header *header,
 	return 0;
 }
 
+static int __init gic_acpi_match_gicc(struct acpi_subtable_header *header,
+				      const unsigned long end)
+{
+	struct acpi_madt_generic_interrupt *gicc =
+				(struct acpi_madt_generic_interrupt *)header;
+
+	/*
+	 * If GICC is enabled and has valid gicr base address, then it means
+	 * GICR base is presented via GICC
+	 */
+	if ((gicc->flags & ACPI_MADT_ENABLED) && gicc->gicr_base_address)
+		return 0;
+
+	return -ENODEV;
+}
+
+static int __init gic_acpi_count_gicr_regions(void)
+{
+	int count;
+
+	/* Count how many redistributor regions we have */
+	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR,
+				      gic_acpi_match_gicr, 0);
+	if (count > 0) {
+		single_redist = false;
+		return count;
+	}
+
+	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
+				      gic_acpi_match_gicc, 0);
+	if (count > 0)
+		single_redist = true;
+
+	return count;
+}
+
 static bool __init acpi_validate_gic_table(struct acpi_subtable_header *header,
 					   struct acpi_probe_entry *ape)
 {
@@ -1035,8 +1119,7 @@ static bool __init acpi_validate_gic_table(struct acpi_subtable_header *header,
 		return false;
 
 	/* We need to do that exercise anyway, the sooner the better */
-	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR,
-				      gic_acpi_match_gicr, 0);
+	count = gic_acpi_count_gicr_regions();
 	if (count <= 0)
 		return false;
 
@@ -1052,7 +1135,7 @@ gic_acpi_init(struct acpi_subtable_header *header, const unsigned long end)
 	struct acpi_madt_generic_distributor *dist;
 	struct fwnode_handle *domain_handle;
 	void __iomem *dist_base;
-	int i, err, count;
+	int i, err;
 
 	/* Get distributor base address */
 	dist = (struct acpi_madt_generic_distributor *)header;
@@ -1075,12 +1158,9 @@ gic_acpi_init(struct acpi_subtable_header *header, const unsigned long end)
 		goto out_dist_unmap;
 	}
 
-	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR,
-				      gic_acpi_parse_madt_redist, 0);
-	if (count <= 0) {
-		err = -ENODEV;
+	err = gic_acpi_collect_gicr_base();
+	if (err)
 		goto out_redist_unmap;
-	}
 
 	domain_handle = irq_domain_alloc_fwnode(dist_base);
 	if (!domain_handle) {
-- 
1.9.1
