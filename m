From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon,  2 Jan 2017 21:31:36 +0800
Subject: [PATCH v6 05/14] ACPI: platform-msi: retrieve dev id from IORT
In-Reply-To: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1483363905-2806-6-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For devices connecting to ITS, it needs dev id to identify
itself, and this dev id is represented in the IORT table in
named componant node [1] for platform devices, so in this
patch we will scan the IORT to retrieve device's dev id.

Introduce iort_pmsi_get_dev_id() with pointer dev passed
in for that purpose.

[1]: https://static.docs.arm.com/den0049/b/DEN0049B_IO_Remapping_Table.pdf

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
Tested-by: Majun <majun258@huawei.com>
Tested-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/acpi/arm64/iort.c                     | 26 ++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v3-its-platform-msi.c |  4 +++-
 include/linux/acpi_iort.h                     |  8 ++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 174e983..ab7bae7 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -444,6 +444,32 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
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
+	if(!iort_node_get_id(node, dev_id, IORT_MSI_TYPE, 0))
+		return -ENODEV;
+
+	return 0;
+}
+
+/**
  * iort_dev_find_its_id() - Find the ITS identifier for a device
  * @dev: The device.
  * @req_id: Device's Requster ID
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index 3c94278..16587a9 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -15,6 +15,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi_iort.h>
 #include <linux/device.h>
 #include <linux/msi.h>
 #include <linux/of.h>
@@ -56,7 +57,8 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 
 	msi_info = msi_get_domain_info(domain->parent);
 
-	ret = of_pmsi_get_dev_id(domain, dev, &dev_id);
+	ret = dev->of_node ? of_pmsi_get_dev_id(domain, dev, &dev_id) :
+		iort_pmsi_get_dev_id(dev, &dev_id);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 77e0809..ef99fd52 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -33,6 +33,7 @@
 void acpi_iort_init(void);
 bool iort_node_match(u8 type);
 u32 iort_msi_map_rid(struct device *dev, u32 req_id);
+int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
 /* IOMMU interface */
 void iort_set_dma_mask(struct device *dev);
@@ -42,9 +43,16 @@ static inline void acpi_iort_init(void) { }
 static inline bool iort_node_match(u8 type) { return false; }
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
 /* IOMMU interface */
 static inline void iort_set_dma_mask(struct device *dev) { }
 static inline
-- 
1.9.1
