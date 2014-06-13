From: shc_work@mail.ru (Alexander Shiyan)
Date: Fri, 13 Jun 2014 11:26:12 +0400
Subject: [PATCH 1/2] ARM: i.MX system: Simplify handling watchdog clock
Message-ID: <1402644373-8408-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch simplifies handling watchdog clock a bit.
As an additional change, now we properly check WDT clock in a reset
function.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/system.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index 3b0733e..ae521f3 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -42,7 +42,7 @@ void mxc_restart(enum reboot_mode mode, const char *cmd)
 {
 	unsigned int wcr_enable;
 
-	if (wdog_clk)
+	if (!IS_ERR_OR_NULL(wdog_clk))
 		clk_enable(wdog_clk);
 
 	if (cpu_is_mx1())
@@ -79,13 +79,10 @@ void __init mxc_arch_reset_init(void __iomem *base)
 	wdog_base = base;
 
 	wdog_clk = clk_get_sys("imx2-wdt.0", NULL);
-	if (IS_ERR(wdog_clk)) {
+	if (IS_ERR(wdog_clk))
 		pr_warn("%s: failed to get wdog clock\n", __func__);
-		wdog_clk = NULL;
-		return;
-	}
-
-	clk_prepare(wdog_clk);
+	else
+		clk_prepare(wdog_clk);
 }
 
 void __init mxc_arch_reset_init_dt(void)
@@ -97,13 +94,10 @@ void __init mxc_arch_reset_init_dt(void)
 	WARN_ON(!wdog_base);
 
 	wdog_clk = of_clk_get(np, 0);
-	if (IS_ERR(wdog_clk)) {
+	if (IS_ERR(wdog_clk))
 		pr_warn("%s: failed to get wdog clock\n", __func__);
-		wdog_clk = NULL;
-		return;
-	}
-
-	clk_prepare(wdog_clk);
+	else
+		clk_prepare(wdog_clk);
 }
 
 #ifdef CONFIG_CACHE_L2X0
-- 
1.8.5.5
