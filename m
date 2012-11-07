From: alban.bedel@avionic-design.de (Alban Bedel)
Date: Wed,  7 Nov 2012 16:47:17 +0100
Subject: [PATCH] lpc32xx: Add the motor PWM clock
Message-ID: <1352303237-16052-1-git-send-email-alban.bedel@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
---
 arch/arm/mach-lpc32xx/clock.c                 |    8 ++++++++
 arch/arm/mach-lpc32xx/include/mach/platform.h |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index f48c2e9..dd5d6f5 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -585,6 +585,13 @@ static struct clk clk_timer3 = {
 	.enable_mask	= LPC32XX_CLKPWR_TMRPWMCLK_TIMER3_EN,
 	.get_rate	= local_return_parent_rate,
 };
+static struct clk clk_mpwm = {
+	.parent		= &clk_pclk,
+	.enable		= local_onoff_enable,
+	.enable_reg	= LPC32XX_CLKPWR_TIMERS_PWMS_CLK_CTRL_1,
+	.enable_mask	= LPC32XX_CLKPWR_TMRPWMCLK_MPWM_EN,
+	.get_rate	= local_return_parent_rate,
+};
 static struct clk clk_wdt = {
 	.parent		= &clk_pclk,
 	.enable		= local_onoff_enable,
@@ -1202,6 +1209,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_INIT("pl08xdmac", NULL, &clk_dma),
 	CLKDEV_INIT("4003c000.watchdog", NULL, &clk_wdt),
 	CLKDEV_INIT("4005c000.pwm", NULL, &clk_pwm),
+	CLKDEV_INIT("400e8000.mpwm", NULL, &clk_mpwm),
 	CLKDEV_INIT(NULL, "uart3_ck", &clk_uart3),
 	CLKDEV_INIT(NULL, "uart4_ck", &clk_uart4),
 	CLKDEV_INIT(NULL, "uart5_ck", &clk_uart5),
diff --git a/arch/arm/mach-lpc32xx/include/mach/platform.h b/arch/arm/mach-lpc32xx/include/mach/platform.h
index acc4aab..b5612a1 100644
--- a/arch/arm/mach-lpc32xx/include/mach/platform.h
+++ b/arch/arm/mach-lpc32xx/include/mach/platform.h
@@ -515,6 +515,7 @@
 /*
  * clkpwr_timers_pwms_clk_ctrl_1 register definitions
  */
+#define LPC32XX_CLKPWR_TMRPWMCLK_MPWM_EN	0x40
 #define LPC32XX_CLKPWR_TMRPWMCLK_TIMER3_EN	0x20
 #define LPC32XX_CLKPWR_TMRPWMCLK_TIMER2_EN	0x10
 #define LPC32XX_CLKPWR_TMRPWMCLK_TIMER1_EN	0x08
-- 
1.7.0.4
