From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 10 Jul 2015 18:45:14 +0800
Subject: [PATCH v3 8/8] irqchip / gicv3 / ACPI: Add GICR support via GICC
 structures
In-Reply-To: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1436525114-14425-9-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On systems supporting GICv3 and above, the field of GICR Base
Address holds the 64-bit physical address of the associated
Redistributor if the GIC Redistributors are not in the always-on
power domain, so instead of init GICR regions via GIC redistributor
stricture, init it with GICR base address in GICC structures.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-acpi.c       |  35 ++++++-
 drivers/irqchip/irq-gic-v3.c         | 180 ++++++++++++++++++++++++++++++++---
 include/linux/irqchip/arm-gic-acpi.h |   2 +
 3 files changed, 203 insertions(+), 14 deletions(-)

diff --git a/drivers/irqchip/irq-gic-acpi.c b/drivers/irqchip/irq-gic-acpi.c
index b87a581..792e5ea 100644
--- a/drivers/irqchip/irq-gic-acpi.c
+++ b/drivers/irqchip/irq-gic-acpi.c
@@ -21,6 +21,11 @@ static u8 gic_version __initdata = ACPI_MADT_GIC_VERSION_NONE;
 
 static phys_addr_t dist_phy_base __initdata;
 
+u8 __init acpi_gic_version(void)
+{
+	return gic_version;
+}
+
 static int __init
 acpi_gic_parse_distributor(struct acpi_subtable_header *header,
 			   const unsigned long end)
@@ -38,6 +43,27 @@ acpi_gic_parse_distributor(struct acpi_subtable_header *header,
 }
 
 static int __init
+gic_acpi_parse_madt_gicc(struct acpi_subtable_header *header,
+			 const unsigned long end)
+{
+	struct acpi_madt_generic_interrupt *gicc;
+
+	gicc = (struct acpi_madt_generic_interrupt *)header;
+
+	if (BAD_MADT_ENTRY(gicc, end))
+		return -EINVAL;
+
+	/*
+	 * If GICC is enabled but has no valid gicr base address, then it
+	 * means GICR is not presented via GICC
+	 */
+	if ((gicc->flags & ACPI_MADT_ENABLED) && !gicc->gicr_base_address)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int __init
 match_gic_redist(struct acpi_subtable_header *header, const unsigned long end)
 {
 	return 0;
@@ -51,7 +77,14 @@ static bool __init acpi_gic_redist_is_present(void)
 	count  =  acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR,
 					match_gic_redist, 0);
 
-	/* that's true if we have at least one GIC redistributor entry */
+	/* has at least one GIC redistributor entry */
+	if (count > 0)
+		return true;
+
+	/* else try to find GICR base in GICC entries */
+	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
+				      gic_acpi_parse_madt_gicc, 0);
+
 	return count > 0;
 }
 
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 91d2f9a..fd617d6 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -389,9 +389,8 @@ static void __init gic_dist_init(void)
 		writeq_relaxed(affinity, base + GICD_IROUTER + i * 8);
 }
 
-static int gic_populate_rdist(void)
+static int gic_populate_rdist_with_regions(u64 mpidr)
 {
-	u64 mpidr = cpu_logical_map(smp_processor_id());
 	u64 typer;
 	u32 aff;
 	int i;
@@ -439,6 +438,34 @@ static int gic_populate_rdist(void)
 		} while (!(typer & GICR_TYPER_LAST));
 	}
 
