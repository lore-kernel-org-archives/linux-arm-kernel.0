From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 10 Jul 2014 14:52:56 +0800
Subject: [PATCH v3 03/13] iommu/arm: split arm-smmu.c into three files
In-Reply-To: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
References: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1404975186-12032-4-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To support other SMMUs(contains SMMUv3) which using incompatible registers
definition relate to SMMUv1-2, but choose ARMv8 Translation System. In order to
reuse current arm-smmu(SMMUv1-2) code as much as possible, apart arm-smmu.c.
Both arm-smmu-base.c and arm-smmu.h are shared by all SMMUs.

This is a intermediate patch, just simpe apart arm-smmu.c, to make subsequent
changes clear.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/Kconfig         |    4 +
 drivers/iommu/Makefile        |    1 +
 drivers/iommu/arm-smmu-base.c | 1009 +++++++++++++++++++++++++++++++++++
 drivers/iommu/arm-smmu.c      | 1164 +----------------------------------------
 drivers/iommu/arm-smmu.h      |  230 ++++++++
 5 files changed, 1257 insertions(+), 1151 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-base.c
 create mode 100644 drivers/iommu/arm-smmu.h

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d260605..fad5e38 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -292,10 +292,14 @@ config SPAPR_TCE_IOMMU
 	  Enables bits of IOMMU API required by VFIO. The iommu_ops
 	  is not implemented as it is not necessary for VFIO.

+config ARM_SMMU_BASE
+	bool
+
 config ARM_SMMU
 	bool "ARM Ltd. System MMU (SMMU) Support"
 	depends on ARM64 || (ARM_LPAE && OF)
 	select IOMMU_API
