From: yifan.zhangm@gmail.com (Yifan Zhang)
Date: Fri, 3 Jan 2014 20:01:26 +0800
Subject: [PATCH] iommu/arm-smmu: change pud/pmd entry fill sequence
Message-ID: <1388750486-5060-1-git-send-email-yifan.zhangm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yifan Zhang <zhangyf@marvell.com>

Pgd/pud entry should be filled only once when their next level pud/pmd
created, the value should be pud/pmd start address, while in current
code, pgd/pud entry is filled every time when pud/pmd walk occurs,
the value is pud/pmd start address + iova pud/pmd index , this is
incorrect; Besides, when pud/pmd are created, we need to add pud/pmd
index, then pass to next level, while in currect code, if a new pud/pmd
created, their iova pud/pmd index is not taken into account, only
existing pud/pmd do. This patch change pud/pmd entry fill sequence,
fixes the 2 bugs.

Signed-off-by: Yifan Zhang <zhangyf@marvell.com>
---
 drivers/iommu/arm-smmu.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index e46a887..e3168a2 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1317,6 +1317,11 @@ static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
 		pmd = pmd_alloc_one(NULL, addr);
 		if (!pmd)
 			return -ENOMEM;
+
+		pud_populate(NULL, pud, pmd);
+		arm_smmu_flush_pgtable(smmu, pud, sizeof(*pud));
+
+		pmd += pmd_index(addr);
 	} else
 #endif
 		pmd = pmd_offset(pud, addr);
@@ -1325,8 +1330,6 @@ static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
 		next = pmd_addr_end(addr, end);
 		ret = arm_smmu_alloc_init_pte(smmu, pmd, addr, end, pfn,
 					      flags, stage);
-		pud_populate(NULL, pud, pmd);
-		arm_smmu_flush_pgtable(smmu, pud, sizeof(*pud));
 		phys += next - addr;
 	} while (pmd++, addr = next, addr < end);
 
@@ -1346,6 +1349,11 @@ static int arm_smmu_alloc_init_pud(struct arm_smmu_device *smmu, pgd_t *pgd,
 		pud = pud_alloc_one(NULL, addr);
 		if (!pud)
 			return -ENOMEM;
+
+		pgd_populate(NULL, pgd, pud);
+		arm_smmu_flush_pgtable(smmu, pgd, sizeof(*pgd));
+
+		pud += pud_index(addr);
 	} else
 #endif
 		pud = pud_offset(pgd, addr);
@@ -1354,8 +1362,6 @@ static int arm_smmu_alloc_init_pud(struct arm_smmu_device *smmu, pgd_t *pgd,
 		next = pud_addr_end(addr, end);
 		ret = arm_smmu_alloc_init_pmd(smmu, pud, addr, next, phys,
 					      flags, stage);
-		pgd_populate(NULL, pud, pgd);
-		arm_smmu_flush_pgtable(smmu, pgd, sizeof(*pgd));
 		phys += next - addr;
 	} while (pud++, addr = next, addr < end);
 
-- 
1.7.9.5
