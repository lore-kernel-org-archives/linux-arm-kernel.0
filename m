From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Oct 2013 11:17:11 +0800
Subject: [PATCH 1/4] ARM: imx6q: move low-power code out of clock driver
In-Reply-To: <1381979834-20998-1-git-send-email-shawn.guo@linaro.org>
References: <1381979834-20998-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1381979834-20998-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LPM (Low Power Mode) code that currently sits in imx6q clock driver
will be reused by imx6sl.  Let's move it into pm-imx6q.c, so that we
can keep clock driver SoC specific and reuse pm-imx6q.c on imx6sl.

In order to avoid adding another ioremap for CCM block,
imx6q_pm_set_ccm_base() is created to let clock driver set up ccm_base
for pm code.

During the move, the unused CCGR macros get removed.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-imx6q.c |  156 +----------------------------------------
 arch/arm/mach-imx/common.h    |    2 +
 arch/arm/mach-imx/pm-imx6q.c  |  152 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+), 154 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 07bc0d8..d756d91 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -14,7 +14,6 @@
 #include <linux/types.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
-#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -25,155 +24,6 @@
 #include "common.h"
 #include "hardware.h"
 
-#define CCR				0x0
-#define BM_CCR_WB_COUNT			(0x7 << 16)
-#define BM_CCR_RBC_BYPASS_COUNT		(0x3f << 21)
-#define BM_CCR_RBC_EN			(0x1 << 27)
-
-#define CCGR0				0x68
-#define CCGR1				0x6c
-#define CCGR2				0x70
-#define CCGR3				0x74
-#define CCGR4				0x78
-#define CCGR5				0x7c
-#define CCGR6				0x80
-#define CCGR7				0x84
-
-#define CLPCR				0x54
-#define BP_CLPCR_LPM			0
-#define BM_CLPCR_LPM			(0x3 << 0)
-#define BM_CLPCR_BYPASS_PMIC_READY	(0x1 << 2)
-#define BM_CLPCR_ARM_CLK_DIS_ON_LPM	(0x1 << 5)
-#define BM_CLPCR_SBYOS			(0x1 << 6)
-#define BM_CLPCR_DIS_REF_OSC		(0x1 << 7)
-#define BM_CLPCR_VSTBY			(0x1 << 8)
-#define BP_CLPCR_STBY_COUNT		9
-#define BM_CLPCR_STBY_COUNT		(0x3 << 9)
-#define BM_CLPCR_COSC_PWRDOWN		(0x1 << 11)
-#define BM_CLPCR_WB_PER_AT_LPM		(0x1 << 16)
-#define BM_CLPCR_WB_CORE_AT_LPM		(0x1 << 17)
-#define BM_CLPCR_BYP_MMDC_CH0_LPM_HS	(0x1 << 19)
-#define BM_CLPCR_BYP_MMDC_CH1_LPM_HS	(0x1 << 21)
-#define BM_CLPCR_MASK_CORE0_WFI		(0x1 << 22)
-#define BM_CLPCR_MASK_CORE1_WFI		(0x1 << 23)
-#define BM_CLPCR_MASK_CORE2_WFI		(0x1 << 24)
-#define BM_CLPCR_MASK_CORE3_WFI		(0x1 << 25)
-#define BM_CLPCR_MASK_SCU_IDLE		(0x1 << 26)
-#define BM_CLPCR_MASK_L2CC_IDLE		(0x1 << 27)
-
-#define CGPR				0x64
-#define BM_CGPR_CHICKEN_BIT		(0x1 << 17)
-
-static void __iomem *ccm_base;
-
-void imx6q_set_chicken_bit(void)
-{
-	u32 val = readl_relaxed(ccm_base + CGPR);
-
-	val |= BM_CGPR_CHICKEN_BIT;
-	writel_relaxed(val, ccm_base + CGPR);
-}
-
-static void imx6q_enable_rbc(bool enable)
-{
-	u32 val;
-	static bool last_rbc_mode;
-
-	if (last_rbc_mode == enable)
-		return;
-	/*
-	 * need to mask all interrupts in GPC before
-	 * operating RBC configurations
-	 */
-	imx_gpc_mask_all();
-
-	/* configure RBC enable bit */
-	val = readl_relaxed(ccm_base + CCR);
-	val &= ~BM_CCR_RBC_EN;
-	val |= enable ? BM_CCR_RBC_EN : 0;
-	writel_relaxed(val, ccm_base + CCR);
-
-	/* configure RBC count */
-	val = readl_relaxed(ccm_base + CCR);
-	val &= ~BM_CCR_RBC_BYPASS_COUNT;
-	val |= enable ? BM_CCR_RBC_BYPASS_COUNT : 0;
-	writel(val, ccm_base + CCR);
-
-	/*
-	 * need to delay@least 2 cycles of CKIL(32K)
-	 * due to hardware design requirement, which is
-	 * ~61us, here we use 65us for safe
-	 */
-	udelay(65);
-
-	/* restore GPC interrupt mask settings */
-	imx_gpc_restore_all();
-
-	last_rbc_mode = enable;
-}
-
-static void imx6q_enable_wb(bool enable)
-{
-	u32 val;
-	static bool last_wb_mode;
-
-	if (last_wb_mode == enable)
-		return;
-
-	/* configure well bias enable bit */
-	val = readl_relaxed(ccm_base + CLPCR);
-	val &= ~BM_CLPCR_WB_PER_AT_LPM;
-	val |= enable ? BM_CLPCR_WB_PER_AT_LPM : 0;
-	writel_relaxed(val, ccm_base + CLPCR);
-
-	/* configure well bias count */
-	val = readl_relaxed(ccm_base + CCR);
-	val &= ~BM_CCR_WB_COUNT;
-	val |= enable ? BM_CCR_WB_COUNT : 0;
-	writel_relaxed(val, ccm_base + CCR);
-
-	last_wb_mode = enable;
-}
-
-int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
-{
-	u32 val = readl_relaxed(ccm_base + CLPCR);
-
-	val &= ~BM_CLPCR_LPM;
-	switch (mode) {
-	case WAIT_CLOCKED:
-		imx6q_enable_wb(false);
-		imx6q_enable_rbc(false);
-		break;
-	case WAIT_UNCLOCKED:
-		val |= 0x1 << BP_CLPCR_LPM;
-		val |= BM_CLPCR_ARM_CLK_DIS_ON_LPM;
-		break;
-	case STOP_POWER_ON:
-		val |= 0x2 << BP_CLPCR_LPM;
-		break;
-	case WAIT_UNCLOCKED_POWER_OFF:
-		val |= 0x1 << BP_CLPCR_LPM;
-		val &= ~BM_CLPCR_VSTBY;
-		val &= ~BM_CLPCR_SBYOS;
-		break;
-	case STOP_POWER_OFF:
-		val |= 0x2 << BP_CLPCR_LPM;
-		val |= 0x3 << BP_CLPCR_STBY_COUNT;
-		val |= BM_CLPCR_VSTBY;
-		val |= BM_CLPCR_SBYOS;
-		imx6q_enable_wb(true);
-		imx6q_enable_rbc(true);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	writel_relaxed(val, ccm_base + CLPCR);
-
-	return 0;
-}
-
 static const char *step_sels[]	= { "osc", "pll2_pfd2_396m", };
 static const char *pll1_sw_sels[]	= { "pll1_sys", "step", };
 static const char *periph_pre_sels[]	= { "pll2_bus", "pll2_pfd2_396m", "pll2_pfd0_352m", "pll2_198m", };
@@ -384,7 +234,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	np = ccm_node;
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
-	ccm_base = base;
+
+	imx6q_pm_set_ccm_base(base);
 
 	/*                                  name                reg       shift width parent_names     num_parents */
 	clk[step]             = imx_clk_mux("step",	        base + 0xc,  8,  1, step_sels,	       ARRAY_SIZE(step_sels));
@@ -627,9 +478,6 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	if (IS_ENABLED(CONFIG_PCI_IMX6))
 		clk_set_parent(clk[lvds1_sel], clk[sata_ref]);
 
-	/* Set initial power mode */
-	imx6q_set_lpm(WAIT_CLOCKED);
-
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-gpt");
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index c1fe6d5..2b4ce09 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -151,9 +151,11 @@ int imx_cpu_kill(unsigned int cpu);
 
 #ifdef CONFIG_PM
 void imx6q_pm_init(void);
+void imx6q_pm_set_ccm_base(void __iomem *base);
 void imx5_pm_init(void);
 #else
 static inline void imx6q_pm_init(void) {}
+static inline void imx6q_pm_set_ccm_base(void __iomem *base) {}
 static inline void imx5_pm_init(void) {}
 #endif
 
diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index 2049427..461a895 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -10,9 +10,11 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/suspend.h>
 #include <asm/cacheflush.h>
 #include <asm/proc-fns.h>
@@ -22,6 +24,146 @@
 #include "common.h"
 #include "hardware.h"
 
+#define CCR				0x0
+#define BM_CCR_WB_COUNT			(0x7 << 16)
+#define BM_CCR_RBC_BYPASS_COUNT		(0x3f << 21)
+#define BM_CCR_RBC_EN			(0x1 << 27)
+
+#define CLPCR				0x54
+#define BP_CLPCR_LPM			0
+#define BM_CLPCR_LPM			(0x3 << 0)
+#define BM_CLPCR_BYPASS_PMIC_READY	(0x1 << 2)
+#define BM_CLPCR_ARM_CLK_DIS_ON_LPM	(0x1 << 5)
+#define BM_CLPCR_SBYOS			(0x1 << 6)
+#define BM_CLPCR_DIS_REF_OSC		(0x1 << 7)
+#define BM_CLPCR_VSTBY			(0x1 << 8)
+#define BP_CLPCR_STBY_COUNT		9
+#define BM_CLPCR_STBY_COUNT		(0x3 << 9)
+#define BM_CLPCR_COSC_PWRDOWN		(0x1 << 11)
+#define BM_CLPCR_WB_PER_AT_LPM		(0x1 << 16)
+#define BM_CLPCR_WB_CORE_AT_LPM		(0x1 << 17)
+#define BM_CLPCR_BYP_MMDC_CH0_LPM_HS	(0x1 << 19)
+#define BM_CLPCR_BYP_MMDC_CH1_LPM_HS	(0x1 << 21)
+#define BM_CLPCR_MASK_CORE0_WFI		(0x1 << 22)
+#define BM_CLPCR_MASK_CORE1_WFI		(0x1 << 23)
+#define BM_CLPCR_MASK_CORE2_WFI		(0x1 << 24)
+#define BM_CLPCR_MASK_CORE3_WFI		(0x1 << 25)
+#define BM_CLPCR_MASK_SCU_IDLE		(0x1 << 26)
+#define BM_CLPCR_MASK_L2CC_IDLE		(0x1 << 27)
+
+#define CGPR				0x64
+#define BM_CGPR_CHICKEN_BIT		(0x1 << 17)
+
+static void __iomem *ccm_base;
+
+void imx6q_set_chicken_bit(void)
+{
+	u32 val = readl_relaxed(ccm_base + CGPR);
+
+	val |= BM_CGPR_CHICKEN_BIT;
+	writel_relaxed(val, ccm_base + CGPR);
+}
+
+static void imx6q_enable_rbc(bool enable)
+{
+	u32 val;
+	static bool last_rbc_mode;
+
+	if (last_rbc_mode == enable)
+		return;
+	/*
+	 * need to mask all interrupts in GPC before
+	 * operating RBC configurations
+	 */
+	imx_gpc_mask_all();
+
+	/* configure RBC enable bit */
+	val = readl_relaxed(ccm_base + CCR);
+	val &= ~BM_CCR_RBC_EN;
+	val |= enable ? BM_CCR_RBC_EN : 0;
+	writel_relaxed(val, ccm_base + CCR);
+
+	/* configure RBC count */
+	val = readl_relaxed(ccm_base + CCR);
+	val &= ~BM_CCR_RBC_BYPASS_COUNT;
+	val |= enable ? BM_CCR_RBC_BYPASS_COUNT : 0;
+	writel(val, ccm_base + CCR);
+
+	/*
+	 * need to delay@least 2 cycles of CKIL(32K)
+	 * due to hardware design requirement, which is
+	 * ~61us, here we use 65us for safe
+	 */
+	udelay(65);
+
+	/* restore GPC interrupt mask settings */
+	imx_gpc_restore_all();
+
+	last_rbc_mode = enable;
+}
+
+static void imx6q_enable_wb(bool enable)
+{
+	u32 val;
+	static bool last_wb_mode;
+
+	if (last_wb_mode == enable)
+		return;
+
+	/* configure well bias enable bit */
+	val = readl_relaxed(ccm_base + CLPCR);
+	val &= ~BM_CLPCR_WB_PER_AT_LPM;
+	val |= enable ? BM_CLPCR_WB_PER_AT_LPM : 0;
+	writel_relaxed(val, ccm_base + CLPCR);
+
+	/* configure well bias count */
+	val = readl_relaxed(ccm_base + CCR);
+	val &= ~BM_CCR_WB_COUNT;
+	val |= enable ? BM_CCR_WB_COUNT : 0;
+	writel_relaxed(val, ccm_base + CCR);
+
+	last_wb_mode = enable;
+}
+
+int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
+{
+	u32 val = readl_relaxed(ccm_base + CLPCR);
+
+	val &= ~BM_CLPCR_LPM;
+	switch (mode) {
+	case WAIT_CLOCKED:
+		imx6q_enable_wb(false);
+		imx6q_enable_rbc(false);
+		break;
+	case WAIT_UNCLOCKED:
+		val |= 0x1 << BP_CLPCR_LPM;
+		val |= BM_CLPCR_ARM_CLK_DIS_ON_LPM;
+		break;
+	case STOP_POWER_ON:
+		val |= 0x2 << BP_CLPCR_LPM;
+		break;
+	case WAIT_UNCLOCKED_POWER_OFF:
+		val |= 0x1 << BP_CLPCR_LPM;
+		val &= ~BM_CLPCR_VSTBY;
+		val &= ~BM_CLPCR_SBYOS;
+		break;
+	case STOP_POWER_OFF:
+		val |= 0x2 << BP_CLPCR_LPM;
+		val |= 0x3 << BP_CLPCR_STBY_COUNT;
+		val |= BM_CLPCR_VSTBY;
+		val |= BM_CLPCR_SBYOS;
+		imx6q_enable_wb(true);
+		imx6q_enable_rbc(true);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	writel_relaxed(val, ccm_base + CLPCR);
+
+	return 0;
+}
+
 static int imx6q_suspend_finish(unsigned long val)
 {
 	cpu_do_idle();
@@ -55,7 +197,17 @@ static const struct platform_suspend_ops imx6q_pm_ops = {
 	.valid = suspend_valid_only_mem,
 };
 
+void __init imx6q_pm_set_ccm_base(void __iomem *base)
+{
+	ccm_base = base;
+}
+
 void __init imx6q_pm_init(void)
 {
+	WARN_ON(!ccm_base);
+
+	/* Set initial power mode */
+	imx6q_set_lpm(WAIT_CLOCKED);
+
 	suspend_set_ops(&imx6q_pm_ops);
 }
-- 
1.7.9.5
