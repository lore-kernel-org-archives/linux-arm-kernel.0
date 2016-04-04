From: eric.auger@linaro.org (Eric Auger)
Date: Mon,  4 Apr 2016 08:30:10 +0000
Subject: [PATCH v6 4/5] iommu/arm-smmu: do not advertise IOMMU_CAP_INTR_REMAP
In-Reply-To: <1459758611-2972-1-git-send-email-eric.auger@linaro.org>
References: <1459758611-2972-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1459758611-2972-5-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not advertise IOMMU_CAP_INTR_REMAP for arm-smmu. Indeed the
irq_remapping capability is abstracted on irqchip side for ARM as
opposed to Intel IOMMU featuring IRQ remapping HW.

So to check IRQ remapping capability, the msi domain needs to be
checked instead.

This commit needs to be applied after "vfio/type1: also check IRQ
remapping capability at msi domain" else the legacy interrupt
assignment gets broken with arm-smmu.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 drivers/iommu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 6562752..83d5200 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1304,7 +1304,7 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 		 */
 		return true;
 	case IOMMU_CAP_INTR_REMAP:
-		return true; /* MSIs are just memory writes */
+		return false; /* interrupt translation handled at MSI controller level */
 	case IOMMU_CAP_NOEXEC:
 		return true;
 	default:
-- 
1.9.1
