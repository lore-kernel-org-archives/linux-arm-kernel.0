From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 12 Jun 2014 13:08:11 +0800
Subject: [PATCH RFC v2 2/3] iommu/hisilicon: Add support for Hisilicon Ltd.
 System MMU architecture
In-Reply-To: <1402549692-5224-1-git-send-email-thunder.leizhen@huawei.com>
References: <1402549692-5224-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1402549692-5224-3-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is the major hardware difference compare to arm-smmu specification:
1. Only have global register space 0, no GR1. Actually, some context bank
registers have been moved into GR0 to optimize hardware logic.

2. StreamID is 16 bits, highest 8 bits is VMID, lowest 8 bits is ASID. StreamID
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

3. The base address of stage2 context bank is stored in SMMU_CFG_S2CTBAR, and
the base address of stage1 context bank is stored in S2_S1CTBAR(locate in
stage2 context bank).

4. All context bank fault share 8 groups of context fault registers. That is,
max record 8 context faults. Fault syndrome register recorded StreamID to help
software determine which context bank issue fault.

5. When choose stage1 translation and stage2 bypass mode, the register sequence
impact output attribute is: S1_SCTLR, CBAR, S2CR(for arm-smmu, process S2CR
first). This issue a problem, because total 256 stage1 CBs share a stage2 CB
when VMID=0. If some devices use bypass mode(use device built-in attributes),
and some devices use map mode(use page table entry specified attributes), smmu
can not work properly. The avoidance scheme is occupy another stage2 CB(S2CR)
to support bypass mode.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/Kconfig     |   7 +
 drivers/iommu/Makefile    |   1 +
 drivers/iommu/arm-smmu.c  |   4 +
 drivers/iommu/arm-smmu.h  |  11 +
 drivers/iommu/hisi-smmu.c | 662 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 685 insertions(+)
 create mode 100644 drivers/iommu/hisi-smmu.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d260605..ef4e851 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -305,4 +305,11 @@ config ARM_SMMU
 	  Say Y here if your SoC includes an IOMMU device implementing
 	  the ARM SMMU architecture.

