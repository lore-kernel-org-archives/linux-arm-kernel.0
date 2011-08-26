From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 26 Aug 2011 16:21:57 -0300
Subject: [PATCH 1/5] ARM: mx5: Allow CCM definitions to work on MX51 and MX53
Message-ID: <1314386521-29351-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow CCM (Clock Control Module) definitions to work on MX51 and MX53
by checking the cpu type in run-time and using the appropriate register bases.

Also, MX50 shares the same base addresses for these registers as MX53.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/crm_regs.h |  136 ++++++++++++++++++++++-------------------
 1 files changed, 73 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-mx5/crm_regs.h b/arch/arm/mach-mx5/crm_regs.h
index 5e11ba7..4385307 100644
--- a/arch/arm/mach-mx5/crm_regs.h
+++ b/arch/arm/mach-mx5/crm_regs.h
@@ -24,6 +24,16 @@
 #define MX53_DPLL2_BASE		MX53_IO_ADDRESS(MX53_PLL2_BASE_ADDR)
 #define MX53_DPLL3_BASE		MX53_IO_ADDRESS(MX53_PLL3_BASE_ADDR)
 #define MX53_DPLL4_BASE		MX53_IO_ADDRESS(MX53_PLL3_BASE_ADDR)
+#define MX53_CORTEXA8_BASE	MX53_IO_ADDRESS(MX53_ARM_BASE_ADDR)
+#define MX53_GPC_BASE		MX53_IO_ADDRESS(MX53_GPC_BASE_ADDR)
+
+#define MX5_CORTEXA8_BASE	(cpu_is_mx51() ? MX51_CORTEXA8_BASE : \
+							MX53_CORTEXA8_BASE)
+#define MX5_GPC_BASE		(cpu_is_mx51() ? MX51_GPC_BASE : \
+							MX53_GPC_BASE)
+
+#define MX5_CCM_BASE		(cpu_is_mx51() ? MX51_CCM_BASE : \
+							MX53_CCM_BASE)
 
 /* PLL Register Offsets */
 #define MXC_PLL_DP_CTL			0x00
@@ -81,42 +91,42 @@
 #define MXC_PLL_DP_DESTAT_MFN		0x07FFFFFF
 
 /* Register addresses of CCM*/
