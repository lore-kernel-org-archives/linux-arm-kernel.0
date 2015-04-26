From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 26 Apr 2015 22:31:06 +0800
Subject: [PATCH 05/11] ARM: imx6: set initial power mode in pm function
In-Reply-To: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
References: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1430058672-9267-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than setting initial low-power mode in every single i.MX6 clock
initialization function, we should really do that in pm code.  Let's
move imx6q_set_lpm(WAIT_CLOCKED) call into imx6_pm_common_init().

While at it, let's rename the function to imx6_set_lpm() since it's
actually common for all i.MX6 SoCs.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-imx6q.c      |  3 ---
 arch/arm/mach-imx/clk-imx6sl.c     |  3 ---
 arch/arm/mach-imx/clk-imx6sx.c     |  3 ---
 arch/arm/mach-imx/common.h         |  2 +-
 arch/arm/mach-imx/cpuidle-imx6q.c  |  4 ++--
 arch/arm/mach-imx/cpuidle-imx6sl.c |  4 ++--
 arch/arm/mach-imx/cpuidle-imx6sx.c |  4 ++--
 arch/arm/mach-imx/pm-imx6.c        | 14 ++++++++------
 8 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 469a150bf98f..54ce0b30b9ad 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -527,8 +527,5 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	/* All existing boards with PCIe use LVDS1 */
 	if (IS_ENABLED(CONFIG_PCI_IMX6))
 		clk_set_parent(clk[IMX6QDL_CLK_LVDS1_SEL], clk[IMX6QDL_CLK_SATA_REF_100M]);
-
-	/* Set initial power mode */
-	imx6q_set_lpm(WAIT_CLOCKED);
 }
 CLK_OF_DECLARE(imx6q, "fsl,imx6q-ccm", imx6q_clocks_init);
diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
index e982ebe10814..d990f51ded71 100644
--- a/arch/arm/mach-imx/clk-imx6sl.c
+++ b/arch/arm/mach-imx/clk-imx6sl.c
@@ -443,8 +443,5 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 
 	clk_set_parent(clks[IMX6SL_CLK_LCDIF_AXI_SEL],
 		       clks[IMX6SL_CLK_PLL2_PFD2]);
-
-	/* Set initial power mode */
-	imx6q_set_lpm(WAIT_CLOCKED);
 }
 CLK_OF_DECLARE(imx6sl, "fsl,imx6sl-ccm", imx6sl_clocks_init);
diff --git a/arch/arm/mach-imx/clk-imx6sx.c b/arch/arm/mach-imx/clk-imx6sx.c
index 5a3e5a159e70..2b0a1fd5d7eb 100644
--- a/arch/arm/mach-imx/clk-imx6sx.c
+++ b/arch/arm/mach-imx/clk-imx6sx.c
@@ -560,8 +560,5 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 
 	clk_set_parent(clks[IMX6SX_CLK_QSPI1_SEL], clks[IMX6SX_CLK_PLL2_BUS]);
 	clk_set_parent(clks[IMX6SX_CLK_QSPI2_SEL], clks[IMX6SX_CLK_PLL2_BUS]);
-
-	/* Set initial power mode */
-	imx6q_set_lpm(WAIT_CLOCKED);
 }
 CLK_OF_DECLARE(imx6sx, "fsl,imx6sx-ccm", imx6sx_clocks_init);
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index fe510fbd0c8c..d7f3b7b1d911 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -107,7 +107,7 @@ void imx_gpc_hwirq_unmask(unsigned int hwirq);
 void imx_anatop_init(void);
 void imx_anatop_pre_suspend(void);
 void imx_anatop_post_resume(void);
-int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
+int imx6_set_lpm(enum mxc_cpu_pwr_mode mode);
 void imx6q_set_int_mem_clk_lpm(bool enable);
 void imx6sl_set_wait_clk(bool enter);
 int imx_mmdc_get_ddr_type(void);
diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index d76d08623f9f..ce3f60f4f781 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -28,9 +28,9 @@ static int imx6q_enter_wait(struct cpuidle_device *dev,
 		 */
 		if (!spin_trylock(&master_lock))
 			goto idle;
-		imx6q_set_lpm(WAIT_UNCLOCKED);
+		imx6_set_lpm(WAIT_UNCLOCKED);
 		cpu_do_idle();
-		imx6q_set_lpm(WAIT_CLOCKED);
+		imx6_set_lpm(WAIT_CLOCKED);
 		spin_unlock(&master_lock);
 		goto done;
 	}
