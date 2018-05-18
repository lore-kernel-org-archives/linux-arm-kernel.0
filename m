From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Fri, 18 May 2018 15:34:47 -0600
Subject: [PATCH 03/16] iommu/io-pgtable-arm: Remove ttbr[1] from io_pgtbl_cfg
In-Reply-To: <20180518213500.31595-1-jcrouse@codeaurora.org>
References: <20180518213500.31595-1-jcrouse@codeaurora.org>
Message-ID: <20180518213500.31595-4-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a working example of an ARM driver that implements
split pagetables completely in the client driver it is apparent that
we don't need to store an extra ttbr value in the io_pgtbl_cfg struct
that will never get used.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/iommu/arm-smmu-v3-context.c | 2 +-
 drivers/iommu/arm-smmu.c            | 8 ++++----
 drivers/iommu/io-pgtable-arm-v7s.c  | 3 +--
 drivers/iommu/io-pgtable-arm.c      | 5 ++---
 drivers/iommu/io-pgtable.h          | 4 ++--
 drivers/iommu/ipmmu-vmsa.c          | 2 +-
 drivers/iommu/msm_iommu.c           | 4 ++--
 drivers/iommu/mtk_iommu.c           | 4 ++--
 drivers/iommu/qcom_iommu.c          | 3 +--
 9 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3-context.c b/drivers/iommu/arm-smmu-v3-context.c
index 22e7b80a7682..d23e0092f917 100644
--- a/drivers/iommu/arm-smmu-v3-context.c
+++ b/drivers/iommu/arm-smmu-v3-context.c
@@ -522,7 +522,7 @@ arm_smmu_alloc_priv_cd(struct iommu_pasid_table_ops *ops,
 
 	switch (fmt) {
 	case ARM_64_LPAE_S1:
-		cd->ttbr	= cfg->arm_lpae_s1_cfg.ttbr[0];
+		cd->ttbr	= cfg->arm_lpae_s1_cfg.ttbr;
 		cd->tcr		= cfg->arm_lpae_s1_cfg.tcr;
 		cd->mair	= cfg->arm_lpae_s1_cfg.mair[0];
 		break;
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 3568e8b073ec..d459909877c3 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -644,7 +644,7 @@ static void arm_smmu_init_ttbr1(struct arm_smmu_domain *smmu_domain,
 		cb->split_table_mask = (1ULL << 48);
 	}
 
-	cb->ttbr[1] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
+	cb->ttbr[1] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
 	cb->ttbr[1] |= (u64)cfg->asid << TTBRn_ASID_SHIFT;
 }
 
@@ -675,10 +675,10 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 	/* TTBRs */
 	if (stage1) {
 		if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_S) {
-			cb->ttbr[0] = pgtbl_cfg->arm_v7s_cfg.ttbr[0];
-			cb->ttbr[1] = pgtbl_cfg->arm_v7s_cfg.ttbr[1];
+			cb->ttbr[0] = pgtbl_cfg->arm_v7s_cfg.ttbr;
+			cb->ttbr[1] = 0;
 		} else {
-			cb->ttbr[0] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
+			cb->ttbr[0] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
 			cb->ttbr[0] |= (u64)cfg->asid << TTBRn_ASID_SHIFT;
 
 			/*
diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 10e4a3d11c02..37d607ac5153 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -767,11 +767,10 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	wmb();
 
 	/* TTBRs */
-	cfg->arm_v7s_cfg.ttbr[0] = virt_to_phys(data->pgd) |
+	cfg->arm_v7s_cfg.ttbr = virt_to_phys(data->pgd) |
 				   ARM_V7S_TTBR_S | ARM_V7S_TTBR_NOS |
 				   ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_WBWA) |
 				   ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_WBWA);
-	cfg->arm_v7s_cfg.ttbr[1] = 0;
 	return &data->iop;
 
 out_free_data:
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 920d9faa2a76..5bba30d901b4 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -793,9 +793,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	/* Ensure the empty pgd is visible before any actual TTBR write */
 	wmb();
 
-	/* TTBRs */
-	cfg->arm_lpae_s1_cfg.ttbr[0] = virt_to_phys(data->pgd);
-	cfg->arm_lpae_s1_cfg.ttbr[1] = 0;
+	/* TTBR */
+	cfg->arm_lpae_s1_cfg.ttbr = virt_to_phys(data->pgd);
 	return &data->iop;
 
 out_free_data:
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 2df79093cad9..fd9f0fc4eb60 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -87,7 +87,7 @@ struct io_pgtable_cfg {
 	/* Low-level data specific to the table format */
 	union {
 		struct {
-			u64	ttbr[2];
+			u64	ttbr;
 			u64	tcr;
 			u64	mair[2];
 		} arm_lpae_s1_cfg;
@@ -98,7 +98,7 @@ struct io_pgtable_cfg {
 		} arm_lpae_s2_cfg;
 
 		struct {
-			u32	ttbr[2];
+			u32	ttbr;
 			u32	tcr;
 			u32	nmrr;
 			u32	prrr;
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 40ae6e87cb88..7cdaa0fef85a 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -447,7 +447,7 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 	}
 
 	/* TTBR0 */
-	ttbr = domain->cfg.arm_lpae_s1_cfg.ttbr[0];
+	ttbr = domain->cfg.arm_lpae_s1_cfg.ttbr;
 	ipmmu_ctx_write_root(domain, IMTTLBR0, ttbr);
 	ipmmu_ctx_write_root(domain, IMTTUBR0, ttbr >> 32);
 
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 0d3350463a3f..ef323301c574 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -281,8 +281,8 @@ static void __program_context(void __iomem *base, int ctx,
 	SET_V2PCFG(base, ctx, 0x3);
 
 	SET_TTBCR(base, ctx, priv->cfg.arm_v7s_cfg.tcr);
-	SET_TTBR0(base, ctx, priv->cfg.arm_v7s_cfg.ttbr[0]);
-	SET_TTBR1(base, ctx, priv->cfg.arm_v7s_cfg.ttbr[1]);
+	SET_TTBR0(base, ctx, priv->cfg.arm_v7s_cfg.ttbr);
+	SET_TTBR1(base, ctx, 0);
 
 	/* Set prrr and nmrr */
 	SET_PRRR(base, ctx, priv->cfg.arm_v7s_cfg.prrr);
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index f2832a10fcea..db710d99fc5f 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -344,7 +344,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 	/* Update the pgtable base address register of the M4U HW */
 	if (!data->m4u_dom) {
 		data->m4u_dom = dom;
-		writel(dom->cfg.arm_v7s_cfg.ttbr[0],
+		writel(dom->cfg.arm_v7s_cfg.ttbr,
 		       data->base + REG_MMU_PT_BASE_ADDR);
 	}
 
@@ -725,7 +725,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 	writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
 	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
 	if (data->m4u_dom)
-		writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
+		writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr,
 		       base + REG_MMU_PT_BASE_ADDR);
 	return 0;
 }
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 65b9c99707f8..b0f5fd5b33c0 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -257,10 +257,9 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 
 		/* TTBRs */
 		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
-				pgtbl_cfg.arm_lpae_s1_cfg.ttbr[0] |
+				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
 				((u64)ctx->asid << TTBRn_ASID_SHIFT));
 		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1,
-				pgtbl_cfg.arm_lpae_s1_cfg.ttbr[1] |
 				((u64)ctx->asid << TTBRn_ASID_SHIFT));
 
 		/* TTBCR */
-- 
2.17.0
