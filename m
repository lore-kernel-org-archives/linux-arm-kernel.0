From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 10 Jul 2014 14:53:05 +0800
Subject: [PATCH v3 12/13] iommu/hisilicon: Add support for Hisilicon Ltd.
 System MMU architecture
In-Reply-To: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
References: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1404975186-12032-13-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some Hisilicon smmu features are list below:
1. StreamID is 16 bits, highest 8 bits is VMID, lowest 8 bits is ASID. StreamID
match is not support, so direct use VMID and ASID to index context bank. First
use VMID to index stage2 context bank, then use ASID to index stage1 context
bank. In fact, max 256 stage2 context banks, each stage2 context bank relate to
256 stage1 context banks.
|-----------------|            |-----------------|
|stage2 CB VMID0  |----------->|stage1 CB ASID0  |
|-----------------|            |-----------------|
|   ......        |            |   ......        |
|-----------------|            |-----------------|
|stage2 CB VMID255|-----|      |stage2 CB ASID255|
|-----------------|     |      |-----------------|
                        |
                        |
                        |
                        |----->|-----------------|
                               |stage1 CB ASID0  |
                               |-----------------|
                               |   ......        |
                               |-----------------|
                               |stage2 CB ASID255|
                               |-----------------|

2. The base address of stage2 context bank is stored in SMMU_CFG_S2CTBAR, and
the base address of stage1 context bank is stored in S2_S1CTBAR(locate in
stage2 context bank).

3. All context bank fault share 8 groups of context fault registers. That is,
max record 8 context faults. Fault syndrome register recorded StreamID to help
software determine which context bank issue fault.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/Kconfig     |  10 +
 drivers/iommu/Makefile    |   1 +
 drivers/iommu/arm-smmu.h  |   2 +
 drivers/iommu/hisi-smmu.c | 575 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 588 insertions(+)
 create mode 100644 drivers/iommu/hisi-smmu.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index fad5e38..716b0ab 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -309,4 +309,14 @@ config ARM_SMMU
 	  Say Y here if your SoC includes an IOMMU device implementing
 	  the ARM SMMU architecture.

