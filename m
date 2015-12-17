From: tn@semihalf.com (Tomasz Nowicki)
Date: Thu, 17 Dec 2015 12:52:13 +0100
Subject: [PATCH V2 10/10] acpi, gicv3,
 its: Use MADT ITS subtable to do PCI/MSI domain initialization.
In-Reply-To: <1450353133-15992-1-git-send-email-tn@semihalf.com>
References: <1450353133-15992-1-git-send-email-tn@semihalf.com>
Message-ID: <1450353133-15992-11-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After refactoring DT code, we let ACPI to build ITS PCI MSI domain
and do requester ID to device ID translation using IORT table.

We have now full PCI MSI domain stack, thus we can enable ITS initialization
from GICv3 core driver for ACPI scenario.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 44 +++++++++++++++++++++++++++++++-
 drivers/irqchip/irq-gic-v3.c             |  3 +--
 drivers/pci/msi.c                        |  3 +++
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index 06165cb..7f0a958 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -15,6 +15,8 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi.h>
+#include <linux/iort.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -143,10 +145,50 @@ static int __init its_pci_of_msi_init(void)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+
+static int __init
+its_pci_msi_parse_madt(struct acpi_subtable_header *header,
+		    const unsigned long end)
+{
+	struct acpi_madt_generic_translator *its_entry;
+	struct fwnode_handle *domain_handle;
+
+	its_entry = (struct acpi_madt_generic_translator *)header;
+	domain_handle = iort_find_its_domain_token(its_entry->translation_id);
+	if (!domain_handle) {
+		pr_err("ITS at 0x%lx: Unable to locate ITS domain handle\n",
+		       (long)its_entry->base_address);
+		return 0;
+	}
+
+	if (its_pci_msi_init_one(domain_handle))
+		return 0;
+
+	pci_msi_register_fwnode_provider(&iort_find_pci_domain_token);
+	pr_info("PCI/MSI: ITS at 0x%lx domain created\n",
+		(long)its_entry->base_address);
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
index 1f3d761..1c9cd5c 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -870,8 +870,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	set_handle_irq(gic_handle_irq);
 
-	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis() &&
-	    to_of_node(handle)) /* Temp hack to prevent ITS init for ACPI */
+	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
 		its_init(handle, &gic_data.rdists, gic_data.domain);
 
 	gic_smp_init();
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 53e4632..0393114 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -18,6 +18,7 @@
 #include <linux/smp.h>
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <linux/iort.h>
 #include <linux/slab.h>
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
@@ -1366,6 +1367,8 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 	of_node = irq_domain_get_of_node(domain);
 	if (of_node)
 		rid = of_msi_map_rid(&pdev->dev, of_node, rid);
+	else
+		iort_find_pci_id(pdev, rid, &rid);
 
 	return rid;
 }
-- 
1.9.1
