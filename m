From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Tue, 19 Jul 2016 13:36:51 -0700
Subject: [PATCH v3 2/6] iommu/io-pgtable-arm: add support for the IOMMU_PRIV
 flag
In-Reply-To: <20160719203655.16629-1-mitchelh@codeaurora.org>
References: <20160719203655.16629-1-mitchelh@codeaurora.org>
Message-ID: <20160719203655.16629-3-mitchelh@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Gebben <jgebben@codeaurora.org>

Allow the creation of privileged mode mappings, for stage 1 only.

Signed-off-by: Jeremy Gebben <jgebben@codeaurora.org>
---

Notes:
    v2..v3
    
      - Use existing bit definitions.

 drivers/iommu/io-pgtable-arm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index a1ed1b73fed4..2a7d28ab8241 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -350,11 +350,14 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 
 	if (data->iop.fmt == ARM_64_LPAE_S1 ||
 	    data->iop.fmt == ARM_32_LPAE_S1) {
-		pte = ARM_LPAE_PTE_AP_UNPRIV | ARM_LPAE_PTE_nG;
+		pte = ARM_LPAE_PTE_nG;
 
 		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
 			pte |= ARM_LPAE_PTE_AP_RDONLY;
 
+		if (!(prot & IOMMU_PRIV))
+			pte |= ARM_LPAE_PTE_AP_UNPRIV;
+
 		if (prot & IOMMU_MMIO)
 			pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
 				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
