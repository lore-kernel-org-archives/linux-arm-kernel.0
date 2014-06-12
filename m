From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 12 Jun 2014 13:08:10 +0800
Subject: [PATCH RFC v2 1/3] iommu/arm: Adjust code to facilitate support arm
 smmu variants
In-Reply-To: <1402549692-5224-1-git-send-email-thunder.leizhen@huawei.com>
References: <1402549692-5224-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1402549692-5224-2-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no harmful for original arm-smmu process. A variant can appropriate
rewrite hooks according to the hardware.

1. Pick out hardware dependent functions, replace direct call with hooks
2. Move common struct and marco definition into arm-smmu.h
3. flush_pgtable is a special case, hardware independent but maybe referenced

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu.c | 186 ++++++++++++++++++-----------------------------
 drivers/iommu/arm-smmu.h | 154 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 226 insertions(+), 114 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu.h

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1599354..413a1f2 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -46,15 +46,7 @@
 #include <linux/amba/bus.h>

 #include <asm/pgalloc.h>
-
-/* Maximum number of stream IDs assigned to a single device */
-#define MAX_MASTER_STREAMIDS		MAX_PHANDLE_ARGS
-
-/* Maximum number of context banks per SMMU */
-#define ARM_SMMU_MAX_CBS		128
-
-/* Maximum number of mapping groups per SMMU */
-#define ARM_SMMU_MAX_SMRS		128
+#include "arm-smmu.h"

 /* SMMU global address space */
 #define ARM_SMMU_GR0(smmu)		((smmu)->base)
@@ -323,96 +315,12 @@

 #define FSYNR0_WNR			(1 << 4)

-struct arm_smmu_smr {
-	u8				idx;
-	u16				mask;
-	u16				id;
-};
-
-struct arm_smmu_master {
-	struct device_node		*of_node;
-
-	/*
-	 * The following is specific to the master's position in the
-	 * SMMU chain.
-	 */
-	struct rb_node			node;
-	int				num_streamids;
-	u16				streamids[MAX_MASTER_STREAMIDS];
-
-	/*
-	 * We only need to allocate these on the root SMMU, as we
-	 * configure unmatched streams to bypass translation.
-	 */
-	struct arm_smmu_smr		*smrs;
-};
-
-struct arm_smmu_device {
-	struct device			*dev;
-	struct device_node		*parent_of_node;
-
-	void __iomem			*base;
-	unsigned long			size;
-	unsigned long			pagesize;
-
-#define ARM_SMMU_FEAT_COHERENT_WALK	(1 << 0)
-#define ARM_SMMU_FEAT_STREAM_MATCH	(1 << 1)
-#define ARM_SMMU_FEAT_TRANS_S1		(1 << 2)
-#define ARM_SMMU_FEAT_TRANS_S2		(1 << 3)
-#define ARM_SMMU_FEAT_TRANS_NESTED	(1 << 4)
-	u32				features;
-
-#define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
-	u32				options;
-	int				version;
-
-	u32				num_context_banks;
-	u32				num_s2_context_banks;
-	DECLARE_BITMAP(context_map, ARM_SMMU_MAX_CBS);
-	atomic_t			irptndx;
-
-	u32				num_mapping_groups;
-	DECLARE_BITMAP(smr_map, ARM_SMMU_MAX_SMRS);
-
-	unsigned long			input_size;
-	unsigned long			s1_output_size;
-	unsigned long			s2_output_size;
-
-	u32				num_global_irqs;
-	u32				num_context_irqs;
-	unsigned int			*irqs;
-
-	struct list_head		list;
-	struct rb_root			masters;
-};
-
-struct arm_smmu_cfg {
-	struct arm_smmu_device		*smmu;
-	u8				cbndx;
-	u8				irptndx;
-	u32				cbar;
-	pgd_t				*pgd;
-};
-#define INVALID_IRPTNDX			0xff
-
 #define ARM_SMMU_CB_ASID(cfg)		((cfg)->cbndx)
 #define ARM_SMMU_CB_VMID(cfg)		((cfg)->cbndx + 1)

-struct arm_smmu_domain {
-	/*
-	 * A domain can span across multiple, chained SMMUs and requires
-	 * all devices within the domain to follow the same translation
-	 * path.
-	 */
-	struct arm_smmu_device		*leaf_smmu;
-	struct arm_smmu_cfg		root_cfg;
-	phys_addr_t			output_mask;
-
-	spinlock_t			lock;
-};
-
 static DEFINE_SPINLOCK(arm_smmu_devices_lock);
 static LIST_HEAD(arm_smmu_devices);
