From: binw@marvell.com (Bin Wang)
Date: Fri, 21 Mar 2014 18:06:07 +0800
Subject: [PATCH] iommu/arm-smmu: fix panic in arm_smmu_alloc_init_pte
Message-ID: <1395396367-19110-1-git-send-email-binw@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel panic happened when iommu_unmap a buffer larger than 2MB,
more than expected pmd entries got ?invalidated?, due to a wrong range
passed to arm_smmu_alloc_init_pte. it was likely a typo, now we fix
it, passing the correct "end" address to arm_smmu_alloc_init_pte.

Signed-off-by: Bin Wang <binw@marvell.com>
---
 drivers/iommu/arm-smmu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1d9ab39..52d0c34 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1346,7 +1346,7 @@ static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
 
 	do {
 		next = pmd_addr_end(addr, end);
-		ret = arm_smmu_alloc_init_pte(smmu, pmd, addr, end, pfn,
+		ret = arm_smmu_alloc_init_pte(smmu, pmd, addr, next, pfn,
 					      flags, stage);
 		phys += next - addr;
 	} while (pmd++, addr = next, addr < end);
-- 
1.7.0.4
