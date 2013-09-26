From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Fri, 27 Sep 2013 00:36:20 +0200
Subject: [PATCH 8/9] iommu/arm-smmu: Introduce a default fault handler
In-Reply-To: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <1380234982-1677-9-git-send-email-andreas.herrmann@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

And register the default handler for domains that are created during
device isolation.

Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 drivers/iommu/arm-smmu.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 48f3bfb..380c2a0 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1816,6 +1816,13 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+static int arm_smmu_context_fault_handler(struct iommu_domain *domain,
+		struct device *dev, unsigned long iova, int flags, void *arg)
+{
+	dev_warn(dev, "context fault: iova=0x%08lx, flags=0x%x\n", iova, flags);
+	return 0;
+}
+
 extern struct platform_device *of_find_device_by_node(struct device_node *np);
 
 static int arm_smmu_isolate_devices(void)
@@ -1859,6 +1866,9 @@ static int arm_smmu_isolate_devices(void)
 				goto out;
 			}
 
+			iommu_set_fault_handler(mapping->domain,
+					arm_smmu_context_fault_handler, dev);
+
 			ret = arm_iommu_attach_device(dev, mapping);
 			if (ret < 0) {
 				dev_info(dev, "arm_iommu_attach_device failed\n");
-- 
1.7.9.5
