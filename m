From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Tue, 24 Sep 2013 17:06:59 +0200
Subject: [PATCH 5/7] iommu/arm-smmu: Add function that isolates all masters
 for all SMMUs
In-Reply-To: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
References: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <1380035221-11576-6-git-send-email-andreas.herrmann@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each device is put into its own protection domain (if possible).
For configuration with one or just a view masters per SMMU that
is easy to achieve.

In case of many devices per SMMU (e.g. MMU-500 with it's distributed
translation support) isolation of each device might not be possible --
depending on number of available SMR groups and/or context banks.

Derive dma_base and size from (coherent_)dma_mask of device

Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 drivers/iommu/arm-smmu.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 0dfd255..3eb2259 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -46,6 +46,7 @@
 #include <linux/amba/bus.h>
 
 #include <asm/pgalloc.h>
+#include <asm/dma-iommu.h>
 
 /* Maximum number of stream IDs assigned to a single device */
 #define MAX_MASTER_STREAMIDS		8
@@ -1768,6 +1769,64 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+extern struct platform_device *of_find_device_by_node(struct device_node *np);
+
+static int arm_smmu_isolate_devices(void)
+{
+	struct dma_iommu_mapping *mapping;
+	struct arm_smmu_device *smmu;
+	struct rb_node *rbn;
+	struct arm_smmu_master *master;
+	struct platform_device *pdev;
+	struct device *dev;
+	void __iomem *gr0_base;
+	u32 cr0;
+	int ret = 0;
+	size_t size;
+
+	list_for_each_entry(smmu, &arm_smmu_devices, list) {
+		rbn = rb_first(&smmu->masters);
+		while (rbn) {
+			master = container_of(rbn, struct arm_smmu_master, node);
+			pdev = of_find_device_by_node(master->of_node);
+			if (!pdev)
+				break;
+			dev = &pdev->dev;
+
+			size = (size_t) dev->coherent_dma_mask;
+			size = size ? : (unsigned long) dev->dma_mask;
+			if (!size) {
+				dev_warn(dev, "(coherent_)dma_mask not set\n");
+				continue;
+			}
+
+			mapping = arm_iommu_create_mapping(&platform_bus_type,
+							0, size, 0);
+			if (IS_ERR(mapping)) {
+				ret = PTR_ERR(mapping);
+				dev_info(dev, "arm_iommu_create_mapping failed\n");
+				goto out;
+			}
+
+			ret = arm_iommu_attach_device(dev, mapping);
+			if (ret < 0) {
+				dev_info(dev, "arm_iommu_attach_device failed\n");
+				arm_iommu_release_mapping(mapping);
+			}
+			rbn = rb_next(rbn);
+		}
+
+		gr0_base = ARM_SMMU_GR0(smmu);
+		cr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sCR0);
+		cr0 |= sCR0_USFCFG;
+		writel(cr0, gr0_base + ARM_SMMU_GR0_sCR0);
+	}
+
+out:
+	return ret;
+}
+
+
 static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-- 
1.7.9.5
