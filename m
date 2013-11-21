From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 21 Nov 2013 15:40:39 +0200
Subject: [PATCHv6 03/13] iommu/of: check if dependee iommu is ready or not
In-Reply-To: <1385041249-7705-1-git-send-email-hdoyu@nvidia.com>
References: <1385041249-7705-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1385041249-7705-4-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IOMMU devices on the bus need to be poplulated first, then iommu
master devices are done later.

With CONFIG_OF_IOMMU, "iommus=" DT binding would be used to identify
whether a device can be an iommu msater or not. If a device can, we'll
defer to populate that device till an depending iommu device is
populated.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
v6:
Spinned off only of_iommu part from:
  [PATCHv5 2/9] driver/core: populate devices in order for IOMMUs

v5:
Use "iommus=" binding instread of arm,smmu's "#stream-id-cells".

v4:
This is newly added, and the successor of the following RFC:
  [RFC][PATCHv3+ 1/2] driver/core: Add of_iommu_attach()
  http://lists.linuxfoundation.org/pipermail/iommu/2013-November/006914.html
---
 drivers/iommu/of_iommu.c | 16 ++++++++++++++++
 include/linux/of_iommu.h |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5d1aeb9..6ad4997e 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -125,3 +125,19 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_get_dma_window);
+
+int of_iommu_attach(struct device *dev)
+{
+	int i;
+	struct of_phandle_args args;
+
+	of_property_for_each_phandle_with_args(dev->of_node, "iommus",
+					       "#iommu-cells", i, &args) {
+		pr_debug("%s(i=%d) %s\n", __func__, i, dev_name(dev));
+
+		if (!of_find_iommu_by_node(args.np))
+			return -EPROBE_DEFER;
+	}
+
+	return 0;
+}
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index a0aa9d4..14c9a5c 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -14,6 +14,7 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
 
 extern void iommu_add(struct iommu *iommu);
 extern void iommu_del(struct iommu *iommu);
+extern int of_iommu_attach(struct device *dev);
 
 #else
 
@@ -32,6 +33,11 @@ static inline void iommu_del(struct iommu *iommu)
 {
 }
 
+static inline int of_iommu_attach(struct device *dev)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_OF_IOMMU */
 
 #endif /* __OF_IOMMU_H */
-- 
1.8.1.5
