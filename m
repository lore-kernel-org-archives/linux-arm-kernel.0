From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 21 Aug 2013 11:33:30 +0300
Subject: [patch 1/2] iommu/arm-smmu: fix a signedness bug
Message-ID: <20130821083329.GF5240@elgon.mountain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unsigned char is never equal to -1.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I can't compile this code.

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f417e89e..7243af3 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -377,6 +377,7 @@ struct arm_smmu_cfg {
 	u32				cbar;
 	pgd_t				*pgd;
 };
+#define INVALID_IRPTNDX			0xff
 
 #define ARM_SMMU_CB_ASID(cfg)		((cfg)->cbndx)
 #define ARM_SMMU_CB_VMID(cfg)		((cfg)->cbndx + 1)
@@ -840,7 +841,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (IS_ERR_VALUE(ret)) {
 		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
 			root_cfg->irptndx, irq);
-		root_cfg->irptndx = -1;
+		root_cfg->irptndx = INVALID_IRPTNDX;
 		goto out_free_context;
 	}
 
@@ -869,7 +870,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	writel_relaxed(0, cb_base + ARM_SMMU_CB_SCTLR);
 	arm_smmu_tlb_inv_context(root_cfg);
 
-	if (root_cfg->irptndx != -1) {
+	if (root_cfg->irptndx != INVALID_IRPTNDX) {
 		irq = smmu->irqs[smmu->num_global_irqs + root_cfg->irptndx];
 		free_irq(irq, domain);
 	}
