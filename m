From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 10 Jul 2014 14:53:02 +0800
Subject: [PATCH v3 09/13] iommu/arm: Change context_map to dynamic memory
 allocation
In-Reply-To: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
References: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1404975186-12032-10-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some SMMUs(like hisi-smmu and SMMUv3), the number of context banks is more
than 128. Static array size does not fit.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-base.c | 9 ++++++++-
 drivers/iommu/arm-smmu.h      | 5 +----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-base.c b/drivers/iommu/arm-smmu-base.c
index be73eba..400de39 100644
--- a/drivers/iommu/arm-smmu-base.c
+++ b/drivers/iommu/arm-smmu-base.c
@@ -947,6 +947,13 @@ int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	if (err)
 		goto out_put_parent;

+	smmu->context_map = devm_kzalloc(dev,
+			BITS_TO_LONGS(smmu->num_context_banks), GFP_KERNEL);
+	if (!smmu->context_map) {
+		dev_err(dev, "failed to allocate context map\n");
+		return -ENOMEM;
+	}
+
 	parse_driver_options(smmu);

 	if (smmu->version > 1 &&
@@ -1029,7 +1036,7 @@ int arm_smmu_device_remove(struct platform_device *pdev)
 		of_node_put(master->of_node);
 	}

-	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
+	if (!bitmap_empty(smmu->context_map, smmu->num_context_banks))
 		dev_err(dev, "removing device with active domains!\n");

 	for (i = 0; i < smmu->num_global_irqs; ++i)
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index f7346d89..fff2b98 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -26,9 +26,6 @@
 /* Maximum number of stream IDs assigned to a single device */
 #define MAX_MASTER_STREAMIDS		MAX_PHANDLE_ARGS

-/* Maximum number of context banks per SMMU */
-#define ARM_SMMU_MAX_CBS		128
-
 /* Maximum number of mapping groups per SMMU */
 #define ARM_SMMU_MAX_SMRS		128

@@ -164,7 +161,7 @@ struct arm_smmu_device {

 	u32				num_context_banks;
 	u32				num_s2_context_banks;
-	DECLARE_BITMAP(context_map, ARM_SMMU_MAX_CBS);
+	unsigned long		       *context_map;
 	atomic_t			irptndx;

 	u32				num_mapping_groups;
--
1.8.0
