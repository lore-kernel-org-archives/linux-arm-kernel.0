From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 22 Sep 2017 15:04:00 +0100
Subject: [PATCH] iommu/arm-smmu: Remove ACPICA workarounds
Message-ID: <63cc66c4c23a6066c06498079295035df7e68160.1506088916.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the kernel headers have synced with the relevant upstream
ACPICA updates, it's time to clean up the temporary local definitions.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 11 +----------
 drivers/iommu/arm-smmu.c    |  8 --------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e67ba6c40faf..47f52b1ab838 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -413,15 +413,6 @@
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
-/* Until ACPICA headers cover IORT rev. C */
-#ifndef ACPI_IORT_SMMU_HISILICON_HI161X
-#define ACPI_IORT_SMMU_HISILICON_HI161X		0x1
-#endif
-
-#ifndef ACPI_IORT_SMMU_V3_CAVIUM_CN99XX
-#define ACPI_IORT_SMMU_V3_CAVIUM_CN99XX		0x2
-#endif
-
 static bool disable_bypass;
 module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
@@ -2665,7 +2656,7 @@ static void acpi_smmu_get_options(u32 model, struct arm_smmu_device *smmu)
 	case ACPI_IORT_SMMU_V3_CAVIUM_CN99XX:
 		smmu->options |= ARM_SMMU_OPT_PAGE0_REGS_ONLY;
 		break;
-	case ACPI_IORT_SMMU_HISILICON_HI161X:
+	case ACPI_IORT_SMMU_V3_HISILICON_HI161X:
 		smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
 		break;
 	}
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 3bdb799d3b4b..bce312a99f52 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -119,14 +119,6 @@ enum arm_smmu_implementation {
 	CAVIUM_SMMUV2,
 };
 
-/* Until ACPICA headers cover IORT rev. C */
-#ifndef ACPI_IORT_SMMU_CORELINK_MMU401
-#define ACPI_IORT_SMMU_CORELINK_MMU401	0x4
-#endif
-#ifndef ACPI_IORT_SMMU_CAVIUM_THUNDERX
-#define ACPI_IORT_SMMU_CAVIUM_THUNDERX	0x5
-#endif
-
 struct arm_smmu_s2cr {
 	struct iommu_group		*group;
 	int				count;
-- 
2.13.4.dirty