+	select ARM_SMMU_BASE
 	select ARM_DMA_USE_IOMMU if ARM
 	help
 	  Support for implementations of the ARM System MMU architecture
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 8893bad..717cfa3 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o msm_iommu_dev.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
+obj-$(CONFIG_ARM_SMMU_BASE) += arm-smmu-base.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += iova.o intel-iommu.o
diff --git a/drivers/iommu/arm-smmu-base.c b/drivers/iommu/arm-smmu-base.c
new file mode 100644
index 0000000..2fd29e5
--- /dev/null
+++ b/drivers/iommu/arm-smmu-base.c
@@ -0,0 +1,1009 @@
+/*
+ * IOMMU API for ARM architected SMMU implementations.
+ *
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
+ *
+ * This driver currently supports:
+ *	- SMMUv1 and v2 implementations
+ *	- Stream-matching and stream-indexing
+ *	- v7/v8 long-descriptor format
+ *	- Non-secure access to the SMMU
+ *	- 4k and 64k pages, with contiguous pte hints.
+ *	- Up to 42-bit addressing (dependent on VA_BITS)
+ *	- Context fault reporting
+ */
+
+#define pr_fmt(fmt) "arm-smmu: " fmt
+
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iommu.h>
+#include <linux/mm.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include <linux/amba/bus.h>
+
+#include <asm/pgalloc.h>
+#include "arm-smmu.h"
+
+static DEFINE_SPINLOCK(arm_smmu_devices_lock);
+static LIST_HEAD(arm_smmu_devices);
+
+struct arm_smmu_option_prop {
+	u32 opt;
+	const char *prop;
+};
+
+static struct arm_smmu_option_prop arm_smmu_options[] = {
+	{ ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
+	{ 0, NULL},
+};
+
+static void parse_driver_options(struct arm_smmu_device *smmu)
+{
+	int i = 0;
+	do {
+		if (of_property_read_bool(smmu->dev->of_node,
+						arm_smmu_options[i].prop)) {
+			smmu->options |= arm_smmu_options[i].opt;
+			dev_notice(smmu->dev, "option %s\n",
+				arm_smmu_options[i].prop);
+		}
+	} while (arm_smmu_options[++i].opt);
+}
+
+static struct arm_smmu_master *find_smmu_master(struct arm_smmu_device *smmu,
+						struct device_node *dev_node)
+{
+	struct rb_node *node = smmu->masters.rb_node;
+
+	while (node) {
+		struct arm_smmu_master *master;
+		master = container_of(node, struct arm_smmu_master, node);
+
+		if (dev_node < master->of_node)
+			node = node->rb_left;
+		else if (dev_node > master->of_node)
+			node = node->rb_right;
+		else
+			return master;
+	}
+
+	return NULL;
+}
+
+static int insert_smmu_master(struct arm_smmu_device *smmu,
+			      struct arm_smmu_master *master)
+{
+	struct rb_node **new, *parent;
+
+	new = &smmu->masters.rb_node;
+	parent = NULL;
+	while (*new) {
+		struct arm_smmu_master *this;
+		this = container_of(*new, struct arm_smmu_master, node);
+
+		parent = *new;
+		if (master->of_node < this->of_node)
+			new = &((*new)->rb_left);
+		else if (master->of_node > this->of_node)
+			new = &((*new)->rb_right);
+		else
+			return -EEXIST;
+	}
+
+	rb_link_node(&master->node, parent, new);
+	rb_insert_color(&master->node, &smmu->masters);
+	return 0;
+}
+
+static int register_smmu_master(struct arm_smmu_device *smmu,
+				struct device *dev,
+				struct of_phandle_args *masterspec)
+{
+	int i;
+	struct arm_smmu_master *master;
+
+	master = find_smmu_master(smmu, masterspec->np);
+	if (master) {
+		dev_err(dev,
+			"rejecting multiple registrations for master device %s\n",
+			masterspec->np->name);
+		return -EBUSY;
+	}
+
+	if (masterspec->args_count > MAX_MASTER_STREAMIDS) {
+		dev_err(dev,
+			"reached maximum number (%d) of stream IDs for master device %s\n",
+			MAX_MASTER_STREAMIDS, masterspec->np->name);
+		return -ENOSPC;
+	}
+
+	master = devm_kzalloc(dev, sizeof(*master), GFP_KERNEL);
+	if (!master)
+		return -ENOMEM;
+
+	master->of_node		= masterspec->np;
+	master->num_streamids	= masterspec->args_count;
+
+	for (i = 0; i < master->num_streamids; ++i)
+		master->streamids[i] = masterspec->args[i];
+
+	return insert_smmu_master(smmu, master);
+}
+
+struct arm_smmu_device *find_parent_smmu(struct arm_smmu_device *smmu)
+{
+	struct arm_smmu_device *parent;
+
+	if (!smmu->parent_of_node)
+		return NULL;
+
+	spin_lock(&arm_smmu_devices_lock);
+	list_for_each_entry(parent, &arm_smmu_devices, list)
+		if (parent->dev->of_node == smmu->parent_of_node)
+			goto out_unlock;
+
+	parent = NULL;
+	dev_warn(smmu->dev,
+		 "Failed to find SMMU parent despite parent in DT\n");
+out_unlock:
+	spin_unlock(&arm_smmu_devices_lock);
+	return parent;
+}
+
+int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
+{
+	int idx;
+
+	do {
+		idx = find_next_zero_bit(map, end, start);
+		if (idx == end)
+			return -ENOSPC;
+	} while (test_and_set_bit(idx, map));
+
+	return idx;
+}
+
+void __arm_smmu_free_bitmap(unsigned long *map, int idx)
+{
+	clear_bit(idx, map);
+}
+
+void arm_smmu_flush_pgtable(struct arm_smmu_device *smmu, void *addr,
+				   size_t size)
+{
+	unsigned long offset = (unsigned long)addr & ~PAGE_MASK;
+
+
+	/* Ensure new page tables are visible to the hardware walker */
+	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK) {
+		dsb(ishst);
+	} else {
+		/*
+		 * If the SMMU can't walk tables in the CPU caches, treat them
+		 * like non-coherent DMA since we need to flush the new entries
+		 * all the way out to memory. There's no possibility of
+		 * recursion here as the SMMU table walker will not be wired
+		 * through another SMMU.
+		 */
+		dma_map_page(smmu->dev, virt_to_page(addr), offset, size,
+				DMA_TO_DEVICE);
+	}
+}
+
+static int arm_smmu_init_domain_context(struct iommu_domain *domain,
+					struct device *dev)
+{
+	int irq, ret, start;
+	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
+	struct arm_smmu_device *smmu, *parent;
+
+	/*
+	 * Walk the SMMU chain to find the root device for this chain.
+	 * We assume that no masters have translations which terminate
+	 * early, and therefore check that the root SMMU does indeed have
+	 * a StreamID for the master in question.
+	 */
+	parent = dev->archdata.iommu;
+	smmu_domain->output_mask = -1;
+	do {
+		smmu = parent;
+		smmu_domain->output_mask &= (1ULL << smmu->s2_output_size) - 1;
+	} while ((parent = find_parent_smmu(smmu)));
+
+	if (!find_smmu_master(smmu, dev->of_node)) {
+		dev_err(dev, "unable to find root SMMU for device\n");
+		return -ENODEV;
+	}
+
+	if (smmu->features & ARM_SMMU_FEAT_TRANS_NESTED) {
+		/*
+		 * We will likely want to change this if/when KVM gets
+		 * involved.
+		 */
+		root_cfg->cbar = CBAR_TYPE_S1_TRANS_S2_BYPASS;
+		start = smmu->num_s2_context_banks;
+	} else if (smmu->features & ARM_SMMU_FEAT_TRANS_S2) {
+		root_cfg->cbar = CBAR_TYPE_S2_TRANS;
+		start = 0;
+	} else {
+		root_cfg->cbar = CBAR_TYPE_S1_TRANS_S2_BYPASS;
+		start = smmu->num_s2_context_banks;
+	}
+
+	ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
+				      smmu->num_context_banks);
+	if (IS_ERR_VALUE(ret))
+		return ret;
+
+	root_cfg->cbndx = ret;
+	if (smmu->version == 1) {
+		root_cfg->irptndx = atomic_inc_return(&smmu->irptndx);
+		root_cfg->irptndx %= smmu->num_context_irqs;
+	} else {
+		root_cfg->irptndx = root_cfg->cbndx;
+	}
+
+	irq = smmu->irqs[smmu->num_global_irqs + root_cfg->irptndx];
+	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
+			  "arm-smmu-context-fault", domain);
+	if (IS_ERR_VALUE(ret)) {
+		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
+			root_cfg->irptndx, irq);
+		root_cfg->irptndx = INVALID_IRPTNDX;
+		goto out_free_context;
+	}
+
+	root_cfg->smmu = smmu;
+	arm_smmu_init_context_bank(smmu_domain);
+	return ret;
+
+out_free_context:
+	__arm_smmu_free_bitmap(smmu->context_map, root_cfg->cbndx);
+	return ret;
+}
+
+static int arm_smmu_domain_init(struct iommu_domain *domain)
+{
+	struct arm_smmu_domain *smmu_domain;
+	pgd_t *pgd;
+
+	/*
+	 * Allocate the domain and initialise some of its data structures.
+	 * We can't really do anything meaningful until we've added a
+	 * master.
+	 */
+	smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
+	if (!smmu_domain)
+		return -ENOMEM;
+
+	pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
+	if (!pgd)
+		goto out_free_domain;
+	smmu_domain->root_cfg.pgd = pgd;
+
+	spin_lock_init(&smmu_domain->lock);
+	domain->priv = smmu_domain;
+	return 0;
+
+out_free_domain:
+	kfree(smmu_domain);
+	return -ENOMEM;
+}
+
+static void arm_smmu_free_ptes(pmd_t *pmd)
+{
+	pgtable_t table = pmd_pgtable(*pmd);
+	pgtable_page_dtor(table);
+	__free_page(table);
+}
+
+static void arm_smmu_free_pmds(pud_t *pud)
+{
+	int i;
+	pmd_t *pmd, *pmd_base = pmd_offset(pud, 0);
+
+	pmd = pmd_base;
+	for (i = 0; i < PTRS_PER_PMD; ++i) {
+		if (pmd_none(*pmd))
+			continue;
+
+		arm_smmu_free_ptes(pmd);
+		pmd++;
+	}
+
+	pmd_free(NULL, pmd_base);
+}
+
+static void arm_smmu_free_puds(pgd_t *pgd)
+{
+	int i;
+	pud_t *pud, *pud_base = pud_offset(pgd, 0);
+
+	pud = pud_base;
+	for (i = 0; i < PTRS_PER_PUD; ++i) {
+		if (pud_none(*pud))
+			continue;
+
+		arm_smmu_free_pmds(pud);
+		pud++;
+	}
+
+	pud_free(NULL, pud_base);
+}
+
+static void arm_smmu_free_pgtables(struct arm_smmu_domain *smmu_domain)
+{
+	int i;
+	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
+	pgd_t *pgd, *pgd_base = root_cfg->pgd;
+
+	/*
+	 * Recursively free the page tables for this domain. We don't
+	 * care about speculative TLB filling because the tables should
+	 * not be active in any context bank at this point (SCTLR.M is 0).
+	 */
+	pgd = pgd_base;
+	for (i = 0; i < PTRS_PER_PGD; ++i) {
+		if (pgd_none(*pgd))
+			continue;
+		arm_smmu_free_puds(pgd);
+		pgd++;
+	}
+
+	kfree(pgd_base);
+}
+
+static void arm_smmu_domain_destroy(struct iommu_domain *domain)
+{
+	struct arm_smmu_domain *smmu_domain = domain->priv;
+
+	/*
+	 * Free the domain resources. We assume that all devices have
+	 * already been detached.
+	 */
+	arm_smmu_destroy_domain_context(domain);
+	arm_smmu_free_pgtables(smmu_domain);
+	kfree(smmu_domain);
+}
+
+static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
+{
+	int ret = -EINVAL;
+	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_device *device_smmu = dev->archdata.iommu;
+	struct arm_smmu_master *master;
+	unsigned long flags;
+
+	if (!device_smmu) {
+		dev_err(dev, "cannot attach to SMMU, is it on the same bus?\n");
+		return -ENXIO;
+	}
+
+	/*
+	 * Sanity check the domain. We don't currently support domains
+	 * that cross between different SMMU chains.
+	 */
+	spin_lock_irqsave(&smmu_domain->lock, flags);
+	if (!smmu_domain->leaf_smmu) {
+		/* Now that we have a master, we can finalise the domain */
+		ret = arm_smmu_init_domain_context(domain, dev);
+		if (IS_ERR_VALUE(ret))
+			goto err_unlock;
+
+		smmu_domain->leaf_smmu = device_smmu;
+	} else if (smmu_domain->leaf_smmu != device_smmu) {
+		dev_err(dev,
+			"cannot attach to SMMU %s whilst already attached to domain on SMMU %s\n",
+			dev_name(smmu_domain->leaf_smmu->dev),
+			dev_name(device_smmu->dev));
+		goto err_unlock;
+	}
+	spin_unlock_irqrestore(&smmu_domain->lock, flags);
+
+	/* Looks ok, so add the device to the domain */
+	master = find_smmu_master(smmu_domain->leaf_smmu, dev->of_node);
+	if (!master)
+		return -ENODEV;
+
+	return arm_smmu_domain_add_master(smmu_domain, master);
+
+err_unlock:
+	spin_unlock_irqrestore(&smmu_domain->lock, flags);
+	return ret;
+}
+
+static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
+{
+	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_master *master;
+
+	master = find_smmu_master(smmu_domain->leaf_smmu, dev->of_node);
+	if (master)
+		arm_smmu_domain_remove_master(smmu_domain, master);
+}
+
+static bool arm_smmu_pte_is_contiguous_range(unsigned long addr,
+					     unsigned long end)
+{
+	return !(addr & ~ARM_SMMU_PTE_CONT_MASK) &&
+		(addr + ARM_SMMU_PTE_CONT_SIZE <= end);
+}
+
+static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
+				   unsigned long addr, unsigned long end,
+				   unsigned long pfn, int prot, int stage)
+{
+	pte_t *pte, *start;
+	pteval_t pteval = ARM_SMMU_PTE_PAGE | ARM_SMMU_PTE_AF | ARM_SMMU_PTE_XN;
+
+	if (pmd_none(*pmd)) {
+		/* Allocate a new set of tables */
+		pgtable_t table = alloc_page(GFP_ATOMIC|__GFP_ZERO);
+		if (!table)
+			return -ENOMEM;
+
+		arm_smmu_flush_pgtable(smmu, page_address(table), PAGE_SIZE);
+		if (!pgtable_page_ctor(table)) {
+			__free_page(table);
+			return -ENOMEM;
+		}
+		pmd_populate(NULL, pmd, table);
+		arm_smmu_flush_pgtable(smmu, pmd, sizeof(*pmd));
+	}
+
+	if (stage == 1) {
+		pteval |= ARM_SMMU_PTE_AP_UNPRIV | ARM_SMMU_PTE_nG;
+		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
+			pteval |= ARM_SMMU_PTE_AP_RDONLY;
+
+		if (prot & IOMMU_CACHE)
+			pteval |= (MAIR_ATTR_IDX_CACHE <<
+				   ARM_SMMU_PTE_ATTRINDX_SHIFT);
+	} else {
+		pteval |= ARM_SMMU_PTE_HAP_FAULT;
+		if (prot & IOMMU_READ)
+			pteval |= ARM_SMMU_PTE_HAP_READ;
+		if (prot & IOMMU_WRITE)
+			pteval |= ARM_SMMU_PTE_HAP_WRITE;
+		if (prot & IOMMU_CACHE)
+			pteval |= ARM_SMMU_PTE_MEMATTR_OIWB;
+		else
+			pteval |= ARM_SMMU_PTE_MEMATTR_NC;
+	}
+
+	/* If no access, create a faulting entry to avoid TLB fills */
+	if (prot & IOMMU_EXEC)
+		pteval &= ~ARM_SMMU_PTE_XN;
+	else if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
+		pteval &= ~ARM_SMMU_PTE_PAGE;
+
+	pteval |= ARM_SMMU_PTE_SH_IS;
+	start = pmd_page_vaddr(*pmd) + pte_index(addr);
+	pte = start;
+
+	/*
+	 * Install the page table entries. This is fairly complicated
+	 * since we attempt to make use of the contiguous hint in the
+	 * ptes where possible. The contiguous hint indicates a series
+	 * of ARM_SMMU_PTE_CONT_ENTRIES ptes mapping a physically
+	 * contiguous region with the following constraints:
+	 *
+	 *   - The region start is aligned to ARM_SMMU_PTE_CONT_SIZE
+	 *   - Each pte in the region has the contiguous hint bit set
+	 *
+	 * This complicates unmapping (also handled by this code, when
+	 * neither IOMMU_READ or IOMMU_WRITE are set) because it is
+	 * possible, yet highly unlikely, that a client may unmap only
+	 * part of a contiguous range. This requires clearing of the
+	 * contiguous hint bits in the range before installing the new
+	 * faulting entries.
+	 *
+	 * Note that re-mapping an address range without first unmapping
+	 * it is not supported, so TLB invalidation is not required here
+	 * and is instead performed@unmap and domain-init time.
+	 */
+	do {
+		int i = 1;
+		pteval &= ~ARM_SMMU_PTE_CONT;
+
+		if (arm_smmu_pte_is_contiguous_range(addr, end)) {
+			i = ARM_SMMU_PTE_CONT_ENTRIES;
+			pteval |= ARM_SMMU_PTE_CONT;
+		} else if (pte_val(*pte) &
+			   (ARM_SMMU_PTE_CONT | ARM_SMMU_PTE_PAGE)) {
+			int j;
+			pte_t *cont_start;
+			unsigned long idx = pte_index(addr);
+
+			idx &= ~(ARM_SMMU_PTE_CONT_ENTRIES - 1);
+			cont_start = pmd_page_vaddr(*pmd) + idx;
+			for (j = 0; j < ARM_SMMU_PTE_CONT_ENTRIES; ++j)
+				pte_val(*(cont_start + j)) &= ~ARM_SMMU_PTE_CONT;
+
+			arm_smmu_flush_pgtable(smmu, cont_start,
+					       sizeof(*pte) *
+					       ARM_SMMU_PTE_CONT_ENTRIES);
+		}
+
+		do {
+			*pte = pfn_pte(pfn, __pgprot(pteval));
+		} while (pte++, pfn++, addr += PAGE_SIZE, --i);
+	} while (addr != end);
+
+	arm_smmu_flush_pgtable(smmu, start, sizeof(*pte) * (pte - start));
+	return 0;
+}
+
+static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
+				   unsigned long addr, unsigned long end,
+				   phys_addr_t phys, int prot, int stage)
+{
+	int ret;
+	pmd_t *pmd;
+	unsigned long next, pfn = __phys_to_pfn(phys);
+
+#ifndef __PAGETABLE_PMD_FOLDED
+	if (pud_none(*pud)) {
+		pmd = (pmd_t *)get_zeroed_page(GFP_ATOMIC);
+		if (!pmd)
+			return -ENOMEM;
+
+		arm_smmu_flush_pgtable(smmu, pmd, PAGE_SIZE);
+		pud_populate(NULL, pud, pmd);
+		arm_smmu_flush_pgtable(smmu, pud, sizeof(*pud));
+
+		pmd += pmd_index(addr);
+	} else
+#endif
+		pmd = pmd_offset(pud, addr);
+
+	do {
+		next = pmd_addr_end(addr, end);
+		ret = arm_smmu_alloc_init_pte(smmu, pmd, addr, next, pfn,
+					      prot, stage);
+		phys += next - addr;
+	} while (pmd++, addr = next, addr < end);
+
+	return ret;
+}
+
+static int arm_smmu_alloc_init_pud(struct arm_smmu_device *smmu, pgd_t *pgd,
+				   unsigned long addr, unsigned long end,
+				   phys_addr_t phys, int prot, int stage)
+{
+	int ret = 0;
+	pud_t *pud;
+	unsigned long next;
+
+#ifndef __PAGETABLE_PUD_FOLDED
+	if (pgd_none(*pgd)) {
+		pud = (pud_t *)get_zeroed_page(GFP_ATOMIC);
+		if (!pud)
+			return -ENOMEM;
+
+		arm_smmu_flush_pgtable(smmu, pud, PAGE_SIZE);
+		pgd_populate(NULL, pgd, pud);
+		arm_smmu_flush_pgtable(smmu, pgd, sizeof(*pgd));
+
+		pud += pud_index(addr);
+	} else
+#endif
+		pud = pud_offset(pgd, addr);
+
+	do {
+		next = pud_addr_end(addr, end);
+		ret = arm_smmu_alloc_init_pmd(smmu, pud, addr, next, phys,
+					      prot, stage);
+		phys += next - addr;
+	} while (pud++, addr = next, addr < end);
+
+	return ret;
+}
+
+static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
+				   unsigned long iova, phys_addr_t paddr,
+				   size_t size, int prot)
+{
+	int ret, stage;
+	unsigned long end;
+	phys_addr_t input_mask, output_mask;
+	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
+	pgd_t *pgd = root_cfg->pgd;
+	struct arm_smmu_device *smmu = root_cfg->smmu;
+	unsigned long flags;
+
+	if (root_cfg->cbar == CBAR_TYPE_S2_TRANS) {
+		stage = 2;
+		output_mask = (1ULL << smmu->s2_output_size) - 1;
+	} else {
+		stage = 1;
+		output_mask = (1ULL << smmu->s1_output_size) - 1;
+	}
+
+	if (!pgd)
+		return -EINVAL;
+
+	if (size & ~PAGE_MASK)
+		return -EINVAL;
+
+	input_mask = (1ULL << smmu->input_size) - 1;
+	if ((phys_addr_t)iova & ~input_mask)
+		return -ERANGE;
+
+	if (paddr & ~output_mask)
+		return -ERANGE;
+
+	spin_lock_irqsave(&smmu_domain->lock, flags);
+	pgd += pgd_index(iova);
+	end = iova + size;
+	do {
+		unsigned long next = pgd_addr_end(iova, end);
+
+		ret = arm_smmu_alloc_init_pud(smmu, pgd, iova, next, paddr,
+					      prot, stage);
+		if (ret)
+			goto out_unlock;
+
+		paddr += next - iova;
+		iova = next;
+	} while (pgd++, iova != end);
+
+out_unlock:
+	spin_unlock_irqrestore(&smmu_domain->lock, flags);
+
+	return ret;
+}
+
+static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
+			phys_addr_t paddr, size_t size, int prot)
+{
+	struct arm_smmu_domain *smmu_domain = domain->priv;
+
+	if (!smmu_domain)
+		return -ENODEV;
+
+	/* Check for silent address truncation up the SMMU chain. */
+	if ((phys_addr_t)iova & ~smmu_domain->output_mask)
+		return -ERANGE;
+
+	return arm_smmu_handle_mapping(smmu_domain, iova, paddr, size, prot);
+}
+
+static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
+			     size_t size)
+{
+	int ret;
+	struct arm_smmu_domain *smmu_domain = domain->priv;
+
+	ret = arm_smmu_handle_mapping(smmu_domain, iova, 0, size, 0);
+	arm_smmu_tlb_inv_context(&smmu_domain->root_cfg);
+	return ret ? 0 : size;
+}
+
+static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
+					 dma_addr_t iova)
+{
+	pgd_t *pgdp, pgd;
+	pud_t pud;
+	pmd_t pmd;
+	pte_t pte;
+	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
+
+	pgdp = root_cfg->pgd;
+	if (!pgdp)
+		return 0;
+
+	pgd = *(pgdp + pgd_index(iova));
+	if (pgd_none(pgd))
+		return 0;
+
+	pud = *pud_offset(&pgd, iova);
+	if (pud_none(pud))
+		return 0;
+
+	pmd = *pmd_offset(&pud, iova);
+	if (pmd_none(pmd))
+		return 0;
+
+	pte = *(pmd_page_vaddr(pmd) + pte_index(iova));
+	if (pte_none(pte))
+		return 0;
+
+	return __pfn_to_phys(pte_pfn(pte)) | (iova & ~PAGE_MASK);
+}
+
+static int arm_smmu_domain_has_cap(struct iommu_domain *domain,
+				   unsigned long cap)
+{
+	unsigned long caps = 0;
+	struct arm_smmu_domain *smmu_domain = domain->priv;
+
+	if (smmu_domain->root_cfg.smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
+		caps |= IOMMU_CAP_CACHE_COHERENCY;
+
+	return !!(cap & caps);
+}
+
+static int arm_smmu_add_device(struct device *dev)
+{
+	struct arm_smmu_device *child, *parent, *smmu;
+	struct arm_smmu_master *master = NULL;
+	struct iommu_group *group;
+	int ret;
+
+	if (dev->archdata.iommu) {
+		dev_warn(dev, "IOMMU driver already assigned to device\n");
+		return -EINVAL;
+	}
+
+	spin_lock(&arm_smmu_devices_lock);
+	list_for_each_entry(parent, &arm_smmu_devices, list) {
+		smmu = parent;
+
+		/* Try to find a child of the current SMMU. */
+		list_for_each_entry(child, &arm_smmu_devices, list) {
+			if (child->parent_of_node == parent->dev->of_node) {
+				/* Does the child sit above our master? */
+				master = find_smmu_master(child, dev->of_node);
+				if (master) {
+					smmu = NULL;
+					break;
+				}
+			}
+		}
+
+		/* We found some children, so keep searching. */
+		if (!smmu) {
+			master = NULL;
+			continue;
+		}
+
+		master = find_smmu_master(smmu, dev->of_node);
+		if (master)
+			break;
+	}
+	spin_unlock(&arm_smmu_devices_lock);
+
+	if (!master)
+		return -ENODEV;
+
+	group = iommu_group_alloc();
+	if (IS_ERR(group)) {
+		dev_err(dev, "Failed to allocate IOMMU group\n");
+		return PTR_ERR(group);
+	}
+
+	ret = iommu_group_add_device(group, dev);
+	iommu_group_put(group);
+	dev->archdata.iommu = smmu;
+
+	return ret;
+}
+
+static void arm_smmu_remove_device(struct device *dev)
+{
+	dev->archdata.iommu = NULL;
+	iommu_group_remove_device(dev);
+}
+
+static struct iommu_ops arm_smmu_ops = {
+	.domain_init	= arm_smmu_domain_init,
+	.domain_destroy	= arm_smmu_domain_destroy,
+	.attach_dev	= arm_smmu_attach_dev,
+	.detach_dev	= arm_smmu_detach_dev,
+	.map		= arm_smmu_map,
+	.unmap		= arm_smmu_unmap,
+	.iova_to_phys	= arm_smmu_iova_to_phys,
+	.domain_has_cap	= arm_smmu_domain_has_cap,
+	.add_device	= arm_smmu_add_device,
+	.remove_device	= arm_smmu_remove_device,
+	.pgsize_bitmap	= (SECTION_SIZE |
+			   ARM_SMMU_PTE_CONT_SIZE |
+			   PAGE_SIZE),
+};
+
+int arm_smmu_device_dt_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct arm_smmu_device *smmu;
+	struct device_node *dev_node;
+	struct device *dev = &pdev->dev;
+	struct rb_node *node;
+	struct of_phandle_args masterspec;
+	int num_irqs, i, err;
+
+	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
+	if (!smmu) {
+		dev_err(dev, "failed to allocate arm_smmu_device\n");
+		return -ENOMEM;
+	}
+	smmu->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	smmu->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(smmu->base))
+		return PTR_ERR(smmu->base);
+	smmu->size = resource_size(res);
+
+	if (of_property_read_u32(dev->of_node, "#global-interrupts",
+				 &smmu->num_global_irqs)) {
+		dev_err(dev, "missing #global-interrupts property\n");
+		return -ENODEV;
+	}
+
+	num_irqs = 0;
+	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
+		num_irqs++;
+		if (num_irqs > smmu->num_global_irqs)
+			smmu->num_context_irqs++;
+	}
+
+	if (!smmu->num_context_irqs) {
+		dev_err(dev, "found %d interrupts but expected at least %d\n",
+			num_irqs, smmu->num_global_irqs + 1);
+		return -ENODEV;
+	}
+
+	smmu->irqs = devm_kzalloc(dev, sizeof(*smmu->irqs) * num_irqs,
+				  GFP_KERNEL);
+	if (!smmu->irqs) {
+		dev_err(dev, "failed to allocate %d irqs\n", num_irqs);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_irqs; ++i) {
+		int irq = platform_get_irq(pdev, i);
+		if (irq < 0) {
+			dev_err(dev, "failed to get irq index %d\n", i);
+			return -ENODEV;
+		}
+		smmu->irqs[i] = irq;
+	}
+
+	i = 0;
+	smmu->masters = RB_ROOT;
+	while (!of_parse_phandle_with_args(dev->of_node, "mmu-masters",
+					   "#stream-id-cells", i,
+					   &masterspec)) {
+		err = register_smmu_master(smmu, dev, &masterspec);
+		if (err) {
+			dev_err(dev, "failed to add master %s\n",
+				masterspec.np->name);
+			goto out_put_masters;
+		}
+
+		i++;
+	}
+	dev_notice(dev, "registered %d master devices\n", i);
+
+	dev_node = of_parse_phandle(dev->of_node, "smmu-parent", 0);
+	if (dev_node)
+		smmu->parent_of_node = dev_node;
+
+	err = arm_smmu_device_cfg_probe(smmu);
+	if (err)
+		goto out_put_parent;
+
+	parse_driver_options(smmu);
+
+	if (smmu->version > 1 &&
+	    smmu->num_context_banks != smmu->num_context_irqs) {
+		dev_err(dev,
+			"found only %d context interrupt(s) but %d required\n",
+			smmu->num_context_irqs, smmu->num_context_banks);
+		err = -ENODEV;
+		goto out_put_parent;
+	}
+
+	for (i = 0; i < smmu->num_global_irqs; ++i) {
+		err = request_irq(smmu->irqs[i],
+				  arm_smmu_global_fault,
+				  IRQF_SHARED,
+				  "arm-smmu global fault",
+				  smmu);
+		if (err) {
+			dev_err(dev, "failed to request global IRQ %d (%u)\n",
+				i, smmu->irqs[i]);
+			goto out_free_irqs;
+		}
+	}
+
+	INIT_LIST_HEAD(&smmu->list);
+	spin_lock(&arm_smmu_devices_lock);
+	list_add(&smmu->list, &arm_smmu_devices);
+	spin_unlock(&arm_smmu_devices_lock);
+
+	arm_smmu_device_reset(smmu);
+	return 0;
+
+out_free_irqs:
+	while (i--)
+		free_irq(smmu->irqs[i], smmu);
+
+out_put_parent:
+	if (smmu->parent_of_node)
+		of_node_put(smmu->parent_of_node);
+
+out_put_masters:
+	for (node = rb_first(&smmu->masters); node; node = rb_next(node)) {
+		struct arm_smmu_master *master;
+		master = container_of(node, struct arm_smmu_master, node);
+		of_node_put(master->of_node);
+	}
+
+	return err;
+}
+
+int arm_smmu_device_remove(struct platform_device *pdev)
+{
+	int i;
+	struct device *dev = &pdev->dev;
+	struct arm_smmu_device *curr, *smmu = NULL;
+	struct rb_node *node;
+
+	spin_lock(&arm_smmu_devices_lock);
+	list_for_each_entry(curr, &arm_smmu_devices, list) {
+		if (curr->dev == dev) {
+			smmu = curr;
+			list_del(&smmu->list);
+			break;
+		}
+	}
+	spin_unlock(&arm_smmu_devices_lock);
+
+	if (!smmu)
+		return -ENODEV;
+
+	if (smmu->parent_of_node)
+		of_node_put(smmu->parent_of_node);
+
+	for (node = rb_first(&smmu->masters); node; node = rb_next(node)) {
+		struct arm_smmu_master *master;
+		master = container_of(node, struct arm_smmu_master, node);
+		of_node_put(master->of_node);
+	}
+
+	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
+		dev_err(dev, "removing device with active domains!\n");
+
+	for (i = 0; i < smmu->num_global_irqs; ++i)
+		free_irq(smmu->irqs[i], smmu);
+
+	/* Turn the thing off */
+	return arm_smmu_device_unload(smmu);
+}
+
+int __init arm_smmu_ops_init(void)
+{
+	/* Oh, for a proper bus abstraction */
+	if (!iommu_present(&platform_bus_type))
+		bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
+
+#ifdef CONFIG_ARM_AMBA
+	if (!iommu_present(&amba_bustype))
+		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
+#endif
+
+	return 0;
+}
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index dfc53e7..c368e82 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -27,30 +27,16 @@
 #define pr_fmt(fmt) "arm-smmu: " fmt

 #include <linux/delay.h>