-#define MXC_CCM_CCR		(MX51_CCM_BASE + 0x00)
-#define MXC_CCM_CCDR		(MX51_CCM_BASE + 0x04)
-#define MXC_CCM_CSR		(MX51_CCM_BASE + 0x08)
-#define MXC_CCM_CCSR		(MX51_CCM_BASE + 0x0C)
-#define MXC_CCM_CACRR		(MX51_CCM_BASE + 0x10)
-#define MXC_CCM_CBCDR		(MX51_CCM_BASE + 0x14)
-#define MXC_CCM_CBCMR		(MX51_CCM_BASE + 0x18)
-#define MXC_CCM_CSCMR1		(MX51_CCM_BASE + 0x1C)
-#define MXC_CCM_CSCMR2		(MX51_CCM_BASE + 0x20)
-#define MXC_CCM_CSCDR1		(MX51_CCM_BASE + 0x24)
-#define MXC_CCM_CS1CDR		(MX51_CCM_BASE + 0x28)
-#define MXC_CCM_CS2CDR		(MX51_CCM_BASE + 0x2C)
-#define MXC_CCM_CDCDR		(MX51_CCM_BASE + 0x30)
-#define MXC_CCM_CHSCDR		(MX51_CCM_BASE + 0x34)
-#define MXC_CCM_CSCDR2		(MX51_CCM_BASE + 0x38)
-#define MXC_CCM_CSCDR3		(MX51_CCM_BASE + 0x3C)
-#define MXC_CCM_CSCDR4		(MX51_CCM_BASE + 0x40)
-#define MXC_CCM_CWDR		(MX51_CCM_BASE + 0x44)
-#define MXC_CCM_CDHIPR		(MX51_CCM_BASE + 0x48)
-#define MXC_CCM_CDCR		(MX51_CCM_BASE + 0x4C)
-#define MXC_CCM_CTOR		(MX51_CCM_BASE + 0x50)
-#define MXC_CCM_CLPCR		(MX51_CCM_BASE + 0x54)
-#define MXC_CCM_CISR		(MX51_CCM_BASE + 0x58)
-#define MXC_CCM_CIMR		(MX51_CCM_BASE + 0x5C)
-#define MXC_CCM_CCOSR		(MX51_CCM_BASE + 0x60)
-#define MXC_CCM_CGPR		(MX51_CCM_BASE + 0x64)
-#define MXC_CCM_CCGR0		(MX51_CCM_BASE + 0x68)
-#define MXC_CCM_CCGR1		(MX51_CCM_BASE + 0x6C)
-#define MXC_CCM_CCGR2		(MX51_CCM_BASE + 0x70)
-#define MXC_CCM_CCGR3		(MX51_CCM_BASE + 0x74)
-#define MXC_CCM_CCGR4		(MX51_CCM_BASE + 0x78)
-#define MXC_CCM_CCGR5		(MX51_CCM_BASE + 0x7C)
-#define MXC_CCM_CCGR6		(MX51_CCM_BASE + 0x80)
-#define MXC_CCM_CCGR7		(MX51_CCM_BASE + 0x84)
-
-#define MXC_CCM_CMEOR		(MX51_CCM_BASE + 0x84)
+#define MXC_CCM_CCR		(MX5_CCM_BASE + 0x00)
+#define MXC_CCM_CCDR		(MX5_CCM_BASE + 0x04)
+#define MXC_CCM_CSR		(MX5_CCM_BASE + 0x08)
+#define MXC_CCM_CCSR		(MX5_CCM_BASE + 0x0C)
+#define MXC_CCM_CACRR		(MX5_CCM_BASE + 0x10)
+#define MXC_CCM_CBCDR		(MX5_CCM_BASE + 0x14)
+#define MXC_CCM_CBCMR		(MX5_CCM_BASE + 0x18)
+#define MXC_CCM_CSCMR1		(MX5_CCM_BASE + 0x1C)
+#define MXC_CCM_CSCMR2		(MX5_CCM_BASE + 0x20)
+#define MXC_CCM_CSCDR1		(MX5_CCM_BASE + 0x24)
+#define MXC_CCM_CS1CDR		(MX5_CCM_BASE + 0x28)
+#define MXC_CCM_CS2CDR		(MX5_CCM_BASE + 0x2C)
+#define MXC_CCM_CDCDR		(MX5_CCM_BASE + 0x30)
+#define MXC_CCM_CHSCDR		(MX5_CCM_BASE + 0x34)
+#define MXC_CCM_CSCDR2		(MX5_CCM_BASE + 0x38)
+#define MXC_CCM_CSCDR3		(MX5_CCM_BASE + 0x3C)
+#define MXC_CCM_CSCDR4		(MX5_CCM_BASE + 0x40)
+#define MXC_CCM_CWDR		(MX5_CCM_BASE + 0x44)
+#define MXC_CCM_CDHIPR		(MX5_CCM_BASE + 0x48)
+#define MXC_CCM_CDCR		(MX5_CCM_BASE + 0x4C)
+#define MXC_CCM_CTOR		(MX5_CCM_BASE + 0x50)
+#define MXC_CCM_CLPCR		(MX5_CCM_BASE + 0x54)
+#define MXC_CCM_CISR		(MX5_CCM_BASE + 0x58)
+#define MXC_CCM_CIMR		(MX5_CCM_BASE + 0x5C)
+#define MXC_CCM_CCOSR		(MX5_CCM_BASE + 0x60)
+#define MXC_CCM_CGPR		(MX5_CCM_BASE + 0x64)
+#define MXC_CCM_CCGR0		(MX5_CCM_BASE + 0x68)
+#define MXC_CCM_CCGR1		(MX5_CCM_BASE + 0x6C)
+#define MXC_CCM_CCGR2		(MX5_CCM_BASE + 0x70)
+#define MXC_CCM_CCGR3		(MX5_CCM_BASE + 0x74)
+#define MXC_CCM_CCGR4		(MX5_CCM_BASE + 0x78)
+#define MXC_CCM_CCGR5		(MX5_CCM_BASE + 0x7C)
+#define MXC_CCM_CCGR6		(MX5_CCM_BASE + 0x80)
+#define MXC_CCM_CCGR7		(MX5_CCM_BASE + 0x84)
+
+#define MXC_CCM_CMEOR		(MX5_CCM_BASE + 0x84)
 
 /* Define the bits in register CCR */
 #define MXC_CCM_CCR_COSC_EN		(1 << 12)