+static struct arm_smmu_hwdep_ops smmu_hwdep_ops;

 struct arm_smmu_option_prop {
 	u32 opt;
@@ -555,6 +463,12 @@ static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
 	clear_bit(idx, map);
 }

+static int arm_smmu_alloc_context(struct arm_smmu_device *smmu,
+			int start, int end, struct arm_smmu_master *master)
+{
+	return __arm_smmu_alloc_bitmap(smmu->context_map, start, end);
+}
+
 /* Wait for any pending TLB invalidations to complete */
 static void arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
 {
@@ -590,7 +504,7 @@ static void arm_smmu_tlb_inv_context(struct arm_smmu_cfg *cfg)
 			       base + ARM_SMMU_GR0_TLBIVMID);
 	}

-	arm_smmu_tlb_sync(smmu);
+	smmu_hwdep_ops.tlb_sync(smmu);
 }

 static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
@@ -859,6 +773,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	struct arm_smmu_domain *smmu_domain = domain->priv;
 	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
 	struct arm_smmu_device *smmu, *parent;
+	struct arm_smmu_master *master;

 	/*
 	 * Walk the SMMU chain to find the root device for this chain.
@@ -873,7 +788,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		smmu_domain->output_mask &= (1ULL << smmu->s2_output_size) - 1;
 	} while ((parent = find_parent_smmu(smmu)));

-	if (!find_smmu_master(smmu, dev->of_node)) {
+	master = find_smmu_master(smmu, dev->of_node);
+	if (!master) {
 		dev_err(dev, "unable to find root SMMU for device\n");
 		return -ENODEV;
 	}
@@ -893,8 +809,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		start = smmu->num_s2_context_banks;
 	}

-	ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
-				      smmu->num_context_banks);
+	ret = smmu_hwdep_ops.alloc_context(smmu, start,
+					smmu->num_context_banks, master);
 	if (IS_ERR_VALUE(ret))
 		return ret;

@@ -907,7 +823,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	}

 	irq = smmu->irqs[smmu->num_global_irqs + root_cfg->irptndx];
-	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
+	ret = request_irq(irq, smmu_hwdep_ops.context_fault, IRQF_SHARED,
 			  "arm-smmu-context-fault", domain);
 	if (IS_ERR_VALUE(ret)) {
 		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
@@ -917,7 +833,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	}

 	root_cfg->smmu = smmu;
-	arm_smmu_init_context_bank(smmu_domain);
+	smmu_hwdep_ops.init_context_bank(smmu_domain);
 	return ret;

 out_free_context:
@@ -925,21 +841,29 @@ out_free_context:
 	return ret;
 }

+static void arm_smmu_destroy_context_bank(struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
+	struct arm_smmu_device *smmu = root_cfg->smmu;
+	void __iomem *cb_base;
+
+	/* Disable the context bank and nuke the TLB before freeing it. */
+	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, root_cfg->cbndx);
+	writel_relaxed(0, cb_base + ARM_SMMU_CB_SCTLR);
+	smmu_hwdep_ops.tlb_inv_context(root_cfg);
+}
+
 static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = domain->priv;
 	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
 	struct arm_smmu_device *smmu = root_cfg->smmu;
-	void __iomem *cb_base;
 	int irq;

 	if (!smmu)
 		return;

-	/* Disable the context bank and nuke the TLB before freeing it. */
-	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, root_cfg->cbndx);
-	writel_relaxed(0, cb_base + ARM_SMMU_CB_SCTLR);
-	arm_smmu_tlb_inv_context(root_cfg);
+	smmu_hwdep_ops.destroy_context_bank(smmu_domain);

 	if (root_cfg->irptndx != INVALID_IRPTNDX) {
 		irq = smmu->irqs[smmu->num_global_irqs + root_cfg->irptndx];
@@ -1227,7 +1151,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (!master)
 		return -ENODEV;

-	return arm_smmu_domain_add_master(smmu_domain, master);
+	return smmu_hwdep_ops.domain_add_master(smmu_domain, master);

 err_unlock:
 	spin_unlock_irqrestore(&smmu_domain->lock, flags);
@@ -1241,7 +1165,7 @@ static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)

 	master = find_smmu_master(smmu_domain->leaf_smmu, dev->of_node);
 	if (master)
-		arm_smmu_domain_remove_master(smmu_domain, master);
+		smmu_hwdep_ops.domain_remove_master(smmu_domain, master);
 }

 static bool arm_smmu_pte_is_contiguous_range(unsigned long addr,
@@ -1498,7 +1422,7 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	struct arm_smmu_domain *smmu_domain = domain->priv;

 	ret = arm_smmu_handle_mapping(smmu_domain, iova, 0, size, 0);
-	arm_smmu_tlb_inv_context(&smmu_domain->root_cfg);
+	smmu_hwdep_ops.tlb_inv_context(&smmu_domain->root_cfg);
 	return ret ? 0 : size;
 }

