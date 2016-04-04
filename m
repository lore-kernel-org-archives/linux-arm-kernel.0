From: tn@semihalf.com (Tomasz Nowicki)
Date: Mon,  4 Apr 2016 10:52:53 +0200
Subject: [PATCH V4 5/7] irqchip, gicv3, its: Probe ITS in the ACPI way.
In-Reply-To: <1459759975-24097-1-git-send-email-tn@semihalf.com>
References: <1459759975-24097-1-git-send-email-tn@semihalf.com>
Message-ID: <1459759975-24097-6-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ITS is prepared for being initialized different than DT,
therefore we can initialize it in ACPI way. We collect register base
address from MADT table and pass mandatory info to firmware-agnostic
ITS init call.

Note that we are using here IORT lib to register ITS domain which
then can be found and used to build another PCI MSI domain
in hierarchical stack domain.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 61 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2dcc7b4..a277c9b 100644
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
@@ -1277,6 +1280,11 @@ static int its_irq_gic_domain_alloc(struct irq_domain *domain,
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
@@ -1617,6 +1625,57 @@ its_of_probe(struct device_node *node, struct irq_domain *parent)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+
+#define ACPI_GICV3_ITS_MEM_SIZE (2 * SZ_64K)
+
+static struct irq_domain *its_parent __initdata;
+
+static int __init
+gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
+			const unsigned long end)
+{
+	struct acpi_madt_generic_translator *its_entry;
+	struct fwnode_handle *domain_handle;
+	int err;
+
+	its_entry = (struct acpi_madt_generic_translator *)header;
+	domain_handle = irq_domain_alloc_fwnode((void *)its_entry->base_address);
+	if (!domain_handle) {
+		pr_err("Unable to allocate GICv3 ITS domain token\n");
+		return -ENOMEM;
+	}
+
+	err = iort_register_domain_token(its_entry->translation_id, domain_handle);
+	if (err) {
+		irq_domain_free_fwnode(domain_handle);
+		goto out;
+	}
+
+	err = its_probe_one(its_entry->base_address, ACPI_GICV3_ITS_MEM_SIZE,
+			    its_parent, domain_handle);
+	if (err) {
+		iort_deregister_domain_token(its_entry->translation_id);
+		irq_domain_free_fwnode(domain_handle);
+	}
+out:
+	return err;
+}
+
+void __init its_acpi_probe(struct irq_domain *parent_domain)
+{
+	int count;
+
+	its_parent = parent_domain;
+	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
+				      gic_acpi_parse_madt_its, 0);
+	if (count <= 0)
+		pr_info("No valid GIC ITS entries exist\n");
+}
+#else
+static inline void __init its_acpi_probe(struct irq_domain *parent_domain) { }
+#endif
+
 int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		    struct irq_domain *parent_domain)
 {
@@ -1625,6 +1684,8 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	of_node = to_of_node(handle);
 	if (of_node)
 		its_of_probe(of_node, parent_domain);
+	else
+		its_acpi_probe(parent_domain);
 
 	if (list_empty(&its_nodes)) {
 		pr_warn("ITS: No ITS available, not enabling LPIs\n");
-- 
1.9.1
