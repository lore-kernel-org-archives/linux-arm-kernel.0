From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Tue, 8 Dec 2015 12:19:01 -0800
Subject: [PATCH v4 1/5] acpi: pci: Setup MSI domain for ACPI based pci devices
In-Reply-To: <1449605945-10707-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1449605945-10707-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1449605945-10707-2-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces an interface for irqchip to register a callback,
to provide a way to determine appropriate MSI domain for a pci device.

It also introduces pci_host_bridge_acpi_msi_domain(), which returns
the MSI domain of the specified PCI host bridge with DOMAIN_BUS_PCI_MSI
bus token. Then, it is assigned to pci device.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/pci/pci-acpi.c | 32 ++++++++++++++++++++++++++++++++
 drivers/pci/probe.c    |  2 ++
 include/linux/pci.h    | 10 ++++++++++
 3 files changed, 44 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a32ba75..a555d7e 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -9,7 +9,9 @@
 
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/irqdomain.h>
 #include <linux/pci.h>
+#include <linux/msi.h>
 #include <linux/pci_hotplug.h>
 #include <linux/module.h>
 #include <linux/pci-aspm.h>
@@ -689,6 +691,36 @@ static struct acpi_bus_type acpi_pci_bus = {
 	.cleanup = pci_acpi_cleanup,
 };
 
+
+static struct fwnode_handle *(*pci_msi_get_fwnode_cb)(struct device *dev);
+
+/**
+ * pci_msi_register_fwnode_provider - Register callback to retrieve fwnode
+ * @fn:		The interrupt domain to retrieve
+ *
+ * This should be called by irqchip driver, which is the parent of
+ * the MSI domain to provide callback interface to query fwnode.
+ */
+void
+pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *))
+{
+	pci_msi_get_fwnode_cb = fn;
+}
+
+struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus)
+{
+	struct irq_domain *dom = NULL;
+	struct fwnode_handle *fwnode = NULL;
+
+	if (pci_msi_get_fwnode_cb)
+		fwnode = pci_msi_get_fwnode_cb(&bus->dev);
+
+	if (fwnode)
+		dom = irq_find_matching_fwnode(fwnode,
+					       DOMAIN_BUS_PCI_MSI);
+	return dom;
+}
+
 static int __init acpi_pci_init(void)
 {
 	int ret;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index edb1984..553a029 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -672,6 +672,8 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
 	 * should be called from here.
 	 */
 	d = pci_host_bridge_of_msi_domain(bus);
+	if (!d)
+		d = pci_host_bridge_acpi_msi_domain(bus);
 
 	return d;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6ae25aa..d86378c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1946,6 +1946,16 @@ static inline struct irq_domain *
 pci_host_bridge_of_msi_domain(struct pci_bus *bus) { return NULL; }
 #endif  /* CONFIG_OF */
 
+#ifdef CONFIG_ACPI
+struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
+
+void
+pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
+#else
+static inline struct irq_domain *
+pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
+#endif
+
 #ifdef CONFIG_EEH
 static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
 {
-- 
2.1.0
