From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Fri, 18 May 2018 15:34:46 -0600
Subject: [PATCH 02/16] iommu/arm-smmu: Add split pagetable support for
 arm-smmu-v2
In-Reply-To: <20180518213500.31595-1-jcrouse@codeaurora.org>
References: <20180518213500.31595-1-jcrouse@codeaurora.org>
Message-ID: <20180518213500.31595-3-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for a split pagetable (TTBR0/TTBR1) scheme for
arm-smmu-v2. If split pagetables are enabled, create a
pagetable for TTBR1 and set up the sign extension bit so
that all IOVAs with that bit set are mapped and translated
from the TTBR1 pagetable.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/iommu/arm-smmu-regs.h  |  18 ++++
 drivers/iommu/arm-smmu.c       | 148 +++++++++++++++++++++++++++++----
 drivers/iommu/io-pgtable-arm.c |   3 +-
 3 files changed, 153 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
index a1226e4ab5f8..56f97093f46a 100644
--- a/drivers/iommu/arm-smmu-regs.h
+++ b/drivers/iommu/arm-smmu-regs.h
@@ -193,7 +193,25 @@ enum arm_smmu_s2cr_privcfg {
 #define RESUME_RETRY			(0 << 0)
 #define RESUME_TERMINATE		(1 << 0)
 
+#define TTBCR_EPD1			(1 << 23)
+#define TTBCR_T1SZ_SHIFT		16
+#define TTBCR_IRGN1_SHIFT		24
+#define TTBCR_ORGN1_SHIFT		26
+#define TTBCR_RGN_WBWA			1
+#define TTBCR_SH1_SHIFT			28
+#define TTBCR_SH_IS			3
+
+#define TTBCR_TG1_16K			(1 << 30)
+#define TTBCR_TG1_4K			(2 << 30)
+#define TTBCR_TG1_64K			(3 << 30)
+
 #define TTBCR2_SEP_SHIFT		15
+#define TTBCR2_SEP_31			(0x0 << TTBCR2_SEP_SHIFT)
+#define TTBCR2_SEP_35			(0x1 << TTBCR2_SEP_SHIFT)
+#define TTBCR2_SEP_39			(0x2 << TTBCR2_SEP_SHIFT)
+#define TTBCR2_SEP_41			(0x3 << TTBCR2_SEP_SHIFT)
+#define TTBCR2_SEP_43			(0x4 << TTBCR2_SEP_SHIFT)
+#define TTBCR2_SEP_47			(0x5 << TTBCR2_SEP_SHIFT)
 #define TTBCR2_SEP_UPSTREAM		(0x7 << TTBCR2_SEP_SHIFT)
 #define TTBCR2_AS			(1 << 4)
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 69e7c60792a8..3568e8b073ec 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -143,6 +143,7 @@ struct arm_smmu_cb {
 	u32				tcr[2];
 	u32				mair[2];
 	struct arm_smmu_cfg		*cfg;
+	u64				split_table_mask;
 };
 
 struct arm_smmu_master_cfg {
@@ -200,6 +201,7 @@ struct arm_smmu_device {
 	unsigned long			va_size;
 	unsigned long			ipa_size;
 	unsigned long			pa_size;
+	unsigned long			ubs_size;
 	unsigned long			pgsize_bitmap;
 
 	u32				num_global_irqs;
@@ -242,12 +244,13 @@ enum arm_smmu_domain_stage {
 
 struct arm_smmu_domain {
 	struct arm_smmu_device		*smmu;
-	struct io_pgtable_ops		*pgtbl_ops;
+	struct io_pgtable_ops		*pgtbl_ops[2];
 	const struct iommu_gather_ops	*tlb_ops;
 	struct arm_smmu_cfg		cfg;
 	enum arm_smmu_domain_stage	stage;
 	struct mutex			init_mutex; /* Protects smmu pointer */
 	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
+	u32 attributes;
 	struct iommu_domain		domain;
 };
 
@@ -582,6 +585,69 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static void arm_smmu_init_ttbr1(struct arm_smmu_domain *smmu_domain,
+		struct io_pgtable_cfg *pgtbl_cfg)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	struct arm_smmu_cb *cb = &smmu_domain->smmu->cbs[cfg->cbndx];
+	int pgsize = 1 << __ffs(pgtbl_cfg->pgsize_bitmap);
+
+	/* Enable speculative walks through the TTBR1 */
+	cb->tcr[0] &= ~TTBCR_EPD1;
+
+	cb->tcr[0] |= TTBCR_SH_IS << TTBCR_SH1_SHIFT;
+	cb->tcr[0] |= TTBCR_RGN_WBWA << TTBCR_IRGN1_SHIFT;
+	cb->tcr[0] |= TTBCR_RGN_WBWA << TTBCR_ORGN1_SHIFT;
+
+	switch (pgsize) {
+	case SZ_4K:
+		cb->tcr[0] |= TTBCR_TG1_4K;
+		break;
+	case SZ_16K:
+		cb->tcr[0] |= TTBCR_TG1_16K;
+		break;
+	case SZ_64K:
+		cb->tcr[0] |= TTBCR_TG1_64K;
+		break;
+	}
+
+	cb->tcr[0] |= (64ULL - smmu->va_size) << TTBCR_T1SZ_SHIFT;
+
+	/* Clear the existing SEP configuration */
+	cb->tcr[1] &= ~TTBCR2_SEP_UPSTREAM;
+
+	/* Set up the sign extend bit */
+	switch (smmu->va_size) {
+	case 32:
+		cb->tcr[1] |= TTBCR2_SEP_31;
+		cb->split_table_mask = (1ULL << 31);
+		break;
+	case 36:
+		cb->tcr[1] |= TTBCR2_SEP_35;
+		cb->split_table_mask = (1ULL << 35);
+		break;
+	case 40:
+		cb->tcr[1] |= TTBCR2_SEP_39;
+		cb->split_table_mask = (1ULL << 39);
+		break;
+	case 42:
+		cb->tcr[1] |= TTBCR2_SEP_41;
+		cb->split_table_mask = (1ULL << 41);
+		break;
+	case 44:
+		cb->tcr[1] |= TTBCR2_SEP_43;
+		cb->split_table_mask = (1ULL << 43);
+		break;
+	case 48:
+		cb->tcr[1] |= TTBCR2_SEP_UPSTREAM;
+		cb->split_table_mask = (1ULL << 48);
+	}
+
+	cb->ttbr[1] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
+	cb->ttbr[1] |= (u64)cfg->asid << TTBRn_ASID_SHIFT;
+}
+
 static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
@@ -614,8 +680,12 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 		} else {
 			cb->ttbr[0] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
 			cb->ttbr[0] |= (u64)cfg->asid << TTBRn_ASID_SHIFT;
-			cb->ttbr[1] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
-			cb->ttbr[1] |= (u64)cfg->asid << TTBRn_ASID_SHIFT;
+
+			/*
+			 * Set TTBR1 to empty by default - it will get
+			 * programmed later if it is enabled
+			 */
+			cb->ttbr[1] = (u64)cfg->asid << TTBRn_ASID_SHIFT;
 		}
 	} else {
 		cb->ttbr[0] = pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
@@ -724,11 +794,13 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 {
 	int irq, start, ret = 0;
 	unsigned long ias, oas;
-	struct io_pgtable_ops *pgtbl_ops;
+	struct io_pgtable_ops *pgtbl_ops[2];
 	struct io_pgtable_cfg pgtbl_cfg;
 	enum io_pgtable_fmt fmt;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	bool split_tables =
+		(smmu_domain->attributes & (1 << DOMAIN_ATTR_SPLIT_TABLES));
 
 	mutex_lock(&smmu_domain->init_mutex);
 	if (smmu_domain->smmu)
@@ -758,8 +830,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	 *
 	 * Note that you can't actually request stage-2 mappings.
 	 */
-	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
+	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1)) {
 		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
+		/* FIXME: fail instead? */
+		split_tables = false;
+	}
 	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
 		smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
 
@@ -776,8 +851,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (IS_ENABLED(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) &&
 	    !IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_ARM_LPAE) &&
 	    (smmu->features & ARM_SMMU_FEAT_FMT_AARCH32_S) &&
-	    (smmu_domain->stage == ARM_SMMU_DOMAIN_S1))
+	    (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)) {
+		/* FIXME: fail instead? */
+		split_tables = false;
 		cfg->fmt = ARM_SMMU_CTX_FMT_AARCH32_S;
+	}
 	if ((IS_ENABLED(CONFIG_64BIT) || cfg->fmt == ARM_SMMU_CTX_FMT_NONE) &&
 	    (smmu->features & (ARM_SMMU_FEAT_FMT_AARCH64_64K |
 			       ARM_SMMU_FEAT_FMT_AARCH64_16K |
@@ -864,8 +942,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
 
 	smmu_domain->smmu = smmu;
-	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
-	if (!pgtbl_ops) {
+	pgtbl_ops[0] = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
+	if (!pgtbl_ops[0]) {
 		ret = -ENOMEM;
 		goto out_clear_smmu;
 	}
@@ -877,6 +955,22 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 
 	/* Initialise the context bank with our page table cfg */
 	arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
+
+	pgtbl_ops[1] = NULL;
+
+	if (split_tables) {
+		/* FIXME: I think it is safe to reuse pgtbl_cfg here */
+		pgtbl_ops[1] = alloc_io_pgtable_ops(fmt, &pgtbl_cfg,
+			smmu_domain);
+		if (!pgtbl_ops[1]) {
+			free_io_pgtable_ops(pgtbl_ops[0]);
+			ret = -ENOMEM;
+			goto out_clear_smmu;
+		}
+
+		arm_smmu_init_ttbr1(smmu_domain, &pgtbl_cfg);
+	}
+
 	arm_smmu_write_context_bank(smmu, cfg->cbndx);
 
 	/*
@@ -895,7 +989,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	mutex_unlock(&smmu_domain->init_mutex);
 
 	/* Publish page table ops for map/unmap */
-	smmu_domain->pgtbl_ops = pgtbl_ops;
+	smmu_domain->pgtbl_ops[0] = pgtbl_ops[0];
+	smmu_domain->pgtbl_ops[1] = pgtbl_ops[1];
+
 	return 0;
 
 out_clear_smmu:
@@ -927,7 +1023,9 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 		devm_free_irq(smmu->dev, irq, domain);
 	}
 
-	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
+	free_io_pgtable_ops(smmu_domain->pgtbl_ops[0]);
+	free_io_pgtable_ops(smmu_domain->pgtbl_ops[1]);
+
 	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
 }
 
@@ -1230,10 +1328,23 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return arm_smmu_domain_add_master(smmu_domain, fwspec);
 }
 
+static struct io_pgtable_ops *
+arm_smmu_get_pgtbl_ops(struct iommu_domain *domain, unsigned long iova)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	struct arm_smmu_cb *cb = &smmu_domain->smmu->cbs[cfg->cbndx];
+
+	if (iova & cb->split_table_mask)
+		return smmu_domain->pgtbl_ops[1];
+
+	return smmu_domain->pgtbl_ops[0];
+}
+
 static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 			phys_addr_t paddr, size_t size, int prot)
 {
-	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
+	struct io_pgtable_ops *ops = arm_smmu_get_pgtbl_ops(domain, iova);
 
 	if (!ops)
 		return -ENODEV;
@@ -1244,7 +1355,7 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 			     size_t size)
 {
-	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
+	struct io_pgtable_ops *ops = arm_smmu_get_pgtbl_ops(domain, iova);
 
 	if (!ops)
 		return 0;
@@ -1266,7 +1377,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	struct io_pgtable_ops *ops= smmu_domain->pgtbl_ops;
+	struct io_pgtable_ops *ops = arm_smmu_get_pgtbl_ops(domain, iova);
 	struct device *dev = smmu->dev;
 	void __iomem *cb_base;
 	u32 tmp;
@@ -1307,7 +1418,7 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
 					dma_addr_t iova)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
