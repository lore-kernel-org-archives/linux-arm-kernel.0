From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  5 Sep 2011 23:00:00 +0200
Subject: [PATCH] mach-integrator: fix the clocksource
Message-ID: <1315256400-10949-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I was intrigued by the fact that the clock stood still on
the Integrator, but it wasn't strange at all, because the
timer was set up all wrong and probably has been for a
while. With this patch the clock starts ticking again:
make the timer periodic (reload), |= on the divisor bit
and load the timer before starting it.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: stable at kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/integrator_ap.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 2fbbdd5..fcf0ae9 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -337,15 +337,15 @@ static unsigned long timer_reload;
 static void integrator_clocksource_init(u32 khz)
 {
 	void __iomem *base = (void __iomem *)TIMER2_VA_BASE;
-	u32 ctrl = TIMER_CTRL_ENABLE;
+	u32 ctrl = TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC;
 
 	if (khz >= 1500) {
 		khz /= 16;
-		ctrl = TIMER_CTRL_DIV16;
+		ctrl |= TIMER_CTRL_DIV16;
 	}
 
-	writel(ctrl, base + TIMER_CTRL);
 	writel(0xffff, base + TIMER_LOAD);
+	writel(ctrl, base + TIMER_CTRL);
 
 	clocksource_mmio_init(base + TIMER_VALUE, "timer2",
 		khz * 1000, 200, 16, clocksource_mmio_readl_down);
-- 
1.7.6