+config HISI_SMMU
+	bool "Hisilicon Ltd. System MMU (SMMU) Support"
+	depends on ARM_SMMU
+	help
+	  Say Y here if your SoC includes an IOMMU device implementing
+	  the Hisilicon SMMU architecture.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 8893bad..e06e36e 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o msm_iommu_dev.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
+obj-$(CONFIG_HISI_SMMU) += hisi-smmu.o
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += iova.o intel-iommu.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 413a1f2..c952d72 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -968,6 +968,9 @@ static void arm_smmu_domain_destroy(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = domain->priv;

+	if (smmu_domain->num_of_masters)
+		dev_err(smmu_domain->leaf_smmu->dev, "destroy domain with active dev!\n");
+
 	/*
 	 * Free the domain resources. We assume that all devices have
 	 * already been detached.
@@ -1972,6 +1975,7 @@ static struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v2", },
 	{ .compatible = "arm,mmu-400", },
 	{ .compatible = "arm,mmu-500", },
+	{ .compatible = "hisilicon,smmu-v1", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 79366ee..2941b39 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -24,8 +24,12 @@
 /* Maximum number of stream IDs assigned to a single device */
 #define MAX_MASTER_STREAMIDS		MAX_PHANDLE_ARGS

+#ifdef CONFIG_HISI_SMMU
+#define ARM_SMMU_MAX_CBS		256
+#else
 /* Maximum number of context banks per SMMU */
 #define ARM_SMMU_MAX_CBS		128
+#endif

 /* Maximum number of mapping groups per SMMU */
 #define ARM_SMMU_MAX_SMRS		128
@@ -58,6 +62,12 @@ struct arm_smmu_device {
 	struct device			*dev;
 	struct device_node		*parent_of_node;

+#ifdef CONFIG_HISI_SMMU
+	void __iomem			*s1cbt;
+	void __iomem			*s2cbt;
+	u8				cb_mtcfg[ARM_SMMU_MAX_CBS];
+#endif
+
 	void __iomem			*base;
 	unsigned long			size;
 	unsigned long			pagesize;
@@ -113,6 +123,7 @@ struct arm_smmu_domain {
 	phys_addr_t			output_mask;

 	spinlock_t			lock;
+	int				num_of_masters;
 };

 /**
diff --git a/drivers/iommu/hisi-smmu.c b/drivers/iommu/hisi-smmu.c
new file mode 100644
index 0000000..5a2035e
--- /dev/null
+++ b/drivers/iommu/hisi-smmu.c
@@ -0,0 +1,662 @@
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
+ * Hisilicon smmu-v1 hardware dependent implemention, a arm smmu variant
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
+#include <linux/of.h>
+#include <linux/spinlock.h>
+
+#include "arm-smmu.h"
+
+/* SMMU global address space */
+#define SMMU_GR0(smmu)			((smmu)->base)
+
+#define SMMU_OS_VMID			0
+#define SMMU_CB_NUMIRPT			8
+#define SMMU_S1CBT_SIZE			0x10000
+#define SMMU_S2CBT_SIZE			0x2000
+#define SMMU_S1CBT_SHIFT		16
+#define SMMU_S2CBT_SHIFT		12
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
+#define SMMU_HIS_CB_FAR_LOW(n)		(0x140 + ((n) << 2))
+#define SMMU_HIS_CB_FAR_HIGH(n)		(0x144 + ((n) << 2))
+#define SMMU_CTRL_CB_RESUME(n)		(0x180 + ((n) << 2))
+
+#define SMMU_CB_S2CR(n)			(0x0  + ((n) << 5))
+#define SMMU_CB_CBAR(n)			(0x4  + ((n) << 5))
+#define SMMU_CB_S1CTBAR(n)		(0x18 + ((n) << 5))
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
+/* Configuration registers */
+#define sCR0_CLIENTPD			(1 << 0)
+#define sCR0_GFRE			(1 << 1)
+#define sCR0_GFIE			(1 << 2)
+#define sCR0_GCFGFRE			(1 << 4)
+#define sCR0_GCFGFIE			(1 << 5)
+
+#if (PAGE_SIZE == SZ_4K)
+#define sACR_WC_EN			(7 << 0)
+#elif (PAGE_SIZE == SZ_64K)
+#define sACR_WC_EN			(3 << 5)
+#else
+#define sACR_WC_EN			0
+#endif
+
+#define ID0_S1TS			(1 << 30)
+#define ID0_S2TS			(1 << 29)
+#define ID0_NTS				(1 << 28)
+#define ID0_PTFS_SHIFT			24
+#define ID0_PTFS_MASK			0x2
+#define ID0_PTFS_V8_ONLY		0x2
+#define ID0_CTTW			(1 << 14)
+
+#define ID2_OAS_SHIFT			8
+#define ID2_OAS_MASK			0xff
+#define ID2_IAS_SHIFT			0
+#define ID2_IAS_MASK			0xff
+
+#define S2CR_TYPE_SHIFT			16
+#define S2CR_TYPE_MASK			0x3
+#define S2CR_TYPE_TRANS			(0 << S2CR_TYPE_SHIFT)
+#define S2CR_TYPE_BYPASS		(1 << S2CR_TYPE_SHIFT)
+#define S2CR_TYPE_FAULT			(2 << S2CR_TYPE_SHIFT)
+#define S2CR_SHCFG_NS			(3 << 8)
+#define S2CR_MTCFG			(1 << 11)
+#define S2CR_MEMATTR_OIWB		(0xf << 12)
+#define S2CR_MTSH_WEAKEST		(S2CR_SHCFG_NS | \
+				S2CR_MTCFG | S2CR_MEMATTR_OIWB)
+
+/* Context bank attribute registers */
+#define CBAR_VMID_SHIFT			0
+#define CBAR_VMID_MASK			0xff
+#define CBAR_S1_BPSHCFG_SHIFT		8
+#define CBAR_S1_BPSHCFG_MASK		3
+#define CBAR_S1_BPSHCFG_NSH		3
+#define CBAR_S1_MEMATTR_SHIFT		12
+#define CBAR_S1_MEMATTR_MASK		0xf
+#define CBAR_S1_MEMATTR_WB		0xf
+#define CBAR_TYPE_SHIFT			16
+#define CBAR_TYPE_MASK			0x3
+#define CBAR_TYPE_S2_TRANS		(0 << CBAR_TYPE_SHIFT)
+#define CBAR_TYPE_S1_TRANS_S2_BYPASS	(1 << CBAR_TYPE_SHIFT)
+#define CBAR_TYPE_S1_TRANS_S2_FAULT	(2 << CBAR_TYPE_SHIFT)
+#define CBAR_TYPE_S1_TRANS_S2_TRANS	(3 << CBAR_TYPE_SHIFT)
+#define CBAR_IRPTNDX_SHIFT		24
+#define CBAR_IRPTNDX_MASK		0xff
+
+#define SMMU_CB_BASE(smmu)	((smmu)->s1cbt)
+#define SMMU_CB(smmu, n)	((n) << 5)
+#define SMMU_CB_SID(cfg)	(((u16)SMMU_OS_VMID << 8) | ((cfg)->cbndx))
+
+#define sTLBGSTATUS_GSACTIVE	(1 << 0)
+#define TLB_LOOP_TIMEOUT	1000000	/* 1s! */
+
+#define SCTLR_WACFG_WA		(2 << 26)
+#define SCTLR_RACFG_RA		(2 << 24)
+#define SCTLR_SHCFG_IS		(2 << 22)
+#define SCTLR_MTCFG		(1 << 20)
+#define SCTLR_MEMATTR_WB	(0xf << 16)
+#define SCTLR_MEMATTR_NC	(0x5 << 16)
+#define SCTLR_MEMATTR_NGNRE	(0x1 << 16)
+#define SCTLR_CACHE_WBRAWA	(SCTLR_WACFG_WA | SCTLR_RACFG_RA | \
+			SCTLR_SHCFG_IS | SCTLR_MTCFG | SCTLR_MEMATTR_WB)
+#define SCTLR_CACHE_NC		(SCTLR_SHCFG_IS | \
+			SCTLR_MTCFG | SCTLR_MEMATTR_NC)
+#define SCTLR_CACHE_NGNRE	(SCTLR_SHCFG_IS | \
+			SCTLR_MTCFG | SCTLR_MEMATTR_NGNRE)
+
+#define SCTLR_CFCFG			(1 << 7)
+#define SCTLR_CFIE			(1 << 6)
+#define SCTLR_CFRE			(1 << 5)
+#define SCTLR_E				(1 << 4)
+#define SCTLR_AFED			(1 << 3)
+#define SCTLR_M				(1 << 0)
+#define SCTLR_EAE_SBOP			(SCTLR_AFED)
+
+#define RESUME_RETRY			(0 << 0)
+#define RESUME_TERMINATE		(1 << 0)
+
+#define TTBCR_TG0_4K			(0 << 14)
+#define TTBCR_TG0_64K			(3 << 14)
+
+#define TTBCR_SH0_SHIFT			12
+#define TTBCR_SH0_MASK			0x3
+#define TTBCR_SH_NS			0
+#define TTBCR_SH_OS			2
+#define TTBCR_SH_IS			3
+#define TTBCR_ORGN0_SHIFT		10
+#define TTBCR_IRGN0_SHIFT		8
+#define TTBCR_RGN_MASK			0x3
+#define TTBCR_RGN_NC			0
+#define TTBCR_RGN_WBWA			1
+#define TTBCR_RGN_WT			2
+#define TTBCR_RGN_WB			3
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
+#define FSR_MULTI		(1 << 31)
+#define FSR_EF			(1 << 4)
+#define FSR_PF			(1 << 3)
+#define FSR_AFF			(1 << 2)
+#define FSR_TF			(1 << 1)
+#define FSR_IGN			(FSR_AFF)
+#define FSR_FAULT		(FSR_MULTI | FSR_EF | FSR_PF | FSR_TF | FSR_IGN)
+
+#define FSYNR0_ASID(n)			(0xff & ((n) >> 24))
+#define FSYNR0_VMID(n)			(0xff & ((n) >> 16))
+#define FSYNR0_WNR			(1 << 4)
+#define FSYNR0_SS			(1 << 2)
+#define FSYNR0_CF			(1 << 0)
+
+
+static u32 hisi_bypass_vmid = 0xff;
+static struct arm_smmu_hwdep_ops smmu_hwdep_ops_bak;
+
+
+static int hisi_smmu_alloc_context(struct arm_smmu_device *smmu,
+			int start, int end, struct arm_smmu_master *master)
+{
+	if (master)
+		start = master->streamids[0];
+
+	if (smmu->cb_mtcfg[start])
+		return -ENOSPC;
+
+	return smmu_hwdep_ops_bak.alloc_context(smmu, start, end, master);
+}
+
+static void hisi_smmu_tlb_sync(struct arm_smmu_device *smmu)
+{
+	int count = 0;
+	void __iomem *gr0_base = SMMU_GR0(smmu);
+
+	writel_relaxed(0, gr0_base + SMMU_TLBGSYNC);
+	while (readl_relaxed(gr0_base + SMMU_TLBGSTATUS)
+	       & sTLBGSTATUS_GSACTIVE) {
+		cpu_relax();
+		if (++count == TLB_LOOP_TIMEOUT) {
+			dev_err_ratelimited(smmu->dev,
+			"TLB sync timed out -- SMMU may be deadlocked\n");
+			return;
+		}
+		udelay(1);
+	}
+}
+
+static void hisi_smmu_tlb_inv_context(struct arm_smmu_cfg *cfg)
+{
+	struct arm_smmu_device *smmu = cfg->smmu;
+
+	writel_relaxed(SMMU_CB_SID(cfg), SMMU_GR0(smmu) + SMMU_CXTISID);
+
+	hisi_smmu_tlb_sync(smmu);
+}
+
+static irqreturn_t hisi_smmu_context_fault(int irq, void *dev)
+{
+	int i, flags, ret = IRQ_NONE, num_unhandled = 0;
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
+		if (!(fsynr & FSYNR0_CF) ||
+		    (FSYNR0_VMID(fsynr) != SMMU_OS_VMID) ||
+		    (root_cfg->cbndx != FSYNR0_ASID(fsynr)))
+			continue;
+
+		fsr = readl_relaxed(gr0_base + SMMU_RINT_CB_FSR(i));
+		if (fsr & FSR_IGN)
+			dev_err_ratelimited(smmu->dev,
+					    "Unexpected context fault (fsr 0x%u)\n",
+					    fsr);
+
+		flags = fsynr & FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ;
+
+		far = readl_relaxed(gr0_base + SMMU_HIS_CB_FAR_LOW(i));
+		iova = far;
+#ifdef CONFIG_64BIT
+		far = readl_relaxed(gr0_base + SMMU_HIS_CB_FAR_HIGH(i));
+		iova |= ((unsigned long)far << 32);
+#endif
+
+		if (!report_iommu_fault(domain, smmu->dev, iova, flags)) {
+			ret = IRQ_HANDLED;
+			resume = RESUME_RETRY;
+		} else {
+			dev_err_ratelimited(smmu->dev,
+			    "Unhandled context fault: iova=0x%08lx, fsynr=0x%x, cb=%d\n",
+			    iova, fsynr, FSYNR0_ASID(fsynr));
+			num_unhandled++;
+			resume = RESUME_TERMINATE;
+		}
+
+		/* Clear the faulting FSR */
+		writel(fsr, gr0_base + SMMU_RINT_CB_FSR(i));
+
+		/* Retry or terminate any stalled transactions */
+		if (fsynr & FSYNR0_SS)
+			writel_relaxed(resume, gr0_base + SMMU_CTRL_CB_RESUME(i));
+	}
+
+	/*
+	 * If any fault unhandled, treat IRQ_NONE, although some maybe handled.
+	 */
+	if (num_unhandled)
+		ret = IRQ_NONE;
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
+	smmu_hwdep_ops_bak.flush_pgtable(smmu, root_cfg->pgd,
+			       PTRS_PER_PGD * sizeof(pgd_t));
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
+		reg = TTBCR_TG0_64K;
+
+	reg |= (64 - smmu->s1_output_size) << TTBCR_T0SZ_SHIFT;
+
+	reg |= (TTBCR_SH_IS << TTBCR_SH0_SHIFT) |
+	       (TTBCR_RGN_WBWA << TTBCR_ORGN0_SHIFT) |
+	       (TTBCR_RGN_WBWA << TTBCR_IRGN0_SHIFT);
+	writel_relaxed(reg, cb_base + SMMU_S1_TTBCR);
+
+	reg = (MAIR_ATTR_NC << MAIR_ATTR_SHIFT(MAIR_ATTR_IDX_NC)) |
+	      (MAIR_ATTR_WBRWA << MAIR_ATTR_SHIFT(MAIR_ATTR_IDX_CACHE)) |
+	      (MAIR_ATTR_DEVICE << MAIR_ATTR_SHIFT(MAIR_ATTR_IDX_DEV));
+	writel_relaxed(reg, cb_base + SMMU_S1_MAIR0);
+
+	/* SCTLR */
+	reg = SCTLR_CFCFG | SCTLR_CFIE | SCTLR_CFRE | SCTLR_M | SCTLR_EAE_SBOP;
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
+	unsigned long flags;
+
+	if (SMMU_CB_SID(&smmu_domain->root_cfg) != master->streamids[0]) {
+		dev_err(smmu_domain->leaf_smmu->dev, "Too many sid attached\n");
+		return -ENODEV;
+	}
+
+	spin_lock_irqsave(&smmu_domain->lock, flags);
+	smmu_domain->num_of_masters++;
+	spin_unlock_irqrestore(&smmu_domain->lock, flags);
+
+	return 0;
+}
+
+static void hisi_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
+					  struct arm_smmu_master *master)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&smmu_domain->lock, flags);
+	smmu_domain->num_of_masters--;
+	spin_unlock_irqrestore(&smmu_domain->lock, flags);
+}
+
+static int hisi_smmu_device_reset(struct arm_smmu_device *smmu)
+{
+	void __iomem *gr0_base = SMMU_GR0(smmu);
+	void __iomem *cb_base;
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
+	/* stage 2 context bank table */
+	reg = readl_relaxed(gr0_base + SMMU_CFG_S2CTBAR);
+	smmu->s2cbt = devm_ioremap(smmu->dev,
+			(phys_addr_t)reg << SMMU_S2CBT_SHIFT, SMMU_S2CBT_SIZE);
+	if (!smmu->s2cbt) {
+		pr_err("Failed to ioremap SnCB table\n");
+		return -ENOMEM;
+	}
+
+	/* stage 1 context bank table */
+	reg = readl_relaxed(smmu->s2cbt + SMMU_CB_S1CTBAR(SMMU_OS_VMID));
+	smmu->s1cbt = devm_ioremap(smmu->dev,
+			(phys_addr_t)reg << SMMU_S1CBT_SHIFT, SMMU_S1CBT_SIZE);
+	if (!smmu->s1cbt) {
+		pr_err("Failed to ioremap SnCB table\n");
+		return -ENOMEM;
+	}
+
+	/* Make sure all context banks are disabled */
+	for (i = 0; i < smmu->num_context_banks; i++) {
+		cb_base = SMMU_CB_BASE(smmu) + SMMU_CB(smmu, i);
+
+		switch (smmu->cb_mtcfg[i]) {
+		case 1:
+			reg = SCTLR_CACHE_WBRAWA;
+			break;
+		case 2:
+			reg = SCTLR_CACHE_NC;
+			break;
+		case 3:
+			reg = SCTLR_CACHE_NGNRE;
+			break;
+		default:
+			reg = 0;
+			break;
+		}
+
+		writel_relaxed(reg, cb_base + SMMU_S1_SCTLR);
+	}
+
+	/* Clear CB_FSR  */
+	for (i = 0; i < SMMU_CB_NUMIRPT; i++)
+		writel_relaxed(FSR_FAULT, gr0_base + SMMU_RINT_CB_FSR(i));
+
+	/*
+	 * Use the weakest attribute, so no impact stage 1 output attribute.
+	 */
+	reg = CBAR_TYPE_S1_TRANS_S2_BYPASS |
+		(CBAR_S1_BPSHCFG_NSH << CBAR_S1_BPSHCFG_SHIFT) |
+		(CBAR_S1_MEMATTR_WB << CBAR_S1_MEMATTR_SHIFT);
+	writel_relaxed(reg, smmu->s2cbt + SMMU_CB_CBAR(SMMU_OS_VMID));
+
+	/* Bypass need use another S2CR */
+	reg = S2CR_TYPE_BYPASS | S2CR_MTSH_WEAKEST;
+	writel_relaxed(reg, smmu->s2cbt + SMMU_CB_S2CR(hisi_bypass_vmid));
+
+	/* Mark S2CR as translation */
+	reg = S2CR_TYPE_TRANS | S2CR_MTSH_WEAKEST;
+	writel_relaxed(reg, smmu->s2cbt + SMMU_CB_S2CR(SMMU_OS_VMID));
+
+	/* Invalidate the TLB, just in case */
+	writel_relaxed(SMMU_OS_VMID, gr0_base + SMMU_TLBIVMID);
+	hisi_smmu_tlb_sync(smmu);
+
+	writel_relaxed(sACR_WC_EN, gr0_base + SMMU_CTRL_ACR);
+
+	/* Enable fault reporting */
+	reg  = (sCR0_GFRE | sCR0_GFIE | sCR0_GCFGFRE | sCR0_GCFGFIE);
+	reg &= ~sCR0_CLIENTPD;
+
+	writel_relaxed(reg, gr0_base + SMMU_CTRL_CR0);
+	dsb();
+
+	return 0;
+}
+
+static int hisi_smmu_id_size_to_bits(unsigned long size)
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
+	unsigned long size;
+	void __iomem *gr0_base = SMMU_GR0(smmu);
+	u32 id;
+
+	dev_notice(smmu->dev, "probing hardware configuration...\n");
+
+	smmu->version = 1;
+
+	/* ID0 */
+	id = readl_relaxed(gr0_base + SMMU_IDR0);
+#ifndef CONFIG_64BIT
+	if (((id >> ID0_PTFS_SHIFT) & ID0_PTFS_MASK) == ID0_PTFS_V8_ONLY) {
+		dev_err(smmu->dev, "\tno v7 descriptor support!\n");
+		return -ENODEV;
+	}
+#endif
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
+	smmu->num_context_banks = ARM_SMMU_MAX_CBS;
+
+	/* ID2 */
+	id = readl_relaxed(gr0_base + SMMU_IDR2);
+	size = hisi_smmu_id_size_to_bits((id >> ID2_IAS_SHIFT) & ID2_IAS_MASK);
+
+	smmu->input_size = min_t(unsigned long, VA_BITS, size);
+
+	/* The stage-2 output mask is also applied for bypass */
+	size = hisi_smmu_id_size_to_bits((id >> ID2_OAS_SHIFT) & ID2_OAS_MASK);
+	smmu->s2_output_size = min_t(unsigned long, PHYS_MASK_SHIFT, size);
+
+	/*
+	 * Stage-1 output limited by stage-2 input size due to pgd
+	 * allocation (PTRS_PER_PGD).
+	 */
+#ifdef CONFIG_64BIT
+	smmu->s1_output_size = min_t(unsigned long, VA_BITS, size);
+#else
+	smmu->s1_output_size = min(32UL, size);
+#endif
+
+	dev_notice(smmu->dev,
+		   "\t%lu-bit VA, %lu-bit IPA, %lu-bit PA\n",
+		   smmu->input_size,
+		   smmu->s1_output_size, smmu->s2_output_size);
+
+	return 0;
+}
+
+static int hisi_dt_cfg_probe(struct arm_smmu_device *smmu, struct device *dev)
+{
+	int i, ret;
+	const __be32 *prop;
+	int len;
+
+	/*
+	 * some devices may not support bring cache attributes, but want
+	 * specified cache attributes. Here list three common cases:
+	 * 1, cahceable, WBRAWA
+	 * 2, non-cacheable
+	 * 3, device, nGnRE
+	 */
+	prop = of_get_property(dev->of_node, "smmu-force-memtype", &len);
+	for (i = 0; prop && (i < (len / 4) - 1); i += 2) {
+		int cbidx;
+
+		cbidx = of_read_number(&prop[i], 1);
+		if (cbidx >= ARM_SMMU_MAX_CBS) {
+			dev_err(dev, "invalid StreamID %d\n", cbidx);
+			return -ENODEV;
+		}
+
+		ret = hisi_smmu_alloc_context(smmu, cbidx, cbidx + 1, NULL);
+		if (IS_ERR_VALUE(ret)) {
+			dev_err(dev, "conflict StreamID %d\n", cbidx);
+			return ret;
+		}
+
+		smmu->cb_mtcfg[cbidx] = (u8)of_read_number(&prop[i + 1], 1);
+		if (!smmu->cb_mtcfg[cbidx])
+			smmu->cb_mtcfg[cbidx] = 0xff;
+	}
+
+	of_property_read_u32(dev->of_node,
+				"smmu-bypass-vmid", &hisi_bypass_vmid);
+
+	return 0;
+}
+
+void arm_smmu_hwdep_ops_override(struct arm_smmu_hwdep_ops *ops)
+{
+	memcpy(&smmu_hwdep_ops_bak, ops, sizeof(*ops));
+
+	ops->alloc_context	= hisi_smmu_alloc_context;
+	ops->tlb_sync		= hisi_smmu_tlb_sync;
+	ops->context_fault	= hisi_smmu_context_fault;
+	ops->global_fault	= hisi_smmu_global_fault;
+	ops->init_context_bank	= hisi_smmu_init_context_bank;
+	ops->destroy_context_bank = hisi_smmu_destroy_context_bank;
+	ops->domain_add_master	= hisi_smmu_domain_add_master;
+	ops->domain_remove_master = hisi_smmu_domain_remove_master;
+	ops->device_reset	= hisi_smmu_device_reset;
+	ops->device_cfg_probe	= hisi_smmu_device_cfg_probe;
+	ops->dt_cfg_probe	= hisi_dt_cfg_probe;
+}
--
1.8.0
