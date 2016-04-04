From: tn@semihalf.com (Tomasz Nowicki)
Date: Mon,  4 Apr 2016 10:52:49 +0200
Subject: [PATCH V4 1/7] acpi, pci: Setup MSI domain on a per-devices basis.
In-Reply-To: <1459759975-24097-1-git-send-email-tn@semihalf.com>
References: <1459759975-24097-1-git-send-email-tn@semihalf.com>
Message-ID: <1459759975-24097-2-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is now possible to provide information about which MSI controller to
use on a per-device basis for DT. This patch supply this with ACPI support.

In order to handle MSI domain on per-devices basis we need to add
PCI device requester ID (RID) mapper, MSI domain provider and corresponding
registration:
pci_acpi_msi_domain_get_msi_rid - maps PCI ID and returns MSI RID
pci_acpi_register_msi_rid_mapper - registers RID mapper

pci_acpi_msi_get_device_domain - finds PCI device MSI domain
pci_acpi_register_dev_msi_fwnode_provider - registers MSI domain finder

Then, it is plugged into MSI infrastructure.

To: Bjorn Helgaas <bhelgaas@google.com>
To: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/pci/msi.c      | 10 +++++--
 drivers/pci/pci-acpi.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h    | 11 ++++++++
 3 files changed, 95 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a080f44..07b59a3 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1364,8 +1364,8 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
 
 	of_node = irq_domain_get_of_node(domain);
-	if (of_node)
-		rid = of_msi_map_rid(&pdev->dev, of_node, rid);
+	rid = of_node ? of_msi_map_rid(&pdev->dev, of_node, rid) :
+			pci_acpi_msi_domain_get_msi_rid(pdev, rid);
 
 	return rid;
 }
@@ -1381,9 +1381,13 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
  */
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 {
+	struct irq_domain *dom;
 	u32 rid = 0;
 
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
-	return of_msi_map_get_device_domain(&pdev->dev, rid);
+	dom = of_msi_map_get_device_domain(&pdev->dev, rid);
+	if (!dom)
+		dom = pci_acpi_msi_get_device_domain(pdev, rid);
+	return dom;
 }
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 9a033e8..26f4552 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -731,6 +731,83 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus)
 	return irq_find_matching_fwnode(fwnode, DOMAIN_BUS_PCI_MSI);
 }
 
+static u32 (*pci_msi_map_dev_rid_cb)(struct pci_dev *pdev, u32 req_id);
+
+/**
+ * pci_acpi_register_msi_rid_mapper - Register callback to map the MSI
+ * requester id (RID)
+ * @fn:       Callback mapping a PCI device RID.
+ *
+ * This should be called by irqchip driver, which can provide firmware-defined
+ * topologies about MSI requester id (RID) on a per-device basis.
+ */
+void pci_acpi_register_msi_rid_mapper(u32 (*fn)(struct pci_dev *, u32))
+{
+	pci_msi_map_dev_rid_cb = fn;
+}
+
+/**
+ * pci_acpi_msi_domain_get_msi_rid - Get the MSI requester id (RID) of
+ * a PCI device
+ * @pdev:     The PCI device.
+ * @rid_in:   The PCI device request ID.
+ *
+ * This function uses the callback function registered by
+ * pci_acpi_register_msi_rid_mapper() to get the device RID based on ACPI
+ * supplied mapping.
+ * This should return rid_in on error or when there is no valid map.
+ */
+u32 pci_acpi_msi_domain_get_msi_rid(struct pci_dev *pdev, u32 rid_in)
+{
+	if (!pci_msi_map_dev_rid_cb)
+		return rid_in;
+
+	return pci_msi_map_dev_rid_cb(pdev, rid_in);
+}
+
+static struct fwnode_handle *(*pci_msi_get_dev_fwnode_cb)(struct pci_dev *pdev,
+							  u32 req_id);
+
+/**
+ * pci_acpi_register_dev_msi_fwnode_provider - Register callback to retrieve
+ * domain fwnode on the per-device basis
+ * @fn:       Callback matching a device to a fwnode that identifies a PCI
+ *            MSI domain.
+ *
+ * This should be called by irqchip driver, which can provide firmware-defined
+ * topologies about which MSI controller to use on a per-device basis.
+ */
+void
+pci_acpi_register_dev_msi_fwnode_provider(
+			struct fwnode_handle *(*fn)(struct pci_dev *, u32))
+{
+	pci_msi_get_dev_fwnode_cb = fn;
+}
+
+/**
+ * pci_acpi_msi_get_device_domain - Retrieve MSI domain of a PCI device
+ * @pdev:     The PCI device.
+ * @rid:      The PCI device requester ID.
+ *
+ * This function uses the callback function registered by
+ * pci_acpi_register_dev_msi_fwnode_provider() to retrieve the irq_domain with
+ * type DOMAIN_BUS_PCI_MSI of the specified PCI device.
+ * This returns NULL on error or when the domain is not found.
+ */
+struct irq_domain *pci_acpi_msi_get_device_domain(struct pci_dev *pdev, u32 rid)
+{
+	struct fwnode_handle *fwnode;
+
+	if (!pci_msi_get_dev_fwnode_cb)
+		return NULL;
+
+	fwnode = pci_msi_get_dev_fwnode_cb(pdev, rid);
+	if (!fwnode)
+		return NULL;
+
+	return irq_find_matching_fwnode(fwnode, DOMAIN_BUS_PCI_MSI);
+}
+
 static int __init acpi_pci_init(void)
 {
 	int ret;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2771625..f50ba85 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1932,9 +1932,20 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
 
 void
 pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
+u32 pci_acpi_msi_domain_get_msi_rid(struct pci_dev *pdev, u32 rid_in);
+void pci_acpi_register_msi_rid_mapper(u32 (*fn)(struct pci_dev *, u32));
+struct irq_domain *
+pci_acpi_msi_get_device_domain(struct pci_dev *pdev, u32 rid);
+void pci_acpi_register_dev_msi_fwnode_provider(
+			struct fwnode_handle *(*fn)(struct pci_dev *, u32));
 #else
 static inline struct irq_domain *
 pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
+static inline u32
+pci_acpi_msi_domain_get_msi_rid(struct pci_dev *pdev, u32 rid_in)
+{ return rid_in; }
+static inline struct irq_domain *
+pci_acpi_msi_get_device_domain(struct pci_dev *pdev, u32 rid) { return NULL; }
 #endif
 
 #ifdef CONFIG_EEH
-- 
1.9.1
