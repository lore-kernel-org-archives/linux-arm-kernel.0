From: eric.auger@redhat.com (Eric Auger)
Date: Mon,  9 Jan 2017 13:46:10 +0000
Subject: [PATCH v7 19/19] iommu/arm-smmu: Do not advertise
 IOMMU_CAP_INTR_REMAP anymore
In-Reply-To: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
References: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1483969570-3154-20-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IOMMU_CAP_INTR_REMAP has been advertised in arm-smmu(-v3) although
on ARM this property is not attached to the IOMMU but rather is
implemented in the MSI controller (GICv3 ITS).

Now vfio_iommu_type1 checks MSI remapping capability at MSI controller
level, let's correct this.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/arm-smmu-v3.c | 2 --
 drivers/iommu/arm-smmu.c    | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 6c4111c..d9cf6cb 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1375,8 +1375,6 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
 		return true;
-	case IOMMU_CAP_INTR_REMAP:
-		return true; /* MSIs are just memory writes */
 	case IOMMU_CAP_NOEXEC:
 		return true;
 	default:
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a354572..13d2600 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1374,8 +1374,6 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 		 * requests.
 		 */
 		return true;
-	case IOMMU_CAP_INTR_REMAP:
-		return true; /* MSIs are just memory writes */
 	case IOMMU_CAP_NOEXEC:
 		return true;
 	default:
-- 
1.9.1