@@ -1625,7 +1549,7 @@ static struct iommu_ops arm_smmu_ops = {
 			   PAGE_SIZE),
 };

-static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
+static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 {
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 	void __iomem *cb_base;
@@ -1672,8 +1596,10 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	reg &= ~(sCR0_BSU_MASK << sCR0_BSU_SHIFT);

 	/* Push the button */
-	arm_smmu_tlb_sync(smmu);
+	smmu_hwdep_ops.tlb_sync(smmu);
 	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+
+	return 0;
 }

 static int arm_smmu_id_size_to_bits(int size)
@@ -1839,6 +1765,27 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }

+static struct arm_smmu_hwdep_ops smmu_hwdep_ops = {
+	.alloc_context		= arm_smmu_alloc_context,
+	.flush_pgtable		= arm_smmu_flush_pgtable,
+	.tlb_sync		= arm_smmu_tlb_sync,
+	.tlb_inv_context	= arm_smmu_tlb_inv_context,
+	.context_fault		= arm_smmu_context_fault,
+	.global_fault		= arm_smmu_global_fault,
+	.init_context_bank	= arm_smmu_init_context_bank,
+	.destroy_context_bank	= arm_smmu_destroy_context_bank,
+	.domain_add_master	= arm_smmu_domain_add_master,
+	.domain_remove_master	= arm_smmu_domain_remove_master,
+	.device_reset		= arm_smmu_device_reset,
+	.device_cfg_probe	= arm_smmu_device_cfg_probe,
+	.dt_cfg_probe		= NULL,
+};
+
+void __attribute__((weak))
+arm_smmu_hwdep_ops_override(struct arm_smmu_hwdep_ops *ops)
+{
+}
+
 static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -1916,7 +1863,13 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	if ((dev_node = of_parse_phandle(dev->of_node, "smmu-parent", 0)))
 		smmu->parent_of_node = dev_node;

-	err = arm_smmu_device_cfg_probe(smmu);
+	if (smmu_hwdep_ops.dt_cfg_probe) {
+		err = smmu_hwdep_ops.dt_cfg_probe(smmu, dev);
+		if (err)
+			goto out_put_parent;
+	}
+
+	err = smmu_hwdep_ops.device_cfg_probe(smmu);
 	if (err)
 		goto out_put_parent;

