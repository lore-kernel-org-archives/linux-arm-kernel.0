From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Wed, 17 Sep 2014 13:16:09 -0700
Subject: [PATCH 2/2] iommu/arm-smmu: add support for access-protected mappings
In-Reply-To: <1410984969-2340-1-git-send-email-mitchelh@codeaurora.org>
References: <1410984969-2340-1-git-send-email-mitchelh@codeaurora.org>
Message-ID: <1410984969-2340-3-git-send-email-mitchelh@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM SMMUs support memory access control via some bits in the translation
table descriptor memory attributes. Currently we assume all translations
are "unprivileged". Add support for privileged mappings, controlled by
the IOMMU_PRIV prot flag.

Also sneak in a whitespace change for consistency with nearby code.

Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ca18d6d42a..93999ec22c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1256,10 +1256,11 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 	}
 
 	if (stage == 1) {
-		pteval |= ARM_SMMU_PTE_AP_UNPRIV | ARM_SMMU_PTE_nG;
+		pteval |= ARM_SMMU_PTE_nG;
+		if (!(prot & IOMMU_PRIV))
+			pteval |= ARM_SMMU_PTE_AP_UNPRIV;
 		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
 			pteval |= ARM_SMMU_PTE_AP_RDONLY;
-
 		if (prot & IOMMU_CACHE)
 			pteval |= (MAIR_ATTR_IDX_CACHE <<
 				   ARM_SMMU_PTE_ATTRINDX_SHIFT);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
