From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 20 Nov 2014 17:57:01 +0800
Subject: [PATCH 1/1] iommu/arm-smmu: forbid userspace IO devices access memory
 through SMMU by default
Message-ID: <1416477421-1288-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's dangerous to set pte with ARM_SMMU_PTE_AP_UNPRIV. A hacker can use any
devices running at userspace to access the memory which originally mapped for
kernel devices, suppose they have the same StreamID. The userspace devices
should through vfio to dynamic create mapping.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 60558f7..e31517b 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -92,7 +92,7 @@
 #define ARM_SMMU_PTE_CONT_MASK		(~(ARM_SMMU_PTE_CONT_SIZE - 1))

 /* Stage-1 PTE */
-#define ARM_SMMU_PTE_AP_UNPRIV		(((pteval_t)1) << 6)
+#define ARM_SMMU_PTE_AP_PRIV		(((pteval_t)0) << 6)
 #define ARM_SMMU_PTE_AP_RDONLY		(((pteval_t)2) << 6)
 #define ARM_SMMU_PTE_ATTRINDX_SHIFT	2
 #define ARM_SMMU_PTE_nG			(((pteval_t)1) << 11)
@@ -1296,7 +1296,7 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 	}

 	if (stage == 1) {
-		pteval |= ARM_SMMU_PTE_AP_UNPRIV | ARM_SMMU_PTE_nG;
+		pteval |= ARM_SMMU_PTE_AP_PRIV | ARM_SMMU_PTE_nG;
 		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
 			pteval |= ARM_SMMU_PTE_AP_RDONLY;

--
1.8.0
