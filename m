From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 10 Jul 2014 14:53:04 +0800
Subject: [PATCH v3 11/13] iommu/arm: Put off the initialization phase of
 arm_smmu_ops registration
In-Reply-To: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
References: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1404975186-12032-12-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When more than two SMMU drivers running at the same, should make sure all SMMUs
device tree nodes can be probed before arm_smmu_ops registered.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-base.c |  3 ++-
 drivers/iommu/arm-smmu.c      | 12 ++----------
 drivers/iommu/arm-smmu.h      |  2 --
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm-smmu-base.c b/drivers/iommu/arm-smmu-base.c
index 8013751..d71af43 100644
--- a/drivers/iommu/arm-smmu-base.c
+++ b/drivers/iommu/arm-smmu-base.c
@@ -1066,7 +1066,7 @@ int arm_smmu_device_remove(struct platform_device *pdev)
 	return smmu->hwdep_ops->device_remove(smmu);
 }

-int __init arm_smmu_ops_init(void)
+static int __init arm_smmu_ops_init(void)
 {
 	/* Oh, for a proper bus abstraction */
 	if (!iommu_present(&platform_bus_type))
@@ -1079,3 +1079,4 @@ int __init arm_smmu_ops_init(void)

 	return 0;
 }
+subsys_initcall_sync(arm_smmu_ops_init);
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 6971e11..868e9ac 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -728,7 +728,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 	u32 id;

-	dev_notice(smmu->dev, "probing hardware configuration...\n");
+	dev_notice(smmu->dev, "probing arm-smmu hardware configuration...\n");

 	/* Primecell ID */
 	id = readl_relaxed(gr0_base + ARM_SMMU_GR0_PIDR2);
@@ -899,15 +899,7 @@ static struct platform_driver arm_smmu_driver = {

 static int __init arm_smmu_init(void)
 {
-	int ret;
-
-	ret = platform_driver_register(&arm_smmu_driver);
-	if (ret)
-		return ret;
-
-	arm_smmu_ops_init();
-
-	return 0;
+	return platform_driver_register(&arm_smmu_driver);
 }

 static void __exit arm_smmu_exit(void)
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 3164ba78..9847a33 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -253,6 +253,4 @@ extern void arm_smmu_flush_pgtable(struct arm_smmu_device *smmu, void *addr,
 extern int arm_smmu_device_dt_probe(struct platform_device *pdev,
 					struct smmu_hwdep_ops *ops);
 extern int arm_smmu_device_remove(struct platform_device *pdev);
-
-extern int __init arm_smmu_ops_init(void);
 #endif
--
1.8.0
