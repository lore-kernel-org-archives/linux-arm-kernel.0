From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 10 Jul 2015 18:45:12 +0800
Subject: [PATCH v3 6/8] irqchip / GICv3: Add ACPI support for GICv3+
 initialization
In-Reply-To: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1436525114-14425-7-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

With the refator of gic_of_init(), GICv3/4 can be initialized
by gic_init_bases() with gic distributor base address and gic
redistributor region(s).

So get the redistributor region base addresses from MADT GIC
redistributor subtable, and the distributor base address from
GICD subtable to init GICv3 irqchip in ACPI way.

Note: GIC redistributor base address may also be provided in
GICC structures on systems supporting GICv3 and above if the GIC
Redistributors are not in the always-on power domain, this
patch didn't implement such feature yet.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
[hj: Rework this patch and fix multi issues]
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 144 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 140 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index aeba1cc..7b5bde3 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -15,6 +15,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/cpu_pm.h>
 #include <linux/delay.h>
@@ -25,6 +26,7 @@
 #include <linux/percpu.h>
 #include <linux/slab.h>
 
+#include <linux/irqchip/arm-gic-acpi.h>
 #include <linux/irqchip/arm-gic-v3.h>
 
 #include <asm/cputype.h>
@@ -820,6 +822,16 @@ out_free:
 	return err;
 }
 
+static int __init detect_distributor(void __iomem *dist_base)
+{
+	u32 reg = readl_relaxed(dist_base + GICD_PIDR2) & GIC_PIDR2_ARCH_MASK;
+
+	if (reg != GIC_PIDR2_ARCH_GICv3 && reg != GIC_PIDR2_ARCH_GICv4)
+		return -ENODEV;
+
+	return 0;
+}
+
 #ifdef CONFIG_OF
 static int __init gic_of_init(struct device_node *node, struct device_node *parent)
 {
@@ -827,7 +839,6 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 	struct redist_region *rdist_regs;
 	u64 redist_stride;
 	u32 nr_redist_regions;
-	u32 reg;
 	int err, i;
 
 	dist_base = of_iomap(node, 0);
@@ -837,11 +848,10 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 		return -ENXIO;
 	}
 
-	reg = readl_relaxed(dist_base + GICD_PIDR2) & GIC_PIDR2_ARCH_MASK;
-	if (reg != GIC_PIDR2_ARCH_GICv3 && reg != GIC_PIDR2_ARCH_GICv4) {
+	err = detect_distributor(dist_base);
+	if (err) {
 		pr_err("%s: no distributor detected, giving up\n",
 			node->full_name);
-		err = -ENODEV;
 		goto out_unmap_dist;
 	}
 
@@ -889,3 +899,129 @@ out_unmap_dist:
 
 IRQCHIP_DECLARE(gic_v3, "arm,gic-v3", gic_of_init);
 #endif
+
+#ifdef CONFIG_ACPI
+static struct redist_region *redist_regs __initdata;
+static u32 nr_redist_regions __initdata;
+static phys_addr_t dist_phy_base __initdata;
+
+static int __init
+gic_acpi_register_redist(u64 phys_base, u64 size)
+{
+	struct redist_region *redist_regs_new;
+	void __iomem *redist_base;
+
+	redist_regs_new = krealloc(redist_regs,
+				   sizeof(*redist_regs) * (nr_redist_regions + 1),
+				   GFP_KERNEL);
+	if (!redist_regs_new) {
+		pr_err("Couldn't allocate resource for GICR region\n");
+		return -ENOMEM;
+	}
+
+	redist_regs = redist_regs_new;
+
+	redist_base = ioremap(phys_base, size);
+	if (!redist_base) {
+		pr_err("Couldn't map GICR region @%llx\n", phys_base);
+		return -ENOMEM;
+	}
+
+	redist_regs[nr_redist_regions].phys_base = phys_base;
+	redist_regs[nr_redist_regions].redist_base = redist_base;
+	nr_redist_regions++;
+	return 0;
+}
+
+static int __init
+gic_acpi_parse_madt_redist(struct acpi_subtable_header *header,
+			const unsigned long end)
+{
+	struct acpi_madt_generic_redistributor *redist;
+
+	if (BAD_MADT_ENTRY(header, end))
+		return -EINVAL;
+
+	redist = (struct acpi_madt_generic_redistributor *)header;
+	if (!redist->base_address)
+		return -EINVAL;
+
+	return gic_acpi_register_redist(redist->base_address, redist->length);
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
+static int __init
+gic_acpi_init(struct acpi_table_header *table)
+{
+	int count, i, err = 0;
+	void __iomem *dist_base;
+
+	/* Get distributor base address */
+	count = acpi_parse_entries(ACPI_SIG_MADT,
+				sizeof(struct acpi_table_madt),
+				gic_acpi_parse_madt_distributor, table,
+				ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR, 0);
+	if (count <= 0) {
+		pr_err("No valid GICD entry exist\n");
+		return -EINVAL;
+	} else if (count > 1) {
+		pr_err("More than one GICD entry detected\n");
+		return -EINVAL;
+	}
+
+	dist_base = ioremap(dist_phy_base, ACPI_GICV3_DIST_MEM_SIZE);
+	if (!dist_base) {
+		pr_err("Unable to map GICD registers\n");
+		return -ENOMEM;
+	}
+
+	err = detect_distributor(dist_base);
+	if (err) {
+		pr_err("No distributor detected at @%p, giving up", dist_base);
+		goto out_dist_unmap;
+	}
+
+	/* Collect redistributor base addresses */
+	count = acpi_parse_entries(ACPI_SIG_MADT,
+			sizeof(struct acpi_table_madt),
+			gic_acpi_parse_madt_redist, table,
+			ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR, 0);
+	if (count <= 0) {
+		pr_info("No valid GICR entries exist\n");
+		err = -EINVAL;
+		goto out_redist_unmap;
+	}
+
+	err = gic_init_bases(dist_base, redist_regs, nr_redist_regions, 0, NULL);
+	if (err)
+		goto out_redist_unmap;
+
+	irq_set_default_host(gic_data.domain);
+	return 0;
+
+out_redist_unmap:
+	for (i = 0; i < nr_redist_regions; i++)
+		if (redist_regs[i].redist_base)
+			iounmap(redist_regs[i].redist_base);
+	kfree(redist_regs);
+out_dist_unmap:
+	iounmap(dist_base);
+	return err;
+}
+IRQCHIP_ACPI_DECLARE(gic_v3, ACPI_MADT_GIC_VERSION_V3, gic_acpi_init);
+IRQCHIP_ACPI_DECLARE(gic_v4, ACPI_MADT_GIC_VERSION_V4, gic_acpi_init);
+#endif
-- 
1.9.1
