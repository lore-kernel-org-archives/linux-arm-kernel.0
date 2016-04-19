From: eric.auger@linaro.org (Eric Auger)
Date: Tue, 19 Apr 2016 17:24:46 +0000
Subject: [PATCH v7 6/7] iommu/arm-smmu: do not advertise IOMMU_CAP_INTR_REMAP
In-Reply-To: <1461086687-2658-1-git-send-email-eric.auger@linaro.org>
References: <1461086687-2658-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1461086687-2658-7-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not advertise IOMMU_CAP_INTR_REMAP for arm-smmu(-v3). Indeed the
irq_remapping capability is abstracted on irqchip side for ARM as
opposed to Intel IOMMU featuring IRQ remapping HW.

So to check IRQ remapping capability, the msi domain needs to be
checked instead.

This commit needs to be applied after "vfio/type1: also check IRQ
remapping capability at msi domain" else the legacy interrupt
assignment gets broken with arm-smmu.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 3 ++-
 drivers/iommu/arm-smmu.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index afd0dac..1d0106c 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1386,7 +1386,8 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 	case IOMMU_CAP_CACHE_COHERENCY:
 		return true;
 	case IOMMU_CAP_INTR_REMAP:
-		return true; /* MSIs are just memory writes */
+		/* interrupt translation handled at MSI controller level */
+		return false;
 	case IOMMU_CAP_NOEXEC:
 		return true;
 	default:
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 492339f..6232b2a 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1312,7 +1312,8 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 		 */
 		return true;
 	case IOMMU_CAP_INTR_REMAP:
-		return true; /* MSIs are just memory writes */
+		/* interrupt translation handled at MSI controller level */
+		return false;
 	case IOMMU_CAP_NOEXEC:
 		return true;
 	default:
-- 
1.9.1