-#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iommu.h>
-#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>

-#include <linux/amba/bus.h>
-
-#include <asm/pgalloc.h>
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
@@ -66,40 +52,6 @@
 		((smmu->options & ARM_SMMU_OPT_SECURE_CFG_ACCESS)	\
 			? 0x400 : 0))

-/* Page table bits */
-#define ARM_SMMU_PTE_XN			(((pteval_t)3) << 53)
-#define ARM_SMMU_PTE_CONT		(((pteval_t)1) << 52)
-#define ARM_SMMU_PTE_AF			(((pteval_t)1) << 10)
-#define ARM_SMMU_PTE_SH_NS		(((pteval_t)0) << 8)
-#define ARM_SMMU_PTE_SH_OS		(((pteval_t)2) << 8)
-#define ARM_SMMU_PTE_SH_IS		(((pteval_t)3) << 8)
-#define ARM_SMMU_PTE_PAGE		(((pteval_t)3) << 0)
-
-#if PAGE_SIZE == SZ_4K
-#define ARM_SMMU_PTE_CONT_ENTRIES	16
-#elif PAGE_SIZE == SZ_64K
-#define ARM_SMMU_PTE_CONT_ENTRIES	32
-#else
-#define ARM_SMMU_PTE_CONT_ENTRIES	1
-#endif
-
-#define ARM_SMMU_PTE_CONT_SIZE		(PAGE_SIZE * ARM_SMMU_PTE_CONT_ENTRIES)
-#define ARM_SMMU_PTE_CONT_MASK		(~(ARM_SMMU_PTE_CONT_SIZE - 1))
-
-/* Stage-1 PTE */
-#define ARM_SMMU_PTE_AP_UNPRIV		(((pteval_t)1) << 6)
-#define ARM_SMMU_PTE_AP_RDONLY		(((pteval_t)2) << 6)
-#define ARM_SMMU_PTE_ATTRINDX_SHIFT	2
-#define ARM_SMMU_PTE_nG			(((pteval_t)1) << 11)
-
-/* Stage-2 PTE */
-#define ARM_SMMU_PTE_HAP_FAULT		(((pteval_t)0) << 6)
-#define ARM_SMMU_PTE_HAP_READ		(((pteval_t)1) << 6)
-#define ARM_SMMU_PTE_HAP_WRITE		(((pteval_t)2) << 6)
-#define ARM_SMMU_PTE_MEMATTR_OIWB	(((pteval_t)0xf) << 2)
-#define ARM_SMMU_PTE_MEMATTR_NC		(((pteval_t)0x5) << 2)
-#define ARM_SMMU_PTE_MEMATTR_DEV	(((pteval_t)0x1) << 2)
-
 /* Configuration registers */
 #define ARM_SMMU_GR0_sCR0		0x0
 #define sCR0_CLIENTPD			(1 << 0)
