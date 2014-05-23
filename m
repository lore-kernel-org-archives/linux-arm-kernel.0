From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 23 May 2014 12:43:00 +0200
Subject: [PATCH 2/2] clocksource: tcb_clksrc: Make tc_mode interrupt safe
In-Reply-To: <1400841780-7119-1-git-send-email-daniel.lezcano@linaro.org>
References: <537F2589.5050807@linaro.org>
 <1400841780-7119-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1400841780-7119-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Jander <david@protonic.nl>

tc_mode() can be called from interrupt context and thus must not call
clk_*prepare*() functions.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/clocksource/tcb_clksrc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index 00fdd11..a8d7ea1 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -100,7 +100,7 @@ static void tc_mode(enum clock_event_mode m, struct clock_event_device *d)
 			|| tcd->clkevt.mode == CLOCK_EVT_MODE_ONESHOT) {
 		__raw_writel(0xff, regs + ATMEL_TC_REG(2, IDR));
 		__raw_writel(ATMEL_TC_CLKDIS, regs + ATMEL_TC_REG(2, CCR));
-		clk_disable_unprepare(tcd->clk);
+		clk_disable(tcd->clk);
 	}
 
 	switch (m) {
@@ -109,7 +109,7 @@ static void tc_mode(enum clock_event_mode m, struct clock_event_device *d)
 	 * of oneshot, we get lower overhead and improved accuracy.
 	 */
 	case CLOCK_EVT_MODE_PERIODIC:
-		clk_prepare_enable(tcd->clk);
+		clk_enable(tcd->clk);
 
 		/* slow clock, count up to RC, then irq and restart */
 		__raw_writel(timer_clock
@@ -126,7 +126,7 @@ static void tc_mode(enum clock_event_mode m, struct clock_event_device *d)
 		break;
 
 	case CLOCK_EVT_MODE_ONESHOT:
-		clk_prepare_enable(tcd->clk);
+		clk_enable(tcd->clk);
 
 		/* slow clock, count up to RC, then irq and stop */
 		__raw_writel(timer_clock | ATMEL_TC_CPCSTOP
@@ -194,7 +194,7 @@ static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
 	ret = clk_prepare_enable(t2_clk);
 	if (ret)
 		return ret;
-	clk_disable_unprepare(t2_clk);
+	clk_disable(t2_clk);
 
 	clkevt.regs = tc->regs;
 	clkevt.clk = t2_clk;
-- 
1.7.9.5
