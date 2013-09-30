From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 30 Sep 2013 18:03:30 -0300
Subject: [PATCH 4/4] ARM: kirkwood: Remove redundant ethernet clock enable
In-Reply-To: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1380575010-8573-5-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After adding the CLK_IGNORE_UNUSED flags for the ethernet clocks
ge0 and ge1, we can get rid of the hack to prevent such clocks
from being gated.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-kirkwood/board-dt.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 1bbced8..92be484 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -27,37 +27,6 @@
 #include <plat/common.h>
 #include "common.h"
 
-/*
- * There are still devices that doesn't know about DT yet.  Get clock
- * gates here and add a clock lookup alias, so that old platform
- * devices still work.
-*/
-
-static void __init kirkwood_legacy_clk_init(void)
-{
-
-	struct device_node *np = of_find_compatible_node(
-		NULL, NULL, "marvell,kirkwood-gating-clock");
-	struct of_phandle_args clkspec;
-	struct clk *clk;
-
-	clkspec.np = np;
-	clkspec.args_count = 1;
-
-	/*
-	 * The ethernet interfaces forget the MAC address assigned by
-	 * u-boot if the clocks are turned off. Until proper DT support
-	 * is available we always enable them for now.
-	 */
-	clkspec.args[0] = CGC_BIT_GE0;
-	clk = of_clk_get_from_provider(&clkspec);
-	clk_prepare_enable(clk);
-
-	clkspec.args[0] = CGC_BIT_GE1;
-	clk = of_clk_get_from_provider(&clkspec);
-	clk_prepare_enable(clk);
-}
-
 static void __init kirkwood_dt_time_init(void)
 {
 	of_clk_init(NULL);
@@ -83,9 +52,6 @@ static void __init kirkwood_dt_init(void)
 
 	kirkwood_cpufreq_init();
 
-	/* Setup clocks for legacy devices */
-	kirkwood_legacy_clk_init();
-
 	kirkwood_cpuidle_init();
 
 #ifdef CONFIG_KEXEC
-- 
1.8.1.5