@@ -502,30 +512,30 @@
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
+#define MXC_DPTC_LP_BASE	(MX5_GPC_BASE + 0x80)
+#define MXC_DPTC_GP_BASE	(MX5_GPC_BASE + 0x100)
+#define MXC_DVFS_CORE_BASE	(MX5_GPC_BASE + 0x180)
+#define MXC_DPTC_PER_BASE	(MX5_GPC_BASE + 0x1C0)
+#define MXC_PGC_IPU_BASE	(MX5_GPC_BASE + 0x220)
+#define MXC_PGC_VPU_BASE	(MX5_GPC_BASE + 0x240)
+#define MXC_PGC_GPU_BASE	(MX5_GPC_BASE + 0x260)
+#define MXC_SRPG_NEON_BASE	(MX5_GPC_BASE + 0x280)
+#define MXC_SRPG_ARM_BASE	(MX5_GPC_BASE + 0x2A0)
+#define MXC_SRPG_EMPGC0_BASE	(MX5_GPC_BASE + 0x2C0)
+#define MXC_SRPG_EMPGC1_BASE	(MX5_GPC_BASE + 0x2D0)
+#define MXC_SRPG_MEGAMIX_BASE	(MX5_GPC_BASE + 0x2E0)
+#define MXC_SRPG_EMI_BASE	(MX5_GPC_BASE + 0x300)
 
 /* CORTEXA8 platform */
-#define MXC_CORTEXA8_PLAT_PVID		(MX51_CORTEXA8_BASE + 0x0)
-#define MXC_CORTEXA8_PLAT_GPC		(MX51_CORTEXA8_BASE + 0x4)
-#define MXC_CORTEXA8_PLAT_PIC		(MX51_CORTEXA8_BASE + 0x8)
-#define MXC_CORTEXA8_PLAT_LPC		(MX51_CORTEXA8_BASE + 0xC)
-#define MXC_CORTEXA8_PLAT_NEON_LPC	(MX51_CORTEXA8_BASE + 0x10)
-#define MXC_CORTEXA8_PLAT_ICGC		(MX51_CORTEXA8_BASE + 0x14)
-#define MXC_CORTEXA8_PLAT_AMC		(MX51_CORTEXA8_BASE + 0x18)
-#define MXC_CORTEXA8_PLAT_NMC		(MX51_CORTEXA8_BASE + 0x20)
-#define MXC_CORTEXA8_PLAT_NMS		(MX51_CORTEXA8_BASE + 0x24)
+#define MXC_CORTEXA8_PLAT_PVID		(MX5_CORTEXA8_BASE + 0x0)
+#define MXC_CORTEXA8_PLAT_GPC		(MX5_CORTEXA8_BASE + 0x4)
+#define MXC_CORTEXA8_PLAT_PIC		(MX5_CORTEXA8_BASE + 0x8)
+#define MXC_CORTEXA8_PLAT_LPC		(MX5_CORTEXA8_BASE + 0xC)
+#define MXC_CORTEXA8_PLAT_NEON_LPC	(MX5_CORTEXA8_BASE + 0x10)
+#define MXC_CORTEXA8_PLAT_ICGC		(MX5_CORTEXA8_BASE + 0x14)
+#define MXC_CORTEXA8_PLAT_AMC		(MX5_CORTEXA8_BASE + 0x18)
+#define MXC_CORTEXA8_PLAT_NMC		(MX5_CORTEXA8_BASE + 0x20)
+#define MXC_CORTEXA8_PLAT_NMS		(MX5_CORTEXA8_BASE + 0x24)
 
 /* DVFS CORE */
 #define MXC_DVFSTHRS		(MXC_DVFS_CORE_BASE + 0x00)
@@ -547,11 +557,11 @@
 #define MXC_DVFSPT3 		(MXC_DVFS_CORE_BASE + 0x40)
 
 /* GPC */
-#define MXC_GPC_CNTR		(MX51_GPC_BASE + 0x0)
-#define MXC_GPC_PGR		(MX51_GPC_BASE + 0x4)
-#define MXC_GPC_VCR		(MX51_GPC_BASE + 0x8)
-#define MXC_GPC_ALL_PU		(MX51_GPC_BASE + 0xC)
-#define MXC_GPC_NEON		(MX51_GPC_BASE + 0x10)
+#define MXC_GPC_CNTR		(MX5_GPC_BASE + 0x0)
+#define MXC_GPC_PGR		(MX5_GPC_BASE + 0x4)
+#define MXC_GPC_VCR		(MX5_GPC_BASE + 0x8)
+#define MXC_GPC_ALL_PU		(MX5_GPC_BASE + 0xC)
+#define MXC_GPC_NEON		(MX5_GPC_BASE + 0x10)
 #define MXC_GPC_PGR_ARMPG_OFFSET	8
 #define MXC_GPC_PGR_ARMPG_MASK		(3 << 8)
 
-- 
1.6.0.4
