From: pmallapp@broadcom.com (Prem Mallappa)
Date: Thu, 17 Dec 2015 15:29:35 +0530
Subject: [PATCH v2 1/2] IOMMU: arm-smmu-v3: Fix broken STE.VALID check in
 Broadcom Vulcan
Message-ID: <1450346376-30920-1-git-send-email-pmallapp@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vulcan SMMUv3 looks into more bits than necessary to validate the STE
entry (including EATS, S2PS, AARCH64), which is a overkill, but without
the proper encoding; the SMMU stops processing PCIe read/write requests.
Giving the h/w what it wants.

Signed-off-by: Prem Mallappa <pmallapp@broadcom.com>
---
 drivers/iommu/arm-smmu-v3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 359190b..9886d2d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -260,6 +260,7 @@
 #define STRTAB_STE_2_S2VMID_MASK	0xffffUL
 #define STRTAB_STE_2_VTCR_SHIFT		32
 #define STRTAB_STE_2_VTCR_MASK		0x7ffffUL
+#define STRTAB_STE_2_S2PS_SHIFT        48
 #define STRTAB_STE_2_S2AA64		(1UL << 51)
 #define STRTAB_STE_2_S2ENDI		(1UL << 52)
 #define STRTAB_STE_2_S2PTW		(1UL << 54)
@@ -579,6 +580,7 @@ struct arm_smmu_device {
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
+#define ARM_SMMU_OPT_BRCM_BROKEN_STE_VALID	(1 << 1)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
@@ -643,6 +645,7 @@ struct arm_smmu_option_prop {
 
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
+	{ ARM_SMMU_OPT_BRCM_BROKEN_STE_VALID, "broadcom,broken-ste-valid-check" },
 	{ 0, NULL},
 };
 
@@ -1053,6 +1056,13 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 				      : STRTAB_STE_0_CFG_BYPASS;
 		dst[0] = cpu_to_le64(val);
 		dst[2] = 0; /* Nuke the VMID */
+
+		if (smmu && (smmu->options & ARM_SMMU_OPT_BRCM_BROKEN_STE_VALID)) {
+			WARN_ON(smmu->oas != 44);
+			dst[1] = STRTAB_STE_1_EATS_TRANS << STRTAB_STE_1_EATS_SHIFT;
+			dst[2] |= cpu_to_le64(STRTAB_STE_2_S2AA64);
+		}
+
 		if (ste_live)
 			arm_smmu_sync_ste_for_sid(smmu, sid);
 		return;
-- 
2.6.0
