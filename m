From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 12 May 2017 11:41:42 +0100
Subject: [PATCH 2/2] iommu/arm-smmu: Plumb in new ACPI identifiers
In-Reply-To: <0bb462748c0a08dbf1db103d2a96b80c71412817.1494585645.git.robin.murphy@arm.com>
References: <0bb462748c0a08dbf1db103d2a96b80c71412817.1494585645.git.robin.murphy@arm.com>
Message-ID: <18776416ca1543f13b85209851b0e5dfab511b06.1494585645.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Revision C of IORT now allows us to identify ARM MMU-401 and the Cavium
ThunderX implementation; wire them up so that the appropriate quirks get
enabled when booting with ACPI.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 6dadd51d486c..d9ec840defc9 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2018,6 +2018,10 @@ static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
 		smmu->version = ARM_SMMU_V1;
 		smmu->model = GENERIC_SMMU;
 		break;
+	case ACPI_IORT_SMMU_CORELINK_MMU401:
+		smmu->version = ARM_SMMU_V1_64K;
+		smmu->model = GENERIC_SMMU;
+		break;
 	case ACPI_IORT_SMMU_V2:
 		smmu->version = ARM_SMMU_V2;
 		smmu->model = GENERIC_SMMU;
@@ -2026,6 +2030,10 @@ static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
 		smmu->version = ARM_SMMU_V2;
 		smmu->model = ARM_MMU500;
 		break;
+	case ACPI_IORT_SMMU_CAVIUM_SMMUV2:
+		smmu->version = ARM_SMMU_V2;
+		smmu->model = CAVIUM_SMMUV2;
+		break;
 	default:
 		ret = -ENODEV;
 	}
-- 
2.12.2.dirty
