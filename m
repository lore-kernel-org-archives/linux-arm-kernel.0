From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 14 Sep 2016 22:21:10 +0800
Subject: [RFC PATCH v2 02/11] ACPI: platform-msi: retrieve dev id from IORT
In-Reply-To: <1473862879-7769-1-git-send-email-guohanjun@huawei.com>
References: <1473862879-7769-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1473862879-7769-3-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

For devices connecting to ITS, it needs dev id to identify
itself, and this dev id is represented in the IORT table in
named componant node [1] for platform devices, so in this
patch we will scan the IORT to retrieve device's dev id.

Introduce iort_pmsi_get_dev_id() with pointer dev passed
in for that purpose.

[1]: https://static.docs.arm.com/den0049/b/DEN0049B_IO_Remapping_Table.pdf

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/arm64/iort.c                     | 26 ++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v3-its-platform-msi.c |  4 +++-
 include/linux/acpi_iort.h                     |  8 ++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index cee82d4..13a1905 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -408,6 +408,32 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 }
 
 /**
+ * iort_pmsi_get_dev_id() - Get the device id for a device
+ * @dev: The device for which the mapping is to be done.
+ * @dev_id: The device ID found.
+ *
+ * Returns: 0 for successful find a dev id, errors otherwise
+ */
+int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
+{
+	struct acpi_iort_node *node;
+
+	if (!iort_table)
+		return -ENODEV;
+
+	node = iort_find_dev_node(dev);
+	if (!node) {
+		dev_err(dev, "can't find related IORT node\n");
+		return -ENODEV;
+	}
+
+	if( !iort_node_get_id(node, dev_id, IORT_MSI_TYPE, 0))
+		return -ENODEV;
+
+	return 0;
+}
+
+/**
  * iort_dev_find_its_id() - Find the ITS identifier for a device
  * @dev: The device.
  * @idx: Index of the ITS identifier list.
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index 3c94278..3646c23 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/acpi_iort.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -56,7 +57,8 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 
 	msi_info = msi_get_domain_info(domain->parent);
 
-	ret = of_pmsi_get_dev_id(domain, dev, &dev_id);
+	ret = dev->of_node ? of_pmsi_get_dev_id(domain, dev, &dev_id) :
+		iort_pmsi_get_dev_id(dev, &dev_id);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 167649a..bfaf75f 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -32,6 +32,7 @@ struct fwnode_handle *iort_find_domain_token(int trans_id);
 #ifdef CONFIG_ACPI_IORT
 void acpi_iort_init(void);
 u32 iort_msi_map_rid(struct device *dev, u32 req_id);
+int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
 int iort_set_fwnode(struct acpi_iort_node *iort_node,
 		    struct fwnode_handle *fwnode);
@@ -42,9 +43,16 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev);
 static inline void acpi_iort_init(void) { }
 static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 { return req_id; }
+
 static inline struct irq_domain *iort_get_device_domain(struct device *dev,
 							u32 req_id)
 { return NULL; }
+
+static inline int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
+{
+	return -ENODEV;
+}
+
 static inline int iort_set_fwnode(struct acpi_iort_node *iort_node,
 				  struct fwnode_handle *fwnode)
 { return -ENODEV; }
-- 
1.7.12.4
