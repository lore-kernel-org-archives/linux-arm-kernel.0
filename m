From: a.motakis@virtualopensystems.com (Antonios Motakis)
Date: Tue, 23 Sep 2014 16:46:00 +0200
Subject: [PATCHv7 01/26] iommu/arm-smmu: change IOMMU_EXEC to IOMMU_NOEXEC
In-Reply-To: <1411483586-29304-1-git-send-email-a.motakis@virtualopensystems.com>
References: <1411483586-29304-1-git-send-email-a.motakis@virtualopensystems.com>
Message-ID: <1411483586-29304-2-git-send-email-a.motakis@virtualopensystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exposing the XN flag of the SMMU driver as IOMMU_NOEXEC instead of
IOMMU_EXEC makes it enforceable, since for IOMMUs that don't support
the XN flag pages will always be executable.

Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
---
 drivers/iommu/arm-smmu.c | 9 +++++----
 include/linux/iommu.h    | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a83cc2a..c7cbdda 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1252,7 +1252,7 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 				   unsigned long pfn, int prot, int stage)
 {
 	pte_t *pte, *start;
-	pteval_t pteval = ARM_SMMU_PTE_PAGE | ARM_SMMU_PTE_AF | ARM_SMMU_PTE_XN;
+	pteval_t pteval = ARM_SMMU_PTE_PAGE | ARM_SMMU_PTE_AF;
 
 	if (pmd_none(*pmd)) {
 		/* Allocate a new set of tables */
@@ -1286,10 +1286,11 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 			pteval |= ARM_SMMU_PTE_MEMATTR_NC;
 	}
 
+	if (prot & IOMMU_NOEXEC)
+		pteval |= ARM_SMMU_PTE_XN;
+
 	/* If no access, create a faulting entry to avoid TLB fills */
-	if (prot & IOMMU_EXEC)
-		pteval &= ~ARM_SMMU_PTE_XN;
-	else if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
+	if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
 		pteval &= ~ARM_SMMU_PTE_PAGE;
 
 	pteval |= ARM_SMMU_PTE_SH_IS;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 20f9a52..e1a644c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -27,7 +27,7 @@
 #define IOMMU_READ	(1 << 0)
 #define IOMMU_WRITE	(1 << 1)
 #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
-#define IOMMU_EXEC	(1 << 3)
+#define IOMMU_NOEXEC	(1 << 3)
 
 struct iommu_ops;
 struct iommu_group;
-- 
1.8.3.2
