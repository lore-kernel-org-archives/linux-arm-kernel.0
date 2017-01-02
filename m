From: sricharan@codeaurora.org (Sricharan R)
Date: Mon,  2 Jan 2017 18:42:37 +0530
Subject: [PATCH V8 2/9] iommu/io-pgtable-arm: add support for the IOMMU_PRIV
 flag
In-Reply-To: <1483362764-11990-1-git-send-email-sricharan@codeaurora.org>
References: <1483362764-11990-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1483362764-11990-3-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Gebben <jgebben@codeaurora.org>

Allow the creation of privileged mode mappings, for stage 1 only.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jeremy Gebben <jgebben@codeaurora.org>
---
 drivers/iommu/io-pgtable-arm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index a40ce34..feacc54 100644
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
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
