From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 10 Jul 2014 14:52:57 +0800
Subject: [PATCH v3 04/13] iommu/arm: avoid arm-smmu-base.c bound to a specific
 smmu
In-Reply-To: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
References: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1404975186-12032-5-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To keep all SMMU drivers can be running at the same time, place hwdep-ops hooks
in structure arm_smmu_device, so each smmu can correctly invoke the appropriate
hooks at running time.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-base.c | 28 +++++++++++++++++----------
 drivers/iommu/arm-smmu.c      | 39 ++++++++++++++++++++++++++++----------
 drivers/iommu/arm-smmu.h      | 44 +++++++++++++++++++++++++++++++------------
 3 files changed, 79 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/arm-smmu-base.c b/drivers/iommu/arm-smmu-base.c
index 2fd29e5..c6824b5 100644
--- a/drivers/iommu/arm-smmu-base.c
+++ b/drivers/iommu/arm-smmu-base.c
@@ -264,7 +264,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	}

 	irq = smmu->irqs[smmu->num_global_irqs + root_cfg->irptndx];
-	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
+	ret = request_irq(irq, smmu->hwdep_ops->context_fault, IRQF_SHARED,
 			  "arm-smmu-context-fault", domain);
 	if (IS_ERR_VALUE(ret)) {
 		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
@@ -274,7 +274,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	}

 	root_cfg->smmu = smmu;
-	arm_smmu_init_context_bank(smmu_domain);
+	smmu->hwdep_ops->init_context_bank(smmu_domain);
 	return ret;

 out_free_context:
@@ -425,7 +425,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (!master)
 		return -ENODEV;

-	return arm_smmu_domain_add_master(smmu_domain, master);
+	return device_smmu->hwdep_ops->domain_add_master(smmu_domain, master);

 err_unlock:
 	spin_unlock_irqrestore(&smmu_domain->lock, flags);
@@ -436,10 +436,11 @@ static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	struct arm_smmu_domain *smmu_domain = domain->priv;
 	struct arm_smmu_master *master;
+	struct arm_smmu_device *smmu = smmu_domain->root_cfg.smmu;

 	master = find_smmu_master(smmu_domain->leaf_smmu, dev->of_node);
 	if (master)
-		arm_smmu_domain_remove_master(smmu_domain, master);
+		smmu->hwdep_ops->domain_remove_master(smmu_domain, master);
 }

 static bool arm_smmu_pte_is_contiguous_range(unsigned long addr,
@@ -694,9 +695,10 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 {
 	int ret;
 	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_device *smmu = smmu_domain->root_cfg.smmu;

 	ret = arm_smmu_handle_mapping(smmu_domain, iova, 0, size, 0);
-	arm_smmu_tlb_inv_context(&smmu_domain->root_cfg);
+	smmu->hwdep_ops->tlb_inv_context(&smmu_domain->root_cfg);
 	return ret ? 0 : size;
 }

@@ -823,7 +825,8 @@ static struct iommu_ops arm_smmu_ops = {
 			   PAGE_SIZE),
 };

-int arm_smmu_device_dt_probe(struct platform_device *pdev)
+int arm_smmu_device_dt_probe(struct platform_device *pdev,
+			     struct smmu_hwdep_ops *ops)
 {
 	struct resource *res;
 	struct arm_smmu_device *smmu;
@@ -901,7 +904,9 @@ int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	if (dev_node)
 		smmu->parent_of_node = dev_node;

-	err = arm_smmu_device_cfg_probe(smmu);
+	smmu->hwdep_ops = ops;
+
+	err = smmu->hwdep_ops->device_cfg_probe(smmu);
 	if (err)
 		goto out_put_parent;

@@ -918,7 +923,7 @@ int arm_smmu_device_dt_probe(struct platform_device *pdev)

 	for (i = 0; i < smmu->num_global_irqs; ++i) {
 		err = request_irq(smmu->irqs[i],
-				  arm_smmu_global_fault,
+				  smmu->hwdep_ops->global_fault,
 				  IRQF_SHARED,
 				  "arm-smmu global fault",
 				  smmu);
@@ -934,7 +939,10 @@ int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	list_add(&smmu->list, &arm_smmu_devices);
 	spin_unlock(&arm_smmu_devices_lock);

-	arm_smmu_device_reset(smmu);
+	err = smmu->hwdep_ops->device_reset(smmu);
+	if (err)
+		goto out_free_irqs;
+
 	return 0;

 out_free_irqs:
@@ -991,7 +999,7 @@ int arm_smmu_device_remove(struct platform_device *pdev)
 		free_irq(smmu->irqs[i], smmu);

 	/* Turn the thing off */
-	return arm_smmu_device_unload(smmu);
+	return smmu->hwdep_ops->device_remove(smmu);
 }

 int __init arm_smmu_ops_init(void)
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c368e82..d08149d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -240,7 +240,7 @@ static void arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
 	}
 }

