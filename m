From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 10 Jul 2014 14:52:59 +0800
Subject: [PATCH v3 06/13] iommu/arm: Split arm_smmu_destroy_domain_context to
 reuse code
In-Reply-To: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
References: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1404975186-12032-7-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Free IRQ and context bank is a common operation, should be shared by all SMMUs.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-base.c | 20 ++++++++++++++++++++
 drivers/iommu/arm-smmu.c      | 15 ++-------------
 drivers/iommu/arm-smmu.h      |  3 ++-
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm-smmu-base.c b/drivers/iommu/arm-smmu-base.c
index 0b02da8..4d1c511 100644
--- a/drivers/iommu/arm-smmu-base.c
+++ b/drivers/iommu/arm-smmu-base.c
@@ -282,6 +282,26 @@ out_free_context:
 	return ret;
 }

+static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
+{
+	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
+	struct arm_smmu_device *smmu = root_cfg->smmu;
+	int irq;
+
+	if (!smmu)
+		return;
+
+	smmu->hwdep_ops->destroy_context_bank(smmu_domain);
+
+	if (root_cfg->irptndx != INVALID_IRPTNDX) {
+		irq = smmu->irqs[smmu->num_global_irqs + root_cfg->irptndx];
+		free_irq(irq, domain);
+	}
+
+	__arm_smmu_free_bitmap(smmu->context_map, root_cfg->cbndx);
+}
+
 static int arm_smmu_domain_init(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain;
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index b9538f6..d2fc14c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -498,28 +498,16 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 	writel_relaxed(reg, cb_base + ARM_SMMU_CB_SCTLR);
 }

-void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
+static void arm_smmu_destroy_context_bank(struct arm_smmu_domain *smmu_domain)
 {
-	struct arm_smmu_domain *smmu_domain = domain->priv;
 	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
 	struct arm_smmu_device *smmu = root_cfg->smmu;
 	void __iomem *cb_base;
-	int irq;
-
-	if (!smmu)
-		return;

 	/* Disable the context bank and nuke the TLB before freeing it. */
 	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, root_cfg->cbndx);
 	writel_relaxed(0, cb_base + ARM_SMMU_CB_SCTLR);
 	arm_smmu_tlb_inv_context(root_cfg);
-
-	if (root_cfg->irptndx != INVALID_IRPTNDX) {
-		irq = smmu->irqs[smmu->num_global_irqs + root_cfg->irptndx];
-		free_irq(irq, domain);
-	}
-
-	__arm_smmu_free_bitmap(smmu->context_map, root_cfg->cbndx);
 }

 static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
@@ -885,6 +873,7 @@ static struct smmu_hwdep_ops arm_smmu_hwdep_ops = {
 	.context_fault		= arm_smmu_context_fault,
 	.global_fault		= arm_smmu_global_fault,
 	.init_context_bank	= arm_smmu_init_context_bank,
+	.destroy_context_bank	= arm_smmu_destroy_context_bank,
 	.domain_add_master	= arm_smmu_domain_add_master,
 	.domain_remove_master	= arm_smmu_domain_remove_master,
 	.device_reset		= arm_smmu_device_reset,
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index d66a8c4..190f77c 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -213,6 +213,7 @@ struct arm_smmu_domain {
  * @context_fault: context fault handler
  * @global_fault: global fault handler
  * @init_context_bank: init a context bank
+ * @destroy_context_bank: disable a context bank and invalid the TLBs
  * @domain_add_master: add a master into a domain
  * @domain_remove_master: remove a master from a domain
  * @device_reset: initialize a smmu
@@ -224,6 +225,7 @@ struct smmu_hwdep_ops {
 	irqreturn_t (*context_fault)(int irq, void *dev);
 	irqreturn_t (*global_fault)(int irq, void *dev);
 	void (*init_context_bank)(struct arm_smmu_domain *smmu_domain);
+	void (*destroy_context_bank)(struct arm_smmu_domain *smmu_domain);
 	int (*domain_add_master)(struct arm_smmu_domain *smmu_domain,
 					struct arm_smmu_master *master);
 	void (*domain_remove_master)(struct arm_smmu_domain *smmu_domain,
@@ -242,6 +244,5 @@ extern int arm_smmu_device_dt_probe(struct platform_device *pdev,
 					struct smmu_hwdep_ops *ops);
 extern int arm_smmu_device_remove(struct platform_device *pdev);

-extern void arm_smmu_destroy_domain_context(struct iommu_domain *domain);
 extern int __init arm_smmu_ops_init(void);
 #endif
--
1.8.0
