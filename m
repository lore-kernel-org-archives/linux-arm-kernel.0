From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 12 Feb 2014 11:45:48 +0100
Subject: [PATCH] ARM: imx6: fix !CONFIG_PM and !CONFIG_CPU_IDLE build
Message-ID: <1392201948-16311-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building a kernel with only CONFIG_CPU_IDLE, but no
CONFIG_PM we still need the functions to set the lpm mode
and chicken bits.

Also if both options are unset, we have to stub out the
set_lpm function, as this one is called from the clk
driver directly.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
This fix depends on an earlier one by Philipp:
"ARM: imx6: Initialize low-power mode early again"

Both should go to stable after a sensible sinking time.
---
 arch/arm/mach-imx/Makefile   |   9 +++-
 arch/arm/mach-imx/common.h   |  11 +++--
 arch/arm/mach-imx/pm-imx6q.c | 112 ++++++++++++++++++++++---------------------
 3 files changed, 72 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index befcaf5d0574..a8f2a1a1cbfc 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -102,9 +102,14 @@ obj-$(CONFIG_SOC_IMX6Q) += clk-imx6q.o mach-imx6q.o
 obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o mach-imx6sl.o
 
 ifeq ($(CONFIG_PM),y)
-obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o headsmp.o
+obj-$(CONFIG_SOC_IMX6Q) += headsmp.o
 # i.MX6SL reuses i.MX6Q code
-obj-$(CONFIG_SOC_IMX6SL) += pm-imx6q.o headsmp.o
+obj-$(CONFIG_SOC_IMX6SL) += headsmp.o
+endif
+
+ifeq ($(findstring y,$(CONFIG_CPU_IDLE) $(CONFIG_PM)),y)
+obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o
+obj-$(CONFIG_SOC_IMX6SL) += pm-imx6q.o
 endif
 
 # i.MX5 based machines
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 59c3b9b26bb4..9141277e143f 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -138,7 +138,6 @@ void imx_gpc_irq_unmask(struct irq_data *d);
 void imx_anatop_init(void);
 void imx_anatop_pre_suspend(void);
 void imx_anatop_post_resume(void);
-int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
 void imx6q_set_chicken_bit(void);
 
 void imx_cpu_die(unsigned int cpu);
@@ -146,14 +145,20 @@ int imx_cpu_kill(unsigned int cpu);
 
 #ifdef CONFIG_PM
 void imx6q_pm_init(void);
-void imx6q_pm_set_ccm_base(void __iomem *base);
 void imx5_pm_init(void);
 #else
 static inline void imx6q_pm_init(void) {}
-static inline void imx6q_pm_set_ccm_base(void __iomem *base) {}
 static inline void imx5_pm_init(void) {}
 #endif
 
+#if defined(CONFIG_PM) || defined(CONFIG_CPU_IDLE)
+void imx6q_pm_set_ccm_base(void __iomem *base);
+int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
+#else
+static inline void imx6q_pm_set_ccm_base(void __iomem *base) {}
+static inline int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode) { return 0; }
+#endif
+
 #ifdef CONFIG_NEON
 int mx51_neon_fixup(void);
 #else
diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index 7a9b98589db7..038091050e61 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -68,56 +68,6 @@ void imx6q_set_chicken_bit(void)
 	writel_relaxed(val, ccm_base + CGPR);
 }
 
-static void imx6q_enable_rbc(bool enable)
-{
-	u32 val;
-
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
-	 * need to delay at least 2 cycles of CKIL(32K)
-	 * due to hardware design requirement, which is
-	 * ~61us, here we use 65us for safe
-	 */
-	udelay(65);
-
-	/* restore GPC interrupt mask settings */
-	imx_gpc_restore_all();
-}
-
-static void imx6q_enable_wb(bool enable)
-{
-	u32 val;
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
-}
-
 int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 {
 	struct irq_desc *iomuxc_irq_desc;
@@ -175,6 +125,62 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 	return 0;
 }
 
+void __init imx6q_pm_set_ccm_base(void __iomem *base)
+{
+	ccm_base = base;
+}
+
+#ifdef CONFIG_PM
+static void imx6q_enable_rbc(bool enable)
+{
+	u32 val;
+
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
+	 * need to delay at least 2 cycles of CKIL(32K)
+	 * due to hardware design requirement, which is
+	 * ~61us, here we use 65us for safe
+	 */
+	udelay(65);
+
+	/* restore GPC interrupt mask settings */
+	imx_gpc_restore_all();
+}
+
+static void imx6q_enable_wb(bool enable)
+{
+	u32 val;
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
+}
+
 static int imx6q_suspend_finish(unsigned long val)
 {
 	cpu_do_idle();
@@ -213,11 +219,6 @@ static const struct platform_suspend_ops imx6q_pm_ops = {
 	.valid = suspend_valid_only_mem,
 };
 
-void __init imx6q_pm_set_ccm_base(void __iomem *base)
-{
-	ccm_base = base;
-}
-
 void __init imx6q_pm_init(void)
 {
 	struct regmap *gpr;
@@ -239,3 +240,4 @@ void __init imx6q_pm_init(void)
 
 	suspend_set_ops(&imx6q_pm_ops);
 }
+#endif
-- 
1.8.5.3