@@ -173,7 +125,6 @@
 #define ARM_SMMU_GR0_sTLBGSYNC		0x70
 #define ARM_SMMU_GR0_sTLBGSTATUS	0x74
 #define sTLBGSTATUS_GSACTIVE		(1 << 0)
-#define TLB_LOOP_TIMEOUT		1000000	/* 1s! */

 /* Stream mapping registers */
 #define ARM_SMMU_GR0_SMR(n)		(0x800 + ((n) << 2))
@@ -202,12 +153,6 @@
 #define CBAR_S1_MEMATTR_SHIFT		12
 #define CBAR_S1_MEMATTR_MASK		0xf
 #define CBAR_S1_MEMATTR_WB		0xf
-#define CBAR_TYPE_SHIFT			16
-#define CBAR_TYPE_MASK			0x3
-#define CBAR_TYPE_S2_TRANS		(0 << CBAR_TYPE_SHIFT)
-#define CBAR_TYPE_S1_TRANS_S2_BYPASS	(1 << CBAR_TYPE_SHIFT)
-#define CBAR_TYPE_S1_TRANS_S2_FAULT	(2 << CBAR_TYPE_SHIFT)
-#define CBAR_TYPE_S1_TRANS_S2_TRANS	(3 << CBAR_TYPE_SHIFT)
 #define CBAR_IRPTNDX_SHIFT		24
 #define CBAR_IRPTNDX_MASK		0xff

@@ -242,40 +187,6 @@
 #define SCTLR_M				(1 << 0)
 #define SCTLR_EAE_SBOP			(SCTLR_AFE | SCTLR_TRE)

-#define RESUME_RETRY			(0 << 0)
-#define RESUME_TERMINATE		(1 << 0)
-
-#define TTBCR_EAE			(1 << 31)
-
-#define TTBCR_PASIZE_SHIFT		16
-#define TTBCR_PASIZE_MASK		0x7
-
-#define TTBCR_TG0_4K			(0 << 14)
-#define TTBCR_TG0_64K			(1 << 14)
-
-#define TTBCR_SH0_SHIFT			12
-#define TTBCR_SH0_MASK			0x3
-#define TTBCR_SH_NS			0
-#define TTBCR_SH_OS			2
-#define TTBCR_SH_IS			3
-
-#define TTBCR_ORGN0_SHIFT		10
-#define TTBCR_IRGN0_SHIFT		8
-#define TTBCR_RGN_MASK			0x3
-#define TTBCR_RGN_NC			0
-#define TTBCR_RGN_WBWA			1
-#define TTBCR_RGN_WT			2
-#define TTBCR_RGN_WB			3
-
-#define TTBCR_SL0_SHIFT			6
-#define TTBCR_SL0_MASK			0x3
-#define TTBCR_SL0_LVL_2			0
-#define TTBCR_SL0_LVL_1			1
-
-#define TTBCR_T1SZ_SHIFT		16
-#define TTBCR_T0SZ_SHIFT		0
-#define TTBCR_SZ_MASK			0xf
-
 #define TTBCR2_SEP_SHIFT		15
 #define TTBCR2_SEP_MASK			0x7

@@ -292,15 +203,6 @@

 #define TTBRn_HI_ASID_SHIFT		16

-#define MAIR_ATTR_SHIFT(n)		((n) << 3)
-#define MAIR_ATTR_MASK			0xff
-#define MAIR_ATTR_DEVICE		0x04
-#define MAIR_ATTR_NC			0x44
-#define MAIR_ATTR_WBRWA			0xff
-#define MAIR_ATTR_IDX_NC		0
-#define MAIR_ATTR_IDX_CACHE		1
-#define MAIR_ATTR_IDX_DEV		2
-
 #define FSR_MULTI			(1 << 31)
 #define FSR_SS				(1 << 30)
 #define FSR_UUT				(1 << 8)
