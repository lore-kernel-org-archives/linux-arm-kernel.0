From: stefan@agner.ch (Stefan Agner)
Date: Wed,  9 Mar 2016 18:16:56 -0800
Subject: [PATCH 15/18] ARM: vf610: PM: initial suspend/resume support
In-Reply-To: <1457576219-7971-1-git-send-email-stefan@agner.ch>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
Message-ID: <1457576219-7971-16-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add system suspend and resume support for Vybrid SoC. The standby
sleep state puts the SoC in STOP mode. The SoC can be woken through
an interrupt from GPC (Global Power Controller). The GPC can use any
interrupt as wake-up source. To save power the main PLL1 is bypassed
and uses the 24MHz on-chip oscillator. However, memory clock need to
be at full speed, hence the PLL2 needs to be on to keep the memory
clocked. The mode is completely implemented in C since we can access
the full memory at all times. The mode provides most power saving
while being able to be woken by any IRQ as wake-up source.

The mem sleep state (Suspend-to-RAM) uses Vybrid's LPSTOP2 mode. This
mode powergates most parts of the SoC expect some peripherials such as
Wake-Up controller (WKPU) or LP RTC. Parts of the internal SRAM is
retained too. The suspend code written in assembly runs from this SRAM.
The code puts the main memory (DDR3) into self-refresh mode and takes
it out of self-refresh mode on resume. Verified with Colibri VF50/VF61
V1.2A.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mach-imx/Makefile        |   3 +
 arch/arm/mach-imx/common.h        |  10 +
 arch/arm/mach-imx/mach-vf610.c    |   8 +
 arch/arm/mach-imx/pm-vf610.c      | 634 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/suspend-vf610.S | 437 ++++++++++++++++++++++++++
 drivers/clk/imx/clk-vf610.c       |  17 +
 6 files changed, 1109 insertions(+)
 create mode 100644 arch/arm/mach-imx/pm-vf610.c
 create mode 100644 arch/arm/mach-imx/suspend-vf610.S

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 9fbe624..ea2e8bd 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -90,8 +90,11 @@ ifeq ($(CONFIG_SUSPEND),y)
 AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SOC_IMX6) += suspend-imx6.o
 obj-$(CONFIG_SOC_IMX53) += suspend-imx53.o
+AFLAGS_suspend-vf610.o :=-Wa,-march=armv7-a
+obj-$(CONFIG_SOC_VF610) += suspend-vf610.o
 endif
 obj-$(CONFIG_SOC_IMX6) += pm-imx6.o
+obj-$(CONFIG_SOC_VF610) += pm-vf610.o
 
 obj-$(CONFIG_SOC_IMX50) += mach-imx50.o
 obj-$(CONFIG_SOC_IMX51) += mach-imx51.o
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 58a3846..737b1e4 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -76,6 +76,13 @@ enum mxc_cpu_pwr_mode {
 	STOP_POWER_OFF,		/* STOP + SRPG */
 };
 