+	struct io_pgtable_ops *ops = arm_smmu_get_pgtbl_ops(domain, iova);
 
 	if (domain->type == IOMMU_DOMAIN_IDENTITY)
 		return iova;
@@ -1477,6 +1588,10 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 	case DOMAIN_ATTR_NESTING:
 		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
 		return 0;
+	case DOMAIN_ATTR_SPLIT_TABLES:
+		*((int *)data) = !!(smmu_domain->attributes
+					& (1 << DOMAIN_ATTR_SPLIT_TABLES));
+		return 0;
 	default:
 		return -ENODEV;
 	}
@@ -1506,6 +1621,11 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 			smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
 
 		break;
+	case DOMAIN_ATTR_SPLIT_TABLES:
+		if (*((int *)data))
+			smmu_domain->attributes |=
+				1 << DOMAIN_ATTR_SPLIT_TABLES;
+		break;
 	default:
 		ret = -ENODEV;
 	}
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index fe851eae9057..920d9faa2a76 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -422,8 +422,7 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
 	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
 		return 0;
 
-	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias) ||
-		    paddr >= (1ULL << data->iop.cfg.oas)))
+	if (WARN_ON(paddr >= (1ULL << data->iop.cfg.oas)))
 		return -ERANGE;
 
 	prot = arm_lpae_prot_to_pte(data, iommu_prot);
-- 
2.17.0
