From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Fri, 19 Sep 2014 14:58:42 -0700
Subject: [PATCH] iommu/arm-smmu: fix bug in pmd construction
Message-ID: <1411163922-8833-1-git-send-email-mitchelh@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are using the same pfn for every pte we create while constructing the
pmd. Fix this by actually updating the pfn on each iteration of the pmd
construction loop.

It's not clear if we can actually hit this bug right now since iommu_map
splits up the calls to .map based on the page size, so we only ever seem to
iterate this loop once. However, things might change in the future that
might cause us to hit this.

Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
---
Will, I was unable to come up with a test case to hit this bug based on
what I said in the commit message above. Not sure if my analysis is
completely off base, my head is still spinning from all these page tables
:).
---
 drivers/iommu/arm-smmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ca18d6d42a..eba4cb390c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1368,6 +1368,7 @@ static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
 		ret = arm_smmu_alloc_init_pte(smmu, pmd, addr, next, pfn,
 					      prot, stage);
 		phys += next - addr;
+		pfn = __phys_to_pfn(phys);
 	} while (pmd++, addr = next, addr < end);
 
 	return ret;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