+	return -ENODEV;
+}
+
+#ifdef CONFIG_ACPI
+/*
+ * Populate redist when GIC redistributor address is presented in ACPI
+ * MADT GICC entries
+ */
+static int gic_populate_rdist_with_gicr_base(u64 mpidr);
+#else
+static inline int gic_populate_rdist_with_gicr_base(u64 mpidr)
+{
+	return -ENODEV;
+}
+#endif
+
+static int gic_populate_rdist(void)
+{
+	u64 mpidr = cpu_logical_map(smp_processor_id());
+
+	if (!gic_data.nr_redist_regions) {
+		if (!gic_populate_rdist_with_gicr_base(mpidr))
+			return 0;
+	} else {
+		if (!gic_populate_rdist_with_regions(mpidr))
+			return 0;
+	}
+
 	/* We couldn't even deal with ourselves... */
 	WARN(true, "CPU%d: mpidr %llx has no re-distributor!\n",
 	     smp_processor_id(), (unsigned long long)mpidr);
@@ -907,6 +934,16 @@ IRQCHIP_DECLARE(gic_v3, "arm,gic-v3", gic_of_init);
 #endif
 
 #ifdef CONFIG_ACPI
+
+struct acpi_gicc_redist {
+	struct list_head list;
+	u64 mpidr;
+	phys_addr_t phys_base;
+	void __iomem *redist_base;
+};
+
+static LIST_HEAD(redist_list);
+
 static struct redist_region *redist_regs __initdata;
 static u32 nr_redist_regions __initdata;
 static phys_addr_t dist_phy_base __initdata;
@@ -940,6 +977,17 @@ gic_acpi_register_redist(u64 phys_base, u64 size)
 	return 0;
 }
 
+static void __init
+gic_acpi_release_redist_regions(void)
+{
+	int i;
+
+	for (i = 0; i < nr_redist_regions; i++)
+		if (redist_regs[i].redist_base)
+			iounmap(redist_regs[i].redist_base);
+	kfree(redist_regs);
+}
+
 static int __init
 gic_acpi_parse_madt_redist(struct acpi_subtable_header *header,
 			const unsigned long end)
@@ -973,10 +1021,101 @@ gic_acpi_parse_madt_distributor(struct acpi_subtable_header *header,
 }
 
 static int __init
