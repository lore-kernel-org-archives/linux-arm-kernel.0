From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 7 Mar 2017 20:40:06 +0800
Subject: [PATCH v9 11/15] ACPI: platform: setup MSI domain for ACPI based
 platform device
In-Reply-To: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
References: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1488890410-15503-12-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

By allowing platform MSI domain to be created on ACPI platforms,
a platform device MSI domain can be set-up when it is probed.

In order to do that, the MSI domain the platform device connects
to should be retrieved, so the iort_get_platform_device_domain() is
introduced to retrieve the domain from the IORT kernel layer.

With the domain retrieved, we need a proper way to set the
domain to platform device.

Given that some platform devices (irqchips) require the MSI irqdomain
to be their interrupt parent domain, the MSI irqdomain should be
determined before platform device is probed but after the platform
device is allocated which means that the code setting up the MSI
irqdomain, ie acpi_configure_pmsi_domain() should be called in
acpi_platform_notify() (that is triggered after adding a device but
before the respective driver is probed) for the platform MSI domain
code set-up path to work properly.

Acked-by: Rafael J. Wysocki <rafael@kernel.org> [for glue.c]
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
[lorenzo.pieralisi at arm.com: rewrote commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Ming Lei <ming.lei@canonical.com>
Tested-by: Wei Xu <xuwei5@hisilicon.com>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/acpi/arm64/iort.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/glue.c       |  6 ++++++
 include/linux/acpi_iort.h |  3 +++
 3 files changed, 59 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index fb95ceb..22e08d2 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -548,6 +548,56 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
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
index d074c77..06b182e 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -34,6 +34,7 @@
 bool iort_node_match(u8 type);
 u32 iort_msi_map_rid(struct device *dev, u32 req_id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
+void acpi_configure_pmsi_domain(struct device *dev);
 int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 /* IOMMU interface */
 void iort_set_dma_mask(struct device *dev);
@@ -47,6 +48,8 @@ static inline struct irq_domain *iort_get_device_domain(struct device *dev,
 							u32 req_id)
 { return NULL; }
 
+static inline void acpi_configure_pmsi_domain(struct device *dev) { }
+
 static inline int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
 { return -ENODEV; }
 
-- 
1.7.12.4