diff --git a/arch/arm/mach-imx/cpuidle-imx6sl.c b/arch/arm/mach-imx/cpuidle-imx6sl.c
index 7d92e6584551..a4856b2200ae 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sl.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sl.c
@@ -17,7 +17,7 @@
 static int imx6sl_enter_wait(struct cpuidle_device *dev,
 			    struct cpuidle_driver *drv, int index)
 {
-	imx6q_set_lpm(WAIT_UNCLOCKED);
+	imx6_set_lpm(WAIT_UNCLOCKED);
 	/*
 	 * Software workaround for ERR005311, see function
 	 * description for details.
@@ -25,7 +25,7 @@ static int imx6sl_enter_wait(struct cpuidle_device *dev,
 	imx6sl_set_wait_clk(true);
 	cpu_do_idle();
 	imx6sl_set_wait_clk(false);
-	imx6q_set_lpm(WAIT_CLOCKED);
+	imx6_set_lpm(WAIT_CLOCKED);
 
 	return index;
 }
diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-imx/cpuidle-imx6sx.c
index 5a36722b089d..2fedea8c5217 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sx.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
@@ -26,7 +26,7 @@ static int imx6sx_idle_finish(unsigned long val)
 static int imx6sx_enter_wait(struct cpuidle_device *dev,
 			    struct cpuidle_driver *drv, int index)
 {
-	imx6q_set_lpm(WAIT_UNCLOCKED);
+	imx6_set_lpm(WAIT_UNCLOCKED);
 
 	switch (index) {
 	case 1:
@@ -51,7 +51,7 @@ static int imx6sx_enter_wait(struct cpuidle_device *dev,
 		break;
 	}
 
-	imx6q_set_lpm(WAIT_CLOCKED);
+	imx6_set_lpm(WAIT_CLOCKED);
 
 	return index;
 }
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 6a7c6fc780cc..5858bde5a4e7 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -255,7 +255,7 @@ static void imx6q_enable_wb(bool enable)
 	writel_relaxed(val, ccm_base + CCR);
 }
 
-int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
+int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 {
 	u32 val = readl_relaxed(ccm_base + CLPCR);
 
@@ -340,7 +340,7 @@ static int imx6q_pm_enter(suspend_state_t state)
 {
 	switch (state) {
 	case PM_SUSPEND_STANDBY:
-		imx6q_set_lpm(STOP_POWER_ON);
+		imx6_set_lpm(STOP_POWER_ON);
 		imx6q_set_int_mem_clk_lpm(true);
 		imx_gpc_pre_suspend(false);
 		if (cpu_is_imx6sl())
@@ -350,10 +350,10 @@ static int imx6q_pm_enter(suspend_state_t state)
 		if (cpu_is_imx6sl())
 			imx6sl_set_wait_clk(false);
 		imx_gpc_post_resume();
-		imx6q_set_lpm(WAIT_CLOCKED);
+		imx6_set_lpm(WAIT_CLOCKED);
 		break;
 	case PM_SUSPEND_MEM:
-		imx6q_set_lpm(STOP_POWER_OFF);
+		imx6_set_lpm(STOP_POWER_OFF);
 		imx6q_set_int_mem_clk_lpm(false);
 		imx6q_enable_wb(true);
 		/*
@@ -373,7 +373,7 @@ static int imx6q_pm_enter(suspend_state_t state)
 		imx6_enable_rbc(false);
 		imx6q_enable_wb(false);
 		imx6q_set_int_mem_clk_lpm(true);
-		imx6q_set_lpm(WAIT_CLOCKED);
+		imx6_set_lpm(WAIT_CLOCKED);
 		break;
 	default:
 		return -EINVAL;
@@ -559,6 +559,8 @@ static void __init imx6_pm_common_init(const struct imx6_pm_socdata
 
 	WARN_ON(!ccm_base);
 
+	imx6_set_lpm(WAIT_CLOCKED);
+
 	if (IS_ENABLED(CONFIG_SUSPEND)) {
 		ret = imx6q_suspend_init(socdata);
 		if (ret)
@@ -568,7 +570,7 @@ static void __init imx6_pm_common_init(const struct imx6_pm_socdata
 
 	/*
 	 * This is for SW workaround step #1 of ERR007265, see comments
-	 * in imx6q_set_lpm for details of this errata.
+	 * in imx6_set_lpm for details of this errata.
 	 * Force IOMUXC irq pending, so that the interrupt to GPC can be
 	 * used to deassert dsm_request signal when the signal gets
 	 * asserted unexpectedly.
-- 
1.9.1
