From: will.deacon@arm.com (Will Deacon)
Date: Fri, 29 Nov 2013 12:15:50 +0000
Subject: [PATCH 4/4] iommu/arm-smmu: add support for IOMMU_EXEC
In-Reply-To: <1385727350-20032-1-git-send-email-will.deacon@arm.com>
References: <1385727350-20032-1-git-send-email-will.deacon@arm.com>
Message-ID: <1385727350-20032-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously, all of our mappings were marked as executable, which isn't
usually required. Now that we have the IOMMU_EXEC flag, use that to
determine whether or not a mapping should be marked as executable.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index fa3371adea4f..8911850c9444 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -61,12 +61,13 @@
 #define ARM_SMMU_GR1(smmu)		((smmu)->base + (smmu)->pagesize)
 
 /* Page table bits */
-#define ARM_SMMU_PTE_PAGE		(((pteval_t)3) << 0)
+#define ARM_SMMU_PTE_XN			(((pteval_t)3) << 53)
 #define ARM_SMMU_PTE_CONT		(((pteval_t)1) << 52)
 #define ARM_SMMU_PTE_AF			(((pteval_t)1) << 10)
 #define ARM_SMMU_PTE_SH_NS		(((pteval_t)0) << 8)
 #define ARM_SMMU_PTE_SH_OS		(((pteval_t)2) << 8)
 #define ARM_SMMU_PTE_SH_IS		(((pteval_t)3) << 8)
+#define ARM_SMMU_PTE_PAGE		(((pteval_t)3) << 0)
 
 #if PAGE_SIZE == SZ_4K
 #define ARM_SMMU_PTE_CONT_ENTRIES	16
@@ -1205,7 +1206,7 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 				   unsigned long pfn, int flags, int stage)
 {
 	pte_t *pte, *start;
-	pteval_t pteval = ARM_SMMU_PTE_PAGE | ARM_SMMU_PTE_AF;
+	pteval_t pteval = ARM_SMMU_PTE_PAGE | ARM_SMMU_PTE_AF | ARM_SMMU_PTE_XN;
 
 	if (pmd_none(*pmd)) {
 		/* Allocate a new set of tables */
@@ -1244,7 +1245,9 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 	}
 
 	/* If no access, create a faulting entry to avoid TLB fills */
-	if (!(flags & (IOMMU_READ | IOMMU_WRITE)))
+	if (flags & IOMMU_EXEC)
+		pteval &= ~ARM_SMMU_PTE_XN;
+	else if (!(flags & (IOMMU_READ | IOMMU_WRITE)))
 		pteval &= ~ARM_SMMU_PTE_PAGE;
 
 	pteval |= ARM_SMMU_PTE_SH_IS;
-- 
1.8.2.2
