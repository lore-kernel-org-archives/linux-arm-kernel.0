From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Wed,  6 Jul 2016 16:51:35 -0700
Subject: [PATCH 2/3] iommu/io-pgtable-arm: add support for the IOMMU_PRIV flag
In-Reply-To: <20160706235136.27854-1-mitchelh@codeaurora.org>
References: <20160706235136.27854-1-mitchelh@codeaurora.org>
Message-ID: <20160706235136.27854-3-mitchelh@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Gebben <jgebben@codeaurora.org>

Allow the creation of privileged mode mappings, for stage 1 only.

Signed-off-by: Jeremy Gebben <jgebben@codeaurora.org>
---
 drivers/iommu/io-pgtable-arm.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index a1ed1b73fed4..e9e7dd179708 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -101,8 +101,10 @@
 					 ARM_LPAE_PTE_ATTR_HI_MASK)
 
 /* Stage-1 PTE */
-#define ARM_LPAE_PTE_AP_UNPRIV		(((arm_lpae_iopte)1) << 6)
-#define ARM_LPAE_PTE_AP_RDONLY		(((arm_lpae_iopte)2) << 6)
+#define ARM_LPAE_PTE_AP_PRIV_RW		(((arm_lpae_iopte)0) << 6)
+#define ARM_LPAE_PTE_AP_RW		(((arm_lpae_iopte)1) << 6)
+#define ARM_LPAE_PTE_AP_PRIV_RO		(((arm_lpae_iopte)2) << 6)
+#define ARM_LPAE_PTE_AP_RO		(((arm_lpae_iopte)3) << 6)
 #define ARM_LPAE_PTE_ATTRINDX_SHIFT	2
 #define ARM_LPAE_PTE_nG			(((arm_lpae_iopte)1) << 11)
 
@@ -350,10 +352,14 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 
 	if (data->iop.fmt == ARM_64_LPAE_S1 ||
 	    data->iop.fmt == ARM_32_LPAE_S1) {
-		pte = ARM_LPAE_PTE_AP_UNPRIV | ARM_LPAE_PTE_nG;
+		pte = ARM_LPAE_PTE_nG;
 
-		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
-			pte |= ARM_LPAE_PTE_AP_RDONLY;
+		if (prot & IOMMU_WRITE)
+			pte |= (prot & IOMMU_PRIV) ? ARM_LPAE_PTE_AP_PRIV_RW
+					: ARM_LPAE_PTE_AP_RW;
+		else
+			pte |= (prot & IOMMU_PRIV) ? ARM_LPAE_PTE_AP_PRIV_RO
+					: ARM_LPAE_PTE_AP_RO;
 
 		if (prot & IOMMU_MMIO)
 			pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
