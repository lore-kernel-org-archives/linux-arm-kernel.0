From: tn@semihalf.com (Tomasz Nowicki)
Date: Thu, 15 Oct 2015 16:05:11 +0200
Subject: [PATCH V1 02/10] irqchip / GICv3: Add ACPI support for GICv3+
 initialization
In-Reply-To: <1444917919-21152-1-git-send-email-tn@semihalf.com>
References: <1444917919-21152-1-git-send-email-tn@semihalf.com>
Message-ID: <1444917919-21152-3-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
Also, ACPI ITS initialization will be added in the following patches.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 142 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e146e20..0da887c 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -15,6 +15,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/cpu_pm.h>
 #include <linux/delay.h>
@@ -798,6 +799,15 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		return 0;
 	}
 
+	if (is_fwnode_irqchip(fwspec->fwnode)) {
+		if(fwspec->param_count != 2)
+			return -EINVAL;
+
+		*hwirq = fwspec->param[0];
+		*type = fwspec->param[1];
+		return 0;
+	}
+
 	return -EINVAL;
 }
 
@@ -975,3 +985,135 @@ out_unmap_dist:
 }
 
 IRQCHIP_DECLARE(gic_v3, "arm,gic-v3", gic_of_init);
+
+#ifdef CONFIG_ACPI
+static struct redist_region *redist_regs __initdata;
+static u32 nr_redist_regions __initdata;
+
+static int __init
+gic_acpi_register_redist(phys_addr_t phys_base, u64 size)
+{
+	void __iomem *redist_base;
+	static int count = 0;
+
+	redist_base = ioremap(phys_base, size);
+	if (!redist_base) {
+		pr_err("Couldn't map GICR region @%llx\n", phys_base);
+		return -ENOMEM;
+	}
+
+	redist_regs[count].phys_base = phys_base;
+	redist_regs[count++].redist_base = redist_base;
+	return 0;
+}
+
+static int __init
+gic_acpi_parse_madt_redist(struct acpi_subtable_header *header,
+			   const unsigned long end)
+{
+	struct acpi_madt_generic_redistributor *redist =
+			(struct acpi_madt_generic_redistributor *)header;
+
+	return gic_acpi_register_redist(redist->base_address, redist->length);
+}
+
+static int __init gic_acpi_match_gicr(struct acpi_subtable_header *header,
+				  const unsigned long end)
+{
+	/* Subtable presence means that redist exists, that's it */
+	return 0;
+}
+
+static bool __init acpi_validate_gic_table(struct acpi_subtable_header *header,
+					   struct acpi_probe_entry *ape)
+{
+	struct acpi_madt_generic_distributor *dist;
+	int count;
+
+	dist = (struct acpi_madt_generic_distributor *)header;
+	if (dist->version != ape->driver_data)
+		return false;
+
+	/* We need to do that exercise anyway, the sooner the better */
+	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR,
+				      gic_acpi_match_gicr, 0);
+	if (count <= 0)
+		return false;
+
+	nr_redist_regions = count;
+	return true;
+}
+
+#define ACPI_GICV3_DIST_MEM_SIZE (SZ_64K)
+
+static int __init
+gic_acpi_init(struct acpi_subtable_header *header, const unsigned long end)
+{
+	struct acpi_madt_generic_distributor *dist;
+	struct fwnode_handle *domain_handle;
+	void __iomem *dist_base;
+	int i, err, count;
+
+	/* Get distributor base address */
+	dist = (struct acpi_madt_generic_distributor *)header;
+	dist_base = ioremap(dist->base_address, ACPI_GICV3_DIST_MEM_SIZE);
+	if (!dist_base) {
+		pr_err("Unable to map GICD registers\n");
+		return -ENOMEM;
+	}
+
+	err = gic_validate_dist_version(dist_base);
+	if (err) {
+		pr_err("No distributor detected at @%p, giving up", dist_base);
+		goto out_dist_unmap;
+	}
+
+	redist_regs = kzalloc(sizeof(*redist_regs) * nr_redist_regions,
+			      GFP_KERNEL);
+	if (!redist_regs) {
+		err = -ENOMEM;
+		goto out_dist_unmap;
+	}
+
+	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR,
+				      gic_acpi_parse_madt_redist, 0);
+	if (count <= 0) {
+		err = -ENODEV;
+		goto out_redist_unmap;
+	}
+
+	domain_handle = irq_domain_alloc_fwnode(dist_base);
+	if (!domain_handle) {
+		err = -ENOMEM;
+		goto out_redist_unmap;
+	}
+
+	err = gic_init_bases(dist_base, redist_regs, nr_redist_regions, 0,
+			     domain_handle);
+	if (err)
+		goto out_fwhandle_free;
+
+	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, domain_handle);
+	return 0;
+
+out_fwhandle_free:
+	irq_domain_free_fwnode(domain_handle);
+out_redist_unmap:
+	for (i = 0; i < nr_redist_regions; i++)
+		if (redist_regs[i].redist_base)
+			iounmap(redist_regs[i].redist_base);
+	kfree(redist_regs);
+out_dist_unmap:
+	iounmap(dist_base);
+	return err;
+}
+IRQCHIP_ACPI_DECLARE(gic_v3, ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR,
+		     acpi_validate_gic_table, ACPI_MADT_GIC_VERSION_V3,
+		     gic_acpi_init);
+IRQCHIP_ACPI_DECLARE(gic_v3_maybe, ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR,
+		     acpi_validate_gic_table, ACPI_MADT_GIC_VERSION_NONE,
+		     gic_acpi_init);
+IRQCHIP_ACPI_DECLARE(gic_v4, ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR,
+		     acpi_validate_gic_table, ACPI_MADT_GIC_VERSION_V4,
+		     gic_acpi_init);
+#endif
-- 
1.9.1
