From: c.tirumalesh@gmail.com (c.tirumalesh at gmail.com)
Date: Wed, 27 Aug 2014 11:02:21 -0700
Subject: [PATCH] iommu/arm-smmu: Allow size of stage 1 output to max possible
 value for sateg 2 bypass
Message-ID: <1409162541-3940-1-git-send-email-c.tirumalesh@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tirumalesh Chalamarla <tchalamarla@cavium.com>

This patch modifes output_mask calculation logic for stage 1 and allow
max possible value supported by SMMU implementaions for translations,
where stage 2 is bypassed.

Erlier it is not possible to access full supported PA address with stage 1,
even if it is supported by SMMU and stage 2 is bypass.

Signed-off-by: Tirumalesh Chalamarla <tchalamarla@cavium.com>
---
 drivers/iommu/arm-smmu.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a6b00bd..56cf42d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -707,6 +707,17 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	void __iomem *cb_base, *gr0_base, *gr1_base;
+	unsigned long s1_out_size;
+
+	if (cfg->cbar == CBAR_TYPE_S1_TRANS_S2_BYPASS) {
+		s1_out_size = smmu->s1_output_size;
+	} else {
+#ifdef CONFIG_64BIT
+		s1_out_size = min((unsigned long)VA_BITS, smmu->s1_output_size);
+#else
+		s1_out_size = min(32UL, smmu->s1_output_size);
+#endif
+	}
 
 	gr0_base = ARM_SMMU_GR0(smmu);
 	gr1_base = ARM_SMMU_GR1(smmu);
@@ -762,7 +773,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 			break;
 		}
 
-		switch (smmu->s1_output_size) {
+		switch (s1_out_size) {
 		case 32:
 			reg |= (TTBCR2_ADDR_32 << TTBCR2_PASIZE_SHIFT);
 			break;
@@ -808,7 +819,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 			reg = TTBCR_TG0_64K;
 
 		if (!stage1) {
-			reg |= (64 - smmu->s1_output_size) << TTBCR_T0SZ_SHIFT;
+			reg |= (64 - s1_out_size) << TTBCR_T0SZ_SHIFT;
 
 			switch (smmu->s2_output_size) {
 			case 32:
@@ -1411,9 +1422,17 @@ static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 	if (cfg->cbar == CBAR_TYPE_S2_TRANS) {
 		stage = 2;
 		output_mask = (1ULL << smmu->s2_output_size) - 1;
-	} else {
+	} else if (cfg->cbar == CBAR_TYPE_S1_TRANS_S2_BYPASS) {
 		stage = 1;
 		output_mask = (1ULL << smmu->s1_output_size) - 1;
+	} else {
+		stage = 1;
+#ifdef CONFIG_64BIT
+		output_mask = (1ULL << min((unsigned long)VA_BITS,
+					smmu->s1_output_size)) - 1;
+#else
+		output_mask = (1ULL << min(32UL, smmu->s1_output_size)) - 1;
+#endif
 	}
 
 	if (!pgd)
@@ -1777,11 +1796,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	 * Stage-1 output limited by stage-2 input size due to pgd
 	 * allocation (PTRS_PER_PGD).
 	 */
-#ifdef CONFIG_64BIT
-	smmu->s1_output_size = min((unsigned long)VA_BITS, size);
-#else
-	smmu->s1_output_size = min(32UL, size);
-#endif
+	smmu->s1_output_size = size;
 
 	/* The stage-2 output mask is also applied for bypass */
 	size = arm_smmu_id_size_to_bits((id >> ID2_OAS_SHIFT) & ID2_OAS_MASK);
-- 
1.9.3
