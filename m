From: torbenh@linutronix.de (Torben Hohn)
Date: Fri, 21 Dec 2012 15:06:15 +0100
Subject: [PATCH 1/2] mxs timer: use ahbx bus clock to drive the timers on
 timrotv2
In-Reply-To: <1356098776-10498-1-git-send-email-torbenh@linutronix.de>
References: <1356098776-10498-1-git-send-email-torbenh@linutronix.de>
Message-ID: <1356098776-10498-2-git-send-email-torbenh@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

timer resolution of ~32us is pretty low.
v2 has 32bits resolution, so we have quite some headroom, and
can use the 24MHz clock.
v1 has only 16bits, so we only increase v2.

So we just exchange the timrot clock in imx28.
On imx23 we have timrotv1 and everything stays the same.

Signed-off-by: Torben Hohn <torbenh@linutronix.de>
---
 arch/arm/mach-mxs/timer.c   |    9 +++++----
 drivers/clk/mxs/clk-imx28.c |    2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mxs/timer.c b/arch/arm/mach-mxs/timer.c
index 856f4c7..689a2b5 100644
--- a/arch/arm/mach-mxs/timer.c
+++ b/arch/arm/mach-mxs/timer.c
@@ -72,8 +72,9 @@
 #define BM_TIMROT_TIMCTRLn_IRQ_EN	(1 << 14)
 #define BM_TIMROT_TIMCTRLn_IRQ		(1 << 15)
 #define BP_TIMROT_TIMCTRLn_SELECT	0
-#define BV_TIMROTv1_TIMCTRLn_SELECT__32KHZ_XTAL	0x8
-#define BV_TIMROTv2_TIMCTRLn_SELECT__32KHZ_XTAL	0xb
+#define BV_TIMROTv1_TIMCTRLn_SELECT__32KHZ_XTAL		0x8
+#define BV_TIMROTv2_TIMCTRLn_SELECT__32KHZ_XTAL		0xb
+#define BV_TIMROTv2_TIMCTRLn_SELECT__TICK_ALWAYS	0xf
 
 static struct clock_event_device mxs_clockevent_device;
 static enum clock_event_mode mxs_clockevent_mode = CLOCK_EVT_MODE_UNUSED;
@@ -288,7 +289,7 @@ void __init mxs_timer_init(void)
 	/* one for clock_event */
 	__raw_writel((timrot_is_v1() ?
 			BV_TIMROTv1_TIMCTRLn_SELECT__32KHZ_XTAL :
-			BV_TIMROTv2_TIMCTRLn_SELECT__32KHZ_XTAL) |
+			BV_TIMROTv2_TIMCTRLn_SELECT__TICK_ALWAYS) |
 			BM_TIMROT_TIMCTRLn_UPDATE |
 			BM_TIMROT_TIMCTRLn_IRQ_EN,
 			mxs_timrot_base + HW_TIMROT_TIMCTRLn(0));
@@ -296,7 +297,7 @@ void __init mxs_timer_init(void)
 	/* another for clocksource */
 	__raw_writel((timrot_is_v1() ?
 			BV_TIMROTv1_TIMCTRLn_SELECT__32KHZ_XTAL :
-			BV_TIMROTv2_TIMCTRLn_SELECT__32KHZ_XTAL) |
+			BV_TIMROTv2_TIMCTRLn_SELECT__TICK_ALWAYS) |
 			BM_TIMROT_TIMCTRLn_RELOAD,
 			mxs_timrot_base + HW_TIMROT_TIMCTRLn(1));
 
diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index db3af08..0174270 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -238,7 +238,7 @@ int __init mx28_clocks_init(void)
 		of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 	}
 
-	clk_register_clkdev(clks[clk32k], NULL, "timrot");
+	clk_register_clkdev(clks[xbus], NULL, "timrot");
 	clk_register_clkdev(clks[enet_out], NULL, "enet_out");
 
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
-- 
1.7.10.4
