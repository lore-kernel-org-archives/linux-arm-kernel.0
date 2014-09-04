From: will.deacon@arm.com (Will Deacon)
Date: Thu,  4 Sep 2014 17:50:03 +0100
Subject: [PATCH 5/7] iommu/arm-smmu: don't bother truncating the s1 output
 size to VA_BITS
In-Reply-To: <1409849405-17347-1-git-send-email-will.deacon@arm.com>
References: <1409849405-17347-1-git-send-email-will.deacon@arm.com>
Message-ID: <1409849405-17347-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order for nested translation to work correctly, we need to ensure
that the maximum output address size from stage-1 is <= the maximum
supported input address size to stage-2. The latter is currently defined
by VA_BITS, since we make use of the CPU page table functions for
allocating out tables and so the driver currently enforces this
restriction by truncating the stage-1 output size during probe.

In reality, this doesn't make a lot of sense; the guest OS is responsible
for managing the stage-1 page tables, so we actually just need to ensure
that the ID registers of the virtual SMMU interface only advertise the
supported stage-2 input size.

This patch fixes the problem by treating the stage-1 and stage-2 input
address sizes separately.

Reported-by: Tirumalesh Chalamarla <tchalamarla@cavium.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ecad700cd4f4..2a7e3331b93a 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -24,7 +24,7 @@
  *	- v7/v8 long-descriptor format
  *	- Non-secure access to the SMMU
  *	- 4k and 64k pages, with contiguous pte hints.
- *	- Up to 42-bit addressing (dependent on VA_BITS)
+ *	- Up to 48-bit addressing (dependent on VA_BITS)
  *	- Context fault reporting
  */
 
@@ -375,8 +375,9 @@ struct arm_smmu_device {
 	u32				num_mapping_groups;
 	DECLARE_BITMAP(smr_map, ARM_SMMU_MAX_SMRS);
 
-	unsigned long			input_size;
+	unsigned long			s1_input_size;
 	unsigned long			s1_output_size;
+	unsigned long			s2_input_size;
 	unsigned long			s2_output_size;
 
 	u32				num_global_irqs;
@@ -755,7 +756,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 			       gr1_base + ARM_SMMU_GR1_CBA2R(cfg->cbndx));
 
 		/* TTBCR2 */
-		switch (smmu->input_size) {
+		switch (smmu->s1_input_size) {
 		case 32:
 			reg = (TTBCR2_ADDR_32 << TTBCR2_SEP_SHIFT);
 			break;
@@ -824,7 +825,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 			reg = TTBCR_TG0_64K;
 
 		if (!stage1) {
-			reg |= (64 - smmu->s1_output_size) << TTBCR_T0SZ_SHIFT;
+			reg |= (64 - smmu->s2_input_size) << TTBCR_T0SZ_SHIFT;
 
 			switch (smmu->s2_output_size) {
 			case 32:
@@ -847,7 +848,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 				break;
 			}
 		} else {
-			reg |= (64 - smmu->input_size) << TTBCR_T0SZ_SHIFT;
+			reg |= (64 - smmu->s1_input_size) << TTBCR_T0SZ_SHIFT;
 		}
 	} else {
 		reg = 0;
@@ -1447,9 +1448,11 @@ static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 
 	if (cfg->cbar == CBAR_TYPE_S2_TRANS) {
 		stage = 2;
+		input_mask = (1ULL << smmu->s2_input_size) - 1;
 		output_mask = (1ULL << smmu->s2_output_size) - 1;
 	} else {
 		stage = 1;
+		input_mask = (1ULL << smmu->s1_input_size) - 1;
 		output_mask = (1ULL << smmu->s1_output_size) - 1;
 	}
 
@@ -1459,7 +1462,6 @@ static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 	if (size & ~PAGE_MASK)
 		return -EINVAL;
 
-	input_mask = (1ULL << smmu->input_size) - 1;
 	if ((phys_addr_t)iova & ~input_mask)
 		return -ERANGE;
 
@@ -1831,28 +1833,21 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	/* ID2 */
 	id = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID2);
 	size = arm_smmu_id_size_to_bits((id >> ID2_IAS_SHIFT) & ID2_IAS_MASK);
+	smmu->s1_output_size = min_t(unsigned long, PHYS_MASK_SHIFT, size);
 
-	/*
-	 * Stage-1 output limited by stage-2 input size due to pgd
-	 * allocation (PTRS_PER_PGD).
-	 */
-	if (smmu->features & ARM_SMMU_FEAT_TRANS_NESTED) {
+	/* Stage-2 input size limited due to pgd allocation (PTRS_PER_PGD) */
 #ifdef CONFIG_64BIT
-		smmu->s1_output_size = min_t(unsigned long, VA_BITS, size);
+	smmu->s2_input_size = min_t(unsigned long, VA_BITS, size);
 #else
-		smmu->s1_output_size = min(32UL, size);
+	smmu->s2_input_size = min(32UL, size);
 #endif
-	} else {
-		smmu->s1_output_size = min_t(unsigned long, PHYS_MASK_SHIFT,
-					     size);
-	}
 
 	/* The stage-2 output mask is also applied for bypass */
 	size = arm_smmu_id_size_to_bits((id >> ID2_OAS_SHIFT) & ID2_OAS_MASK);
 	smmu->s2_output_size = min_t(unsigned long, PHYS_MASK_SHIFT, size);
 
 	if (smmu->version == 1) {
-		smmu->input_size = 32;
+		smmu->s1_input_size = 32;
 	} else {
 #ifdef CONFIG_64BIT
 		size = (id >> ID2_UBS_SHIFT) & ID2_UBS_MASK;
@@ -1860,7 +1855,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 #else
 		size = 32;
 #endif
-		smmu->input_size = size;
+		smmu->s1_input_size = size;
 
 		if ((PAGE_SIZE == SZ_4K && !(id & ID2_PTFS_4K)) ||
 		    (PAGE_SIZE == SZ_64K && !(id & ID2_PTFS_64K)) ||
@@ -1871,10 +1866,14 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 		}
 	}
 
-	dev_notice(smmu->dev,
-		   "\t%lu-bit VA, %lu-bit IPA, %lu-bit PA\n",
-		   smmu->input_size, smmu->s1_output_size,
-		   smmu->s2_output_size);
+	if (smmu->features & ARM_SMMU_FEAT_TRANS_S1)
+		dev_notice(smmu->dev, "\tStage-1: %lu-bit VA -> %lu-bit IPA\n",
+			   smmu->s1_input_size, smmu->s1_output_size);
+
+	if (smmu->features & ARM_SMMU_FEAT_TRANS_S2)
+		dev_notice(smmu->dev, "\tStage-2: %lu-bit IPA -> %lu-bit PA\n",
+			   smmu->s2_input_size, smmu->s2_output_size);
+
 	return 0;
 }
 
-- 
2.1.0
