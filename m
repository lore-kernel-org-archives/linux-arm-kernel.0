From: r.herring@freescale.com (Rob Herring)
Date: Fri, 16 Apr 2010 14:35:15 -0500
Subject: [RFC PATCH 01/10] mx51: convert static mappings in clock code
Message-ID: <1271446524-26450-2-git-send-email-r.herring@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

convert plls and timer to ioremap.
remove unused defines which are static mappings.

Signed-off-by: Rob Herring <r.herring@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51.c |   19 ++++++--
 arch/arm/mach-mx5/crm_regs.h   |  100 ----------------------------------------
 2 files changed, 14 insertions(+), 105 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index 1ee6ce4..726b7fe 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -38,6 +38,10 @@ static struct clk periph_apm_clk;
 static struct clk ahb_clk;
 static struct clk ipg_clk;
 
+static void __iomem *pll1_base;
+static void __iomem *pll2_base;
+static void __iomem *pll3_base;
+
 #define MAX_DPLL_WAIT_TRIES	1000 /* 1000 * udelay(1) = 1ms */
 
 static int _clk_ccgr_enable(struct clk *clk)
@@ -93,11 +97,11 @@ static inline u32 _get_mux(struct clk *parent, struct clk *m0,
 static inline void __iomem *_get_pll_base(struct clk *pll)
 {
 	if (pll == &pll1_main_clk)
-		return MX51_DPLL1_BASE;
+		return pll1_base;
 	else if (pll == &pll2_sw_clk)
-		return MX51_DPLL2_BASE;
+		return pll2_base;
 	else if (pll == &pll3_sw_clk)
-		return MX51_DPLL3_BASE;
+		return pll3_base;
 	else
 		BUG();
 
@@ -805,6 +809,11 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
 			unsigned long ckih1, unsigned long ckih2)
 {
 	int i;
+	__iomem void *base;
+
+	pll1_base = ioremap(MX51_PLL1_BASE_ADDR, SZ_4K);
+	pll2_base = ioremap(MX51_PLL2_BASE_ADDR, SZ_4K);
+	pll3_base = ioremap(MX51_PLL3_BASE_ADDR, SZ_4K);
 
 	external_low_reference = ckil;
 	external_high_reference = ckih1;
@@ -820,7 +829,7 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
 	clk_enable(&main_bus_clk);
 
 	/* System timer */
-	mxc_timer_init(&gpt_clk, MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR),
-		MX51_MXC_INT_GPT);
+	base = ioremap(MX51_GPT1_BASE_ADDR, SZ_4K);
+	mxc_timer_init(&gpt_clk, base, MX51_MXC_INT_GPT);
 	return 0;
 }
diff --git a/arch/arm/mach-mx5/crm_regs.h b/arch/arm/mach-mx5/crm_regs.h
index c776b9a..fbeb928 100644
--- a/arch/arm/mach-mx5/crm_regs.h
+++ b/arch/arm/mach-mx5/crm_regs.h
@@ -12,11 +12,6 @@
 #define __ARCH_ARM_MACH_MX51_CRM_REGS_H__
 
 #define MX51_CCM_BASE		MX51_IO_ADDRESS(MX51_CCM_BASE_ADDR)
-#define MX51_DPLL1_BASE		MX51_IO_ADDRESS(MX51_PLL1_BASE_ADDR)
-#define MX51_DPLL2_BASE		MX51_IO_ADDRESS(MX51_PLL2_BASE_ADDR)
-#define MX51_DPLL3_BASE		MX51_IO_ADDRESS(MX51_PLL3_BASE_ADDR)
-#define MX51_CORTEXA8_BASE	MX51_IO_ADDRESS(MX51_ARM_BASE_ADDR)
-#define MX51_GPC_BASE		MX51_IO_ADDRESS(MX51_GPC_BASE_ADDR)
 
 /* PLL Register Offsets */
 #define MXC_PLL_DP_CTL			0x00
@@ -485,99 +480,4 @@
 #define MXC_CCM_CCGRx_CG1_OFFSET			2
 #define MXC_CCM_CCGRx_CG0_OFFSET			0
 
