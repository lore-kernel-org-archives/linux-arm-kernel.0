From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Oct 2013 11:17:12 +0800
Subject: [PATCH 2/4] ARM: imx6q: call WB and RBC configuration from
 imx6q_pm_enter()
In-Reply-To: <1381979834-20998-1-git-send-email-shawn.guo@linaro.org>
References: <1381979834-20998-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1381979834-20998-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The WB and RBC configuration calls are currently made from
imx6q_set_lpm() for WAIT_CLOCKED and WAIT_UNCLOCKED mode with a simple
state tracking.  This becomes unnecessary since we can make the calls
from imx6q_pm_enter() directly now for suspend.

More importantly, the current call of imx6q_enable_wb() from
imx6q_set_lpm() is buggy.  The CLPCR register bits configured by
imx6q_enable_wb() will get lost, because imx6q_set_lpm() caches the same
register and write it back at the end of the function.  That's why the
imx6dl suspend/resume does not work currently - the wakeup from suspend
triggers a reset on imx6dl.

Moves the WB and RBC calls into imx6q_pm_enter() to save the state
tracking and fixes above bug, so that suspend/resume can start working
on imx6dl.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/pm-imx6q.c |   19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index 461a895..fb7d90d 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -67,10 +67,7 @@ void imx6q_set_chicken_bit(void)
 static void imx6q_enable_rbc(bool enable)
 {
 	u32 val;
-	static bool last_rbc_mode;
 
-	if (last_rbc_mode == enable)
-		return;
 	/*
 	 * need to mask all interrupts in GPC before
 	 * operating RBC configurations
@@ -98,17 +95,11 @@ static void imx6q_enable_rbc(bool enable)
 
 	/* restore GPC interrupt mask settings */
 	imx_gpc_restore_all();
-
-	last_rbc_mode = enable;
 }
 
 static void imx6q_enable_wb(bool enable)
 {
 	u32 val;
-	static bool last_wb_mode;
-
-	if (last_wb_mode == enable)
-		return;
 
 	/* configure well bias enable bit */
 	val = readl_relaxed(ccm_base + CLPCR);
@@ -121,8 +112,6 @@ static void imx6q_enable_wb(bool enable)
 	val &= ~BM_CCR_WB_COUNT;
 	val |= enable ? BM_CCR_WB_COUNT : 0;
 	writel_relaxed(val, ccm_base + CCR);
-
-	last_wb_mode = enable;
 }
 
 int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
@@ -132,8 +121,6 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 	val &= ~BM_CLPCR_LPM;
 	switch (mode) {
 	case WAIT_CLOCKED:
-		imx6q_enable_wb(false);
-		imx6q_enable_rbc(false);
 		break;
 	case WAIT_UNCLOCKED:
 		val |= 0x1 << BP_CLPCR_LPM;
@@ -152,8 +139,6 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 		val |= 0x3 << BP_CLPCR_STBY_COUNT;
 		val |= BM_CLPCR_VSTBY;
 		val |= BM_CLPCR_SBYOS;
-		imx6q_enable_wb(true);
-		imx6q_enable_rbc(true);
 		break;
 	default:
 		return -EINVAL;
@@ -175,6 +160,8 @@ static int imx6q_pm_enter(suspend_state_t state)
 	switch (state) {
 	case PM_SUSPEND_MEM:
 		imx6q_set_lpm(STOP_POWER_OFF);
+		imx6q_enable_wb(true);
+		imx6q_enable_rbc(true);
 		imx_gpc_pre_suspend();
 		imx_anatop_pre_suspend();
 		imx_set_cpu_jump(0, v7_cpu_resume);
@@ -183,6 +170,8 @@ static int imx6q_pm_enter(suspend_state_t state)
 		imx_smp_prepare();
 		imx_anatop_post_resume();
 		imx_gpc_post_resume();
+		imx6q_enable_rbc(false);
+		imx6q_enable_wb(false);
 		imx6q_set_lpm(WAIT_CLOCKED);
 		break;
 	default:
-- 
1.7.9.5
