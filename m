From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 11 Oct 2017 10:41:46 +0100
Subject: [PATCH 1/3] irqchip/gic-v3: Use resource structure to store
 redistributor regions
In-Reply-To: <20171011094148.15674-1-punit.agrawal@arm.com>
References: <20171011094148.15674-1-punit.agrawal@arm.com>
Message-ID: <20171011094148.15674-2-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't store the size of the redistributor region required to prevent
out of bounds accesses to incorrectly sized regions provided by the
firmware.

Instead of only storing the base address, store the redistributor region
as a resource structure. The resource structure will be used in
subsequent commits to add bounds checking to redistributor region
accesses.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b5df99c6f680..8cb383b6e605 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -43,7 +43,7 @@
 
 struct redist_region {
 	void __iomem		*redist_base;
-	phys_addr_t		phys_base;
+	struct resource		res;
 	bool			single_redist;
 };
 
@@ -481,7 +481,7 @@ static int __gic_populate_rdist(struct redist_region *region, void __iomem *ptr)
 	if ((typer >> 32) == aff) {
 		u64 offset = ptr - region->redist_base;
 		gic_data_rdist_rd_base() = ptr;
-		gic_data_rdist()->phys_base = region->phys_base + offset;
+		gic_data_rdist()->phys_base = region->res.start + offset;
 
 		pr_info("CPU%d: found redistributor %lx region %d:%pa\n",
 			smp_processor_id(), mpidr,
@@ -1206,17 +1206,18 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 	}
 
 	for (i = 0; i < nr_redist_regions; i++) {
-		struct resource res;
+		struct resource *res;
 		int ret;
 
-		ret = of_address_to_resource(node, 1 + i, &res);
-		rdist_regs[i].redist_base = of_iomap(node, 1 + i);
+		res = &rdist_regs[i].res;
+
+		ret = of_address_to_resource(node, 1 + i, res);
+		rdist_regs[i].redist_base = ioremap(res->start, resource_size(res));
 		if (ret || !rdist_regs[i].redist_base) {
 			pr_err("%pOF: couldn't map region %d\n", node, i);
 			err = -ENODEV;
 			goto out_unmap_rdist;
 		}
-		rdist_regs[i].phys_base = res.start;
 	}
 
 	if (of_property_read_u64(node, "redistributor-stride", &redist_stride))
@@ -1256,11 +1257,11 @@ static struct
 } acpi_data __initdata;
 
 static void __init
-gic_acpi_register_redist(phys_addr_t phys_base, void __iomem *redist_base)
+gic_acpi_register_redist(struct resource *res, void __iomem *redist_base)
 {
 	static int count = 0;
 
-	acpi_data.redist_regs[count].phys_base = phys_base;
+	acpi_data.redist_regs[count].res = *res;
 	acpi_data.redist_regs[count].redist_base = redist_base;
 	acpi_data.redist_regs[count].single_redist = acpi_data.single_redist;
 	count++;
@@ -1273,6 +1274,10 @@ gic_acpi_parse_madt_redist(struct acpi_subtable_header *header,
 	struct acpi_madt_generic_redistributor *redist =
 			(struct acpi_madt_generic_redistributor *)header;
 	void __iomem *redist_base;
+	struct resource redist_res;
+
+	redist_res.start = redist->base_address;
+	redist_res.end = redist_res.start + redist->length - 1;
 
 	redist_base = ioremap(redist->base_address, redist->length);
 	if (!redist_base) {
@@ -1280,7 +1285,7 @@ gic_acpi_parse_madt_redist(struct acpi_subtable_header *header,
 		return -ENOMEM;
 	}
 
-	gic_acpi_register_redist(redist->base_address, redist_base);
+	gic_acpi_register_redist(&redist_res, redist_base);
 	return 0;
 }
 
@@ -1293,12 +1298,16 @@ gic_acpi_parse_madt_gicc(struct acpi_subtable_header *header,
 	u32 reg = readl_relaxed(acpi_data.dist_base + GICD_PIDR2) & GIC_PIDR2_ARCH_MASK;
 	u32 size = reg == GIC_PIDR2_ARCH_GICv4 ? SZ_64K * 4 : SZ_64K * 2;
 	void __iomem *redist_base;
+	struct resource res;
 
 	redist_base = ioremap(gicc->gicr_base_address, size);
 	if (!redist_base)
 		return -ENOMEM;
 
-	gic_acpi_register_redist(gicc->gicr_base_address, redist_base);
+	res.start = gicc->gicr_base_address;
+	res.end = res.start + size - 1;
+
+	gic_acpi_register_redist(&res, redist_base);
 	return 0;
 }
 
-- 
2.14.1
