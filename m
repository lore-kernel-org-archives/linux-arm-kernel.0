From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Tue, 21 Jul 2015 15:30:32 +0800
Subject: [PATCH v3 4/5] iommu/arm-smmu: add support for non-pci devices
In-Reply-To: <1437463833-16112-1-git-send-email-thunder.leizhen@huawei.com>
References: <1437463833-16112-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1437463833-16112-5-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch support a master with multiple stream IDs, but doesn't support a
master behinds more than one SMMUs.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 216c9d4..129ff36 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -30,6 +30,7 @@
 #include <linux/of_address.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/amba/bus.h>
 #include <linux/of_iommu.h>
 #include <linux/of_platform.h>

@@ -1965,9 +1966,36 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 		return -EINVAL;
 	}

-	/* We only support PCI, for now */
 	if (!dev_is_pci(dev)) {
-		return -ENODEV;
+		struct iommu_group *group;
+
+		if (args->args_count != 1) {
+			dev_err(dev,
+				"only support #iommu-cells = <1>, please check node: %s\n",
+				dev_name(smmu->dev));
+			return -ENODEV;
+		}
+
+		group = iommu_group_get(dev);
+		if (!group) {
+			group = iommu_group_alloc();
+			if (IS_ERR(group)) {
+				dev_err(dev, "failed to allocate IOMMU group\n");
+				return PTR_ERR(group);
+			}
+
+			ret = iommu_group_add_device(group, dev);
+			if (ret) {
+				iommu_group_put(group);
+				dev_err(dev, "failed to add device into IOMMU group\n");
+				return ret;
+			}
+		}
+		iommu_group_put(group);
+
+		ret = __arm_smmu_add_device(dev, args->args[0]);
+		if (ret)
+			return ret;
 	} else {
 		struct device *root;
 		struct pci_dev *pdev = NULL;
@@ -2762,6 +2790,14 @@ static int __init arm_smmu_init(void)
 	if (ret)
 		return ret;

+	if (!iommu_present(&platform_bus_type))
+		bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
+
+#ifdef CONFIG_ARM_AMBA
+	if (!iommu_present(&amba_bustype))
+		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
+#endif
+
 	return bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
 }

--
1.8.0
