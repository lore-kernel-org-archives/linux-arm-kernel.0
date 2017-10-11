From: fkan@apm.com (Feng Kan)
Date: Wed, 11 Oct 2017 15:08:39 -0700
Subject: [PATCH] iommu: enable bypass transaction caching for ARM SMMU 500
Message-ID: <1507759719-16675-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM SMMU identity mapping performance was poor compared with the
DMA mode. It was found that enable caching would restore the performance
back to normal. The S2CRB_TLBEN bit in the ACR register would allow for
caching of the stream to context register bypass transaction information.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 drivers/iommu/arm-smmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 3bdb799..b5676a8 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -59,6 +59,7 @@
 #define ARM_MMU500_ACTLR_CPRE		(1 << 1)
 
 #define ARM_MMU500_ACR_CACHE_LOCK	(1 << 26)
+#define ARM_MMU500_ACR_S2CRB_TLBEN	(1 << 10)
 #define ARM_MMU500_ACR_SMTNMB_TLBEN	(1 << 8)
 
 #define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
@@ -1606,7 +1607,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		 * Allow unmatched Stream IDs to allocate bypass
 		 * TLB entries for reduced latency.
 		 */
-		reg |= ARM_MMU500_ACR_SMTNMB_TLBEN;
+		reg |= ARM_MMU500_ACR_SMTNMB_TLBEN | ARM_MMU500_ACR_S2CRB_TLBEN;
 		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_sACR);
 	}
 
-- 
2.7.4