@@ -319,238 +221,6 @@

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
-	u32				size;
-	u32				pagesize;
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
-	u32				input_size;
-	u32				s1_output_size;
-	u32				s2_output_size;
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
-#define ARM_SMMU_CB_ASID(cfg)		((cfg)->cbndx)
-#define ARM_SMMU_CB_VMID(cfg)		((cfg)->cbndx + 1)
-
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
-static DEFINE_SPINLOCK(arm_smmu_devices_lock);
-static LIST_HEAD(arm_smmu_devices);
-
-struct arm_smmu_option_prop {
-	u32 opt;
-	const char *prop;
-};
-
-static struct arm_smmu_option_prop arm_smmu_options[] = {
-	{ ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
-	{ 0, NULL},
-};
-
-static void parse_driver_options(struct arm_smmu_device *smmu)
-{
-	int i = 0;
-	do {
-		if (of_property_read_bool(smmu->dev->of_node,
-						arm_smmu_options[i].prop)) {
-			smmu->options |= arm_smmu_options[i].opt;
-			dev_notice(smmu->dev, "option %s\n",
-				arm_smmu_options[i].prop);
-		}
-	} while (arm_smmu_options[++i].opt);
-}
-
-static struct arm_smmu_master *find_smmu_master(struct arm_smmu_device *smmu,
-						struct device_node *dev_node)
-{
-	struct rb_node *node = smmu->masters.rb_node;
-
-	while (node) {
-		struct arm_smmu_master *master;
-		master = container_of(node, struct arm_smmu_master, node);
-
-		if (dev_node < master->of_node)
-			node = node->rb_left;
-		else if (dev_node > master->of_node)
-			node = node->rb_right;
-		else
-			return master;
-	}
-
-	return NULL;
-}
-
-static int insert_smmu_master(struct arm_smmu_device *smmu,
-			      struct arm_smmu_master *master)
-{
-	struct rb_node **new, *parent;
-
-	new = &smmu->masters.rb_node;
-	parent = NULL;
-	while (*new) {
-		struct arm_smmu_master *this;
-		this = container_of(*new, struct arm_smmu_master, node);
-
-		parent = *new;
-		if (master->of_node < this->of_node)
-			new = &((*new)->rb_left);
-		else if (master->of_node > this->of_node)
-			new = &((*new)->rb_right);
-		else
-			return -EEXIST;
-	}
-
-	rb_link_node(&master->node, parent, new);
-	rb_insert_color(&master->node, &smmu->masters);
-	return 0;
-}
-
-static int register_smmu_master(struct arm_smmu_device *smmu,
-				struct device *dev,
-				struct of_phandle_args *masterspec)
-{
-	int i;
-	struct arm_smmu_master *master;
-
-	master = find_smmu_master(smmu, masterspec->np);
-	if (master) {
-		dev_err(dev,
-			"rejecting multiple registrations for master device %s\n",
-			masterspec->np->name);
-		return -EBUSY;
-	}
-
-	if (masterspec->args_count > MAX_MASTER_STREAMIDS) {
-		dev_err(dev,
-			"reached maximum number (%d) of stream IDs for master device %s\n",
-			MAX_MASTER_STREAMIDS, masterspec->np->name);
-		return -ENOSPC;
-	}
-
-	master = devm_kzalloc(dev, sizeof(*master), GFP_KERNEL);
-	if (!master)
-		return -ENOMEM;
-
-	master->of_node		= masterspec->np;
-	master->num_streamids	= masterspec->args_count;
-
-	for (i = 0; i < master->num_streamids; ++i)
-		master->streamids[i] = masterspec->args[i];
-
-	return insert_smmu_master(smmu, master);
-}
-
-static struct arm_smmu_device *find_parent_smmu(struct arm_smmu_device *smmu)
-{
-	struct arm_smmu_device *parent;
-
-	if (!smmu->parent_of_node)
-		return NULL;
-
-	spin_lock(&arm_smmu_devices_lock);
-	list_for_each_entry(parent, &arm_smmu_devices, list)
-		if (parent->dev->of_node == smmu->parent_of_node)
-			goto out_unlock;
-
-	parent = NULL;
-	dev_warn(smmu->dev,
-		 "Failed to find SMMU parent despite parent in DT\n");
-out_unlock:
-	spin_unlock(&arm_smmu_devices_lock);
-	return parent;
-}
-
-static int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
-{
-	int idx;
-
-	do {
-		idx = find_next_zero_bit(map, end, start);
-		if (idx == end)
-			return -ENOSPC;
-	} while (test_and_set_bit(idx, map));
-
-	return idx;
-}
-
-static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
-{
-	clear_bit(idx, map);
-}
-
 /* Wait for any pending TLB invalidations to complete */
 static void arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
 {
@@ -570,7 +240,7 @@ static void arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
 	}
 }

-static void arm_smmu_tlb_inv_context(struct arm_smmu_cfg *cfg)
+void arm_smmu_tlb_inv_context(struct arm_smmu_cfg *cfg)
 {
 	struct arm_smmu_device *smmu = cfg->smmu;
 	void __iomem *base = ARM_SMMU_GR0(smmu);
@@ -589,7 +259,7 @@ static void arm_smmu_tlb_inv_context(struct arm_smmu_cfg *cfg)
 	arm_smmu_tlb_sync(smmu);
 }

-static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
+irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 {
 	int flags, ret;
 	u32 fsr, far, fsynr, resume;
@@ -642,7 +312,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	return ret;
 }

-static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
+irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 {
 	u32 gfsr, gfsynr0, gfsynr1, gfsynr2;
 	struct arm_smmu_device *smmu = dev;
@@ -666,29 +336,7 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 	return IRQ_HANDLED;
 }

-static void arm_smmu_flush_pgtable(struct arm_smmu_device *smmu, void *addr,
-				   size_t size)
-{
-	unsigned long offset = (unsigned long)addr & ~PAGE_MASK;
-
-
-	/* Ensure new page tables are visible to the hardware walker */
-	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK) {
-		dsb(ishst);
-	} else {
-		/*
-		 * If the SMMU can't walk tables in the CPU caches, treat them
-		 * like non-coherent DMA since we need to flush the new entries
-		 * all the way out to memory. There's no possibility of
-		 * recursion here as the SMMU table walker will not be wired
-		 * through another SMMU.
-		 */
-		dma_map_page(smmu->dev, virt_to_page(addr), offset, size,
-				DMA_TO_DEVICE);
-	}
-}
-
-static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
+void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 {
 	u32 reg;
 	bool stage1;
@@ -848,80 +496,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 	writel_relaxed(reg, cb_base + ARM_SMMU_CB_SCTLR);
 }

-static int arm_smmu_init_domain_context(struct iommu_domain *domain,
-					struct device *dev)
-{
-	int irq, ret, start;
-	struct arm_smmu_domain *smmu_domain = domain->priv;
-	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
-	struct arm_smmu_device *smmu, *parent;
-
-	/*
-	 * Walk the SMMU chain to find the root device for this chain.
-	 * We assume that no masters have translations which terminate
-	 * early, and therefore check that the root SMMU does indeed have
-	 * a StreamID for the master in question.
-	 */
-	parent = dev->archdata.iommu;
-	smmu_domain->output_mask = -1;
-	do {
-		smmu = parent;
-		smmu_domain->output_mask &= (1ULL << smmu->s2_output_size) - 1;
-	} while ((parent = find_parent_smmu(smmu)));
-
-	if (!find_smmu_master(smmu, dev->of_node)) {
-		dev_err(dev, "unable to find root SMMU for device\n");
-		return -ENODEV;
-	}
-
-	if (smmu->features & ARM_SMMU_FEAT_TRANS_NESTED) {
-		/*
-		 * We will likely want to change this if/when KVM gets
-		 * involved.
-		 */
-		root_cfg->cbar = CBAR_TYPE_S1_TRANS_S2_BYPASS;
-		start = smmu->num_s2_context_banks;
-	} else if (smmu->features & ARM_SMMU_FEAT_TRANS_S2) {
-		root_cfg->cbar = CBAR_TYPE_S2_TRANS;
-		start = 0;
-	} else {
-		root_cfg->cbar = CBAR_TYPE_S1_TRANS_S2_BYPASS;
-		start = smmu->num_s2_context_banks;
-	}
-
-	ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
-				      smmu->num_context_banks);
-	if (IS_ERR_VALUE(ret))
-		return ret;
-
-	root_cfg->cbndx = ret;
-	if (smmu->version == 1) {
-		root_cfg->irptndx = atomic_inc_return(&smmu->irptndx);
-		root_cfg->irptndx %= smmu->num_context_irqs;
-	} else {
-		root_cfg->irptndx = root_cfg->cbndx;
-	}
-
-	irq = smmu->irqs[smmu->num_global_irqs + root_cfg->irptndx];
-	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
-			  "arm-smmu-context-fault", domain);
-	if (IS_ERR_VALUE(ret)) {
-		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
-			root_cfg->irptndx, irq);
-		root_cfg->irptndx = INVALID_IRPTNDX;
-		goto out_free_context;
-	}
-
-	root_cfg->smmu = smmu;
-	arm_smmu_init_context_bank(smmu_domain);
-	return ret;
-
-out_free_context:
-	__arm_smmu_free_bitmap(smmu->context_map, root_cfg->cbndx);
-	return ret;
-}
-
-static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
+void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = domain->priv;
 	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
@@ -945,110 +520,6 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	__arm_smmu_free_bitmap(smmu->context_map, root_cfg->cbndx);
 }

