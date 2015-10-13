From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Tue, 13 Oct 2015 13:46:21 -0700
Subject: [PATCH 2/4] acpi: pci: Setup MSI domain for ACPI based pci devices
In-Reply-To: <1444769183-12374-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1444769183-12374-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1444769183-12374-3-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces pci_host_bridge_acpi_msi_domain(), which returns
the MSI domain of the specified PCI host bridge with DOMAIN_BUS_PCI_MSI
bus token. Then, it is assigned to pci device.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/pci/pci-acpi.c | 13 +++++++++++++
 drivers/pci/probe.c    |  2 ++
 include/linux/pci.h    |  7 +++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a32ba75..0e21ef4 100644
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
@@ -689,6 +691,17 @@ static struct acpi_bus_type acpi_pci_bus = {
 	.cleanup = pci_acpi_cleanup,
 };
 
+struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus)
+{
+	struct irq_domain *dom = NULL;
+	struct fwnode_handle *fwnode = pci_msi_get_fwnode(&bus->dev);
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
index 0dbc7fb..bea1840 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -671,6 +671,8 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
 	 * should be called from here.
 	 */
 	d = pci_host_bridge_of_msi_domain(bus);
+	if (!d)
+		d = pci_host_bridge_acpi_msi_domain(bus);
 
 	return d;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e90eb22..4a7f6a9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1925,6 +1925,13 @@ static inline struct irq_domain *
 pci_host_bridge_of_msi_domain(struct pci_bus *bus) { return NULL; }
 #endif  /* CONFIG_OF */
 
+#ifdef CONFIG_ACPI
+struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
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
