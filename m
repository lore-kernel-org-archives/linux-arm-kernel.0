From: tn@semihalf.com (Tomasz Nowicki)
Date: Tue, 31 May 2016 13:19:44 +0200
Subject: [PATCH V5 7/7] acpi, gicv3,
 its: Use MADT ITS subtable to do PCI/MSI domain initialization.
In-Reply-To: <1464693584-22343-1-git-send-email-tn@semihalf.com>
References: <1464693584-22343-1-git-send-email-tn@semihalf.com>
Message-ID: <1464693584-22343-8-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let ACPI build ITS PCI MSI domain. ACPI is responsible for retrieving
inner domain token and passing it on to its_pci_msi_init_one generic
init call.

We have now full PCI MSI domain stack, thus we can enable ITS initialization
from GICv3 core driver for ACPI scenario.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 42 +++++++++++++++++++++++++++++++-
 drivers/irqchip/irq-gic-v3.c             |  3 +--
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index 23679ae..985f5d9 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -15,6 +15,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/iort.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -144,10 +145,49 @@ static int __init its_pci_of_msi_init(void)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+
+static int __init
+its_pci_msi_parse_madt(struct acpi_subtable_header *header,
+		       const unsigned long end)
+{
+	struct acpi_madt_generic_translator *its_entry;
+	struct fwnode_handle *dom_handle;
+	char node_name[6 + 16 + 1]; // ITS identification name
+
+	its_entry = (struct acpi_madt_generic_translator *)header;
+	snprintf(node_name, 23, "ITS at 0x%lx", (long)its_entry->base_address);
+	dom_handle = iort_its_find_domain_token(its_entry->translation_id);
+	if (!dom_handle) {
+		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
+		return 0;
+	}
+
+	if (its_pci_msi_init_one(dom_handle, node_name))
+		return 0;
+
+	pr_info("PCI/MSI: %s domain created\n", node_name);
+	return 0;
+}
+
+static int __init its_pci_acpi_msi_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
+			      its_pci_msi_parse_madt, 0);
+	return 0;
+}
+#else
+inline static int __init its_pci_acpi_msi_init(void)
+{
+	return 0;
+}
+#endif
+
 static int __init its_pci_msi_init(void)
 {
 	its_pci_of_msi_init();
+	its_pci_acpi_msi_init();
+
 	return 0;
 }
-
 early_initcall(its_pci_msi_init);
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index cee8296..41c1cda 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -951,8 +951,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	set_handle_irq(gic_handle_irq);
 
-	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis() &&
-	    to_of_node(handle)) /* Temp hack to prevent ITS init for ACPI */
+	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
 		its_init(handle, &gic_data.rdists, gic_data.domain);
 
 	gic_smp_init();
-- 
1.9.1
