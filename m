From: tn@semihalf.com (Tomasz Nowicki)
Date: Mon,  4 Apr 2016 10:52:55 +0200
Subject: [PATCH V4 7/7] acpi, gicv3,
 its: Use MADT ITS subtable to do PCI/MSI domain initialization.
In-Reply-To: <1459759975-24097-1-git-send-email-tn@semihalf.com>
References: <1459759975-24097-1-git-send-email-tn@semihalf.com>
Message-ID: <1459759975-24097-8-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let ACPI to build ITS PCI MSI domain. If it succeed, we register IORT
domain provider and RID mapper.

We have now full PCI MSI domain stack, thus we can enable ITS initialization
from GICv3 core driver for ACPI scenario.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 46 +++++++++++++++++++++++++++++++-
 drivers/irqchip/irq-gic-v3.c             |  3 +--
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index 06165cb..df269a4 100644
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
@@ -143,10 +145,52 @@ static int __init its_pci_of_msi_init(void)
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
+	domain_handle = iort_its_find_domain_token(its_entry->translation_id);
+	if (!domain_handle) {
+		pr_err("ITS at 0x%lx: Unable to locate ITS domain handle\n",
+		       (long)its_entry->base_address);
+		return 0;
+	}
+
+	if (its_pci_msi_init_one(domain_handle))
+		return 0;
+
+	pr_info("PCI/MSI: ITS at 0x%lx domain created\n",
+		(long)its_entry->base_address);
+	return 0;
+}
+
+static int __init its_pci_acpi_msi_init(void)
+{
+	if (acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
+				  its_pci_msi_parse_madt, 0) > 0) {
+		pci_acpi_register_msi_rid_mapper(iort_pci_get_msi_rid);
+		pci_acpi_register_dev_msi_fwnode_provider(iort_pci_get_domain);
+	}
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
index 995b7251..fee635e 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -871,8 +871,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	set_handle_irq(gic_handle_irq);
 
-	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis() &&
-	    to_of_node(handle)) /* Temp hack to prevent ITS init for ACPI */
+	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
 		its_init(handle, &gic_data.rdists, gic_data.domain);
 
 	gic_smp_init();
-- 
1.9.1
