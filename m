From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 28 Oct 2013 17:22:53 +0800
Subject: [PATCH] ARM: imx: remove imx_src_prepare_restart() call
Message-ID: <1382952173-28192-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is ~10% possibility that the following emergency restart command
fails to reboot imx6q.

$ echo b > /proc/sysrq-trigger

The IMX restart routine mxc_restart() assumes that it will always run on
primary core, and will call imx_src_prepare_restart() to disable
secondary cores in order to get them come to online in the following
boot.  However, the assumption is only true for normal kernel_restart()
case where migrate_to_reboot_cpu() will be called to migrate to primary
core, but not necessarily true for emergency_restart() case.  So when
emergency_restart() calls into mxc_restart() on any secondary core,
system will hang immediately once imx_src_prepare_restart() is called
to disabled secondary cores.  Since emergency_restart() is defined as a
function that is safe to call in interrupt context, we cannot just call
migrate_to_reboot_cpu() to fix the issue.

Fortunately, we just found that the issue can be fixed at imx6q platform
level.  We used to call imx_src_prepare_restart() to disable all
secondary cores before resetting hardware.  Otherwise, the secondary
will fail come to online in the reboot.  However, we recently found that
after commit 6050d18 (ARM: imx: reset core along with enable/disable
operation) comes to play, we do not need to reset the secondary cores
any more.  That said, mxc_restart() now can run on any core to reboot
the system, as long as we remove the imx_src_prepare_restart() call from
mxc_restart().

So let's simply remove imx_src_prepare_restart() call to fix the above
emergency restart failure.

Reported-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/common.h |    5 -----
 arch/arm/mach-imx/src.c    |   15 ---------------
 arch/arm/mach-imx/system.c |    3 ---
 3 files changed, 23 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 7cbe22d..24a7899 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -127,11 +127,6 @@ static inline void imx_smp_prepare(void) {}
 static inline void imx_scu_standby_enable(void) {}
 #endif
 void imx_src_init(void);
-#ifdef CONFIG_HAVE_IMX_SRC
-void imx_src_prepare_restart(void);
-#else
-static inline void imx_src_prepare_restart(void) {}
-#endif
 void imx_gpc_init(void);
 void imx_gpc_pre_suspend(void);
 void imx_gpc_post_resume(void);
diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index 4754373..45f7f4e 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -115,21 +115,6 @@ void imx_set_cpu_arg(int cpu, u32 arg)
 	writel_relaxed(arg, src_base + SRC_GPR1 + cpu * 8 + 4);
 }
 
-void imx_src_prepare_restart(void)
-{
-	u32 val;
-
-	/* clear enable bits of secondary cores */
-	spin_lock(&scr_lock);
-	val = readl_relaxed(src_base + SRC_SCR);
-	val &= ~(0x7 << BP_SRC_SCR_CORE1_ENABLE);
-	writel_relaxed(val, src_base + SRC_SCR);
-	spin_unlock(&scr_lock);
-
-	/* clear persistent entry register of primary core */
-	writel_relaxed(0, src_base + SRC_GPR1);
-}
-
 void __init imx_src_init(void)
 {
 	struct device_node *np;
diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index e6edcd3..826b72b 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -42,9 +42,6 @@ void mxc_restart(enum reboot_mode mode, const char *cmd)
 {
 	unsigned int wcr_enable;
 
-	if (cpu_is_imx6q() || cpu_is_imx6dl())
-		imx_src_prepare_restart();
-
 	if (wdog_clk)
 		clk_enable(wdog_clk);
 
-- 
1.7.9.5
