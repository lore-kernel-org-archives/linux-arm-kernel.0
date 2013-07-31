From: will.deacon@arm.com (Will Deacon)
Date: Wed, 31 Jul 2013 19:21:25 +0100
Subject: [PATCH 1/4] iommu: arm smmu: remove broken big-endian check
In-Reply-To: <1375294888-10826-1-git-send-email-will.deacon@arm.com>
References: <1375294888-10826-1-git-send-email-will.deacon@arm.com>
Message-ID: <1375294888-10826-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bottom word of the pgd should always be written to the low half of
the TTBR, so we don't need to swap anything for big-endian.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ebd0a4c..da8af45 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -687,15 +687,9 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 
 	/* TTBR0 */
 	reg = __pa(root_cfg->pgd);
-#ifndef __BIG_ENDIAN
 	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
 	reg = (phys_addr_t)__pa(root_cfg->pgd) >> 32;
 	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
-#else
-	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
-	reg = (phys_addr_t)__pa(root_cfg->pgd) >> 32;
-	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
-#endif
 
 	/*
 	 * TTBCR
-- 
1.8.2.2
