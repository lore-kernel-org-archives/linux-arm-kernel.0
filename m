From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 10 Jul 2014 14:53:03 +0800
Subject: [PATCH v3 10/13] iommu/arm: Adjust code to reuse more
In-Reply-To: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
References: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1404975186-12032-11-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Limit smmu ias,oas,uas size is a common operation, the value of register MAIR0
should be consistent across all SMMUs.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-base.c | 20 ++++++++++++++++++++
 drivers/iommu/arm-smmu.c      | 27 ++++-----------------------
 drivers/iommu/arm-smmu.h      |  7 +++++++
 3 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/arm-smmu-base.c b/drivers/iommu/arm-smmu-base.c
index 400de39..8013751 100644
--- a/drivers/iommu/arm-smmu-base.c
+++ b/drivers/iommu/arm-smmu-base.c
@@ -954,6 +954,26 @@ int arm_smmu_device_dt_probe(struct platform_device *pdev,
 		return -ENOMEM;
 	}

+	/*
+	 * Stage-1 output limited by stage-2 input size due to pgd
+	 * allocation (PTRS_PER_PGD).
+	 */
+#ifdef CONFIG_64BIT
+	smmu->s1_output_size = min((u32)VA_BITS, smmu->s1_output_size);
+	smmu->input_size = min((u32)VA_BITS, smmu->input_size);
+#else
+	smmu->s1_output_size = min(32U, smmu->s1_output_size);
+	smmu->input_size = 32;
+#endif
+
+	/* The stage-2 output mask is also applied for bypass */
+	smmu->s2_output_size = min((u32)PHYS_MASK_SHIFT, smmu->s2_output_size);
+
+	dev_notice(smmu->dev,
+		   "\t%u-bit VA, %u-bit IPA, %u-bit PA\n",
+		   smmu->input_size,
+		   smmu->s1_output_size, smmu->s2_output_size);
+
 	parse_driver_options(smmu);

 	if (smmu->version > 1 &&
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index dbd9c60..6971e11 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -489,9 +489,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)

 	/* MAIR0 (stage-1 only) */
 	if (stage1) {
-		reg = (MAIR_ATTR_NC << MAIR_ATTR_SHIFT(MAIR_ATTR_IDX_NC)) |
-		      (MAIR_ATTR_WBRWA << MAIR_ATTR_SHIFT(MAIR_ATTR_IDX_CACHE)) |
-		      (MAIR_ATTR_DEVICE << MAIR_ATTR_SHIFT(MAIR_ATTR_IDX_DEV));
+		reg = MAIR0_STAGE1;
 		writel_relaxed(reg, cb_base + ARM_SMMU_CB_S1_MAIR0);
 	}

@@ -828,30 +826,16 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	id = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID2);
 	size = arm_smmu_id_size_to_bits((id >> ID2_IAS_SHIFT) & ID2_IAS_MASK);

-	/*
-	 * Stage-1 output limited by stage-2 input size due to pgd
-	 * allocation (PTRS_PER_PGD).
-	 */
-#ifdef CONFIG_64BIT
-	smmu->s1_output_size = min((u32)VA_BITS, size);
-#else
-	smmu->s1_output_size = min(32U, size);
-#endif
+	smmu->s1_output_size = size;

-	/* The stage-2 output mask is also applied for bypass */
 	size = arm_smmu_id_size_to_bits((id >> ID2_OAS_SHIFT) & ID2_OAS_MASK);
-	smmu->s2_output_size = min((u32)PHYS_MASK_SHIFT, size);
+	smmu->s2_output_size = size;

 	if (smmu->version == 1) {
 		smmu->input_size = 32;
 	} else {
-#ifdef CONFIG_64BIT
 		size = (id >> ID2_UBS_SHIFT) & ID2_UBS_MASK;
-		size = min((u32)VA_BITS, arm_smmu_id_size_to_bits(size));
-#else
-		size = 32;
-#endif
-		smmu->input_size = size;
+		smmu->input_size = arm_smmu_id_size_to_bits(size);

 		if ((PAGE_SIZE == SZ_4K && !(id & ID2_PTFS_4K)) ||
 		    (PAGE_SIZE == SZ_64K && !(id & ID2_PTFS_64K)) ||
@@ -862,9 +846,6 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 		}
 	}

-	dev_notice(smmu->dev,
-		   "\t%u-bit VA, %u-bit IPA, %u-bit PA\n",
-		   smmu->input_size, smmu->s1_output_size, smmu->s2_output_size);
 	return 0;
 }

diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index fff2b98..3164ba78 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -72,6 +72,7 @@
 #define RESUME_RETRY			(0 << 0)
 #define RESUME_TERMINATE		(1 << 0)

+/* In SMMUv2, this register is named SMMU_CBn_TCR */
 #define TTBCR_EAE			(1 << 31)

 #define TTBCR_PASIZE_SHIFT		16
@@ -112,6 +113,12 @@
 #define MAIR_ATTR_IDX_CACHE		1
 #define MAIR_ATTR_IDX_DEV		2

+#define MAIR0_STAGE1	\
+	((MAIR_ATTR_NC << MAIR_ATTR_SHIFT(MAIR_ATTR_IDX_NC)) |	\
+	(MAIR_ATTR_WBRWA << MAIR_ATTR_SHIFT(MAIR_ATTR_IDX_CACHE)) |	\
+	(MAIR_ATTR_DEVICE << MAIR_ATTR_SHIFT(MAIR_ATTR_IDX_DEV)))
+
+
 struct arm_smmu_smr {
 	u8				idx;
 	u16				mask;
--
1.8.0
