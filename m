From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Nov 2014 13:29:41 +0000
Subject: [PATCH v5 3/8] iommu: add new iommu_ops callback for adding an OF
 device
In-Reply-To: <1417181386-18142-1-git-send-email-will.deacon@arm.com>
References: <1417181386-18142-1-git-send-email-will.deacon@arm.com>
Message-ID: <1417181386-18142-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a new function to the iommu_ops structure to allow an
OF device to be added to a specific IOMMU instance using the recently
merged generic devicetree binding for IOMMUs. The callback (of_xlate)
takes a struct device representing the master and an of_phandle_args
representing the IOMMU and the correspondong IDs for the new master.

Acked-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/linux/iommu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7b83f9f8e11d..415c7613d02c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -21,6 +21,7 @@
 
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/of.h>
 #include <linux/types.h>
 #include <trace/events/iommu.h>
 
@@ -102,6 +103,7 @@ enum iommu_attr {
  * @remove_device: remove device from iommu grouping
  * @domain_get_attr: Query domain attributes
  * @domain_set_attr: Change domain attributes
+ * @of_xlate: add OF master IDs to iommu grouping
  * @pgsize_bitmap: bitmap of supported page sizes
  * @priv: per-instance data private to the iommu driver
  */
@@ -133,6 +135,10 @@ struct iommu_ops {
 	/* Get the numer of window per domain */
 	u32 (*domain_get_windows)(struct iommu_domain *domain);
 
+#ifdef CONFIG_OF_IOMMU
+	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
+#endif
+
 	unsigned long pgsize_bitmap;
 	void *priv;
 };
-- 
2.1.1