+config HISI_SMMU
+	bool "Hisilicon Ltd. System MMU (SMMU) Support"
+	depends on ARM64 || (ARM_LPAE && OF)
+	select IOMMU_API
+	select ARM_SMMU_BASE
+	select ARM_DMA_USE_IOMMU if ARM
+	help
+	  Say Y here if your SoC includes an IOMMU device implementing
+	  the Hisilicon SMMU architecture.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 717cfa3..ef932f2 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU_BASE) += arm-smmu-base.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
+obj-$(CONFIG_HISI_SMMU) += hisi-smmu.o
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += iova.o intel-iommu.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 9847a33..b88b5de 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -151,6 +151,8 @@ struct arm_smmu_device {

 	struct smmu_hwdep_ops		*hwdep_ops;

+	void __iomem			*s1cbt;
+	void __iomem			*s2cbt;
 	void __iomem			*base;
 	u32				size;
 	u32				pagesize;
diff --git a/drivers/iommu/hisi-smmu.c b/drivers/iommu/hisi-smmu.c
new file mode 100644
index 0000000..7191d5c
--- /dev/null
+++ b/drivers/iommu/hisi-smmu.c
@@ -0,0 +1,575 @@
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
+ * Copyright (C) 2014 Hisilicon Limited
+ *
+ * Author: Zhen Lei <thunder.leizhen@huawei.com>
+ *
+ * Hisilicon smmu-v1 implemention
+ *
+ */
+
+#define pr_fmt(fmt) "hisi-smmu: " fmt
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iommu.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/spinlock.h>
+
+#include "arm-smmu.h"
+
+/* Maximum number of context banks per VMID */
+#define HISI_SMMU_MAX_CBS		256
+
+#define SMMU_OS_VMID			0
+#define SMMU_CB_NUMIRPT			8
+#define SMMU_S1CBT_SIZE			0x10000
+#define SMMU_S2CBT_SIZE			0x2000
+#define SMMU_S1CBT_SHIFT		16
+#define SMMU_S2CBT_SHIFT		12
+
+/* SMMU global address space */
+#define SMMU_GR0(smmu)			((smmu)->base)
+
+#define SMMU_CTRL_CR0			0x0
+#define SMMU_CTRL_ACR			0x8
+#define SMMU_CFG_S2CTBAR		0xc
+#define SMMU_IDR0			0x10
+#define SMMU_IDR1			0x14
+#define SMMU_IDR2			0x18
+#define SMMU_HIS_GFAR_LOW		0x20
+#define SMMU_HIS_GFAR_HIGH		0x24
+#define SMMU_RINT_GFSR			0x28
+#define SMMU_RINT_GFSYNR		0x2c
+#define SMMU_CFG_GFIM			0x30
+#define SMMU_CFG_CBF			0x34
+#define SMMU_TLBIALL			0x40
+#define SMMU_TLBIVMID			0x44
+#define SMMU_TLBISID			0x48
+#define SMMU_TLBIVA_LOW			0x4c
+#define SMMU_TLBIVA_HIGH		0x50
+#define SMMU_TLBGSYNC			0x54
+#define SMMU_TLBGSTATUS			0x58
+#define SMMU_CXTIALL			0x60
+#define SMMU_CXTIVMID			0x64
+#define SMMU_CXTISID			0x68
+#define SMMU_CXTGSYNC			0x6c
+#define SMMU_CXTGSTATUS			0x70
+#define SMMU_RINT_CB_FSR(n)		(0x100 + ((n) << 2))
+#define SMMU_RINT_CB_FSYNR(n)		(0x120 + ((n) << 2))
+#define SMMU_HIS_CB_FAR_LOW(n)		(0x140 + ((n) << 3))
+#define SMMU_HIS_CB_FAR_HIGH(n)		(0x144 + ((n) << 3))
+#define SMMU_CTRL_CB_RESUME(n)		(0x180 + ((n) << 2))
+
+#define SMMU_CB_S2CR(n)			(0x0  + ((n) << 5))
+#define SMMU_CB_CBAR(n)			(0x4  + ((n) << 5))
+#define SMMU_CB_S1CTBAR(n)		(0x18 + ((n) << 5))
+
+/* SMMU stage1 context bank and StreamID */
+#define SMMU_CB_BASE(smmu)		((smmu)->s1cbt)
+#define SMMU_CB(smmu, n)		((n) << 5)
+#define SMMU_CB_SID(cfg)		(((u16)SMMU_OS_VMID << 8) | \
+				((cfg)->cbndx))
+
+#define SMMU_S1_MAIR0			0x0
+#define SMMU_S1_MAIR1			0x4
+#define SMMU_S1_TTBR0_L			0x8
+#define SMMU_S1_TTBR0_H			0xc
+#define SMMU_S1_TTBR1_L			0x10
+#define SMMU_S1_TTBR1_H			0x14
+#define SMMU_S1_TTBCR			0x18
+#define SMMU_S1_SCTLR			0x1c
+
+#define CFG_CBF_S1_ORGN_WA		(1 << 12)
+#define CFG_CBF_S1_IRGN_WA		(1 << 10)
+#define CFG_CBF_S1_SHCFG_IS		(3 << 8)
+#define CFG_CBF_S2_ORGN_WA		(1 << 4)
+#define CFG_CBF_S2_IRGN_WA		(1 << 2)
+#define CFG_CBF_S2_SHCFG_IS		(3 << 0)
+
+#if (PAGE_SIZE == SZ_4K)
+#define sACR_WC_EN			(7 << 0)
+#elif (PAGE_SIZE == SZ_64K)
+#define sACR_WC_EN			(3 << 5)
+#else
+#define sACR_WC_EN			0
+#endif
+
+/* Configuration registers */
+#define sCR0_CLIENTPD			(1 << 0)
+#define sCR0_GFRE			(1 << 1)
+#define sCR0_GFIE			(1 << 2)
+#define sCR0_GCFGFRE			(1 << 4)
+#define sCR0_GCFGFIE			(1 << 5)
+
+#define ID0_S1TS			(1 << 30)
+#define ID0_NTS				(1 << 28)
+#define ID0_CTTW			(1 << 14)
+
+#define ID2_IAS_GET(id2)		(((id2) << 0) & 0xff)
+#define ID2_OAS_GET(id2)		(((id2) << 8) & 0xff)
+#define ID2_IPA_SIZE			48
+
+#define CBAR_TYPE_S1_TRANS_S2_BYPASS	(0x1 << 16)
+#define CBAR_S1_BPSHCFG_NSH		(0x3 << 8)
+#define CBAR_S1_MEMATTR_WB		(0xf << 12)
+#define CBAR_MTSH_WEAKEST		(CBAR_S1_BPSHCFG_NSH | \
+				CBAR_S1_MEMATTR_WB)
+
+#define S2CR_TYPE_SHIFT			16
+#define S2CR_TYPE_TRANS			(0 << S2CR_TYPE_SHIFT)
+#define S2CR_TYPE_BYPASS		(1 << S2CR_TYPE_SHIFT)
+#define S2CR_SHCFG_NS			(3 << 8)
+#define S2CR_MTCFG			(1 << 11)
+#define S2CR_MEMATTR_OIWB		(0xf << 12)
+#define S2CR_MTSH_WEAKEST		(S2CR_SHCFG_NS | \
+				S2CR_MTCFG | S2CR_MEMATTR_OIWB)
+
+#define SCTLR_CFCFG			(1 << 7)
+#define SCTLR_CFIE			(1 << 6)
+#define SCTLR_CFRE			(1 << 5)
+#define SCTLR_E				(1 << 4)
+#define SCTLR_AFED			(1 << 3)
+#define SCTLR_M				(1 << 0)
+
+#define sTLBGSTATUS_GSACTIVE		(1 << 0)
+
+#define HISI_TTBCR_TG0_64K		(3 << 14)
+
+#define FSR_MULTI			(1 << 31)
+#define FSR_EF				(1 << 4)
+#define FSR_PF				(1 << 3)
+#define FSR_AFF				(1 << 2)
+#define FSR_TF				(1 << 1)
+#define FSR_IGN				(FSR_AFF)
+#define FSR_FAULT			(FSR_MULTI | FSR_EF | \
+				FSR_PF | FSR_TF | FSR_IGN)
+
+#define FSYNR0_ASID(n)			(0xff & ((n) >> 24))
+#define FSYNR0_VMID(n)			(0xff & ((n) >> 16))
+#define FSYNR0_WNR			(1 << 4)
+#define FSYNR0_SS			(1 << 2)
+#define FSYNR0_CF			(1 << 0)
+
+static int hisi_smmu_alloc_context(struct arm_smmu_device *smmu,
+			int start, int end, struct arm_smmu_master *master)
+{
+	if (!master)
+		return -ENOSPC;
+
+	start = master->streamids[0];
+
+	return __arm_smmu_alloc_bitmap(smmu->context_map, start, start + 1);
+}
+
+static int hisi_smmu_tlb_sync_finished(struct arm_smmu_device *smmu)
+{
+	u32 reg;
+
+	reg = readl_relaxed(SMMU_GR0(smmu) + SMMU_TLBGSTATUS);
+
+	return !(reg & sTLBGSTATUS_GSACTIVE);
+}
+
+static void hisi_smmu_tlb_sync(struct arm_smmu_device *smmu)
+{
+	writel_relaxed(0, SMMU_GR0(smmu) + SMMU_TLBGSYNC);
+	arm_smmu_tlb_sync_wait(smmu);
+}
+
+static void hisi_smmu_tlb_inv_context(struct arm_smmu_cfg *cfg)
+{
+	struct arm_smmu_device *smmu = cfg->smmu;
+
+	writel_relaxed(SMMU_CB_SID(cfg), SMMU_GR0(smmu) + SMMU_CXTISID);
+	hisi_smmu_tlb_sync(smmu);
+}
+
+static irqreturn_t hisi_smmu_context_fault(int irq, void *dev)
+{
+	int i, flags, ret = IRQ_NONE;
+	u32 fsr, far, fsynr, resume;
+	unsigned long iova;
+	struct iommu_domain *domain = dev;
+	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
+	struct arm_smmu_device *smmu = root_cfg->smmu;
+	void __iomem *gr0_base = SMMU_GR0(smmu);
+
+	for (i = 0; i < SMMU_CB_NUMIRPT; i++) {
+		fsynr = readl_relaxed(gr0_base + SMMU_RINT_CB_FSYNR(i));
+
+		if ((fsynr & FSYNR0_CF) &&
+		    (FSYNR0_VMID(fsynr) == SMMU_OS_VMID) &&
+		    (root_cfg->cbndx == FSYNR0_ASID(fsynr)))
+			break;
+	}
+
+	if (i >= SMMU_CB_NUMIRPT)
+		return IRQ_NONE;
+
+	fsr = readl_relaxed(gr0_base + SMMU_RINT_CB_FSR(i));
+	if (fsr & FSR_IGN)
+		dev_err_ratelimited(smmu->dev,
+				    "Unexpected context fault (fsr 0x%u)\n",
+				    fsr);
+
+	flags = fsynr & FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ;
+
+	far = readl_relaxed(gr0_base + SMMU_HIS_CB_FAR_LOW(i));
+	iova = far;
+#ifdef CONFIG_64BIT
+	far = readl_relaxed(gr0_base + SMMU_HIS_CB_FAR_HIGH(i));
+	iova |= ((unsigned long)far << 32);
+#endif
+
+	if (!report_iommu_fault(domain, smmu->dev, iova, flags)) {
+		ret = IRQ_HANDLED;
+		resume = RESUME_RETRY;
+	} else {
+		dev_err_ratelimited(smmu->dev,
+		    "Unhandled context fault: iova=0x%08lx, fsynr=0x%x, cb=%d\n",
+		    iova, fsynr, root_cfg->cbndx);
+		ret = IRQ_NONE;
+		resume = RESUME_TERMINATE;
+	}
+
+	/* Clear the faulting FSR */
+	writel(fsr, gr0_base + SMMU_RINT_CB_FSR(i));
+
+	/* Retry or terminate any stalled transactions */
+	if (fsynr & FSYNR0_SS)
+		writel_relaxed(resume, gr0_base + SMMU_CTRL_CB_RESUME(i));
+
+	return ret;
+}
+
+static irqreturn_t hisi_smmu_global_fault(int irq, void *dev)
+{
+	u32 gfsr, gfsynr0;
+	struct arm_smmu_device *smmu = dev;
+	void __iomem *gr0_base = SMMU_GR0(smmu);
+
+	gfsr = readl_relaxed(gr0_base + SMMU_RINT_GFSR);
+	if (!gfsr)
+		return IRQ_NONE;
+
+	gfsynr0 = readl_relaxed(gr0_base + SMMU_RINT_GFSYNR);
+
+	dev_err_ratelimited(smmu->dev,
+		"Unexpected global fault, this could be serious\n");
+	dev_err_ratelimited(smmu->dev,
+		"\tGFSR 0x%08x, GFSYNR0 0x%08x\n", gfsr, gfsynr0);
+
+	writel(gfsr, gr0_base + SMMU_RINT_GFSR);
+	return IRQ_HANDLED;
+}
+
+static void hisi_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
+{
+	u32 reg;
+	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
+	struct arm_smmu_device *smmu = root_cfg->smmu;
+	void __iomem *cb_base;
+
+	cb_base = SMMU_CB_BASE(smmu) + SMMU_CB(smmu, root_cfg->cbndx);
+
+	/* TTBR0 */
+	arm_smmu_flush_pgtable(smmu, root_cfg->pgd,
+					PTRS_PER_PGD * sizeof(pgd_t));
+	reg = __pa(root_cfg->pgd);
+	writel_relaxed(reg, cb_base + SMMU_S1_TTBR0_L);
+	reg = (phys_addr_t)__pa(root_cfg->pgd) >> 32;
+	writel_relaxed(reg, cb_base + SMMU_S1_TTBR0_H);
+
+	/*
+	 * TTBCR
+	 * We use long descriptor, with inner-shareable WBWA tables in TTBR0.
+	 */
+	if (PAGE_SIZE == SZ_4K)
+		reg = TTBCR_TG0_4K;
+	else
+		reg = HISI_TTBCR_TG0_64K;
+
+	reg |= (64 - smmu->s1_output_size) << TTBCR_T0SZ_SHIFT;
+
+	reg |= (TTBCR_SH_IS << TTBCR_SH0_SHIFT) |
+	       (TTBCR_RGN_WBWA << TTBCR_ORGN0_SHIFT) |
+	       (TTBCR_RGN_WBWA << TTBCR_IRGN0_SHIFT);
+	writel_relaxed(reg, cb_base + SMMU_S1_TTBCR);
+
+	reg = MAIR0_STAGE1;
+	writel_relaxed(reg, cb_base + SMMU_S1_MAIR0);
+
+	/* SCTLR */
+	reg = SCTLR_CFCFG | SCTLR_CFIE | SCTLR_CFRE | SCTLR_M | SCTLR_AFED;
+#ifdef __BIG_ENDIAN
+	reg |= SCTLR_E;
+#endif
+	writel_relaxed(reg, cb_base + SMMU_S1_SCTLR);
+}
+
+static void hisi_smmu_destroy_context_bank(struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
+	struct arm_smmu_device *smmu = root_cfg->smmu;
+	void __iomem *cb_base;
+
+	/* Disable the context bank and nuke the TLB before freeing it. */
+	cb_base = SMMU_CB_BASE(smmu) + SMMU_CB(smmu, root_cfg->cbndx);
+	writel_relaxed(0, cb_base + SMMU_S1_SCTLR);
+	hisi_smmu_tlb_inv_context(root_cfg);
+}
+
+static int hisi_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
+				      struct arm_smmu_master *master)
+{
+	if (SMMU_CB_SID(&smmu_domain->root_cfg) != master->streamids[0]) {
+		dev_err(smmu_domain->leaf_smmu->dev, "Too many sid attached\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void hisi_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
+					  struct arm_smmu_master *master)
+{
+}
+
+static int hisi_smmu_device_reset(struct arm_smmu_device *smmu)
+{
+	void __iomem *gr0_base = SMMU_GR0(smmu);
+	void __iomem *cb_base;
+	struct page  *cbt_page;
+	int i = 0;
+	u32 reg;
+
+	/* Clear Global FSR */
+	reg = readl_relaxed(gr0_base + SMMU_RINT_GFSR);
+	writel(reg, gr0_base + SMMU_RINT_GFSR);
+
+	/* unmask all global interrupt */
+	writel_relaxed(0, gr0_base + SMMU_CFG_GFIM);
+
+	reg  = CFG_CBF_S1_ORGN_WA | CFG_CBF_S1_IRGN_WA | CFG_CBF_S1_SHCFG_IS;
+	reg |= CFG_CBF_S2_ORGN_WA | CFG_CBF_S2_IRGN_WA | CFG_CBF_S2_SHCFG_IS;
+	writel_relaxed(reg, gr0_base + SMMU_CFG_CBF);
+
+	/* stage 2 context banks table */
+	reg = readl_relaxed(gr0_base + SMMU_CFG_S2CTBAR);
+	if (!reg) {
+		cbt_page = alloc_pages(GFP_DMA32, get_order(SMMU_S2CBT_SIZE));
+		if (!cbt_page) {
+			pr_err("Failed to allocate stage2 CB table\n");
+			return -ENOMEM;
+		}
+
+		reg = (u32)(page_to_phys(cbt_page) >> SMMU_S2CBT_SHIFT);
+		writel_relaxed(reg, gr0_base + SMMU_CFG_S2CTBAR);
+		smmu->s2cbt = page_address(cbt_page);
+
+		for (i = 0; i < HISI_SMMU_MAX_CBS; i++) {
+			writel_relaxed(0, smmu->s2cbt + SMMU_CB_S1CTBAR(i));
+			writel_relaxed(S2CR_TYPE_BYPASS,
+						smmu->s2cbt + SMMU_CB_S2CR(i));
+		}
+
+		/* Invalidate all TLB */
+		writel_relaxed(0, gr0_base + SMMU_TLBIALL);
+		hisi_smmu_tlb_sync(smmu);
+	} else {
+		smmu->s2cbt = ioremap_cache(
+			(phys_addr_t)reg << SMMU_S2CBT_SHIFT, SMMU_S2CBT_SIZE);
+	}
+
+	/* stage 1 context banks table */
+	cbt_page = alloc_pages(GFP_DMA32, get_order(SMMU_S1CBT_SIZE));
+	if (!cbt_page) {
+		pr_err("Failed to allocate stage1 CB table\n");
+		return -ENOMEM;
+	}
+
+	reg = (u32)(page_to_phys(cbt_page) >> SMMU_S1CBT_SHIFT);
+	writel_relaxed(reg, smmu->s2cbt + SMMU_CB_S1CTBAR(SMMU_OS_VMID));
+	smmu->s1cbt = page_address(cbt_page);
+
+	/* Make sure all context banks are disabled */
+	for (i = 0; i < smmu->num_context_banks; i++) {
+		cb_base = SMMU_CB_BASE(smmu) + SMMU_CB(smmu, i);
+
+		writel_relaxed(0, cb_base + SMMU_S1_SCTLR);
+	}
+
+	/* Clear CB_FSR  */
+	for (i = 0; i < SMMU_CB_NUMIRPT; i++)
+		writel_relaxed(FSR_FAULT, gr0_base + SMMU_RINT_CB_FSR(i));
+
+	/*
+	 * Use the weakest attribute, so no impact stage 1 output attribute.
+	 */
+	reg = CBAR_TYPE_S1_TRANS_S2_BYPASS | CBAR_MTSH_WEAKEST;
+	writel_relaxed(reg, smmu->s2cbt + SMMU_CB_CBAR(SMMU_OS_VMID));
+
+	/* Bypass need use another S2CR */
+	reg = S2CR_TYPE_BYPASS | S2CR_MTSH_WEAKEST;
+	writel_relaxed(reg, smmu->s2cbt + SMMU_CB_S2CR(0xff));
+
+	/* Mark S2CR as translation */
+	reg = S2CR_TYPE_TRANS | S2CR_MTSH_WEAKEST;
+	writel_relaxed(reg, smmu->s2cbt + SMMU_CB_S2CR(SMMU_OS_VMID));
+
+	/* Invalidate host OS TLB */
+	writel_relaxed(SMMU_OS_VMID, gr0_base + SMMU_TLBIVMID);
+	hisi_smmu_tlb_sync(smmu);
+
+	writel_relaxed(sACR_WC_EN, gr0_base + SMMU_CTRL_ACR);
+
+	/* Enable fault report */
+	reg = readl_relaxed(SMMU_GR0(smmu) + SMMU_CTRL_CR0);
+	reg |= (sCR0_GFRE | sCR0_GFIE | sCR0_GCFGFRE | sCR0_GCFGFIE);
+	reg &= ~sCR0_CLIENTPD;
+
+	writel_relaxed(reg, gr0_base + SMMU_CTRL_CR0);
+
+	return 0;
+}
+
+static u32 hisi_smmu_id_size_to_bits(u32 size)
+{
+	int i;
+
+	for (i = 7; i >= 0; i--)
+		if ((size >> i) & 0x1)
+			break;
+
+	return 32 + 4 * (i + 1);
+}
+
+static int hisi_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
+{
+	void __iomem *gr0_base = SMMU_GR0(smmu);
+	u32 id;
+
+	dev_notice(smmu->dev, "probing hisi-smmu hardware configuration...\n");
+
+	smmu->version = 1;
+
+	/* ID0 */
+	id = readl_relaxed(gr0_base + SMMU_IDR0);
+
+	if (id & ID0_NTS) {
+		smmu->features |= ARM_SMMU_FEAT_TRANS_NESTED;
+		smmu->features |= ARM_SMMU_FEAT_TRANS_S1;
+		smmu->features |= ARM_SMMU_FEAT_TRANS_S2;
+		dev_notice(smmu->dev, "\tnested translation\n");
+	} else if (id & ID0_S1TS) {
+		smmu->features |= ARM_SMMU_FEAT_TRANS_S1;
+		dev_notice(smmu->dev, "\tstage 1 translation\n");
+	}
+
+	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1)) {
+		dev_err(smmu->dev, "\tstage 1 translation not support!\n");
+		return -ENODEV;
+	}
+
+	if (id & ID0_CTTW) {
+		smmu->features |= ARM_SMMU_FEAT_COHERENT_WALK;
+		dev_notice(smmu->dev, "\tcoherent table walk\n");
+	}
+
+	smmu->num_context_banks = HISI_SMMU_MAX_CBS;
+
+	/* ID2 */
+	id = readl_relaxed(gr0_base + SMMU_IDR2);
+	smmu->input_size = hisi_smmu_id_size_to_bits(ID2_IAS_GET(id));
+	smmu->s1_output_size = ID2_IPA_SIZE;
+	smmu->s2_output_size = hisi_smmu_id_size_to_bits(ID2_OAS_GET(id));
+
+	return 0;
+}
+
+static int hisi_smmu_device_remove(struct arm_smmu_device *smmu)
+{
+	u32 reg;
+
+	/*
+	 * Here, we only free s1cbt.
+	 * The s2cbt may be shared with hypervisor or other smmu devices.
+	 */
+	free_pages((unsigned long)smmu->s1cbt, get_order(SMMU_S1CBT_SIZE));
+
+	/* Disable fault report */
+	reg = readl_relaxed(SMMU_GR0(smmu) + SMMU_CTRL_CR0);
+	reg &= ~(sCR0_GFRE | sCR0_GFIE | sCR0_GCFGFRE | sCR0_GCFGFIE);
+	reg |= sCR0_CLIENTPD;
+	writel(reg, SMMU_GR0(smmu) + SMMU_CTRL_CR0);
+
+	return 0;
+}
+
+static struct smmu_hwdep_ops hisi_smmu_hwdep_ops = {
+	.alloc_context		= hisi_smmu_alloc_context,
+	.tlb_sync_finished	= hisi_smmu_tlb_sync_finished,
+	.tlb_inv_context	= hisi_smmu_tlb_inv_context,
+	.context_fault		= hisi_smmu_context_fault,
+	.global_fault		= hisi_smmu_global_fault,
+	.init_context_bank	= hisi_smmu_init_context_bank,
+	.destroy_context_bank	= hisi_smmu_destroy_context_bank,
+	.domain_add_master	= hisi_smmu_domain_add_master,
+	.domain_remove_master	= hisi_smmu_domain_remove_master,
+	.device_reset		= hisi_smmu_device_reset,
+	.device_cfg_probe	= hisi_smmu_device_cfg_probe,
+	.device_remove		= hisi_smmu_device_remove,
+};
+
+#ifdef CONFIG_OF
+static struct of_device_id hisi_smmu_of_match[] = {
+	{ .compatible = "hisilicon,smmu-v1", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, hisi_smmu_of_match);
+#endif
+
+static int arm_smmu_device_probe(struct platform_device *pdev)
+{
+	return arm_smmu_device_dt_probe(pdev, &hisi_smmu_hwdep_ops);
+}
+
+static struct platform_driver hisi_smmu_driver = {
+	.driver	= {
+		.owner		= THIS_MODULE,
+		.name		= "hisi-smmu",
+		.of_match_table	= of_match_ptr(hisi_smmu_of_match),
+	},
+	.probe	= arm_smmu_device_probe,
+	.remove	= arm_smmu_device_remove,
+};
+
+static int __init hisi_smmu_init(void)
+{
+	return platform_driver_register(&hisi_smmu_driver);
+}
+
+static void __exit hisi_smmu_exit(void)
+{
+	return platform_driver_unregister(&hisi_smmu_driver);
+}
+
+subsys_initcall(hisi_smmu_init);
+module_exit(hisi_smmu_exit);
+
+MODULE_DESCRIPTION("IOMMU API for Hisilicon architected SMMU implementations");
+MODULE_AUTHOR("Zhen Lei <thunder.leizhen@huawei.com>");
+MODULE_LICENSE("GPL v2");
--
1.8.0