-void arm_smmu_tlb_inv_context(struct arm_smmu_cfg *cfg)
+static void arm_smmu_tlb_inv_context(struct arm_smmu_cfg *cfg)
 {
 	struct arm_smmu_device *smmu = cfg->smmu;
 	void __iomem *base = ARM_SMMU_GR0(smmu);
@@ -259,7 +259,7 @@ void arm_smmu_tlb_inv_context(struct arm_smmu_cfg *cfg)
 	arm_smmu_tlb_sync(smmu);
 }

-irqreturn_t arm_smmu_context_fault(int irq, void *dev)
+static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 {
 	int flags, ret;
 	u32 fsr, far, fsynr, resume;
@@ -312,7 +312,7 @@ irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	return ret;
 }

-irqreturn_t arm_smmu_global_fault(int irq, void *dev)
+static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 {
 	u32 gfsr, gfsynr0, gfsynr1, gfsynr2;
 	struct arm_smmu_device *smmu = dev;
@@ -336,7 +336,7 @@ irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 	return IRQ_HANDLED;
 }

-void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
+static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 {
 	u32 reg;
 	bool stage1;
@@ -604,7 +604,7 @@ static void arm_smmu_bypass_stream_mapping(struct arm_smmu_device *smmu,
 	}
 }

-int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
+static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 				      struct arm_smmu_master *master)
 {
 	int i, ret;
@@ -642,7 +642,7 @@ int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }

-void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
+static void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
 					  struct arm_smmu_master *master)
 {
 	struct arm_smmu_device *smmu = smmu_domain->root_cfg.smmu;
@@ -655,7 +655,7 @@ void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
 	arm_smmu_master_free_smrs(smmu, master);
 }

-void arm_smmu_device_reset(struct arm_smmu_device *smmu)
+static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 {
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 	void __iomem *cb_base;
@@ -704,6 +704,8 @@ void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	/* Push the button */
 	arm_smmu_tlb_sync(smmu);
 	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+
+	return 0;
 }

 static u32 arm_smmu_id_size_to_bits(u32 size)
@@ -725,7 +727,7 @@ static u32 arm_smmu_id_size_to_bits(u32 size)
 	}
 }

-int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
+static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 {
 	u32 size;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
@@ -869,13 +871,25 @@ int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }

-int arm_smmu_device_unload(struct arm_smmu_device *smmu)
+static int arm_smmu_device_unload(struct arm_smmu_device *smmu)
 {
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);

 	return 0;
 }

+static struct smmu_hwdep_ops arm_smmu_hwdep_ops = {
+	.tlb_inv_context	= arm_smmu_tlb_inv_context,
+	.context_fault		= arm_smmu_context_fault,
+	.global_fault		= arm_smmu_global_fault,
+	.init_context_bank	= arm_smmu_init_context_bank,
+	.domain_add_master	= arm_smmu_domain_add_master,
+	.domain_remove_master	= arm_smmu_domain_remove_master,
+	.device_reset		= arm_smmu_device_reset,
+	.device_cfg_probe	= arm_smmu_device_cfg_probe,
+	.device_remove		= arm_smmu_device_unload,
+};
+
 #ifdef CONFIG_OF
 static struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v1", },
