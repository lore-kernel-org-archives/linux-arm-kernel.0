From: Anson.Huang@nxp.com (Anson Huang)
Date: Mon, 29 Aug 2016 21:49:56 +0800
Subject: [PATCH V2 1/2] ARM: imx: rename imx6q_set_int_mem_clk_lpm() function
Message-ID: <1472478597-6731-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's rename the function imx6q_set_int_mem_clk_lpm()
to imx6_set_int_mem_clk_lpm() since it's actually
common for all i.MX6 SoCs.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	This is a new add patch to improve function name.
 arch/arm/mach-imx/common.h        | 2 +-
 arch/arm/mach-imx/cpuidle-imx6q.c | 2 +-
 arch/arm/mach-imx/pm-imx6.c       | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index bcca481..c4436d9 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -104,7 +104,7 @@ void imx_anatop_init(void);
 void imx_anatop_pre_suspend(void);
 void imx_anatop_post_resume(void);
 int imx6_set_lpm(enum mxc_cpu_pwr_mode mode);
-void imx6q_set_int_mem_clk_lpm(bool enable);
+void imx6_set_int_mem_clk_lpm(bool enable);
 void imx6sl_set_wait_clk(bool enter);
 int imx_mmdc_get_ddr_type(void);
 
diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index db0f48c..bfeb25a 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -85,7 +85,7 @@ EXPORT_SYMBOL_GPL(imx6q_cpuidle_fec_irqs_unused);
 int __init imx6q_cpuidle_init(void)
 {
 	/* Set INT_MEM_CLK_LPM bit to get a reliable WAIT mode support */
-	imx6q_set_int_mem_clk_lpm(true);
+	imx6_set_int_mem_clk_lpm(true);
 
 	return cpuidle_register(&imx6q_cpuidle_driver, NULL);
 }
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 67bab74..70e5bfb 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -217,7 +217,7 @@ struct imx6_cpu_pm_info {
 	u32 mmdc_io_val[MX6_MAX_MMDC_IO_NUM][2]; /* To save offset and value */
 } __aligned(8);
 
-void imx6q_set_int_mem_clk_lpm(bool enable)
+void imx6_set_int_mem_clk_lpm(bool enable)
 {
 	u32 val = readl_relaxed(ccm_base + CGPR);
 
@@ -367,7 +367,7 @@ static int imx6q_pm_enter(suspend_state_t state)
 	switch (state) {
 	case PM_SUSPEND_STANDBY:
 		imx6_set_lpm(STOP_POWER_ON);
-		imx6q_set_int_mem_clk_lpm(true);
+		imx6_set_int_mem_clk_lpm(true);
 		imx_gpc_pre_suspend(false);
 		if (cpu_is_imx6sl())
 			imx6sl_set_wait_clk(true);
@@ -380,7 +380,7 @@ static int imx6q_pm_enter(suspend_state_t state)
 		break;
 	case PM_SUSPEND_MEM:
 		imx6_set_lpm(STOP_POWER_OFF);
-		imx6q_set_int_mem_clk_lpm(false);
+		imx6_set_int_mem_clk_lpm(false);
 		imx6q_enable_wb(true);
 		/*
 		 * For suspend into ocram, asm code already take care of
@@ -398,7 +398,7 @@ static int imx6q_pm_enter(suspend_state_t state)
 		imx_gpc_post_resume();
 		imx6_enable_rbc(false);
 		imx6q_enable_wb(false);
-		imx6q_set_int_mem_clk_lpm(true);
+		imx6_set_int_mem_clk_lpm(true);
 		imx6_set_lpm(WAIT_CLOCKED);
 		break;
 	default:
-- 
1.9.1