@@ -1933,7 +1886,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)

 	for (i = 0; i < smmu->num_global_irqs; ++i) {
 		err = request_irq(smmu->irqs[i],
-				  arm_smmu_global_fault,
+				  smmu_hwdep_ops.global_fault,
 				  IRQF_SHARED,
 				  "arm-smmu global fault",
 				  smmu);
@@ -1949,7 +1902,10 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	list_add(&smmu->list, &arm_smmu_devices);
 	spin_unlock(&arm_smmu_devices_lock);

-	arm_smmu_device_reset(smmu);
+	err = smmu_hwdep_ops.device_reset(smmu);
+	if (err)
+		goto out_free_irqs;
+
 	return 0;

 out_free_irqs:
@@ -2006,7 +1962,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 		free_irq(smmu->irqs[i], smmu);

 	/* Turn the thing off */
-	writel(sCR0_CLIENTPD,ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 	return 0;
 }

@@ -2035,6 +1991,8 @@ static int __init arm_smmu_init(void)
 {
 	int ret;

+	arm_smmu_hwdep_ops_override(&smmu_hwdep_ops);
+
 	ret = platform_driver_register(&arm_smmu_driver);
 	if (ret)
 		return ret;
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
new file mode 100644
index 0000000..79366ee
--- /dev/null
+++ b/drivers/iommu/arm-smmu.h
@@ -0,0 +1,154 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copyright (C) 2013 ARM Limited
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ * Author: Zhen Lei <thunder.leizhen@huawei.com>
+ *
+ */
+
+#ifndef ARM_SMMU_H
+#define ARM_SMMU_H
+
+#include <linux/iommu.h>
+#include <linux/of.h>
+
+/* Maximum number of stream IDs assigned to a single device */
+#define MAX_MASTER_STREAMIDS		MAX_PHANDLE_ARGS
+
+/* Maximum number of context banks per SMMU */
+#define ARM_SMMU_MAX_CBS		128
+
+/* Maximum number of mapping groups per SMMU */
+#define ARM_SMMU_MAX_SMRS		128
+
+struct arm_smmu_smr {
+	u8				idx;
+	u16				mask;
+	u16				id;
+};
+
+struct arm_smmu_master {
+	struct device_node		*of_node;
+
+	/*
+	 * The following is specific to the master's position in the
+	 * SMMU chain.
+	 */
+	struct rb_node			node;
+	int				num_streamids;
+	u16				streamids[MAX_MASTER_STREAMIDS];
+
+	/*
+	 * We only need to allocate these on the root SMMU, as we
+	 * configure unmatched streams to bypass translation.
+	 */
+	struct arm_smmu_smr		*smrs;
+};
+
+struct arm_smmu_device {
+	struct device			*dev;
+	struct device_node		*parent_of_node;
+
+	void __iomem			*base;
+	unsigned long			size;
+	unsigned long			pagesize;
+
+#define ARM_SMMU_FEAT_COHERENT_WALK	(1 << 0)
+#define ARM_SMMU_FEAT_STREAM_MATCH	(1 << 1)
+#define ARM_SMMU_FEAT_TRANS_S1		(1 << 2)
+#define ARM_SMMU_FEAT_TRANS_S2		(1 << 3)
+#define ARM_SMMU_FEAT_TRANS_NESTED	(1 << 4)
+	u32				features;
+
+#define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
+	u32				options;
+	int				version;
+
+	u32				num_context_banks;
+	u32				num_s2_context_banks;
+	DECLARE_BITMAP(context_map, ARM_SMMU_MAX_CBS);
+	atomic_t			irptndx;
+
+	u32				num_mapping_groups;
+	DECLARE_BITMAP(smr_map, ARM_SMMU_MAX_SMRS);
+
+	unsigned long			input_size;
+	unsigned long			s1_output_size;
+	unsigned long			s2_output_size;
+
+	u32				num_global_irqs;
+	u32				num_context_irqs;
+	unsigned int			*irqs;
+
+	struct list_head		list;
+	struct rb_root			masters;
+};
+
+struct arm_smmu_cfg {
+	struct arm_smmu_device		*smmu;
+	u8				cbndx;
+	u8				irptndx;
+	u32				cbar;
+	pgd_t				*pgd;
+};
+#define INVALID_IRPTNDX			0xff
+
+struct arm_smmu_domain {
+	/*
+	 * A domain can span across multiple, chained SMMUs and requires
+	 * all devices within the domain to follow the same translation
+	 * path.
+	 */
+	struct arm_smmu_device		*leaf_smmu;
+	struct arm_smmu_cfg		root_cfg;
+	phys_addr_t			output_mask;
+
+	spinlock_t			lock;
+};
+
+/**
+ * struct arm_smmu_hwdep_ops - arm smmu hardware dependent ops
+ * @alloc_context: alloc a free context bank
+ * @flush_pgtable: flush page table. reference only, don't override
+ * @tlb_sync: sync smmu tlb operation
+ * @tlb_inv_context: invalid smmu context bank tlb
+ * @context_fault: context fault handler
+ * @global_fault: global fault handler
+ * @init_context_bank: init a context bank
+ * @destroy_context_bank: disable a context bank and invalid the TLBs
+ * @domain_add_master: add a master into a domain
+ * @domain_remove_master: remove a master from a domain
+ * @device_reset: reset a smmu
+ * @device_cfg_probe: probe hardware configuration
+ * @dt_cfg_probe: probe device tree configuration(extends, hardware dependent)
+ */
+struct arm_smmu_hwdep_ops {
+	int (*alloc_context)(struct arm_smmu_device *smmu,
+			int start, int end, struct arm_smmu_master *master);
+	void (*flush_pgtable)(struct arm_smmu_device *smmu, void *addr,
+				   size_t size);
+	void (*tlb_sync)(struct arm_smmu_device *smmu);
+	void (*tlb_inv_context)(struct arm_smmu_cfg *cfg);
+	irqreturn_t (*context_fault)(int irq, void *dev);
+	irqreturn_t (*global_fault)(int irq, void *dev);
+	void (*init_context_bank)(struct arm_smmu_domain *smmu_domain);
+	void (*destroy_context_bank)(struct arm_smmu_domain *smmu_domain);
+	int (*domain_add_master)(struct arm_smmu_domain *smmu_domain,
+					struct arm_smmu_master *master);
+	void (*domain_remove_master)(struct arm_smmu_domain *smmu_domain,
+					struct arm_smmu_master *master);
+	int (*device_reset)(struct arm_smmu_device *smmu);
+	int (*device_cfg_probe)(struct arm_smmu_device *smmu);
+	int (*dt_cfg_probe)(struct arm_smmu_device *smmu, struct device *dev);
+};
+
+#endif
--
1.8.0