@@ -887,13 +901,18 @@ static struct of_device_id arm_smmu_of_match[] = {
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 #endif

+static int arm_smmu_device_probe(struct platform_device *pdev)
+{
+	return arm_smmu_device_dt_probe(pdev, &arm_smmu_hwdep_ops);
+}
+
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.owner		= THIS_MODULE,
 		.name		= "arm-smmu",
 		.of_match_table	= of_match_ptr(arm_smmu_of_match),
 	},
-	.probe	= arm_smmu_device_dt_probe,
+	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
 };

diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 37d9a46..ca35694 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -142,10 +142,14 @@ struct arm_smmu_master {
 	struct arm_smmu_smr		*smrs;
 };

+struct smmu_hwdep_ops;
+
 struct arm_smmu_device {
 	struct device			*dev;
 	struct device_node		*parent_of_node;

+	struct smmu_hwdep_ops		*hwdep_ops;
+
 	void __iomem			*base;
 	u32				size;
 	u32				pagesize;
@@ -206,25 +210,41 @@ struct arm_smmu_domain {
 	spinlock_t			lock;
 };

+/**
+ * struct smmu_hwdep_ops - smmu hardware dependent ops
+ * @tlb_inv_context: invalid smmu context bank tlb
+ * @context_fault: context fault handler
+ * @global_fault: global fault handler
+ * @init_context_bank: init a context bank
+ * @domain_add_master: add a master into a domain
+ * @domain_remove_master: remove a master from a domain
+ * @device_reset: initialize a smmu
+ * @device_cfg_probe: probe hardware configuration
+ * @device_remove: turn off a smmu and reclaim associated resources
+ */
+struct smmu_hwdep_ops {
+	void (*tlb_inv_context)(struct arm_smmu_cfg *cfg);
+	irqreturn_t (*context_fault)(int irq, void *dev);
+	irqreturn_t (*global_fault)(int irq, void *dev);
+	void (*init_context_bank)(struct arm_smmu_domain *smmu_domain);
+	int (*domain_add_master)(struct arm_smmu_domain *smmu_domain,
+					struct arm_smmu_master *master);
+	void (*domain_remove_master)(struct arm_smmu_domain *smmu_domain,
+					struct arm_smmu_master *master);
+	int (*device_reset)(struct arm_smmu_device *smmu);
+	int (*device_cfg_probe)(struct arm_smmu_device *smmu);
+	int (*device_remove)(struct arm_smmu_device *smmu);
+};
+
 extern int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end);
 extern void __arm_smmu_free_bitmap(unsigned long *map, int idx);
 extern struct arm_smmu_device *find_parent_smmu(struct arm_smmu_device *smmu);
 extern void arm_smmu_flush_pgtable(struct arm_smmu_device *smmu, void *addr,
 				   size_t size);
-extern int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu);
-extern int arm_smmu_device_dt_probe(struct platform_device *pdev);
+extern int arm_smmu_device_dt_probe(struct platform_device *pdev,
+					struct smmu_hwdep_ops *ops);
 extern int arm_smmu_device_remove(struct platform_device *pdev);

-extern void arm_smmu_tlb_inv_context(struct arm_smmu_cfg *cfg);
-extern irqreturn_t arm_smmu_context_fault(int irq, void *dev);
-extern irqreturn_t arm_smmu_global_fault(int irq, void *dev);
-extern void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain);
 extern void arm_smmu_destroy_domain_context(struct iommu_domain *domain);
-extern int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
-				      struct arm_smmu_master *master);
-extern void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
-					struct arm_smmu_master *master);
-extern void arm_smmu_device_reset(struct arm_smmu_device *smmu);
-extern int arm_smmu_device_unload(struct arm_smmu_device *smmu);
 extern int __init arm_smmu_ops_init(void);
 #endif
--
1.8.0