-static int arm_smmu_domain_init(struct iommu_domain *domain)
-{
-	struct arm_smmu_domain *smmu_domain;
-	pgd_t *pgd;
-
-	/*
-	 * Allocate the domain and initialise some of its data structures.
-	 * We can't really do anything meaningful until we've added a
-	 * master.
-	 */
-	smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
-	if (!smmu_domain)
-		return -ENOMEM;
-
-	pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
-	if (!pgd)
-		goto out_free_domain;
-	smmu_domain->root_cfg.pgd = pgd;
-
-	spin_lock_init(&smmu_domain->lock);
-	domain->priv = smmu_domain;
-	return 0;
-
-out_free_domain:
-	kfree(smmu_domain);
-	return -ENOMEM;
-}
-
-static void arm_smmu_free_ptes(pmd_t *pmd)
-{
-	pgtable_t table = pmd_pgtable(*pmd);
-	pgtable_page_dtor(table);
-	__free_page(table);
-}
-
-static void arm_smmu_free_pmds(pud_t *pud)
-{
-	int i;
-	pmd_t *pmd, *pmd_base = pmd_offset(pud, 0);
-
-	pmd = pmd_base;
-	for (i = 0; i < PTRS_PER_PMD; ++i) {
-		if (pmd_none(*pmd))
-			continue;
-
-		arm_smmu_free_ptes(pmd);
-		pmd++;
-	}
-
-	pmd_free(NULL, pmd_base);
-}
-
-static void arm_smmu_free_puds(pgd_t *pgd)
-{
-	int i;
-	pud_t *pud, *pud_base = pud_offset(pgd, 0);
-
-	pud = pud_base;
-	for (i = 0; i < PTRS_PER_PUD; ++i) {
-		if (pud_none(*pud))
-			continue;
-
-		arm_smmu_free_pmds(pud);
-		pud++;
-	}
-
-	pud_free(NULL, pud_base);
-}
-
-static void arm_smmu_free_pgtables(struct arm_smmu_domain *smmu_domain)
-{
-	int i;
-	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
-	pgd_t *pgd, *pgd_base = root_cfg->pgd;
-
-	/*
-	 * Recursively free the page tables for this domain. We don't
-	 * care about speculative TLB filling because the tables should
-	 * not be active in any context bank at this point (SCTLR.M is 0).
-	 */
-	pgd = pgd_base;
-	for (i = 0; i < PTRS_PER_PGD; ++i) {
-		if (pgd_none(*pgd))
-			continue;
-		arm_smmu_free_puds(pgd);
-		pgd++;
-	}
-
-	kfree(pgd_base);
-}
-
-static void arm_smmu_domain_destroy(struct iommu_domain *domain)
-{
-	struct arm_smmu_domain *smmu_domain = domain->priv;
-
-	/*
-	 * Free the domain resources. We assume that all devices have
-	 * already been detached.
-	 */
-	arm_smmu_destroy_domain_context(domain);
-	arm_smmu_free_pgtables(smmu_domain);
-	kfree(smmu_domain);
-}
-
 static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
 					  struct arm_smmu_master *master)
 {
@@ -1133,7 +604,7 @@ static void arm_smmu_bypass_stream_mapping(struct arm_smmu_device *smmu,
 	}
 }

-static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
+int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 				      struct arm_smmu_master *master)
 {
 	int i, ret;
@@ -1171,7 +642,7 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }

-static void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
+void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
 					  struct arm_smmu_master *master)
 {
 	struct arm_smmu_device *smmu = smmu_domain->root_cfg.smmu;
@@ -1184,444 +655,7 @@ static void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
 	arm_smmu_master_free_smrs(smmu, master);
 }

