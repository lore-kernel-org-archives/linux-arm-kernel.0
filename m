From: rob.lee@linaro.org (Robert Lee)
Date: Mon, 23 Jan 2012 22:37:33 -0600
Subject: [PATCH v3 6/7] ARM: imx: Init imx5 gpc_dvfs clock for global use
In-Reply-To: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
References: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1327379854-12403-7-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpc_dvfs clock consumes practically zero power and must be enabled
for various low power funcitonality.  Now that a second user of this
clock is being added (cpuidle) for mx5, it is cleanest to just enable
this clock during clock initialization and leave it enabled.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c |    3 +++
 arch/arm/mach-mx5/pm-imx5.c         |   24 ++----------------------
 2 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 4cb2769..12c8a2b 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1533,6 +1533,7 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx53-ahci.0", "ahci", sata_clk)
 	_REGISTER_CLOCK("imx53-ahci.0", "ahci_phy", ahci_phy_clk)
 	_REGISTER_CLOCK("imx53-ahci.0", "ahci_dma", ahci_dma_clk)
+	_REGISTER_CLOCK(NULL, "gpc_dvfs", gpc_dvfs_clk)
 };
 
 static void clk_tree_init(void)
@@ -1572,6 +1573,7 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
 
 	clk_enable(&cpu_clk);
 	clk_enable(&main_bus_clk);
+	clk_enable(&gpc_dvfs_clk);
 
 	clk_enable(&iim_clk);
 	imx_print_silicon_rev("i.MX51", mx51_revision());
@@ -1615,6 +1617,7 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
 	clk_set_parent(&uart_root_clk, &pll3_sw_clk);
 	clk_enable(&cpu_clk);
 	clk_enable(&main_bus_clk);
+	clk_enable(&gpc_dvfs_clk);
 
 	clk_enable(&iim_clk);
 	imx_print_silicon_rev("i.MX53", mx53_revision());
diff --git a/arch/arm/mach-mx5/pm-imx5.c b/arch/arm/mach-mx5/pm-imx5.c
index 98052fc..36c5b57 100644
--- a/arch/arm/mach-mx5/pm-imx5.c
+++ b/arch/arm/mach-mx5/pm-imx5.c
@@ -18,13 +18,6 @@
 #include <mach/hardware.h>
 #include "crm_regs.h"
 
-static struct clk *gpc_dvfs_clk;
-
-static int mx5_suspend_prepare(void)
-{
-	return clk_enable(gpc_dvfs_clk);
-}
-
 static int mx5_suspend_enter(suspend_state_t state)
 {
 	switch (state) {
@@ -50,11 +43,6 @@ static int mx5_suspend_enter(suspend_state_t state)
 	return 0;
 }
 
-static void mx5_suspend_finish(void)
-{
-	clk_disable(gpc_dvfs_clk);
-}
-
 static int mx5_pm_valid(suspend_state_t state)
 {
 	return (state > PM_SUSPEND_ON && state <= PM_SUSPEND_MAX);
@@ -62,21 +50,13 @@ static int mx5_pm_valid(suspend_state_t state)
 
 static const struct platform_suspend_ops mx5_suspend_ops = {
 	.valid = mx5_pm_valid,
-	.prepare = mx5_suspend_prepare,
 	.enter = mx5_suspend_enter,
-	.finish = mx5_suspend_finish,
 };
 
 static int __init mx5_pm_init(void)
 {
-	if (gpc_dvfs_clk == NULL)
-		gpc_dvfs_clk = clk_get(NULL, "gpc_dvfs");
-
-	if (!IS_ERR(gpc_dvfs_clk)) {
-		if (cpu_is_mx51())
-			suspend_set_ops(&mx5_suspend_ops);
-	} else
-		return -EPERM;
+	if (cpu_is_mx51())
+		suspend_set_ops(&mx5_suspend_ops);
 
 	return 0;
 }
-- 
1.7.1
