From: sricharan@codeaurora.org (Sricharan R)
Date: Fri,  6 Jan 2017 18:58:16 +0530
Subject: [PATCH V9 9/9] Revert "iommu/arm-smmu: Set PRIVCFG in stage 1 STEs"
In-Reply-To: <1483709296-32761-1-git-send-email-sricharan@codeaurora.org>
References: <1483709296-32761-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1483709296-32761-10-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robin Murphy <robin.murphy@arm.com>

This reverts commit df5e1a0f2a2d779ad467a691203bcbc74d75690e.

Now that proper privileged mappings can be requested via IOMMU_PRIV,
unconditionally overriding the incoming PRIVCFG becomes the wrong thing
to do, so stop it.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4d6ec44..7d45d8b 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -269,9 +269,6 @@
 #define STRTAB_STE_1_SHCFG_INCOMING	1UL
 #define STRTAB_STE_1_SHCFG_SHIFT	44
 
-#define STRTAB_STE_1_PRIVCFG_UNPRIV	2UL
-#define STRTAB_STE_1_PRIVCFG_SHIFT	48
-
 #define STRTAB_STE_2_S2VMID_SHIFT	0
 #define STRTAB_STE_2_S2VMID_MASK	0xffffUL
 #define STRTAB_STE_2_VTCR_SHIFT		32
@@ -1073,9 +1070,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 #ifdef CONFIG_PCI_ATS
 			 STRTAB_STE_1_EATS_TRANS << STRTAB_STE_1_EATS_SHIFT |
 #endif
-			 STRTAB_STE_1_STRW_NSEL1 << STRTAB_STE_1_STRW_SHIFT |
-			 STRTAB_STE_1_PRIVCFG_UNPRIV <<
-			 STRTAB_STE_1_PRIVCFG_SHIFT);
+			 STRTAB_STE_1_STRW_NSEL1 << STRTAB_STE_1_STRW_SHIFT);
 
 		if (smmu->features & ARM_SMMU_FEAT_STALLS)
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