-#define MXC_DPTC_LP_BASE	(MX51_GPC_BASE + 0x80)
-#define MXC_DPTC_GP_BASE	(MX51_GPC_BASE + 0x100)
-#define MXC_DVFS_CORE_BASE	(MX51_GPC_BASE + 0x180)
-#define MXC_DPTC_PER_BASE	(MX51_GPC_BASE + 0x1C0)
-#define MXC_PGC_IPU_BASE	(MX51_GPC_BASE + 0x220)
-#define MXC_PGC_VPU_BASE	(MX51_GPC_BASE + 0x240)
-#define MXC_PGC_GPU_BASE	(MX51_GPC_BASE + 0x260)
-#define MXC_SRPG_NEON_BASE	(MX51_GPC_BASE + 0x280)
-#define MXC_SRPG_ARM_BASE	(MX51_GPC_BASE + 0x2A0)
-#define MXC_SRPG_EMPGC0_BASE	(MX51_GPC_BASE + 0x2C0)
-#define MXC_SRPG_EMPGC1_BASE	(MX51_GPC_BASE + 0x2D0)
-#define MXC_SRPG_MEGAMIX_BASE	(MX51_GPC_BASE + 0x2E0)
-#define MXC_SRPG_EMI_BASE	(MX51_GPC_BASE + 0x300)
-
-/* CORTEXA8 platform */
-#define MXC_CORTEXA8_PLAT_PVID		(MX51_CORTEXA8_BASE + 0x0)
-#define MXC_CORTEXA8_PLAT_GPC		(MX51_CORTEXA8_BASE + 0x4)
-#define MXC_CORTEXA8_PLAT_PIC		(MX51_CORTEXA8_BASE + 0x8)
-#define MXC_CORTEXA8_PLAT_LPC		(MX51_CORTEXA8_BASE + 0xC)
-#define MXC_CORTEXA8_PLAT_NEON_LPC	(MX51_CORTEXA8_BASE + 0x10)
-#define MXC_CORTEXA8_PLAT_ICGC		(MX51_CORTEXA8_BASE + 0x14)
-#define MXC_CORTEXA8_PLAT_AMC		(MX51_CORTEXA8_BASE + 0x18)
-#define MXC_CORTEXA8_PLAT_NMC		(MX51_CORTEXA8_BASE + 0x20)
-#define MXC_CORTEXA8_PLAT_NMS		(MX51_CORTEXA8_BASE + 0x24)
-
-/* DVFS CORE */
-#define MXC_DVFSTHRS		(MXC_DVFS_CORE_BASE + 0x00)
-#define MXC_DVFSCOUN		(MXC_DVFS_CORE_BASE + 0x04)
-#define MXC_DVFSSIG1		(MXC_DVFS_CORE_BASE + 0x08)
-#define MXC_DVFSSIG0		(MXC_DVFS_CORE_BASE + 0x0C)
-#define MXC_DVFSGPC0		(MXC_DVFS_CORE_BASE + 0x10)
-#define MXC_DVFSGPC1		(MXC_DVFS_CORE_BASE + 0x14)
-#define MXC_DVFSGPBT		(MXC_DVFS_CORE_BASE + 0x18)
-#define MXC_DVFSEMAC		(MXC_DVFS_CORE_BASE + 0x1C)
-#define MXC_DVFSCNTR		(MXC_DVFS_CORE_BASE + 0x20)
-#define MXC_DVFSLTR0_0		(MXC_DVFS_CORE_BASE + 0x24)
-#define MXC_DVFSLTR0_1		(MXC_DVFS_CORE_BASE + 0x28)
-#define MXC_DVFSLTR1_0		(MXC_DVFS_CORE_BASE + 0x2C)
-#define MXC_DVFSLTR1_1		(MXC_DVFS_CORE_BASE + 0x30)
-#define MXC_DVFSPT0 		(MXC_DVFS_CORE_BASE + 0x34)
-#define MXC_DVFSPT1 		(MXC_DVFS_CORE_BASE + 0x38)
-#define MXC_DVFSPT2 		(MXC_DVFS_CORE_BASE + 0x3C)
-#define MXC_DVFSPT3 		(MXC_DVFS_CORE_BASE + 0x40)
-
-/* GPC */
-#define MXC_GPC_CNTR		(MX51_GPC_BASE + 0x0)
-#define MXC_GPC_PGR		(MX51_GPC_BASE + 0x4)
-#define MXC_GPC_VCR		(MX51_GPC_BASE + 0x8)
-#define MXC_GPC_ALL_PU		(MX51_GPC_BASE + 0xC)
-#define MXC_GPC_NEON		(MX51_GPC_BASE + 0x10)
-#define MXC_GPC_PGR_ARMPG_OFFSET	8
-#define MXC_GPC_PGR_ARMPG_MASK		(3 << 8)
-
-/* PGC */
-#define MXC_PGC_IPU_PGCR	(MXC_PGC_IPU_BASE + 0x0)
-#define MXC_PGC_IPU_PGSR	(MXC_PGC_IPU_BASE + 0xC)
-#define MXC_PGC_VPU_PGCR	(MXC_PGC_VPU_BASE + 0x0)
-#define MXC_PGC_VPU_PGSR	(MXC_PGC_VPU_BASE + 0xC)
-#define MXC_PGC_GPU_PGCR	(MXC_PGC_GPU_BASE + 0x0)
-#define MXC_PGC_GPU_PGSR	(MXC_PGC_GPU_BASE + 0xC)
-
-#define MXC_PGCR_PCR		1
-#define MXC_SRPGCR_PCR		1
-#define MXC_EMPGCR_PCR		1
-#define MXC_PGSR_PSR		1
-
-
-#define MXC_CORTEXA8_PLAT_LPC_DSM	(1 << 0)
-#define MXC_CORTEXA8_PLAT_LPC_DBG_DSM	(1 << 1)
-
-/* SRPG */
-#define MXC_SRPG_NEON_SRPGCR	(MXC_SRPG_NEON_BASE + 0x0)
-#define MXC_SRPG_NEON_PUPSCR	(MXC_SRPG_NEON_BASE + 0x4)
-#define MXC_SRPG_NEON_PDNSCR	(MXC_SRPG_NEON_BASE + 0x8)
-
-#define MXC_SRPG_ARM_SRPGCR	(MXC_SRPG_ARM_BASE + 0x0)
-#define MXC_SRPG_ARM_PUPSCR	(MXC_SRPG_ARM_BASE + 0x4)
-#define MXC_SRPG_ARM_PDNSCR	(MXC_SRPG_ARM_BASE + 0x8)
-
-#define MXC_SRPG_EMPGC0_SRPGCR	(MXC_SRPG_EMPGC0_BASE + 0x0)
-#define MXC_SRPG_EMPGC0_PUPSCR	(MXC_SRPG_EMPGC0_BASE + 0x4)
-#define MXC_SRPG_EMPGC0_PDNSCR	(MXC_SRPG_EMPGC0_BASE + 0x8)
-
-#define MXC_SRPG_EMPGC1_SRPGCR	(MXC_SRPG_EMPGC1_BASE + 0x0)
-#define MXC_SRPG_EMPGC1_PUPSCR	(MXC_SRPG_EMPGC1_BASE + 0x4)
-#define MXC_SRPG_EMPGC1_PDNSCR	(MXC_SRPG_EMPGC1_BASE + 0x8)
-
-#define MXC_SRPG_MEGAMIX_SRPGCR		(MXC_SRPG_MEGAMIX_BASE + 0x0)
-#define MXC_SRPG_MEGAMIX_PUPSCR		(MXC_SRPG_MEGAMIX_BASE + 0x4)
-#define MXC_SRPG_MEGAMIX_PDNSCR		(MXC_SRPG_MEGAMIX_BASE + 0x8)
-
-#define MXC_SRPGC_EMI_SRPGCR	(MXC_SRPGC_EMI_BASE + 0x0)
-#define MXC_SRPGC_EMI_PUPSCR	(MXC_SRPGC_EMI_BASE + 0x4)
-#define MXC_SRPGC_EMI_PDNSCR	(MXC_SRPGC_EMI_BASE + 0x8)
-
 #endif				/* __ARCH_ARM_MACH_MX51_CRM_REGS_H__ */
-- 
1.6.0.4