-static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
-{
-	int ret = -EINVAL;
-	struct arm_smmu_domain *smmu_domain = domain->priv;
-	struct arm_smmu_device *device_smmu = dev->archdata.iommu;
-	struct arm_smmu_master *master;
-	unsigned long flags;
-
-	if (!device_smmu) {
-		dev_err(dev, "cannot attach to SMMU, is it on the same bus?\n");
-		return -ENXIO;
-	}
-
-	/*
-	 * Sanity check the domain. We don't currently support domains
-	 * that cross between different SMMU chains.
-	 */
-	spin_lock_irqsave(&smmu_domain->lock, flags);
-	if (!smmu_domain->leaf_smmu) {
-		/* Now that we have a master, we can finalise the domain */
-		ret = arm_smmu_init_domain_context(domain, dev);
-		if (IS_ERR_VALUE(ret))
-			goto err_unlock;
-
-		smmu_domain->leaf_smmu = device_smmu;
-	} else if (smmu_domain->leaf_smmu != device_smmu) {
-		dev_err(dev,
-			"cannot attach to SMMU %s whilst already attached to domain on SMMU %s\n",
-			dev_name(smmu_domain->leaf_smmu->dev),
-			dev_name(device_smmu->dev));
-		goto err_unlock;
-	}
-	spin_unlock_irqrestore(&smmu_domain->lock, flags);
-
-	/* Looks ok, so add the device to the domain */
-	master = find_smmu_master(smmu_domain->leaf_smmu, dev->of_node);
-	if (!master)
-		return -ENODEV;
-
-	return arm_smmu_domain_add_master(smmu_domain, master);
-
-err_unlock:
-	spin_unlock_irqrestore(&smmu_domain->lock, flags);
-	return ret;
-}
-
-static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
-{
-	struct arm_smmu_domain *smmu_domain = domain->priv;
-	struct arm_smmu_master *master;
-
-	master = find_smmu_master(smmu_domain->leaf_smmu, dev->of_node);
-	if (master)
-		arm_smmu_domain_remove_master(smmu_domain, master);
-}
-
-static bool arm_smmu_pte_is_contiguous_range(unsigned long addr,
-					     unsigned long end)
-{
-	return !(addr & ~ARM_SMMU_PTE_CONT_MASK) &&
-		(addr + ARM_SMMU_PTE_CONT_SIZE <= end);
-}
-
-static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
-				   unsigned long addr, unsigned long end,
-				   unsigned long pfn, int prot, int stage)
-{
-	pte_t *pte, *start;
-	pteval_t pteval = ARM_SMMU_PTE_PAGE | ARM_SMMU_PTE_AF | ARM_SMMU_PTE_XN;
-
-	if (pmd_none(*pmd)) {
-		/* Allocate a new set of tables */
-		pgtable_t table = alloc_page(GFP_ATOMIC|__GFP_ZERO);
-		if (!table)
-			return -ENOMEM;
-
-		arm_smmu_flush_pgtable(smmu, page_address(table), PAGE_SIZE);
-		if (!pgtable_page_ctor(table)) {
-			__free_page(table);
-			return -ENOMEM;
-		}
-		pmd_populate(NULL, pmd, table);
-		arm_smmu_flush_pgtable(smmu, pmd, sizeof(*pmd));
-	}
-
-	if (stage == 1) {
-		pteval |= ARM_SMMU_PTE_AP_UNPRIV | ARM_SMMU_PTE_nG;
-		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
-			pteval |= ARM_SMMU_PTE_AP_RDONLY;
-
-		if (prot & IOMMU_CACHE)
-			pteval |= (MAIR_ATTR_IDX_CACHE <<
-				   ARM_SMMU_PTE_ATTRINDX_SHIFT);
-	} else {
-		pteval |= ARM_SMMU_PTE_HAP_FAULT;
-		if (prot & IOMMU_READ)
-			pteval |= ARM_SMMU_PTE_HAP_READ;
-		if (prot & IOMMU_WRITE)
-			pteval |= ARM_SMMU_PTE_HAP_WRITE;
-		if (prot & IOMMU_CACHE)
-			pteval |= ARM_SMMU_PTE_MEMATTR_OIWB;
-		else
-			pteval |= ARM_SMMU_PTE_MEMATTR_NC;
-	}
-
-	/* If no access, create a faulting entry to avoid TLB fills */
-	if (prot & IOMMU_EXEC)
-		pteval &= ~ARM_SMMU_PTE_XN;
-	else if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
-		pteval &= ~ARM_SMMU_PTE_PAGE;
-
-	pteval |= ARM_SMMU_PTE_SH_IS;
-	start = pmd_page_vaddr(*pmd) + pte_index(addr);
-	pte = start;
-
-	/*
-	 * Install the page table entries. This is fairly complicated
-	 * since we attempt to make use of the contiguous hint in the
-	 * ptes where possible. The contiguous hint indicates a series
-	 * of ARM_SMMU_PTE_CONT_ENTRIES ptes mapping a physically
-	 * contiguous region with the following constraints:
-	 *
-	 *   - The region start is aligned to ARM_SMMU_PTE_CONT_SIZE
-	 *   - Each pte in the region has the contiguous hint bit set
-	 *
-	 * This complicates unmapping (also handled by this code, when
-	 * neither IOMMU_READ or IOMMU_WRITE are set) because it is
-	 * possible, yet highly unlikely, that a client may unmap only
-	 * part of a contiguous range. This requires clearing of the
-	 * contiguous hint bits in the range before installing the new
-	 * faulting entries.
-	 *
-	 * Note that re-mapping an address range without first unmapping
-	 * it is not supported, so TLB invalidation is not required here
-	 * and is instead performed@unmap and domain-init time.
-	 */
-	do {
-		int i = 1;
-		pteval &= ~ARM_SMMU_PTE_CONT;
-
-		if (arm_smmu_pte_is_contiguous_range(addr, end)) {
-			i = ARM_SMMU_PTE_CONT_ENTRIES;
-			pteval |= ARM_SMMU_PTE_CONT;
-		} else if (pte_val(*pte) &
-			   (ARM_SMMU_PTE_CONT | ARM_SMMU_PTE_PAGE)) {
-			int j;
-			pte_t *cont_start;
-			unsigned long idx = pte_index(addr);
-
-			idx &= ~(ARM_SMMU_PTE_CONT_ENTRIES - 1);
-			cont_start = pmd_page_vaddr(*pmd) + idx;
-			for (j = 0; j < ARM_SMMU_PTE_CONT_ENTRIES; ++j)
-				pte_val(*(cont_start + j)) &= ~ARM_SMMU_PTE_CONT;
-
-			arm_smmu_flush_pgtable(smmu, cont_start,
-					       sizeof(*pte) *
-					       ARM_SMMU_PTE_CONT_ENTRIES);
-		}
-
-		do {
-			*pte = pfn_pte(pfn, __pgprot(pteval));
-		} while (pte++, pfn++, addr += PAGE_SIZE, --i);
-	} while (addr != end);
-
-	arm_smmu_flush_pgtable(smmu, start, sizeof(*pte) * (pte - start));
-	return 0;
-}
-
-static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
-				   unsigned long addr, unsigned long end,
-				   phys_addr_t phys, int prot, int stage)
-{
-	int ret;
-	pmd_t *pmd;
-	unsigned long next, pfn = __phys_to_pfn(phys);
-
-#ifndef __PAGETABLE_PMD_FOLDED
-	if (pud_none(*pud)) {
-		pmd = (pmd_t *)get_zeroed_page(GFP_ATOMIC);
-		if (!pmd)
-			return -ENOMEM;
-
-		arm_smmu_flush_pgtable(smmu, pmd, PAGE_SIZE);
-		pud_populate(NULL, pud, pmd);
-		arm_smmu_flush_pgtable(smmu, pud, sizeof(*pud));
-
-		pmd += pmd_index(addr);
-	} else
-#endif
-		pmd = pmd_offset(pud, addr);
-
-	do {
-		next = pmd_addr_end(addr, end);
-		ret = arm_smmu_alloc_init_pte(smmu, pmd, addr, next, pfn,
-					      prot, stage);
-		phys += next - addr;
-	} while (pmd++, addr = next, addr < end);
-
-	return ret;
-}
-
-static int arm_smmu_alloc_init_pud(struct arm_smmu_device *smmu, pgd_t *pgd,
-				   unsigned long addr, unsigned long end,
-				   phys_addr_t phys, int prot, int stage)
-{
-	int ret = 0;
-	pud_t *pud;
-	unsigned long next;
-
-#ifndef __PAGETABLE_PUD_FOLDED
-	if (pgd_none(*pgd)) {
-		pud = (pud_t *)get_zeroed_page(GFP_ATOMIC);
-		if (!pud)
-			return -ENOMEM;
-
-		arm_smmu_flush_pgtable(smmu, pud, PAGE_SIZE);
-		pgd_populate(NULL, pgd, pud);
-		arm_smmu_flush_pgtable(smmu, pgd, sizeof(*pgd));
-
-		pud += pud_index(addr);
-	} else
-#endif
-		pud = pud_offset(pgd, addr);
-
-	do {
-		next = pud_addr_end(addr, end);
-		ret = arm_smmu_alloc_init_pmd(smmu, pud, addr, next, phys,
-					      prot, stage);
-		phys += next - addr;
-	} while (pud++, addr = next, addr < end);
-
-	return ret;
-}
-
-static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
-				   unsigned long iova, phys_addr_t paddr,
-				   size_t size, int prot)
-{
-	int ret, stage;
-	unsigned long end;
-	phys_addr_t input_mask, output_mask;
-	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
-	pgd_t *pgd = root_cfg->pgd;
-	struct arm_smmu_device *smmu = root_cfg->smmu;
-	unsigned long flags;
-
-	if (root_cfg->cbar == CBAR_TYPE_S2_TRANS) {
-		stage = 2;
-		output_mask = (1ULL << smmu->s2_output_size) - 1;
-	} else {
-		stage = 1;
-		output_mask = (1ULL << smmu->s1_output_size) - 1;
-	}
-
-	if (!pgd)
-		return -EINVAL;
-
-	if (size & ~PAGE_MASK)
-		return -EINVAL;
-
-	input_mask = (1ULL << smmu->input_size) - 1;
-	if ((phys_addr_t)iova & ~input_mask)
-		return -ERANGE;
-
-	if (paddr & ~output_mask)
-		return -ERANGE;
-
-	spin_lock_irqsave(&smmu_domain->lock, flags);
-	pgd += pgd_index(iova);
-	end = iova + size;
-	do {
-		unsigned long next = pgd_addr_end(iova, end);
-
-		ret = arm_smmu_alloc_init_pud(smmu, pgd, iova, next, paddr,
-					      prot, stage);
-		if (ret)
-			goto out_unlock;
-
-		paddr += next - iova;
-		iova = next;
-	} while (pgd++, iova != end);
-
-out_unlock:
-	spin_unlock_irqrestore(&smmu_domain->lock, flags);
-
-	return ret;
-}
-
-static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
-			phys_addr_t paddr, size_t size, int prot)
-{
-	struct arm_smmu_domain *smmu_domain = domain->priv;
-
-	if (!smmu_domain)
-		return -ENODEV;
-
-	/* Check for silent address truncation up the SMMU chain. */
-	if ((phys_addr_t)iova & ~smmu_domain->output_mask)
-		return -ERANGE;
-
-	return arm_smmu_handle_mapping(smmu_domain, iova, paddr, size, prot);
-}
-
-static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
-			     size_t size)
-{
-	int ret;
-	struct arm_smmu_domain *smmu_domain = domain->priv;
-
-	ret = arm_smmu_handle_mapping(smmu_domain, iova, 0, size, 0);
-	arm_smmu_tlb_inv_context(&smmu_domain->root_cfg);
-	return ret ? 0 : size;
-}
-
-static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
-					 dma_addr_t iova)
-{
-	pgd_t *pgdp, pgd;
-	pud_t pud;
-	pmd_t pmd;
-	pte_t pte;
-	struct arm_smmu_domain *smmu_domain = domain->priv;
-	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
-
-	pgdp = root_cfg->pgd;
-	if (!pgdp)
-		return 0;
-
-	pgd = *(pgdp + pgd_index(iova));
-	if (pgd_none(pgd))
-		return 0;
-
-	pud = *pud_offset(&pgd, iova);
-	if (pud_none(pud))
-		return 0;
-
-	pmd = *pmd_offset(&pud, iova);
-	if (pmd_none(pmd))
-		return 0;
-
-	pte = *(pmd_page_vaddr(pmd) + pte_index(iova));
-	if (pte_none(pte))
-		return 0;
-
-	return __pfn_to_phys(pte_pfn(pte)) | (iova & ~PAGE_MASK);
-}
-
-static int arm_smmu_domain_has_cap(struct iommu_domain *domain,
-				   unsigned long cap)
-{
-	unsigned long caps = 0;
-	struct arm_smmu_domain *smmu_domain = domain->priv;
-
-	if (smmu_domain->root_cfg.smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
-		caps |= IOMMU_CAP_CACHE_COHERENCY;
-
-	return !!(cap & caps);
-}
-
-static int arm_smmu_add_device(struct device *dev)
-{
-	struct arm_smmu_device *child, *parent, *smmu;
-	struct arm_smmu_master *master = NULL;
-	struct iommu_group *group;
-	int ret;
-
-	if (dev->archdata.iommu) {
-		dev_warn(dev, "IOMMU driver already assigned to device\n");
-		return -EINVAL;
-	}
-
-	spin_lock(&arm_smmu_devices_lock);
-	list_for_each_entry(parent, &arm_smmu_devices, list) {
-		smmu = parent;
-
-		/* Try to find a child of the current SMMU. */
-		list_for_each_entry(child, &arm_smmu_devices, list) {
-			if (child->parent_of_node == parent->dev->of_node) {
-				/* Does the child sit above our master? */
-				master = find_smmu_master(child, dev->of_node);
-				if (master) {
-					smmu = NULL;
-					break;
-				}
-			}
-		}
-
-		/* We found some children, so keep searching. */
-		if (!smmu) {
-			master = NULL;
-			continue;
-		}
-
-		master = find_smmu_master(smmu, dev->of_node);
-		if (master)
-			break;
-	}
-	spin_unlock(&arm_smmu_devices_lock);
-
-	if (!master)
-		return -ENODEV;
-
-	group = iommu_group_alloc();
-	if (IS_ERR(group)) {
-		dev_err(dev, "Failed to allocate IOMMU group\n");
-		return PTR_ERR(group);
-	}
-
-	ret = iommu_group_add_device(group, dev);
-	iommu_group_put(group);
-	dev->archdata.iommu = smmu;
-
-	return ret;
-}
-
-static void arm_smmu_remove_device(struct device *dev)
-{
-	dev->archdata.iommu = NULL;
-	iommu_group_remove_device(dev);
-}
-
-static struct iommu_ops arm_smmu_ops = {
-	.domain_init	= arm_smmu_domain_init,
-	.domain_destroy	= arm_smmu_domain_destroy,
-	.attach_dev	= arm_smmu_attach_dev,
-	.detach_dev	= arm_smmu_detach_dev,
-	.map		= arm_smmu_map,
-	.unmap		= arm_smmu_unmap,
-	.iova_to_phys	= arm_smmu_iova_to_phys,
-	.domain_has_cap	= arm_smmu_domain_has_cap,
-	.add_device	= arm_smmu_add_device,
-	.remove_device	= arm_smmu_remove_device,
-	.pgsize_bitmap	= (SECTION_SIZE |
-			   ARM_SMMU_PTE_CONT_SIZE |
-			   PAGE_SIZE),
-};
-
-static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
+void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 {
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 	void __iomem *cb_base;
@@ -1691,7 +725,7 @@ static u32 arm_smmu_id_size_to_bits(u32 size)
 	}
 }

-static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
+int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 {
 	u32 size;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
@@ -1835,175 +869,10 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }

