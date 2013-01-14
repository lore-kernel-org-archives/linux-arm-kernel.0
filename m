From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 14 Jan 2013 22:15:21 +0800
Subject: [PATCH] ARM: imx: correct low-power mode setting
Message-ID: <1358172921-9863-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hardware reset value of bit CCM_CLPCR_LPM enables WAIT mode
(WAIT_UNCLOCKED) by default.  However this is undesirable because
WAIT mode should only be enabled when there is a driver managing
ARM clock gating.  Correct the initial power mode to WAIT_CLOCKED
(disable WAIT mode).  While at it, the power mode after resuming
is also set back to WAIT_CLOCKED from STOP_POWER_OFF.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-imx6q.c |    3 +++
 arch/arm/mach-imx/pm-imx6q.c  |    1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 7f2c10c..c0c4e72 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -436,6 +436,9 @@ int __init mx6q_clocks_init(void)
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
 		clk_prepare_enable(clk[clks_init_on[i]]);
 
+	/* Set initial power mode */
+	imx6q_set_lpm(WAIT_CLOCKED);
+
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-gpt");
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index a17543d..ee42d20 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -41,6 +41,7 @@ static int imx6q_pm_enter(suspend_state_t state)
 		cpu_suspend(0, imx6q_suspend_finish);
 		imx_smp_prepare();
 		imx_gpc_post_resume();
+		imx6q_set_lpm(WAIT_CLOCKED);
 		break;
 	default:
 		return -EINVAL;
-- 
1.7.9.5
