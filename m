From: tn@semihalf.com (Tomasz Nowicki)
Date: Tue, 31 May 2016 13:19:42 +0200
Subject: [PATCH V5 5/7] irqchip, gicv3, its: Probe ITS in the ACPI way.
In-Reply-To: <1464693584-22343-1-git-send-email-tn@semihalf.com>
References: <1464693584-22343-1-git-send-email-tn@semihalf.com>
Message-ID: <1464693584-22343-6-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ITS is prepared for being initialized different than DT,
therefore we can initialize it in ACPI way. We collect register base
address from MADT table and pass mandatory info to firmware-agnostic
ITS init call.

Note that we are using here IORT lib to register ITS domain which
then can be found and used on to build another PCI MSI domain
in hierarchical stack domain.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/irqchip/Kconfig          |  1 +
 drivers/irqchip/irq-gic-v3-its.c | 60 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index fa33c50..c6e652f 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -32,6 +32,7 @@ config ARM_GIC_V3
 config ARM_GIC_V3_ITS
 	bool
 	select PCI_MSI_IRQ_DOMAIN
+	select IORT_TABLE if ACPI
 
 config ARM_NVIC
 	bool
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 6a97ee5..c8f36a5 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -15,10 +15,13 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/iort.h>
 #include <linux/log2.h>
 #include <linux/mm.h>
 #include <linux/msi.h>
@@ -1312,6 +1315,11 @@ static int its_irq_gic_domain_alloc(struct irq_domain *domain,
 		fwspec.param[0] = GIC_IRQ_TYPE_LPI;
 		fwspec.param[1] = hwirq;
 		fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
+	} else if (is_fwnode_irqchip(domain->parent->fwnode)) {
+		fwspec.fwnode = domain->parent->fwnode;
+		fwspec.param_count = 2;
+		fwspec.param[0] = hwirq;
+		fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
 	} else {
 		return -EINVAL;
 	}
@@ -1645,6 +1653,56 @@ static int __init its_of_probe(struct device_node *node)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+
+#define ACPI_GICV3_ITS_MEM_SIZE (2 * SZ_64K)
+
+static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
+					  const unsigned long end)
+{
+	struct acpi_madt_generic_translator *its_entry;
+	struct fwnode_handle *dom_handle;
+	struct resource res;
+	int err;
+
+	its_entry = (struct acpi_madt_generic_translator *)header;
+	res.start = its_entry->base_address;
+	res.end = its_entry->base_address + ACPI_GICV3_ITS_MEM_SIZE - 1;
+
+	dom_handle = irq_domain_alloc_fwnode((void *)its_entry->base_address);
+	if (!dom_handle) {
+		pr_err("ITS@%pa: Unable to allocate GICv3 ITS domain token\n",
+		       &res.start);
+		return -ENOMEM;
+	}
+
+	err = iort_register_domain_token(its_entry->translation_id, dom_handle);
+	if (err) {
+		pr_err("ITS@%pa: Unable to register GICv3 ITS domain token (ITS ID %d) to IORT\n",
+		       &res.start, its_entry->translation_id);
+		goto dom_err;
+	}
+
+	err = its_probe_one(&res, dom_handle);
+	if (!err)
+		return 0;
+
+	iort_deregister_domain_token(its_entry->translation_id);
+dom_err:
+	irq_domain_free_fwnode(dom_handle);
+	return err;
+}
+
+void __init its_acpi_probe(void)
+{
+	if (acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
+				  gic_acpi_parse_madt_its, 0) <= 0)
+		pr_info("No valid GIC ITS entries exist\n");
+}
+#else
+static inline void __init its_acpi_probe(struct irq_domain *parent_domain) { }
+#endif
+
 int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		    struct irq_domain *parent_domain)
 {
@@ -1654,6 +1712,8 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	of_node = to_of_node(handle);
 	if (of_node)
 		its_of_probe(of_node);
+	else
+		its_acpi_probe();
 
 	if (list_empty(&its_nodes)) {
 		pr_warn("ITS: No ITS available, not enabling LPIs\n");
-- 
1.9.1
