From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Apr 2015 09:54:28 +0800
Subject: [PATCH] ARM: imx: drop epit timer initialization from imx35 clock
 driver
Message-ID: <1430186068-24511-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EPIT provides another timer implementation besides the default GPT
timer.  The imx35 clock driver will use EPIT timer when option
CONFIG_MXC_USE_EPIT is enabled.  However, initializing timers from
clock driver is a workaround solution and causes problem when we move
clock drivers into driver/clk.

Let's simply drop the EPIT initialization from there.  If people really
want this EPIT option, EPIT timer driver needs to be reworked to do the
initialization in a standard way - use CLOCKSOURCE_OF_DECLARE() with
device tree support.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/imx/clk-imx35.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
index 133fda1dcb25..f2f3b8164f7b 100644
--- a/drivers/clk/imx/clk-imx35.c
+++ b/drivers/clk/imx/clk-imx35.c
@@ -293,11 +293,7 @@ int __init mx35_clocks_init(void)
 
 	imx_print_silicon_rev("i.MX35", mx35_revision());
 
-#ifdef CONFIG_MXC_USE_EPIT
-	epit_timer_init(MX35_IO_ADDRESS(MX35_EPIT1_BASE_ADDR), MX35_INT_EPIT1);
-#else
 	mxc_timer_init(MX35_GPT1_BASE_ADDR, MX35_INT_GPT);
-#endif
 
 	return 0;
 }
-- 
1.9.1
