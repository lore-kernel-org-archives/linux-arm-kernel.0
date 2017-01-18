From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 18 Jan 2017 20:55:00 +0800
Subject: [PATCH v8 10/15] ACPI: platform-msi: retrieve dev id from IORT
In-Reply-To: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
References: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1484744105-53140-11-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

For devices connecting to ITS, it needs dev id to identify itself, and
this dev id is represented in the IORT table in named component node
[1] for platform devices, so in this patch we will scan the IORT to
retrieve device's dev id.

With the preparation of iort_node_map_platform_id(), a new API
iort_pmsi_get_dev_id() is introduced for that purpose, call it in
its_pmsi_prepare() to make retrieving dev id ACPI aware.

[1]: https://static.docs.arm.com/den0049/b/DEN0049B_IO_Remapping_Table.pdf

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Ming Lei <ming.lei@canonical.com>
Tested-by: Wei Xu <xuwei5@hisilicon.com>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/acpi/arm64/iort.c                     | 24 ++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v3-its-platform-msi.c |  3 ++-
 include/linux/acpi_iort.h                     |  5 +++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index dacf5e1..9aebb14 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -468,6 +468,30 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 }
 
 /**
+ * iort_pmsi_get_dev_id() - Get the device id for a device
+ * @dev: The device for which the mapping is to be done.
+ * @dev_id: The device ID found.
+ *
+ * Returns: 0 for successful find a dev id, -ENODEV on error
+ */
+int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
+{
+	int i;
+	struct acpi_iort_node *node;
+
+	node = iort_find_dev_node(dev);
+	if (!node)
+		return -ENODEV;
+
+	for (i = 0; i < node->mapping_count; i++) {
+		if (iort_node_map_platform_id(node, dev_id, IORT_MSI_TYPE, i))
+			return 0;
+	}
+
+	return -ENODEV;
+}
+
+/**
  * iort_dev_find_its_id() - Find the ITS identifier for a device
  * @dev: The device.
  * @req_id: Device's requester ID
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index e4ba9f4..e801fc0 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -57,7 +57,8 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 
 	msi_info = msi_get_domain_info(domain->parent);
 
-	ret = of_pmsi_get_dev_id(domain, dev, &dev_id);
+	ret = dev->of_node ? of_pmsi_get_dev_id(domain, dev, &dev_id) :
+		iort_pmsi_get_dev_id(dev, &dev_id);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 77e0809..d074c77 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -34,6 +34,7 @@
 bool iort_node_match(u8 type);
 u32 iort_msi_map_rid(struct device *dev, u32 req_id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
+int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 /* IOMMU interface */
 void iort_set_dma_mask(struct device *dev);
 const struct iommu_ops *iort_iommu_configure(struct device *dev);
@@ -45,6 +46,10 @@ static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 static inline struct irq_domain *iort_get_device_domain(struct device *dev,
 							u32 req_id)
 { return NULL; }
+
+static inline int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
+{ return -ENODEV; }
+
 /* IOMMU interface */
 static inline void iort_set_dma_mask(struct device *dev) { }
 static inline
-- 
1.7.12.4