+gic_acpi_add_gicc_redist(phys_addr_t phys_base, u64 mpidr)
+{
+	struct acpi_gicc_redist *redist;
+
+	redist = kzalloc(sizeof(*redist), GFP_KERNEL);
+	if (!redist)
+		return -ENOMEM;
+
+	redist->mpidr = mpidr;
+	redist->phys_base = phys_base;
+
+	if (acpi_gic_version() == ACPI_MADT_GIC_VERSION_V3)
+		/* RD_base + SGI_base */
+		redist->redist_base = ioremap(phys_base, 2 * SZ_64K);
+	else
+		/*
+		 * RD_base + SGI_base + VLPI_base,
+		 * we don't map reserved page as it's buggy to access it
+		 */
+		redist->redist_base = ioremap(phys_base, 3 * SZ_64K);
+
+	if (!redist->redist_base) {
+		kfree(redist);
+		return -ENOMEM;
+	}
+
+	list_add(&redist->list, &redist_list);
+	return 0;
+}
+
+static void __init
+gic_acpi_release_gicc_redist(void)
+{
+	struct acpi_gicc_redist *redist, *t;
+
+	list_for_each_entry_safe(redist, t, &redist_list, list) {
+		list_del(&redist->list);
+		iounmap(redist->redist_base);
+		kfree(redist);
+	}
+}
+
+static int __init
+gic_acpi_parse_madt_gicc(struct acpi_subtable_header *header,
+			 const unsigned long end)
+{
+	struct acpi_madt_generic_interrupt *gicc;
+
+	gicc = (struct acpi_madt_generic_interrupt *)header;
+
+	if (BAD_MADT_ENTRY(gicc, end))
+		return -EINVAL;
+
+	if (!(gicc->flags & ACPI_MADT_ENABLED))
+		return -ENODEV;
+
+	return gic_acpi_add_gicc_redist(gicc->gicr_base_address,
+					gicc->arm_mpidr);
+}
+
+static int gic_populate_rdist_with_gicr_base(u64 mpidr)
+{
+	struct acpi_gicc_redist *redist;
+	void __iomem *ptr;
+	u32 reg;
+
+	list_for_each_entry(redist, &redist_list, list) {
+		if (redist->mpidr != mpidr)
+			continue;
+
+		ptr = redist->redist_base;
+		reg = readl_relaxed(ptr + GICR_PIDR2) & GIC_PIDR2_ARCH_MASK;
+		if (reg != GIC_PIDR2_ARCH_GICv3 && reg != GIC_PIDR2_ARCH_GICv4) {
+			pr_warn("No redistributor present @%p\n", ptr);
+			return -ENODEV;
+		}
+
+		gic_data_rdist_rd_base() = ptr;
+		gic_data_rdist()->phys_base = redist->phys_base;
+		pr_info("CPU%d: found redistributor %llx phys base:%pa\n",
+			smp_processor_id(),
+			(unsigned long long)mpidr,
+			&gic_data_rdist()->phys_base);
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+static int __init
 gic_acpi_init(struct acpi_table_header *table)
 {
-	int count, i, err = 0;
+	int count, err = 0;
 	void __iomem *dist_base;
+	bool no_gicr_entries = false;
 
 	/* Get distributor base address */
 	count = acpi_parse_entries(ACPI_SIG_MADT,
@@ -1003,29 +1142,44 @@ gic_acpi_init(struct acpi_table_header *table)
 		goto out_dist_unmap;
 	}
 
-	/* Collect redistributor base addresses */
+	/* Collect redistributor base addresses in GICR entries */
 	count = acpi_parse_entries(ACPI_SIG_MADT,
 			sizeof(struct acpi_table_madt),
 			gic_acpi_parse_madt_redist, table,
 			ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR, 0);
 	if (count <= 0) {
-		pr_info("No valid GICR entries exist\n");
-		err = -EINVAL;
-		goto out_redist_unmap;
+		pr_info("No valid GICR entries exist, try GICC entries\n");
+		gic_acpi_release_redist_regions();
+		no_gicr_entries = true;
+	} else {
+		goto init_base;
 	}
 
+	/* Collect redistributor base addresses in GICC entries */
+	count = acpi_parse_entries(ACPI_SIG_MADT,
+			sizeof(struct acpi_table_madt),
+			gic_acpi_parse_madt_gicc, table,
+			ACPI_MADT_TYPE_GENERIC_INTERRUPT, 0);
+	if (count <= 0) {
+		pr_info("No valid GICC entries exist\n");
+		goto out_release_redist;
+	}
+
+init_base:
 	err = gic_init_bases(dist_base, redist_regs, nr_redist_regions, 0, NULL);
 	if (err)
-		goto out_redist_unmap;
+		goto out_release_redist;
 
 	gsi_cfg_data_add(gic_data.domain, gsi_base, gsi_base + gic_data.irq_nr);
 	return 0;
 
-out_redist_unmap:
-	for (i = 0; i < nr_redist_regions; i++)
-		if (redist_regs[i].redist_base)
-			iounmap(redist_regs[i].redist_base);
-	kfree(redist_regs);
+out_release_redist:
+	if (no_gicr_entries) {
+		if (!list_empty(&redist_list))
+			gic_acpi_release_gicc_redist();
+	} else {
+		gic_acpi_release_redist_regions();
+	}
 out_dist_unmap:
 	iounmap(dist_base);
 	return err;
diff --git a/include/linux/irqchip/arm-gic-acpi.h b/include/linux/irqchip/arm-gic-acpi.h
index 56cd82c..0d43f515 100644
--- a/include/linux/irqchip/arm-gic-acpi.h
+++ b/include/linux/irqchip/arm-gic-acpi.h
@@ -21,5 +21,7 @@
 #define ACPI_GIC_CPU_IF_MEM_SIZE	(SZ_8K)
 #define ACPI_GICV3_DIST_MEM_SIZE	(SZ_64K)
 
+u8 acpi_gic_version(void);
+
 #endif /* CONFIG_ACPI */
 #endif /* ARM_GIC_ACPI_H_ */
-- 
1.9.1
