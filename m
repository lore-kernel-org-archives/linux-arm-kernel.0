From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 9 Aug 2016 15:05:58 +0800
Subject: [RFC PATCH 02/10] ACPI: platform-msi: retrieve dev id from IORT
In-Reply-To: <1470726366-40809-1-git-send-email-guohanjun@huawei.com>
References: <1470726366-40809-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1470726366-40809-3-git-send-email-guohanjun@huawei.com>
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

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/iort.c                           | 27 +++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v3-its-platform-msi.c |  3 ++-
 include/linux/iort.h                          |  7 +++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index 7795f69..cbace4d6 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -310,6 +310,33 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
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
+	/* For a platform device, we don't need a req_id */
+	if( !iort_node_map_rid(node, 0, dev_id, ACPI_IORT_NODE_ITS_GROUP))
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
index 3c94278..a0cb38f 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -56,7 +56,8 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 
 	msi_info = msi_get_domain_info(domain->parent);
 
-	ret = of_pmsi_get_dev_id(domain, dev, &dev_id);
+	ret = dev->of_node ? of_pmsi_get_dev_id(domain, dev, &dev_id) :
+		iort_pmsi_get_dev_id(dev, &dev_id);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/iort.h b/include/linux/iort.h
index d7daba1..f747821 100644
--- a/include/linux/iort.h
+++ b/include/linux/iort.h
@@ -29,11 +29,18 @@ struct fwnode_handle *iort_find_domain_token(int trans_id);
 #ifdef CONFIG_IORT_TABLE
 void iort_table_detect(void);
 u32 iort_msi_map_rid(struct device *dev, u32 req_id);
+int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
 #else
 static inline void iort_table_detect(void) { }
 static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 { return req_id; }
+
+static inline int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
+{
+	return -ENODEV;
+}
+
 static inline struct irq_domain *
 iort_get_device_domain(struct device *dev, u32 req_id) { return NULL; }
 #endif
-- 
1.7.12.4
