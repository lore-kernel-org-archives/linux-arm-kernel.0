From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 29 Nov 2016 21:39:37 +0800
Subject: [PATCH v4 09/11] ACPI: platform: setup MSI domain for ACPI based
 platform device
In-Reply-To: <1480426779-31387-1-git-send-email-guohanjun@huawei.com>
References: <1480426779-31387-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1480426779-31387-10-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

With the platform msi domain created, we can set up the msi domain
for a platform device when it's probed.

In order to do that, we need to get the domain that the platform
device connecting to, so the iort_get_platform_device_domain() is
introduced to retrieve the domain from iort.

After the domain is retrieved, we need a proper way to set the
domain to paltform device, as some platform devices such as an
irqchip needs the msi irqdomain to be the interrupt parent domain,
we need to get irqdomain before platform device is probed but after
the platform device is allocated, so introduce a callback (pre_add_cb)
in pdevinfo to prepare firmware related information which is needed
for device probe, then set the msi domain in that callback.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/acpi/acpi_platform.c    | 11 +++++++++++
 drivers/acpi/arm64/iort.c       | 43 +++++++++++++++++++++++++++++++++++++++++
 drivers/base/platform.c         |  3 +++
 include/linux/acpi_iort.h       |  3 +++
 include/linux/platform_device.h |  3 +++
 5 files changed, 63 insertions(+)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index b4c1a6a..5d8d61b4 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/acpi_iort.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
@@ -48,6 +49,15 @@ static void acpi_platform_fill_resource(struct acpi_device *adev,
 }
 
 /**
+ * acpi_platform_pre_add_cb - callback before platform device is added, to
+ * prepare firmware related information which is needed for device probe
+ */
+static void acpi_platform_pre_add_cb(struct device *dev)
+{
+	acpi_configure_pmsi_domain(dev);
+}
+
+/**
  * acpi_create_platform_device - Create platform device for ACPI device node
  * @adev: ACPI device node to create a platform device for.
  * @properties: Optional collection of build-in properties.
@@ -109,6 +119,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 	pdevinfo.num_res = count;
 	pdevinfo.fwnode = acpi_fwnode_handle(adev);
 	pdevinfo.properties = properties;
+	pdevinfo.pre_add_cb = acpi_platform_pre_add_cb;
 
 	if (acpi_dma_supported(adev))
 		pdevinfo.dma_mask = DMA_BIT_MASK(32);
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 788f445..8714f70 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -527,6 +527,49 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
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
+
+	/* find its associated iort node */
+	node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
+			      iort_match_node_callback, dev);
+	if (!node)
+		return NULL;
+
+	/* then find its msi parent node */
+	msi_parent = iort_node_get_id(node, NULL, IORT_MSI_TYPE, 0);
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
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index c4af003..3e68f31 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -537,6 +537,9 @@ struct platform_device *platform_device_register_full(
 			goto err;
 	}
 
+	if (pdevinfo->pre_add_cb)
+		pdevinfo->pre_add_cb(&pdev->dev);
+
 	ret = platform_device_add(pdev);
 	if (ret) {
 err:
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 3f717cc..21e33b6 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -37,6 +37,7 @@
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
 /* IOMMU interface */
 const struct iommu_ops *iort_iommu_configure(struct device *dev);
+void acpi_configure_pmsi_domain(struct device *dev);
 #else
 static inline void acpi_iort_init(void) { }
 static inline bool iort_node_match(u8 type) { return false; }
@@ -56,6 +57,8 @@ static inline int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
 static inline
 const struct iommu_ops *iort_iommu_configure(struct device *dev)
 { return NULL; }
+
+static inline void acpi_configure_pmsi_domain(struct device *dev) { }
 #endif
 
 #define IORT_ACPI_DECLARE(name, table_id, fn)		\
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 98c2a7c..280d366fb 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -74,6 +74,9 @@ struct platform_device_info {
 		u64 dma_mask;
 
 		struct property_entry *properties;
+
+		/* preparation callback before the platform device is added */
+		void (*pre_add_cb)(struct device *);
 };
 extern struct platform_device *platform_device_register_full(
 		const struct platform_device_info *pdevinfo);
-- 
1.7.12.4
