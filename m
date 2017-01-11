From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 11 Jan 2017 23:06:35 +0800
Subject: [PATCH v7 11/15] ACPI: platform: setup MSI domain for ACPI based
 platform device
In-Reply-To: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1484147199-4267-12-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the platform msi domain created, we can set up the msi domain
for a platform device when it's probed.

In order to do that, we need to get the domain that the platform
device connecting to, so the iort_get_platform_device_domain() is
introduced to retrieve the domain from iort.

After the domain is retrieved, we need a proper way to set the
domain to paltform device, as some platform devices such as an
irqchip needs the msi irqdomain to be the interrupt parent domain,
we need to get irqdomain before platform device is probed but after
the platform device is allocated (the time slot of setting the
msi domain also works for other cases). So simply call
acpi_configure_pmsi_domain() in acpi_platform_notify() for
platform devices will work.

Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net> [for glue.c]
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/acpi/arm64/iort.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/glue.c       |  6 ++++++
 include/linux/acpi_iort.h |  3 +++
 3 files changed, 59 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index a6c8d2d..f5a32d0 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -551,6 +551,56 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
 	return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
 }
 
+/**
+ * iort_get_platform_device_domain() - Find MSI domain related to a
+ * platform device
+ * @dev: the dev pointer associated with the platform device
+ *
+ * Returns: the MSI domain for this device, NULL otherwise
+ */
+static struct irq_domain *iort_get_platform_device_domain(struct device *dev)
+{
+	struct acpi_iort_node *node, *msi_parent;
+	struct fwnode_handle *iort_fwnode;
+	struct acpi_iort_its_group *its;
+	int i;
+
+	/* find its associated iort node */
+	node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
+			      iort_match_node_callback, dev);
+	if (!node)
+		return NULL;
+
+	/* then find its msi parent node */
+	for (i = 0; i < node->mapping_count; i++) {
+		msi_parent = iort_node_map_platform_id(node, NULL,
+						       IORT_MSI_TYPE, i);
+		if (msi_parent)
+			break;
+	}
+
+	if (!msi_parent)
+		return NULL;
+
+	/* Move to ITS specific data */
+	its = (struct acpi_iort_its_group *)msi_parent->node_data;
+
+	iort_fwnode = iort_find_domain_token(its->identifiers[0]);
+	if (!iort_fwnode)
+		return NULL;
+
+	return irq_find_matching_fwnode(iort_fwnode, DOMAIN_BUS_PLATFORM_MSI);
+}
+
+void acpi_configure_pmsi_domain(struct device *dev)
+{
+	struct irq_domain *msi_domain;
+
+	msi_domain = iort_get_platform_device_domain(dev);
+	if (msi_domain)
+		dev_set_msi_domain(dev, msi_domain);
+}
+
 static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
 {
 	u32 *rid = data;
diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index fb19e1c..ec31b43 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -6,6 +6,8 @@
  *
  * This file is released under the GPLv2.
  */
+
+#include <linux/acpi_iort.h>
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/list.h>
@@ -14,6 +16,7 @@
 #include <linux/rwsem.h>
 #include <linux/acpi.h>
 #include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
 
 #include "internal.h"
 
@@ -322,6 +325,9 @@ static int acpi_platform_notify(struct device *dev)
 	if (!adev)
 		goto out;
 
+	if (dev->bus == &platform_bus_type)
+		acpi_configure_pmsi_domain(dev);
+
 	if (type && type->setup)
 		type->setup(dev);
 	else if (adev->handler && adev->handler->bind)
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index ef99fd52..33f5ac3 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -38,6 +38,7 @@
 /* IOMMU interface */
 void iort_set_dma_mask(struct device *dev);
 const struct iommu_ops *iort_iommu_configure(struct device *dev);
+void acpi_configure_pmsi_domain(struct device *dev);
 #else
 static inline void acpi_iort_init(void) { }
 static inline bool iort_node_match(u8 type) { return false; }
@@ -58,6 +59,8 @@ static inline void iort_set_dma_mask(struct device *dev) { }
 static inline
 const struct iommu_ops *iort_iommu_configure(struct device *dev)
 { return NULL; }
+
+static inline void acpi_configure_pmsi_domain(struct device *dev) { }
 #endif
 
 #define IORT_ACPI_DECLARE(name, table_id, fn)		\
-- 
1.9.1