-static int arm_smmu_device_dt_probe(struct platform_device *pdev)
-{
-	struct resource *res;
-	struct arm_smmu_device *smmu;
-	struct device_node *dev_node;
-	struct device *dev = &pdev->dev;
-	struct rb_node *node;
-	struct of_phandle_args masterspec;
-	int num_irqs, i, err;
-
-	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
-	if (!smmu) {
-		dev_err(dev, "failed to allocate arm_smmu_device\n");
-		return -ENOMEM;
-	}
-	smmu->dev = dev;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	smmu->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(smmu->base))
-		return PTR_ERR(smmu->base);
-	smmu->size = resource_size(res);
-
-	if (of_property_read_u32(dev->of_node, "#global-interrupts",
-				 &smmu->num_global_irqs)) {
-		dev_err(dev, "missing #global-interrupts property\n");
-		return -ENODEV;
-	}
-
-	num_irqs = 0;
-	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
-		num_irqs++;
-		if (num_irqs > smmu->num_global_irqs)
-			smmu->num_context_irqs++;
-	}
-
-	if (!smmu->num_context_irqs) {
-		dev_err(dev, "found %d interrupts but expected at least %d\n",
-			num_irqs, smmu->num_global_irqs + 1);
-		return -ENODEV;
-	}
-
-	smmu->irqs = devm_kzalloc(dev, sizeof(*smmu->irqs) * num_irqs,
-				  GFP_KERNEL);
-	if (!smmu->irqs) {
-		dev_err(dev, "failed to allocate %d irqs\n", num_irqs);
-		return -ENOMEM;
-	}
-
-	for (i = 0; i < num_irqs; ++i) {
-		int irq = platform_get_irq(pdev, i);
-		if (irq < 0) {
-			dev_err(dev, "failed to get irq index %d\n", i);
-			return -ENODEV;
-		}
-		smmu->irqs[i] = irq;
-	}
-
-	i = 0;
-	smmu->masters = RB_ROOT;
-	while (!of_parse_phandle_with_args(dev->of_node, "mmu-masters",
-					   "#stream-id-cells", i,
-					   &masterspec)) {
-		err = register_smmu_master(smmu, dev, &masterspec);
-		if (err) {
-			dev_err(dev, "failed to add master %s\n",
-				masterspec.np->name);
-			goto out_put_masters;
-		}
-
-		i++;
-	}
-	dev_notice(dev, "registered %d master devices\n", i);
-
-	dev_node = of_parse_phandle(dev->of_node, "smmu-parent", 0);
-	if (dev_node)
-		smmu->parent_of_node = dev_node;
-
-	err = arm_smmu_device_cfg_probe(smmu);
-	if (err)
-		goto out_put_parent;
-
-	parse_driver_options(smmu);
-
-	if (smmu->version > 1 &&
-	    smmu->num_context_banks != smmu->num_context_irqs) {
-		dev_err(dev,
-			"found only %d context interrupt(s) but %d required\n",
-			smmu->num_context_irqs, smmu->num_context_banks);
-		err = -ENODEV;
-		goto out_put_parent;
-	}
-
-	for (i = 0; i < smmu->num_global_irqs; ++i) {
-		err = request_irq(smmu->irqs[i],
-				  arm_smmu_global_fault,
-				  IRQF_SHARED,
-				  "arm-smmu global fault",
-				  smmu);
-		if (err) {
-			dev_err(dev, "failed to request global IRQ %d (%u)\n",
-				i, smmu->irqs[i]);
-			goto out_free_irqs;
-		}
-	}
-
-	INIT_LIST_HEAD(&smmu->list);
-	spin_lock(&arm_smmu_devices_lock);
-	list_add(&smmu->list, &arm_smmu_devices);
-	spin_unlock(&arm_smmu_devices_lock);
-
-	arm_smmu_device_reset(smmu);
-	return 0;
-
-out_free_irqs:
-	while (i--)
-		free_irq(smmu->irqs[i], smmu);
-
-out_put_parent:
-	if (smmu->parent_of_node)
-		of_node_put(smmu->parent_of_node);
-
-out_put_masters:
-	for (node = rb_first(&smmu->masters); node; node = rb_next(node)) {
-		struct arm_smmu_master *master;
-		master = container_of(node, struct arm_smmu_master, node);
-		of_node_put(master->of_node);
-	}
-
-	return err;
-}
-
-static int arm_smmu_device_remove(struct platform_device *pdev)
+int arm_smmu_device_unload(struct arm_smmu_device *smmu)
 {
-	int i;
-	struct device *dev = &pdev->dev;
-	struct arm_smmu_device *curr, *smmu = NULL;
-	struct rb_node *node;
-
-	spin_lock(&arm_smmu_devices_lock);
-	list_for_each_entry(curr, &arm_smmu_devices, list) {
-		if (curr->dev == dev) {
-			smmu = curr;
-			list_del(&smmu->list);
-			break;
-		}
-	}
-	spin_unlock(&arm_smmu_devices_lock);
-
-	if (!smmu)
-		return -ENODEV;
-
-	if (smmu->parent_of_node)
-		of_node_put(smmu->parent_of_node);
-
-	for (node = rb_first(&smmu->masters); node; node = rb_next(node)) {
-		struct arm_smmu_master *master;
-		master = container_of(node, struct arm_smmu_master, node);
-		of_node_put(master->of_node);
-	}
-
-	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
-		dev_err(dev, "removing device with active domains!\n");
-
-	for (i = 0; i < smmu->num_global_irqs; ++i)
-		free_irq(smmu->irqs[i], smmu);
-
-	/* Turn the thing off */
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+
 	return 0;
 }

@@ -2036,14 +905,7 @@ static int __init arm_smmu_init(void)
 	if (ret)
 		return ret;

-	/* Oh, for a proper bus abstraction */
-	if (!iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
-
-#ifdef CONFIG_ARM_AMBA
-	if (!iommu_present(&amba_bustype))
-		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
-#endif
+	arm_smmu_ops_init();

 	return 0;
 }
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
new file mode 100644
index 0000000..37d9a46
--- /dev/null
+++ b/drivers/iommu/arm-smmu.h
@@ -0,0 +1,230 @@
+/*
+ * IOMMU API for ARM architected SMMU implementations.
+ *
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
+ *
+ */
+
+#ifndef ARM_SMMU_H
+#define ARM_SMMU_H
+
+#include <linux/iommu.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
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
+/* Page table bits */
+#define ARM_SMMU_PTE_XN			(((pteval_t)3) << 53)
+#define ARM_SMMU_PTE_CONT		(((pteval_t)1) << 52)
+#define ARM_SMMU_PTE_AF			(((pteval_t)1) << 10)
+#define ARM_SMMU_PTE_SH_NS		(((pteval_t)0) << 8)
+#define ARM_SMMU_PTE_SH_OS		(((pteval_t)2) << 8)
+#define ARM_SMMU_PTE_SH_IS		(((pteval_t)3) << 8)
+#define ARM_SMMU_PTE_PAGE		(((pteval_t)3) << 0)
+
+#if PAGE_SIZE == SZ_4K
+#define ARM_SMMU_PTE_CONT_ENTRIES	16
+#elif PAGE_SIZE == SZ_64K
+#define ARM_SMMU_PTE_CONT_ENTRIES	32
+#else
+#define ARM_SMMU_PTE_CONT_ENTRIES	1
+#endif
+
+#define ARM_SMMU_PTE_CONT_SIZE		(PAGE_SIZE * ARM_SMMU_PTE_CONT_ENTRIES)
+#define ARM_SMMU_PTE_CONT_MASK		(~(ARM_SMMU_PTE_CONT_SIZE - 1))
+
+/* Stage-1 PTE */
+#define ARM_SMMU_PTE_AP_UNPRIV		(((pteval_t)1) << 6)
+#define ARM_SMMU_PTE_AP_RDONLY		(((pteval_t)2) << 6)
+#define ARM_SMMU_PTE_ATTRINDX_SHIFT	2
+#define ARM_SMMU_PTE_nG			(((pteval_t)1) << 11)
+
+/* Stage-2 PTE */
+#define ARM_SMMU_PTE_HAP_FAULT		(((pteval_t)0) << 6)
+#define ARM_SMMU_PTE_HAP_READ		(((pteval_t)1) << 6)
+#define ARM_SMMU_PTE_HAP_WRITE		(((pteval_t)2) << 6)
+#define ARM_SMMU_PTE_MEMATTR_OIWB	(((pteval_t)0xf) << 2)
+#define ARM_SMMU_PTE_MEMATTR_NC		(((pteval_t)0x5) << 2)
+#define ARM_SMMU_PTE_MEMATTR_DEV	(((pteval_t)0x1) << 2)
+
+#define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
+
+#define CBAR_TYPE_SHIFT			16
+#define CBAR_TYPE_MASK			0x3
+#define CBAR_TYPE_S2_TRANS		(0 << CBAR_TYPE_SHIFT)
+#define CBAR_TYPE_S1_TRANS_S2_BYPASS	(1 << CBAR_TYPE_SHIFT)
+#define CBAR_TYPE_S1_TRANS_S2_FAULT	(2 << CBAR_TYPE_SHIFT)
+#define CBAR_TYPE_S1_TRANS_S2_TRANS	(3 << CBAR_TYPE_SHIFT)
+
+#define RESUME_RETRY			(0 << 0)
+#define RESUME_TERMINATE		(1 << 0)
+
+#define TTBCR_EAE			(1 << 31)
+
+#define TTBCR_PASIZE_SHIFT		16
+#define TTBCR_PASIZE_MASK		0x7
+
+#define TTBCR_TG0_4K			(0 << 14)
+#define TTBCR_TG0_64K			(1 << 14)
+
+#define TTBCR_SH0_SHIFT			12
+#define TTBCR_SH0_MASK			0x3
+#define TTBCR_SH_NS			0
+#define TTBCR_SH_OS			2
+#define TTBCR_SH_IS			3
+
+#define TTBCR_ORGN0_SHIFT		10
+#define TTBCR_IRGN0_SHIFT		8
+#define TTBCR_RGN_MASK			0x3
+#define TTBCR_RGN_NC			0
+#define TTBCR_RGN_WBWA			1
+#define TTBCR_RGN_WT			2
+#define TTBCR_RGN_WB			3
+
+#define TTBCR_SL0_SHIFT			6
+#define TTBCR_SL0_MASK			0x3
+#define TTBCR_SL0_LVL_2			0
+#define TTBCR_SL0_LVL_1			1
+
+#define TTBCR_T1SZ_SHIFT		16
+#define TTBCR_T0SZ_SHIFT		0
+#define TTBCR_SZ_MASK			0xf
+
+#define MAIR_ATTR_SHIFT(n)		((n) << 3)
+#define MAIR_ATTR_MASK			0xff
+#define MAIR_ATTR_DEVICE		0x04
+#define MAIR_ATTR_NC			0x44
+#define MAIR_ATTR_WBRWA			0xff
+#define MAIR_ATTR_IDX_NC		0
+#define MAIR_ATTR_IDX_CACHE		1
+#define MAIR_ATTR_IDX_DEV		2
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
+	u32				size;
+	u32				pagesize;
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
+	u32				input_size;
+	u32				s1_output_size;
+	u32				s2_output_size;
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
+#define ARM_SMMU_CB_ASID(cfg)		((cfg)->cbndx)
+#define ARM_SMMU_CB_VMID(cfg)		((cfg)->cbndx + 1)
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
+extern int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end);
+extern void __arm_smmu_free_bitmap(unsigned long *map, int idx);
+extern struct arm_smmu_device *find_parent_smmu(struct arm_smmu_device *smmu);
+extern void arm_smmu_flush_pgtable(struct arm_smmu_device *smmu, void *addr,
+				   size_t size);
+extern int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu);
+extern int arm_smmu_device_dt_probe(struct platform_device *pdev);
+extern int arm_smmu_device_remove(struct platform_device *pdev);
+
+extern void arm_smmu_tlb_inv_context(struct arm_smmu_cfg *cfg);
+extern irqreturn_t arm_smmu_context_fault(int irq, void *dev);
+extern irqreturn_t arm_smmu_global_fault(int irq, void *dev);
+extern void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain);
+extern void arm_smmu_destroy_domain_context(struct iommu_domain *domain);
+extern int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
+				      struct arm_smmu_master *master);
+extern void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
+					struct arm_smmu_master *master);
+extern void arm_smmu_device_reset(struct arm_smmu_device *smmu);
+extern int arm_smmu_device_unload(struct arm_smmu_device *smmu);
+extern int __init arm_smmu_ops_init(void);
+#endif
--
1.8.0
