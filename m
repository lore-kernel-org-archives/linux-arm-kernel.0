From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 26 Jun 2013 23:16:57 +0200
Subject: [PATCH 4/8] clocksource: sun4i: Fix the next event code
In-Reply-To: <1372281421-2099-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1372281421-2099-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1372281421-2099-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The next_event logic was setting the next interval to fire in the
current timer value instead of the interval value register, which is
obviously wrong. Plus the logic to set the actual value was wrong as
well, so this code has always been broken.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clocksource/sun4i_timer.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 8bd66df..032e504 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -16,6 +16,7 @@
 
 #include <linux/clk.h>
 #include <linux/clockchips.h>
+#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqreturn.h>
@@ -69,9 +70,14 @@ static void sun4i_clkevt_mode(enum clock_event_mode mode,
 static int sun4i_clkevt_next_event(unsigned long evt,
 				   struct clock_event_device *unused)
 {
-	u32 u = readl(timer_base + TIMER_CTL_REG(0));
-	writel(evt, timer_base + TIMER_CNTVAL_REG(0));
-	writel(u | TIMER_CTL_ENABLE | TIMER_CTL_AUTORELOAD,
+	u32 val = readl(timer_base + TIMER_CTL_REG(0));
+	writel(val & ~TIMER_CTL_ENABLE, timer_base + TIMER_CTL_REG(0));
+	udelay(1);
+
+	writel(evt, timer_base + TIMER_INTVAL_REG(0));
+
+	val = readl(timer_base + TIMER_CTL_REG(0));
+	writel(val | TIMER_CTL_ENABLE | TIMER_CTL_AUTORELOAD,
 	       timer_base + TIMER_CTL_REG(0));
 
 	return 0;
-- 
1.8.3.1
