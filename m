From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 Mar 2013 23:17:27 +0800
Subject: [PATCH 1/6] ARM: mxs: use CLKSRC_OF helper to initialize timer
In-Reply-To: <1364224652-28332-1-git-send-email-shawn.guo@linaro.org>
References: <1364224652-28332-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364224652-28332-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select CLKSRC_OF and use clocksource_of_init() to initialize timer, so
that the call to mxs_timer_init() in clock driver can be removed.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig                        |    1 +
 arch/arm/mach-mxs/include/mach/common.h |    1 -
 arch/arm/mach-mxs/mach-mxs.c            |    3 +++
 arch/arm/mach-mxs/timer.c               |   10 ++--------
 drivers/clk/mxs/clk-imx23.c             |    2 --
 drivers/clk/mxs/clk-imx28.c             |    2 --
 6 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index eaae82a..d57fc3d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -474,6 +474,7 @@ config ARCH_MXS
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select CLKSRC_OF
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
 	select HAVE_CLK_PREPARE
diff --git a/arch/arm/mach-mxs/include/mach/common.h b/arch/arm/mach-mxs/include/mach/common.h
index be5a9c9..e043c47 100644
--- a/arch/arm/mach-mxs/include/mach/common.h
+++ b/arch/arm/mach-mxs/include/mach/common.h
@@ -13,7 +13,6 @@
 
 extern const u32 *mxs_get_ocotp(void);
 extern int mxs_reset_block(void __iomem *);
-extern void mxs_timer_init(void);
 extern void mxs_restart(char, const char *);
 extern int mxs_saif_clkmux_select(unsigned int clkmux);
 
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 3218f1f..796c5dd 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -12,6 +12,7 @@
 
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/clocksource.h>
 #include <linux/can/platform/flexcan.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -178,11 +179,13 @@ static struct of_dev_auxdata mxs_auxdata_lookup[] __initdata = {
 static void __init imx23_timer_init(void)
 {
 	mx23_clocks_init();
+	clocksource_of_init();
 }
 
 static void __init imx28_timer_init(void)
 {
 	mx28_clocks_init();
+	clocksource_of_init();
 }
 
 enum mac_oui {
diff --git a/arch/arm/mach-mxs/timer.c b/arch/arm/mach-mxs/timer.c
index 4210204..fe2903d 100644
--- a/arch/arm/mach-mxs/timer.c
+++ b/arch/arm/mach-mxs/timer.c
@@ -242,18 +242,11 @@ static int __init mxs_clocksource_init(struct clk *timer_clk)
 	return 0;
 }
 
-void __init mxs_timer_init(void)
+static void __init mxs_timer_init(struct device_node *np)
 {
-	struct device_node *np;
 	struct clk *timer_clk;
 	int irq;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,timrot");
-	if (!np) {
-		pr_err("%s: failed find timrot node\n", __func__);
-		return;
-	}
-
 	timer_clk = clk_get_sys("timrot", NULL);
 	if (IS_ERR(timer_clk)) {
 		pr_err("%s: failed to get clk\n", __func__);
@@ -304,3 +297,4 @@ void __init mxs_timer_init(void)
 	irq = irq_of_parse_and_map(np, 0);
 	setup_irq(irq, &mxs_timer_irq);
 }
+CLOCKSOURCE_OF_DECLARE(mxs, "fsl,timrot", mxs_timer_init)
diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
index b5c06f9..52e0365 100644
--- a/drivers/clk/mxs/clk-imx23.c
+++ b/drivers/clk/mxs/clk-imx23.c
@@ -165,7 +165,5 @@ int __init mx23_clocks_init(void)
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
 		clk_prepare_enable(clks[clks_init_on[i]]);
 
-	mxs_timer_init();
-
 	return 0;
 }
diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index 76ce6c6..03918e1 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -244,7 +244,5 @@ int __init mx28_clocks_init(void)
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
 		clk_prepare_enable(clks[clks_init_on[i]]);
 
-	mxs_timer_init();
-
 	return 0;
 }
-- 
1.7.9.5
