From: jason.chen@linaro.org (Jason Chen)
Date: Thu, 5 Jan 2012 13:20:42 +0800
Subject: [PATCH] arm: imx6q: bypass anatop regulator during suspend
Message-ID: <1325740842-5464-1-git-send-email-jason.chen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable bit CCM_CLPCR_wb_per_at_lpm to decrease leakage during suspend.
enable bit CCM_CCR_RBC_EN to disable/bypass anatop regulator during suspend.

Signed-off-by: Jason Chen <jason.chen@linaro.org>
Signed-off-by: Jason Chen <jason.chen@freescale.com>
---
 arch/arm/mach-imx/clock-imx6q.c |   31 +++++++++++++++---------
 arch/arm/mach-imx/pm-imx6q.c    |   48 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx6q.c b/arch/arm/mach-imx/clock-imx6q.c
index 56a7a3f..11d2453 100644
--- a/arch/arm/mach-imx/clock-imx6q.c
+++ b/arch/arm/mach-imx/clock-imx6q.c
@@ -115,6 +115,8 @@
 #define CG14		28
 #define CG15		30
 
+#define BM_CCR_RBC_EN			(0x1 << 27)
+
 #define BM_CCSR_PLL1_SW_SEL		(0x1 << 2)
 #define BM_CCSR_STEP_SEL		(0x1 << 8)
 
@@ -1916,33 +1918,38 @@ static struct clk_lookup lookups[] = {
 
 int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 {
-	u32 val = readl_relaxed(CLPCR);
+	u32 clpcr = readl_relaxed(CLPCR);
+	u32 ccr = readl_relaxed(CCR);
 
-	val &= ~BM_CLPCR_LPM;
+	clpcr &= ~(BM_CLPCR_LPM | BM_CLPCR_VSTBY | BM_CLPCR_SBYOS
+			| BM_CLPCR_STBY_COUNT | BM_CLPCR_WB_PER_AT_LPM);
+	ccr &= ~(BM_CCR_RBC_EN);
 	switch (mode) {
 	case WAIT_CLOCKED:
 		break;
 	case WAIT_UNCLOCKED:
-		val |= 0x1 << BP_CLPCR_LPM;
+		clpcr |= 0x1 << BP_CLPCR_LPM;
 		break;
 	case STOP_POWER_ON:
-		val |= 0x2 << BP_CLPCR_LPM;
+		clpcr |= 0x2 << BP_CLPCR_LPM;
 		break;
 	case WAIT_UNCLOCKED_POWER_OFF:
-		val |= 0x1 << BP_CLPCR_LPM;
-		val &= ~BM_CLPCR_VSTBY;
-		val &= ~BM_CLPCR_SBYOS;
+		clpcr |= 0x1 << BP_CLPCR_LPM;
 		break;
 	case STOP_POWER_OFF:
-		val |= 0x2 << BP_CLPCR_LPM;
-		val |= 0x3 << BP_CLPCR_STBY_COUNT;
-		val |= BM_CLPCR_VSTBY;
-		val |= BM_CLPCR_SBYOS;
+		clpcr |= 0x2 << BP_CLPCR_LPM;
+		clpcr |= 0x3 << BP_CLPCR_STBY_COUNT;
+		clpcr |= BM_CLPCR_VSTBY;
+		clpcr |= BM_CLPCR_SBYOS;
+		clpcr |= BM_CLPCR_WB_PER_AT_LPM;
+		/* assert anatop_reg_bypass signal */
+		ccr |= BM_CCR_RBC_EN;
 		break;
 	default:
 		return -EINVAL;
 	}
-	writel_relaxed(val, CLPCR);
+	writel_relaxed(clpcr, CLPCR);
+	writel_relaxed(ccr, CCR);
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index f20f191..72a1399 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/suspend.h>
 #include <asm/cacheflush.h>
 #include <asm/proc-fns.h>
@@ -22,6 +23,41 @@
 #include <mach/hardware.h>
 
 extern unsigned long phys_l2x0_saved_regs;
+static void __iomem *anatop_base;
+
+#define ANATOP_REG_2P5			0x130
+#define BM_ANATOP_REG_2P5_WEAK_EN	(0x1 << 18)
+
+static int imx6q_anatop_reg_pre_suspend(void)
+{
+	/*
+	 * enable anatop weak 2p5 regulator, which should use
+	 * regulator API after anatop regulator implementation.
+	 */
+	if (anatop_base) {
+		unsigned int reg_2p5;
+		reg_2p5 = readl(anatop_base + ANATOP_REG_2P5);
+		reg_2p5 |= BM_ANATOP_REG_2P5_WEAK_EN;
+		writel(reg_2p5, anatop_base + ANATOP_REG_2P5);
+	} else
+		return -EINVAL;
+
+	return 0;
+}
+
+static void imx6q_anatop_reg_post_resume(void)
+{
+	/*
+	 * disable anatop weak 2p5 regulator, which should use
+	 * regulator API after anatop regulator implementation.
+	 */
+	if (anatop_base) {
+		unsigned int reg_2p5;
+		reg_2p5 = readl(anatop_base + ANATOP_REG_2P5);
+		reg_2p5 &= ~BM_ANATOP_REG_2P5_WEAK_EN;
+		writel(reg_2p5, anatop_base + ANATOP_REG_2P5);
+	}
+}
 
 static int imx6q_suspend_finish(unsigned long val)
 {
@@ -33,6 +69,8 @@ static int imx6q_pm_enter(suspend_state_t state)
 {
 	switch (state) {
 	case PM_SUSPEND_MEM:
+		if (imx6q_anatop_reg_pre_suspend() < 0)
+			return -EINVAL;
 		imx6q_set_lpm(STOP_POWER_OFF);
 		imx_gpc_pre_suspend();
 		imx_set_cpu_jump(0, v7_cpu_resume);
@@ -40,6 +78,7 @@ static int imx6q_pm_enter(suspend_state_t state)
 		cpu_suspend(0, imx6q_suspend_finish);
 		imx_smp_prepare();
 		imx_gpc_post_resume();
+		imx6q_anatop_reg_post_resume();
 		break;
 	default:
 		return -EINVAL;
@@ -55,6 +94,15 @@ static const struct platform_suspend_ops imx6q_pm_ops = {
 
 void __init imx6q_pm_init(void)
 {
+	struct device_node *np;
+
+	/*
+	 * remap anatop to adjust anatop regulator, which should
+	 * remove after anatop regulator driver implementation.
+	 */
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
+	anatop_base = of_iomap(np, 0);
+
 	/*
 	 * The l2x0 core code provides an infrastucture to save and restore
 	 * l2x0 registers across suspend/resume cycle.  But because imx6q
-- 
1.7.4.1
