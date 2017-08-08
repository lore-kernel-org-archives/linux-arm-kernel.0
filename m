From: robin.murphy@arm.com (Robin Murphy)
Date: Tue,  8 Aug 2017 14:56:15 +0100
Subject: [PATCH v2 2/2] iommu/arm-smmu: Add system PM support
In-Reply-To: <8cbeda2e236903e20878694c975c8143fd32ad47.1502200001.git.robin.murphy@arm.com>
References: <8cbeda2e236903e20878694c975c8143fd32ad47.1502200001.git.robin.murphy@arm.com>
Message-ID: <fb763ab0725fdff19767147de03fdc8b6578786c.1502200001.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With all our hardware state tracked in such a way that we can naturally
restore it as part of the necessary reset, resuming is trivial, and
there's nothing to do on suspend at all.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Whitespace fixes

 drivers/iommu/arm-smmu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 8f2f345ab7b1..7f7eccab120a 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2359,10 +2359,21 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+
+	arm_smmu_device_reset(smmu);
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
+
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name		= "arm-smmu",
 		.of_match_table	= of_match_ptr(arm_smmu_of_match),
+		.pm		= &arm_smmu_pm_ops,
 	},
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
-- 
2.13.4.dirty