+enum vf610_cpu_pwr_mode {
+	VF610_RUN,
+	VF610_LP_RUN,
+	VF610_STOP,
+	VF610_LP_STOP,
+};
+
 enum mx3_cpu_pwr_mode {
 	MX3_RUN,
 	MX3_WAIT,
@@ -120,11 +127,13 @@ void v7_cpu_resume(void);
 void imx53_suspend(void __iomem *ocram_vbase);
 extern const u32 imx53_suspend_sz;
 void imx6_suspend(void __iomem *ocram_vbase);
+void vf610_suspend(void __iomem *ocram_vbase);
 #else
 static inline void v7_cpu_resume(void) {}
 static inline void imx53_suspend(void __iomem *ocram_vbase) {}
 static const u32 imx53_suspend_sz;
 static inline void imx6_suspend(void __iomem *ocram_vbase) {}
+static inline void vf610_suspend(void __iomem *ocram_vbase) {}
 #endif
 
 void imx6_pm_ccm_init(const char *ccm_compat);
@@ -133,6 +142,7 @@ void imx6dl_pm_init(void);
 void imx6sl_pm_init(void);
 void imx6sx_pm_init(void);
 void imx6ul_pm_init(void);
+void vf610_pm_init(void);
 
 #ifdef CONFIG_PM
 void imx51_pm_init(void);
diff --git a/arch/arm/mach-imx/mach-vf610.c b/arch/arm/mach-imx/mach-vf610.c
index b20f6c1..5ba668f 100644
--- a/arch/arm/mach-imx/mach-vf610.c
+++ b/arch/arm/mach-imx/mach-vf610.c
@@ -11,6 +11,13 @@
 #include <linux/irqchip.h>
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
+#include "common.h"
+
+static void __init vf610_init_machine(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	vf610_pm_init();
+}
 
 static const char * const vf610_dt_compat[] __initconst = {
 	"fsl,vf500",
@@ -24,5 +31,6 @@ static const char * const vf610_dt_compat[] __initconst = {
 DT_MACHINE_START(VYBRID_VF610, "Freescale Vybrid VF5xx/VF6xx (Device Tree)")
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
+	.init_machine	= vf610_init_machine,
 	.dt_compat	= vf610_dt_compat,
 MACHINE_END
diff --git a/arch/arm/mach-imx/pm-vf610.c b/arch/arm/mach-imx/pm-vf610.c
new file mode 100644
index 0000000..ecc7c9c
--- /dev/null
+++ b/arch/arm/mach-imx/pm-vf610.c
@@ -0,0 +1,634 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2016 Toradex AG
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifdef DEBUG
+#define pr_pmdebug(fmt, ...) pr_info("PM: VF610: " fmt "\n", ##__VA_ARGS__)
+#else
+#define pr_pmdebug(fmt, ...)
+#endif
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/genalloc.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <linux/suspend.h>
+#include <linux/clk.h>
+#include <asm/cacheflush.h>
+#include <asm/fncpy.h>
+#include <asm/proc-fns.h>
+#include <asm/suspend.h>
+#include <asm/tlb.h>
+
+#include "common.h"
+
+#define DDRMC_PHY_OFFSET		0x400
+
+#define CCR				0x0
+#define BM_CCR_FIRC_EN			(0x1 << 16)
+#define BM_CCR_FXOSC_EN			(0x1 << 12)
+
+#define CCSR				0x8
+#define BM_CCSR_DDRC_CLK_SEL		(0x1 << 6)
+#define BM_CCSR_FAST_CLK_SEL		(0x1 << 5)
+#define BM_CCSR_SLOW_CLK_SEL		(0x1 << 4)
+#define BM_CCSR_SYS_CLK_SEL_MASK	(0x7 << 0)
+
+#define CACRR				0xc
+
+#define CLPCR				0x2c
+#define BM_CLPCR_ARM_CLK_DIS_ON_LPM	(0x1 << 5)
+#define BM_CLPCR_SBYOS			(0x1 << 6)
+#define BM_CLPCR_DIS_REF_OSC		(0x1 << 7)
+#define BM_CLPCR_ANADIG_STOP_MODE	(0x1 << 8)
+#define BM_CLPCR_FXOSC_BYPSEN		(0x1 << 10)
+#define BM_CLPCR_FXOSC_PWRDWN		(0x1 << 11)
+#define BM_CLPCR_MASK_CORE0_WFI		(0x1 << 22)
+#define BM_CLPCR_MASK_CORE1_WFI		(0x1 << 23)
+#define BM_CLPCR_MASK_SCU_IDLE		(0x1 << 24)
+#define BM_CLPCR_MASK_L2CC_IDLE		(0x1 << 25)
+
+#define CGPR				0x64
+#define BM_CGPR_INT_MEM_CLK_LPM		(0x1 << 17)
+
+#define GPC_PGCR			0x0
+#define BM_PGCR_DS_STOP			(0x1 << 7)
+#define BM_PGCR_DS_LPSTOP		(0x1 << 6)
+#define BM_PGCR_WB_STOP			(0x1 << 4)
+#define BM_PGCR_HP_OFF			(0x1 << 3)
+#define BM_PGCR_PG_PD1			(0x1 << 0)
+
+#define GPC_LPMR			0x40
+#define BM_LPMR_RUN			0x0
+#define BM_LPMR_STOP			0x2
+
+#define ANATOP_PLL1_CTRL		0x270
+#define ANATOP_PLL2_CTRL		0x30
+#define ANATOP_PLL2_PFD			0x100
+#define BM_PLL_POWERDOWN	(0x1 << 12)
+#define BM_PLL_ENABLE		(0x1 << 13)
+#define BM_PLL_BYPASS		(0x1 << 16)
+#define BM_PLL_LOCK		(0x1 << 31)
+#define BM_PLL_PFD2_CLKGATE	(0x1 << 15)
+#define BM_PLL_USB_POWER	(0x1 << 12)
+#define BM_PLL_EN_USB_CLKS	(0x1 << 6)
+
+#define VF610_DDRMC_IO_NUM		94
+#define VF610_IOMUX_DDR_IO_NUM		48
+#define VF610_ANATOP_IO_NUM		2
+
+static void __iomem *suspend_ocram_base;
+static void (*vf610_suspend_in_ocram_fn)(void __iomem *ocram_vbase);
+
+#ifdef DEBUG
+static void __iomem *uart_membase;
+static unsigned long uart_clk;
+#endif
+
+static const u32 vf610_iomuxc_ddr_io_offset[] __initconst = {
+	0x220, 0x224, 0x228, 0x22c, 0x230, 0x234, 0x238, 0x23c,
+	0x240, 0x244, 0x248, 0x24c, 0x250, 0x254, 0x258, 0x25c,
+	0x260, 0x264, 0x268, 0x26c, 0x270, 0x274, 0x278, 0x27c,
+	0x280, 0x284, 0x288, 0x28c, 0x290, 0x294, 0x298, 0x29c,
+	0x2a0, 0x2a4, 0x2a8, 0x2ac, 0x2b0, 0x2b4, 0x2b8, 0x2bc,
+	0x2c0, 0x2c4, 0x2c8, 0x2cc, 0x2d0, 0x2d4, 0x2d8, 0x21c,
+};
+
+
+static const u32 vf610_ddrmc_io_offset[] __initconst = {
+	0x00, 0x08, 0x28, 0x2c, 0x30, 0x34, 0x38,
+	0x40, 0x44, 0x48, 0x50, 0x54, 0x58, 0x5c,
+	0x60, 0x64, 0x68, 0x70, 0x74, 0x78, 0x7c,
+	0x84, 0x88, 0x98, 0x9c, 0xa4, 0xc0,
+	0x108, 0x10c, 0x114, 0x118, 0x120, 0x124,
+	0x128, 0x12c, 0x130, 0x134, 0x138, 0x13c,
+	0x148, 0x15c, 0x160, 0x164, 0x16c, 0x180,
+	0x184, 0x188, 0x18c, 0x198, 0x1a4, 0x1a8,
+	0x1b8, 0x1d4, 0x1d8, 0x1e0, 0x1e4, 0x1e8,
+	0x1ec, 0x1f0, 0x1f8, 0x210, 0x224, 0x228,
+	0x22c, 0x230, 0x23c, 0x240, 0x244, 0x248,
+	0x24c, 0x250, 0x25c, 0x268, 0x26c, 0x278,
+	0x268
+};
+
+static const u32 vf610_ddrmc_phy_io_offset[] __initconst = {
+	0x00, 0x04, 0x08, 0x0c, 0x10,
+	0x40, 0x44, 0x48, 0x4c, 0x50,
+	0x80, 0x84, 0x88, 0x8c, 0x90,
+	0xc4, 0xc8, 0xd0
+};
+
+/*
+ * suspend ocram space layout:
+ * ======================== high address ======================
+ *                              .
+ *                              .
+ *                              .
+ *                              ^
+ *                              ^
+ *                              ^
+ *                      vf610_suspend code
+ *              PM_INFO structure(vf610_cpu_pm_info)
+ * ======================== low address =======================
+ */
+
+struct vf610_pm_base {
+	phys_addr_t pbase;
+	void __iomem *vbase;
+};
+
+struct vf610_pm_socdata {
+	const char *anatop_compat;
+	const char *scsc_compat;
+	const char *wkpu_compat;
+	const char *ccm_compat;
+	const char *gpc_compat;
+	const char *src_compat;
+	const char *ddrmc_compat;
+	const char *iomuxc_compat;
+};
+
+static const struct vf610_pm_socdata vf610_pm_data __initconst = {
+	.anatop_compat = "fsl,vf610-anatop",
+	.scsc_compat = "fsl,vf610-scsc",
+	.wkpu_compat = "fsl,vf610-wkpu",
+	.ccm_compat = "fsl,vf610-ccm",
+	.gpc_compat = "fsl,vf610-gpc",
+	.src_compat = "fsl,vf610-src",
+	.ddrmc_compat = "fsl,vf610-ddrmc",
+	.iomuxc_compat = "fsl,vf610-iomuxc",
+};
+
+/*
+ * This structure is for passing necessary data for low level ocram
+ * suspend code(arch/arm/mach-imx/suspend-vf610.S), if this struct
+ * definition is changed, the offset definition in
+ * arch/arm/mach-imx/suspend-vf610.S must be also changed accordingly,
+ * otherwise, the suspend to ocram function will be broken!
+ */
+struct vf610_cpu_pm_info {
+	phys_addr_t pbase; /* The physical address of pm_info. */
+	phys_addr_t resume_addr; /* The physical resume address for asm code */
+	u32 cpu_type; /* Currently not used, leave it for alignment */
+	u32 pm_info_size; /* Size of pm_info. */
+	struct vf610_pm_base anatop_base;
+	struct vf610_pm_base scsc_base;
+	struct vf610_pm_base wkpu_base;
+	struct vf610_pm_base ccm_base;
+	struct vf610_pm_base gpc_base;
+	struct vf610_pm_base src_base;
+	struct vf610_pm_base ddrmc_base;
+	struct vf610_pm_base iomuxc_base;
+	struct vf610_pm_base l2_base;
+	u32 ccm_cacrr;
+	u32 ccm_ccsr;
+	u32 ddrmc_io_num; /* Number of MMDC IOs which need saved/restored. */
+	u32 ddrmc_io_val[VF610_DDRMC_IO_NUM][2]; /* To save offset and value */
+	u32 iomux_ddr_io_num;
+	u32 iomux_ddr_io_val[VF610_IOMUX_DDR_IO_NUM][2];
+} __aligned(8);
+
+#ifdef DEBUG
+static void vf610_uart_reinit(unsigned long int rate, unsigned long int baud)
+{
+	u8 tmp, c2;
+	u16 sbr, brfa;
+
+	/* UART_C2 */
+	c2 = __raw_readb(uart_membase + 0x3);
+	__raw_writeb(0, uart_membase + 0x3);
+
+	sbr = (u16) (rate / (baud * 16));
+	brfa = (rate / baud) - (sbr * 16);
+
+	tmp = ((sbr & 0x1f00) >> 8);
+	__raw_writeb(tmp, uart_membase + 0x0);
+	tmp = sbr & 0x00ff;
+	__raw_writeb(tmp, uart_membase + 0x1);
+
+	/* UART_C4 */
+	__raw_writeb(brfa & 0xf, uart_membase + 0xa);
+
+	__raw_writeb(c2, uart_membase + 0x3);
+}
+#else
+#define vf610_uart_reinit(rate, baud)
+#endif
+
+static void vf610_set(void __iomem *pll_base, u32 mask)
+{
+	writel(readl(pll_base) | mask, pll_base);
+}
+
+static void vf610_clr(void __iomem *pll_base, u32 mask)
+{
+	writel(readl(pll_base) & ~mask, pll_base);
+}
+
+int vf610_set_lpm(enum vf610_cpu_pwr_mode mode)
+{
+	struct vf610_cpu_pm_info *pm_info = suspend_ocram_base;
+	void __iomem *ccm_base = pm_info->ccm_base.vbase;
+	void __iomem *gpc_base = pm_info->gpc_base.vbase;
+	void __iomem *anatop = pm_info->anatop_base.vbase;
+	u32 ccr = readl_relaxed(ccm_base + CCR);
+	u32 ccsr = readl_relaxed(ccm_base + CCSR);
+	u32 cacrr = readl_relaxed(ccm_base + CACRR);
+	u32 cclpcr = 0;
+	u32 gpc_pgcr = 0;
+
+	switch (mode) {
+	case VF610_LP_STOP:
+		/* Store clock settings */
+		pm_info->ccm_ccsr = ccsr;
+		pm_info->ccm_cacrr = cacrr;
+
+		ccr |= BM_CCR_FIRC_EN;
+		writel_relaxed(ccr, ccm_base + CCR);
+
+		cclpcr |= BM_CLPCR_ANADIG_STOP_MODE;
+		cclpcr |= BM_CLPCR_SBYOS;
+
+		cclpcr |= BM_CLPCR_MASK_SCU_IDLE;
+		cclpcr |= BM_CLPCR_MASK_L2CC_IDLE;
+		cclpcr |= BM_CLPCR_MASK_CORE1_WFI;
+		writel_relaxed(cclpcr, ccm_base + CLPCR);
+
+		gpc_pgcr |= BM_PGCR_DS_STOP;
+		gpc_pgcr |= BM_PGCR_DS_LPSTOP;
+		gpc_pgcr |= BM_PGCR_WB_STOP;
+		gpc_pgcr |= BM_PGCR_HP_OFF;
+		gpc_pgcr |= BM_PGCR_PG_PD1;
+		writel_relaxed(gpc_pgcr, gpc_base + GPC_PGCR);
+		break;
+	case VF610_STOP:
+		cclpcr &= ~BM_CLPCR_ANADIG_STOP_MODE;
+		cclpcr |= BM_CLPCR_ARM_CLK_DIS_ON_LPM;
+		cclpcr |= BM_CLPCR_SBYOS;
+		writel_relaxed(cclpcr, ccm_base + CLPCR);
+
+		gpc_pgcr |= BM_PGCR_DS_STOP;
+		gpc_pgcr |= BM_PGCR_HP_OFF;
+		writel_relaxed(gpc_pgcr, gpc_base + GPC_PGCR);
+
+		/* fall-through */
+	case VF610_LP_RUN:
+		/* Store clock settings */
+		pm_info->ccm_ccsr = ccsr;
+		pm_info->ccm_cacrr = cacrr;
+
+		ccr |= BM_CCR_FIRC_EN;
+		writel_relaxed(ccr, ccm_base + CCR);
+
+		/* Enable PLL2 for DDR clock */
+		vf610_set(anatop + ANATOP_PLL2_CTRL, BM_PLL_ENABLE);
+		vf610_clr(anatop + ANATOP_PLL2_CTRL, BM_PLL_POWERDOWN);
+		vf610_clr(anatop + ANATOP_PLL2_CTRL, BM_PLL_BYPASS);
+		while (!(readl(anatop + ANATOP_PLL2_CTRL) & BM_PLL_LOCK));
+		vf610_clr(anatop + ANATOP_PLL2_PFD, BM_PLL_PFD2_CLKGATE);
+
+		/* Switch internal OSC's */
+		ccsr &= ~BM_CCSR_FAST_CLK_SEL;
+		ccsr &= ~BM_CCSR_SLOW_CLK_SEL;
+
+		/* Select PLL2 as DDR clock */
+		ccsr &= ~BM_CCSR_DDRC_CLK_SEL;
+		writel_relaxed(ccsr, ccm_base + CCSR);
+
+		ccsr &= ~BM_CCSR_SYS_CLK_SEL_MASK;
+		writel_relaxed(ccsr, ccm_base + CCSR);
+		vf610_uart_reinit(4000000UL, 115200);
+
+		vf610_set(anatop + ANATOP_PLL1_CTRL, BM_PLL_BYPASS);
+		writel_relaxed(BM_LPMR_STOP, gpc_base + GPC_LPMR);
+		break;
+	case VF610_RUN:
+		writel_relaxed(BM_LPMR_RUN, gpc_base + GPC_LPMR);
+
+		vf610_clr(anatop + ANATOP_PLL1_CTRL, BM_PLL_BYPASS);
+		while (!(readl(anatop + ANATOP_PLL1_CTRL) & BM_PLL_LOCK));
+
+		/* Restore clock settings */
+		writel(pm_info->ccm_ccsr, ccm_base + CCSR);
+
+		vf610_uart_reinit(uart_clk, 115200);
+		pr_pmdebug("resuming, uart_reinit done");
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int vf610_suspend_finish(unsigned long val)
+{
+	if (!vf610_suspend_in_ocram_fn) {
+		cpu_do_idle();
+	} else {
+		/*
+		 * call low level suspend function in ocram,
+		 * as we need to float DDR IO.
+		 */
+		local_flush_tlb_all();
+		flush_cache_all();
+		outer_flush_all();
+		vf610_suspend_in_ocram_fn(suspend_ocram_base);
+	}
+
+	return 0;
+}
+
+static int vf610_pm_enter(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		vf610_set_lpm(VF610_STOP);
+
+		/* zzZZZzzz */
+		cpu_do_idle();
+
+		vf610_set_lpm(VF610_RUN);
+		break;
+	case PM_SUSPEND_MEM:
+		vf610_set_lpm(VF610_LP_STOP);
+
+		cpu_suspend(0, vf610_suspend_finish);
+		outer_resume();
+
+		vf610_set_lpm(VF610_RUN);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int vf610_pm_valid(suspend_state_t state)
+{
+	return (state == PM_SUSPEND_STANDBY || state == PM_SUSPEND_MEM);
+}
+
+static const struct platform_suspend_ops vf610_pm_ops = {
+	.enter = vf610_pm_enter,
+	.valid = vf610_pm_valid,
+};
+
+static int __init imx_pm_get_base(struct vf610_pm_base *base,
+				const char *compat)
+{
+	struct device_node *node;
+	struct resource res;
+	int ret = 0;
+
+	node = of_find_compatible_node(NULL, NULL, compat);
+	if (!node) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	ret = of_address_to_resource(node, 0, &res);
+	if (ret)
+		goto put_node;
+
+	base->pbase = res.start;
+	base->vbase = ioremap(res.start, resource_size(&res));
+
+	if (!base->vbase)
+		ret = -ENOMEM;
+
+put_node:
+	of_node_put(node);
+out:
+	return ret;
+}
+
+#ifdef DEBUG
+static int __init vf610_uart_init(void)
+{
+	struct device_node *dn;
+	const char *name;
+	struct clk *clk;
+	int ret;
+
+	name = of_get_property(of_chosen, "stdout-path", NULL);
+	if (name == NULL)
+		return -ENODEV;
+
+	dn = of_find_node_by_path(name);
+	if (!dn)
+		return -ENODEV;
+
+	clk = of_clk_get(dn, 0);
+
+	if (!clk) {
+		ret = PTR_ERR(clk);
+		goto put_node;
+	}
+
+	uart_clk = clk_get_rate(clk);
+
+	uart_membase = of_iomap(dn, 0);
+	if (!clk) {
+		ret = -ENOMEM;
+		goto put_node;
+	}
+
+	ret = 0;
+
+put_node:
+	of_node_put(dn);
+	return ret;
+}
+#endif
+
+static int __init vf610_suspend_init(const struct vf610_pm_socdata *socdata)
+{
+	phys_addr_t ocram_pbase;
+	struct device_node *node;
+	struct platform_device *pdev;
+	struct vf610_cpu_pm_info *pm_info;
+	struct gen_pool *ocram_pool;
+	size_t ocram_size;
+	unsigned long ocram_base;
+	int ret = 0, reg = 0;
+	int i;
+
+#ifdef DEBUG
+	ret = vf610_uart_init();
+	if (ret < 0)
+		return ret;
+#endif
+
+	suspend_set_ops(&vf610_pm_ops);
+
+	node = of_find_compatible_node(NULL, NULL, "mmio-sram");
+	if (!node) {
+		pr_warn("%s: failed to find ocram node!\n", __func__);
+		return -ENODEV;
+	}
+
+	pdev = of_find_device_by_node(node);
+	if (!pdev) {
+		pr_warn("%s: failed to find ocram device!\n", __func__);
+		ret = -ENODEV;
+		goto put_node;
+	}
+
+	ocram_pool = gen_pool_get(&pdev->dev, "stbyram1");
+	if (!ocram_pool) {
+		pr_warn("%s: ocram pool unavailable!\n", __func__);
+		ret = -ENODEV;
+		goto put_node;
+	}
+
+	ocram_size = gen_pool_size(ocram_pool);
+	ocram_base = gen_pool_alloc(ocram_pool, ocram_size);
+	if (!ocram_base) {
+		pr_warn("%s: unable to alloc ocram!\n", __func__);
+		ret = -ENOMEM;
+		goto put_node;
+	}
+
+	ocram_pbase = gen_pool_virt_to_phys(ocram_pool, ocram_base);
+
+	suspend_ocram_base = __arm_ioremap_exec(ocram_pbase, ocram_size, false);
+
+	pm_info = suspend_ocram_base;
+	pm_info->pbase = ocram_pbase;
+	pm_info->resume_addr = virt_to_phys(cpu_resume);
+	pm_info->pm_info_size = sizeof(*pm_info);
+
+	ret = imx_pm_get_base(&pm_info->anatop_base, socdata->anatop_compat);
+	if (ret) {
+		pr_warn("%s: failed to get anatop base %d!\n", __func__, ret);
+		goto put_node;
+	}
+
+	ret = imx_pm_get_base(&pm_info->scsc_base, socdata->scsc_compat);
+	if (ret) {
+		pr_warn("%s: failed to get scsc base %d!\n", __func__, ret);
+		goto scsc_map_failed;
+	}
+
+	ret = imx_pm_get_base(&pm_info->ccm_base, socdata->ccm_compat);
+	if (ret) {
+		pr_warn("%s: failed to get ccm base %d!\n", __func__, ret);
+		goto ccm_map_failed;
+	}
+
+	ret = imx_pm_get_base(&pm_info->gpc_base, socdata->gpc_compat);
+	if (ret) {
+		pr_warn("%s: failed to get gpc base %d!\n", __func__, ret);
+		goto gpc_map_failed;
+	}
+
+	ret = imx_pm_get_base(&pm_info->src_base, socdata->src_compat);
+	if (ret) {
+		pr_warn("%s: failed to get src base %d!\n", __func__, ret);
+		goto src_map_failed;
+	}
+
+	ret = imx_pm_get_base(&pm_info->ddrmc_base, socdata->ddrmc_compat);
+	if (ret) {
+		pr_warn("%s: failed to get ddrmc base %d!\n", __func__, ret);
+		goto ddrmc_map_failed;
+	}
+
+	ret = imx_pm_get_base(&pm_info->iomuxc_base, socdata->iomuxc_compat);
+	if (ret) {
+		pr_warn("%s: failed to get iomuxc base %d!\n", __func__, ret);
+		goto iomuxc_map_failed;
+	}
+
+	ret = imx_pm_get_base(&pm_info->l2_base, "arm,pl310-cache");
+	if (ret == -ENODEV)
+		ret = 0;
+	if (ret) {
+		pr_warn("%s: failed to get pl310-cache base %d!\n",
+			__func__, ret);
+		goto pl310_cache_map_failed;
+	}
+
+	pm_info->ddrmc_io_num = VF610_DDRMC_IO_NUM;
+
+	/* Store DDRMC registers */
+	for (i = 0; i < ARRAY_SIZE(vf610_ddrmc_io_offset); i++, reg++) {
+		pm_info->ddrmc_io_val[reg][0] = vf610_ddrmc_io_offset[i];
+		pm_info->ddrmc_io_val[reg][1] =
+			readl_relaxed(pm_info->ddrmc_base.vbase +
+			vf610_ddrmc_io_offset[i]);
+	}
+
+	/* Store DDRMC PHY registers */
+	for (i = 0; i < ARRAY_SIZE(vf610_ddrmc_phy_io_offset); i++, reg++) {
+		pm_info->ddrmc_io_val[reg][0] = vf610_ddrmc_phy_io_offset[i] +
+			DDRMC_PHY_OFFSET;
+		pm_info->ddrmc_io_val[reg][1] =
+			readl_relaxed(pm_info->ddrmc_base.vbase +
+			DDRMC_PHY_OFFSET + vf610_ddrmc_phy_io_offset[i]);
+	}
+
+	/* Store IOMUX DDR pad registers */
+	pm_info->iomux_ddr_io_num = VF610_IOMUX_DDR_IO_NUM;
+	for (i = 0; i < ARRAY_SIZE(vf610_iomuxc_ddr_io_offset); i++) {
+		pm_info->iomux_ddr_io_val[i][0] = vf610_iomuxc_ddr_io_offset[i];
+		pm_info->iomux_ddr_io_val[i][1] =
+			readl_relaxed(pm_info->iomuxc_base.vbase +
+			vf610_iomuxc_ddr_io_offset[i]);
+	}
+
+	vf610_suspend_in_ocram_fn = fncpy(
+		suspend_ocram_base + sizeof(*pm_info),
+		&vf610_suspend, ocram_size - sizeof(*pm_info));
+
+	goto put_node;
+
+pl310_cache_map_failed:
+	iounmap(pm_info->iomuxc_base.vbase);
+iomuxc_map_failed:
+	iounmap(pm_info->ddrmc_base.vbase);
+ddrmc_map_failed:
+	iounmap(pm_info->src_base.vbase);
+src_map_failed:
+	iounmap(pm_info->gpc_base.vbase);
+gpc_map_failed:
+	iounmap(pm_info->ccm_base.vbase);
+ccm_map_failed:
+	iounmap(pm_info->scsc_base.vbase);
+scsc_map_failed:
+	iounmap(pm_info->anatop_base.vbase);
+put_node:
+	of_node_put(node);
+
+	return ret;
+}
+
+void __init vf610_pm_init(void)
+{
+	int ret;
+
+	if (IS_ENABLED(CONFIG_SUSPEND)) {
+		ret = vf610_suspend_init(&vf610_pm_data);
+		if (ret)
+			pr_warn("%s: No DDR LPM support with suspend %d!\n",
+				__func__, ret);
+	}
+}
+
diff --git a/arch/arm/mach-imx/suspend-vf610.S b/arch/arm/mach-imx/suspend-vf610.S
new file mode 100644
index 0000000..09ad246
--- /dev/null
+++ b/arch/arm/mach-imx/suspend-vf610.S
@@ -0,0 +1,437 @@
+/*
+ * Copyright 2014 Freescale Semiconductor, Inc.
+ * Copyright 2016 Toradex AG
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/asm-offsets.h>
+#include <asm/hardware/cache-l2x0.h>
+
+/*
+ * ==================== low level suspend ====================
+ *
+ * Better to follow below rules to use ARM registers:
+ * r0: pm_info structure address;
+ * r1 ~ r4: for saving pm_info members;
+ * r5 ~ r10: free registers;
+ * r11: io base address.
+ *
+ * suspend ocram space layout:
+ * ======================== high address ======================
+ *                              .
+ *                              .
+ *                              .
+ *                              ^
+ *                              ^
+ *                              ^
+ *                      vf610_suspend code
+ *              PM_INFO structure(vf610_cpu_pm_info)
+ * ======================== low address =======================
+ */
+
+/*
+ * Below offsets are based on struct vf610_cpu_pm_info
+ * which defined in arch/arm/mach-imx/pm-vf610.c, this
+ * structure contains necessary pm info for low level
+ * suspend related code.
+ */
+#define PM_INFO_PBASE_OFFSET			0x0
+#define PM_INFO_RESUME_ADDR_OFFSET		0x4
+#define PM_INFO_CPU_TYPE_OFFSET			0x8
+#define PM_INFO_PM_INFO_SIZE_OFFSET		0xC
+#define PM_INFO_VF610_ANATOP_P_OFFSET		0x10
+#define PM_INFO_VF610_ANATOP_V_OFFSET		0x14
+#define PM_INFO_VF610_SCSC_P_OFFSET		0x18
+#define PM_INFO_VF610_SCSC_V_OFFSET		0x1C
+#define PM_INFO_VF610_WKPU_P_OFFSET		0x20
+#define PM_INFO_VF610_WKPU_V_OFFSET		0x24
+#define PM_INFO_VF610_CCM_P_OFFSET		0x28
+#define PM_INFO_VF610_CCM_V_OFFSET		0x2C
+#define PM_INFO_VF610_GPC_P_OFFSET		0x30
+#define PM_INFO_VF610_GPC_V_OFFSET		0x34
+#define PM_INFO_VF610_SRC_P_OFFSET		0x38
+#define PM_INFO_VF610_SRC_V_OFFSET		0x3C
+#define PM_INFO_VF610_DDRMC_P_OFFSET		0x40
+#define PM_INFO_VF610_DDRMC_V_OFFSET		0x44
+#define PM_INFO_VF610_IOMUXC_P_OFFSET		0x48
+#define PM_INFO_VF610_IOMUXC_V_OFFSET		0x4c
+#define PM_INFO_VF610_L2_P_OFFSET		0x50
+#define PM_INFO_VF610_L2_V_OFFSET		0x54
+#define PM_INFO_CCM_CACRR			0x58
+#define PM_INFO_CCM_CCSR			0x5c
+#define PM_INFO_DDRMC_IO_NUM_OFFSET		0x60
+#define PM_INFO_DDRMC_IO_VAL_OFFSET		0x64
+#define PM_INFO_IOMUXC_DDR_IO_NUM_OFFSET	(0x64 + 94 * 2 * 4)
+#define PM_INFO_IOMUXC_DDR_IO_VAL_OFFSET	(0x68 + 94 * 2 * 4)
+
+#define VF610_ANADIG_PLL2_CTRL			0x30
+
+#define VF610_ANADIG_MISC0			0x150
+#define VF610_ANADIG_MISC0_CLK_24M_IRC_XTAL_SEL	(0x1 < 13)
+
+#define VF610_ANADIG_PLL1_CTRL			0x270
+
+#define VF610_ANADIG_POWERDOWN			(1 << 12)
+#define VF610_ANADIG_ENABLE			(1 << 13)
+#define VF610_ANADIG_BYPASS			(1 << 16)
+#define VF610_ANADIG_LOCK			(1 << 31)
+
+#define VF610_SCSC_SIRC				0x0
+#define VF610_SCSC_SIRC_SIRC_EN			(0x1 << 0)
+#define VF610_SCSC_SOSC				0x4
+#define VF610_SCSC_SOSC_SOSC_EN			(0x1 << 0)
+
+#define VF610_GPC_PGCR				0x0
+#define VF610_GPC_LPMR				0x40
+
+#define VF610_CCM_CCR				0x00
+#define VF610_CCM_CCR_FXOSC_EN			(0x1 << 12)
+
+#define VF610_CCM_CCSR				0x08
+#define VF610_CCM_CCSR_DDRC_CLK_SEL		(0x1 << 6)
+#define VF610_CCM_CCSR_FAST_CLK_SEL		(0x1 << 5)
+
+#define VF610_CCM_CACRR				0x0C
+
+#define VF610_CCM_CLPCR				0x2C
+#define VF610_CCM_CLPCR_DIS_REF_OSC		(0x1 << 7)
+#define VF610_CCM_CLPCR_FXOSC_PWRDWN		(0x1 << 11)
+
+#define VF610_CCM_CCGR0				0x40
+#define VF610_CCM_CCGR2				0x48
+#define VF610_CCM_CCGR3				0x4C
+#define VF610_CCM_CCGR4				0x50
+#define VF610_CCM_CCGR6				0x58
+
+#define VF610_SRC_GPR0				0x20
+#define VF610_SRC_GPR1				0x24
+#define VF610_SRC_MISC2				0x54
+
+#define VF610_DDRMC_CR00			0x0
+#define VF610_DDRMC_CR00_START			(0x1 << 0)
+
+#define VF610_DDRMC_CR33			0x84
+#define VF610_DDRMC_CR33_PWUP_SREF_EX		(0x1 << 0)
+
+#define VF610_DDRMC_CR34			0x88
+
+#define VF610_DDRMC_CR35			0x8C
+#define VF610_DDRMC_CR35_LP_CMD(cmd)		((cmd) << 8)
+
+#define VF610_DDRMC_CR80			0x140
+#define VF610_DDRMC_CR80_LP_COMPLETE		(0x1 << 9)
+#define VF610_DDRMC_CR80_INIT_COMPLETE		(0x1 << 8)
+#define VF610_DDRMC_CR81			0x144
+
+	.align 3
+
+	/*
+	 * Take DDR RAM out of Low-Power mode
+	 */
+	.macro resume_ddrmc ddrmc_base
+
+	/* Clear low power complete flag... */
+	ldr	r6, =VF610_DDRMC_CR80_LP_COMPLETE
+	str	r6, [\ddrmc_base, #VF610_DDRMC_CR81]
+
+	ldr	r6, [\ddrmc_base, #VF610_DDRMC_CR35]
+	orr	r6, r6, #VF610_DDRMC_CR35_LP_CMD(0x9)
+	str	r6, [\ddrmc_base, #VF610_DDRMC_CR35]
+
+1:
+	ldr	r5, [\ddrmc_base, #VF610_DDRMC_CR80]
+	ands 	r5, r5, #VF610_DDRMC_CR80_LP_COMPLETE
+	beq	1b
+
+	.endm
+
+	.macro enable_syspll pll_base
+
+	ldr	r5, [\pll_base]
+	orr	r5, r5, #VF610_ANADIG_ENABLE
+	bic	r5, r5, #VF610_ANADIG_POWERDOWN
+	bic	r5, r5, #VF610_ANADIG_BYPASS
+	str	r5, [\pll_base]
+
+1:
+	ldr	r5, [\pll_base]
+	tst 	r5, #VF610_ANADIG_LOCK
+	beq	1b
+
+	.endm
+
+ENTRY(vf610_suspend)
+	ldr	r1, [r0, #PM_INFO_PBASE_OFFSET]
+	ldr	r2, [r0, #PM_INFO_RESUME_ADDR_OFFSET]
+	ldr	r3, [r0, #PM_INFO_CPU_TYPE_OFFSET]
+	ldr	r4, [r0, #PM_INFO_PM_INFO_SIZE_OFFSET]
+
+	/*
+	 * make sure TLB contain the addr we want,
+	 * as we will access them after DDRMC IO floated.
+	 */
+
+	ldr	r11, [r0, #PM_INFO_VF610_DDRMC_V_OFFSET]
+	ldr	r6, [r11, #0x0]
+	ldr	r11, [r0, #PM_INFO_VF610_GPC_V_OFFSET]
+	ldr	r6, [r11, #0x0]
+	ldr	r11, [r0, #PM_INFO_VF610_SRC_V_OFFSET]
+	ldr	r6, [r11, #0x0]
+	ldr	r11, [r0, #PM_INFO_VF610_CCM_V_OFFSET]
+	ldr	r6, [r11, #0x0]
+
+	ldr	r11, [r0, #PM_INFO_VF610_SRC_V_OFFSET]
+
+	/* Disable DDR RESET */
+	ldr	r6, [r11, #VF610_SRC_MISC2]
+	orr	r6, r6, #0x1
+	str	r6, [r11, #VF610_SRC_MISC2]
+
+	/* Set ENTRY/ARGUMENT register */
+	ldr	r6, =vf610_suspend
+	ldr	r7, =resume
+	sub	r7, r7, r6
+	add	r8, r1, r4
+	add	r9, r8, r7
+	str	r9, [r11, #VF610_SRC_GPR0]
+	str	r1, [r11, #VF610_SRC_GPR1]
+
+	/* Put memory in self refresh... */
+	ldr	r11, [r0, #PM_INFO_VF610_DDRMC_V_OFFSET]
+
+	ldr	r6, =VF610_DDRMC_CR80_LP_COMPLETE
+	str	r6, [r11, #VF610_DDRMC_CR81]
+
+	ldr	r6, [r11, #VF610_DDRMC_CR35]
+	orr	r6, r6, #VF610_DDRMC_CR35_LP_CMD(0xA)
+	str	r6, [r11, #VF610_DDRMC_CR35]
+
+ddrmc_cmd_complete:
+	/* Hardware without CKE/RESET fixes seems to hang@this read.... */
+	ldr	r5, [r11, #VF610_DDRMC_CR80]
+	ands 	r5, r5, #VF610_DDRMC_CR80_LP_COMPLETE
+	beq	ddrmc_cmd_complete
+
+	/* switch to internal FIRC */
+	ldr	r11, [r0, #PM_INFO_VF610_CCM_V_OFFSET]
+	ldr	r5, [r11, #VF610_CCM_CCSR]
+	bic	r5, r5, #0x30 /* FAST_/SLOW_CLK_SEL */
+	str	r5, [r11, #VF610_CCM_CCSR]
+	bic	r5, r5, #0x07 /* SYS_CLK_SEL */
+	str	r5, [r11, #VF610_CCM_CCSR]
+
+	/* LP-Mode: STOP */
+	ldr	r11, [r0, #PM_INFO_VF610_GPC_V_OFFSET]
+	ldr	r6, =0x02
+	str	r6, [r11, #VF610_GPC_LPMR]
+
+	/* Zzz, enter stop mode */
+	wfi
+	nop
+	nop
+	nop
+	nop
+
+	/* If we get here, there is already an interrupt pending. Restore... */
+	ldr	r6, =0x00
+	str	r6, [r11, #VF610_GPC_LPMR]
+
+	/* Get previous CCSR/CACRR settings */
+	ldr	r11, [r0, #PM_INFO_VF610_CCM_V_OFFSET]
+	ldr	r5, [r0, #PM_INFO_CCM_CCSR]
+	str	r5, [r11, #VF610_CCM_CCSR]
+
+	ldr	r5, [r0, #PM_INFO_CCM_CACRR]
+	str	r5, [r11, #VF610_CCM_CACRR]
+
+	ldr	r11, [r0, #PM_INFO_VF610_DDRMC_V_OFFSET]
+	resume_ddrmc r11
+
+	ret	lr
+
+/* Resume path if CPU uses the SRC_GPR0 (PERSISTENT_ENTRY0) */
+resume:
+	/* invalidate L1 I-cache first */
+	mov     r6, #0x0
+	mcr     p15, 0, r6, c7, c5, 0
+	mcr     p15, 0, r6, c7, c5, 6
+
+	/* enable the Icache and branch prediction */
+	mov     r6, #0x1800
+	mcr     p15, 0, r6, c1, c0, 0
+	isb
+
+	ldr	r11, [r0, #PM_INFO_VF610_CCM_P_OFFSET]
+
+	ldr	r5, [r11, #VF610_CCM_CCSR]
+	orr	r5, r5, #(1 << 13)
+	str	r5, [r11, #VF610_CCM_CCSR]
+
+	/* enable IOMUX, PORT A-E */
+	ldr	r5, [r11, #VF610_CCM_CCGR2]
+	ldr	r6, =0xfff0000
+	orr	r5, r5, r6
+	str	r5, [r11, #VF610_CCM_CCGR2]
+
+	/* enable ANADIG and SCSM */
+	ldr	r5, [r11, #VF610_CCM_CCGR3]
+	orr	r5, r5, #0x33
+	str	r5, [r11, #VF610_CCM_CCGR3]
+
+	/* enable GPC, CCM and WKUP */
+	ldr	r5, [r11, #VF610_CCM_CCGR4]
+	orr	r5, r5, #0x3f00000
+	str	r5, [r11, #VF610_CCM_CCGR4]
+
+	/* enable DDRMC */
+	ldr	r5, [r11, #VF610_CCM_CCGR6]
+	orr	r5, r5, #0x30000000
+	str	r5, [r11, #VF610_CCM_CCGR6]
+
+#ifdef DEBUG
+	/* enable UART0 */
+	ldr	r5, [r11, #VF610_CCM_CCGR0]
+	orr	r5, r5, #0xC000
+	str	r5, [r11, #VF610_CCM_CCGR0]
+
+	/* Mux UART0 */
+	ldr	r5,=0x1021a2
+	ldr	r6,=0x40048080
+	str	r5, [r6, #0x0]
+	ldr	r5,=0x1021a1
+	ldr	r6,=0x40048084
+	str	r5, [r6, #0x0]
+#endif
+
+	/* Set IOMUX for DDR pads */
+	ldr	r11, [r0, #PM_INFO_VF610_IOMUXC_P_OFFSET]
+
+	ldr	r6, [r0, #PM_INFO_IOMUXC_DDR_IO_NUM_OFFSET]
+	ldr	r7, =PM_INFO_IOMUXC_DDR_IO_VAL_OFFSET
+	add	r7, r7, r0
+
+loop_iomuxc_ddr_restore:
+	ldr	r8, [r7], #0x4
+	ldr	r9, [r7], #0x4
+	str	r9, [r11, r8]
+	subs	r6, r6, #0x1
+	bne	loop_iomuxc_ddr_restore
+
+
+	/* Enable slow oscilators */
+	ldr	r11, [r0, #PM_INFO_VF610_SCSC_P_OFFSET]
+
+	ldr	r5, [r11, #VF610_SCSC_SOSC]
+	orr	r5, r5, #VF610_SCSC_SOSC_SOSC_EN
+	str	r5, [r11, #VF610_SCSC_SOSC]
+
+	ldr	r5, [r11, #VF610_SCSC_SIRC]
+	orr	r5, r5, #VF610_SCSC_SIRC_SIRC_EN
+	str	r5, [r11, #VF610_SCSC_SIRC]
+
+	/* Enable fast osciallator */
+	ldr	r11, [r0, #PM_INFO_VF610_CCM_P_OFFSET]
+
+	ldr	r5, [r11, #VF610_CCM_CLPCR]
+	bic	r5, r5, #VF610_CCM_CLPCR_DIS_REF_OSC
+	bic	r5, r5, #VF610_CCM_CLPCR_FXOSC_PWRDWN
+	str	r5, [r11, #VF610_CCM_CLPCR]
+
+	ldr	r5, [r11, #VF610_CCM_CCR]
+	orr	r5, r5, #VF610_CCM_CCR_FXOSC_EN
+	str	r5, [r11, #VF610_CCM_CCR]
+
+	ldr	r5, [r11, #VF610_CCM_CCSR]
+	orr	r5, r5, #VF610_CCM_CCSR_FAST_CLK_SEL
+	str	r5, [r11, #VF610_CCM_CCSR]
+
+	ldr	r11, [r0, #PM_INFO_VF610_ANATOP_P_OFFSET]
+
+	/* Select external FXOSC */
+	ldr	r5, [r11, #VF610_ANADIG_MISC0]
+	bic	r5, r5, #VF610_ANADIG_MISC0_CLK_24M_IRC_XTAL_SEL
+	str	r5, [r11, #VF610_ANADIG_MISC0]
+
+	add	r6, r11, #VF610_ANADIG_PLL1_CTRL
+	enable_syspll r6
+
+	/* enable pll2 only if required for DDR */
+	ldr	r5, [r0, #PM_INFO_CCM_CCSR]
+	tst 	r5, #VF610_CCM_CCSR_DDRC_CLK_SEL
+	bne	switch_sysclk
+
+	add	r6, r11, #VF610_ANADIG_PLL2_CTRL
+	enable_syspll r6
+
+switch_sysclk:
+
+	/* Enable PFD and switch to fast clock */
+	ldr	r11, [r0, #PM_INFO_VF610_CCM_P_OFFSET]
+
+	/* Get previous CCSR/CACRR settings */
+	ldr	r5, [r0, #PM_INFO_CCM_CCSR]
+	str	r5, [r11, #VF610_CCM_CCSR]
+
+	ldr	r5, [r0, #PM_INFO_CCM_CACRR]
+	str	r5, [r11, #VF610_CCM_CACRR]
+
+	/* Restore memory configuration */
+	ldr	r11, [r0, #PM_INFO_VF610_DDRMC_P_OFFSET]
+
+	ldr	r6, [r0, #PM_INFO_DDRMC_IO_NUM_OFFSET]
+	ldr	r7, =PM_INFO_DDRMC_IO_VAL_OFFSET
+	add	r7, r7, r0
+
+	/* Clear start bit of first memory register, do not start yet... */
+	ldr	r8, [r7], #0x4
+	ldr	r9, [r7], #0x4
+	bic	r9, r9, #VF610_DDRMC_CR00_START
+	str	r9, [r11, r8]
+	subs	r6, r6, #0x1
+
+loop_ddrmc_restore:
+	ldr	r8, [r7], #0x4
+	ldr	r9, [r7], #0x4
+	str	r9, [r11, r8]
+	subs	r6, r6, #0x1
+	bne	loop_ddrmc_restore
+
+	/* Set PWUP_SREF_EX to avoid a full memory initialization */
+	ldr	r6, [r11, #VF610_DDRMC_CR33]
+	orr	r6, r6, #VF610_DDRMC_CR33_PWUP_SREF_EX
+	str	r6, [r11, #VF610_DDRMC_CR33]
+
+	/* Start initialization */
+	ldr	r6, =VF610_DDRMC_CR80_INIT_COMPLETE
+	str	r6, [r11, #VF610_DDRMC_CR81]
+
+	ldr	r6, [r11, #VF610_DDRMC_CR00]
+	orr	r6, r6, #VF610_DDRMC_CR00_START
+	str	r6, [r11, #VF610_DDRMC_CR00]
+
+ddrmc_initializing:
+	ldr	r5, [r11, #VF610_DDRMC_CR80]
+	ands 	r5, r5, #VF610_DDRMC_CR80_INIT_COMPLETE
+	beq	ddrmc_initializing
+
+	resume_ddrmc r11
+
+	/* LP-Mode: RUN */
+	ldr	r11, [r0, #PM_INFO_VF610_GPC_P_OFFSET]
+	ldr	r5, =0x0
+	str	r5, [r11, #VF610_GPC_LPMR]
+
+	/* get physical resume address from pm_info. */
+	ldr	lr, [r0, #PM_INFO_RESUME_ADDR_OFFSET]
+
+	ret	lr
+ENDPROC(vf610_suspend)
+
diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
index 170a96c..27d4cf0 100644
--- a/drivers/clk/imx/clk-vf610.c
+++ b/drivers/clk/imx/clk-vf610.c
@@ -117,6 +117,11 @@ static struct clk_div_table pll4_audio_div_table[] = {
 static struct clk *clk[VF610_CLK_END];
 static struct clk_onecell_data clk_data;
 
+static u32 anadig_pll3_ctrl;
+static u32 anadig_pll4_ctrl;
+static u32 anadig_pll5_ctrl;
+static u32 anadig_pll6_ctrl;
+static u32 anadig_pll7_ctrl;
 static u32 cscmr1;
 static u32 cscmr2;
 static u32 cscdr1;
@@ -147,6 +152,12 @@ static int vf610_clk_suspend(void)
 {
 	int i;
 
+	anadig_pll3_ctrl = readl_relaxed(PLL3_CTRL);
+	anadig_pll4_ctrl = readl_relaxed(PLL4_CTRL);
+	anadig_pll5_ctrl = readl_relaxed(PLL5_CTRL);
+	anadig_pll6_ctrl = readl_relaxed(PLL6_CTRL);
+	anadig_pll7_ctrl = readl_relaxed(PLL7_CTRL);
+
 	cscmr1 = readl_relaxed(CCM_CSCMR1);
 	cscmr2 = readl_relaxed(CCM_CSCMR2);
 
@@ -164,6 +175,12 @@ static void vf610_clk_resume(void)
 {
 	int i;
 
+	writel_relaxed(anadig_pll3_ctrl, PLL3_CTRL);
+	writel_relaxed(anadig_pll4_ctrl, PLL4_CTRL);
+	writel_relaxed(anadig_pll5_ctrl, PLL5_CTRL);
+	writel_relaxed(anadig_pll6_ctrl, PLL6_CTRL);
+	writel_relaxed(anadig_pll7_ctrl, PLL7_CTRL);
+
 	writel_relaxed(cscmr1, CCM_CSCMR1);
 	writel_relaxed(cscmr2, CCM_CSCMR2);
 
-- 
2.7.2
