From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 10 Jul 2014 14:52:58 +0800
Subject: [PATCH v3 05/13] iommu/arm: Rename member "cbar" in struct
 arm_smmu_cfg to "type"
In-Reply-To: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
References: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1404975186-12032-6-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SMMUs may not contain register CBAR, or the "type" field definition may be
different.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-base.c |  8 ++++----
 drivers/iommu/arm-smmu.c      |  8 +++++---
 drivers/iommu/arm-smmu.h      | 11 ++++-------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm-smmu-base.c b/drivers/iommu/arm-smmu-base.c
index c6824b5..0b02da8 100644
--- a/drivers/iommu/arm-smmu-base.c
+++ b/drivers/iommu/arm-smmu-base.c
@@ -240,13 +240,13 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		 * We will likely want to change this if/when KVM gets
 		 * involved.
 		 */
-		root_cfg->cbar = CBAR_TYPE_S1_TRANS_S2_BYPASS;
+		root_cfg->type = TYPE_S1_TRANS_S2_BYPASS;
 		start = smmu->num_s2_context_banks;
 	} else if (smmu->features & ARM_SMMU_FEAT_TRANS_S2) {
-		root_cfg->cbar = CBAR_TYPE_S2_TRANS;
+		root_cfg->type = TYPE_S2_TRANS;
 		start = 0;
 	} else {
-		root_cfg->cbar = CBAR_TYPE_S1_TRANS_S2_BYPASS;
+		root_cfg->type = TYPE_S1_TRANS_S2_BYPASS;
 		start = smmu->num_s2_context_banks;
 	}

@@ -633,7 +633,7 @@ static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_device *smmu = root_cfg->smmu;
 	unsigned long flags;

-	if (root_cfg->cbar == CBAR_TYPE_S2_TRANS) {
+	if (root_cfg->type == TYPE_S2_TRANS) {
 		stage = 2;
 		output_mask = (1ULL << smmu->s2_output_size) - 1;
 	} else {
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index d08149d..b9538f6 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -153,6 +153,8 @@
 #define CBAR_S1_MEMATTR_SHIFT		12
 #define CBAR_S1_MEMATTR_MASK		0xf
 #define CBAR_S1_MEMATTR_WB		0xf
+#define CBAR_TYPE_SHIFT			16
+#define CBAR_TYPE_MASK			0x3
 #define CBAR_IRPTNDX_SHIFT		24
 #define CBAR_IRPTNDX_MASK		0xff

@@ -244,7 +246,7 @@ static void arm_smmu_tlb_inv_context(struct arm_smmu_cfg *cfg)
 {
 	struct arm_smmu_device *smmu = cfg->smmu;
 	void __iomem *base = ARM_SMMU_GR0(smmu);
-	bool stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
+	bool stage1 = cfg->type != TYPE_S2_TRANS;

 	if (stage1) {
 		base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
@@ -346,11 +348,11 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)

 	gr0_base = ARM_SMMU_GR0(smmu);
 	gr1_base = ARM_SMMU_GR1(smmu);
-	stage1 = root_cfg->cbar != CBAR_TYPE_S2_TRANS;
+	stage1 = root_cfg->type != TYPE_S2_TRANS;
 	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, root_cfg->cbndx);

 	/* CBAR */
-	reg = root_cfg->cbar;
+	reg = root_cfg->type << CBAR_TYPE_SHIFT;
 	if (smmu->version == 1)
 	      reg |= root_cfg->irptndx << CBAR_IRPTNDX_SHIFT;

diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index ca35694..d66a8c4 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -68,12 +68,9 @@

 #define TLB_LOOP_TIMEOUT		1000000	/* 1s! */

-#define CBAR_TYPE_SHIFT			16
-#define CBAR_TYPE_MASK			0x3
-#define CBAR_TYPE_S2_TRANS		(0 << CBAR_TYPE_SHIFT)
-#define CBAR_TYPE_S1_TRANS_S2_BYPASS	(1 << CBAR_TYPE_SHIFT)
-#define CBAR_TYPE_S1_TRANS_S2_FAULT	(2 << CBAR_TYPE_SHIFT)
-#define CBAR_TYPE_S1_TRANS_S2_TRANS	(3 << CBAR_TYPE_SHIFT)
+#define TYPE_S2_TRANS			0
+#define TYPE_S1_TRANS_S2_BYPASS		1
+#define TYPE_S1_TRANS_S2_TRANS		3

 #define RESUME_RETRY			(0 << 0)
 #define RESUME_TERMINATE		(1 << 0)
@@ -189,7 +186,7 @@ struct arm_smmu_cfg {
 	struct arm_smmu_device		*smmu;
 	u8				cbndx;
 	u8				irptndx;
-	u32				cbar;
+	u32				type;
 	pgd_t				*pgd;
 };
 #define INVALID_IRPTNDX			0xff
--
1.8.0
