From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 10 Jul 2014 14:52:54 +0800
Subject: [PATCH v3 01/13] iommu/arm: change some structure member types in
 arm_smmu_device
In-Reply-To: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
References: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1404975186-12032-2-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some structure members, such as s1_output_size, it's impossible large than 4G.
Change unsigned long to u32 can save a few memory on ARM64.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1599354..d0f0021 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -352,8 +352,8 @@ struct arm_smmu_device {
 	struct device_node		*parent_of_node;

 	void __iomem			*base;
-	unsigned long			size;
-	unsigned long			pagesize;
+	u32				size;
+	u32				pagesize;

 #define ARM_SMMU_FEAT_COHERENT_WALK	(1 << 0)
 #define ARM_SMMU_FEAT_STREAM_MATCH	(1 << 1)
@@ -374,9 +374,9 @@ struct arm_smmu_device {
 	u32				num_mapping_groups;
 	DECLARE_BITMAP(smr_map, ARM_SMMU_MAX_SMRS);

-	unsigned long			input_size;
-	unsigned long			s1_output_size;
-	unsigned long			s2_output_size;
+	u32				input_size;
+	u32				s1_output_size;
+	u32				s2_output_size;

 	u32				num_global_irqs;
 	u32				num_context_irqs;
@@ -1676,7 +1676,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 }

-static int arm_smmu_id_size_to_bits(int size)
+static u32 arm_smmu_id_size_to_bits(u32 size)
 {
 	switch (size) {
 	case 0:
@@ -1697,7 +1697,7 @@ static int arm_smmu_id_size_to_bits(int size)

 static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 {
-	unsigned long size;
+	u32 size;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 	u32 id;

@@ -1782,8 +1782,8 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	size = 1 << (((id >> ID1_NUMPAGENDXB_SHIFT) & ID1_NUMPAGENDXB_MASK) + 1);
 	size *= (smmu->pagesize << 1);
 	if (smmu->size != size)
-		dev_warn(smmu->dev, "SMMU address space size (0x%lx) differs "
-			"from mapped region size (0x%lx)!\n", size, smmu->size);
+		dev_warn(smmu->dev, "SMMU address space size (0x%x) differs "
+			"from mapped region size (0x%x)!\n", size, smmu->size);

 	smmu->num_s2_context_banks = (id >> ID1_NUMS2CB_SHIFT) &
 				      ID1_NUMS2CB_MASK;
@@ -1804,21 +1804,21 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	 * allocation (PTRS_PER_PGD).
 	 */
 #ifdef CONFIG_64BIT
-	smmu->s1_output_size = min((unsigned long)VA_BITS, size);
+	smmu->s1_output_size = min((u32)VA_BITS, size);
 #else
-	smmu->s1_output_size = min(32UL, size);
+	smmu->s1_output_size = min(32U, size);
 #endif

 	/* The stage-2 output mask is also applied for bypass */
 	size = arm_smmu_id_size_to_bits((id >> ID2_OAS_SHIFT) & ID2_OAS_MASK);
-	smmu->s2_output_size = min((unsigned long)PHYS_MASK_SHIFT, size);
+	smmu->s2_output_size = min((u32)PHYS_MASK_SHIFT, size);

 	if (smmu->version == 1) {
 		smmu->input_size = 32;
 	} else {
 #ifdef CONFIG_64BIT
 		size = (id >> ID2_UBS_SHIFT) & ID2_UBS_MASK;
-		size = min(VA_BITS, arm_smmu_id_size_to_bits(size));
+		size = min((u32)VA_BITS, arm_smmu_id_size_to_bits(size));
 #else
 		size = 32;
 #endif
@@ -1834,7 +1834,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	}

 	dev_notice(smmu->dev,
-		   "\t%lu-bit VA, %lu-bit IPA, %lu-bit PA\n",
+		   "\t%u-bit VA, %u-bit IPA, %u-bit PA\n",
 		   smmu->input_size, smmu->s1_output_size, smmu->s2_output_size);
 	return 0;
 }
--
1.8.0
