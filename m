From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Mon, 12 Feb 2018 18:33:48 +0000
Subject: [PATCH 33/37] iommu/arm-smmu-v3: Disable tagged pointers
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Message-ID: <20180212183352.22730-34-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM architecture has a "Top Byte Ignore" (TBI) option that makes the
MMU mask out bits [63:56] of an address, allowing a userspace application
to store data in its pointers. This option is incompatible with PCI ATS.

If TBI is enabled in the SMMU and userspace triggers DMA transactions on
tagged pointers, the endpoint might create ATC entries for addresses that
include a tag. Software would then have to send ATC invalidation packets
for each 255 possible alias of an address, or just wipe the whole address
space. This is not a viable option, so disable TBI.

The impact of this change is unclear, since there are very few users of
tagged pointers, much less SVA. But the requirement introduced by this
patch doesn't seem excessive: a userspace application using both tagged
pointers and SVA should now sanitize addresses (clear the tag) before
using them for device DMA.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3-context.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3-context.c b/drivers/iommu/arm-smmu-v3-context.c
index eaeba1bec2e9..0479cae5249c 100644
--- a/drivers/iommu/arm-smmu-v3-context.c
+++ b/drivers/iommu/arm-smmu-v3-context.c
@@ -221,7 +221,6 @@ static u64 arm_smmu_cpu_tcr_to_cd(struct arm_smmu_context_cfg *cfg, u64 tcr)
 	val |= ARM_SMMU_TCR2CD(tcr, EPD0);
 	val |= ARM_SMMU_TCR2CD(tcr, EPD1);
 	val |= ARM_SMMU_TCR2CD(tcr, IPS);
-	val |= ARM_SMMU_TCR2CD(tcr, TBI0);
 
 	if (cfg->hw_access)
 		val |= ARM_SMMU_TCR2CD(tcr, HA);
-- 
2.15.1
