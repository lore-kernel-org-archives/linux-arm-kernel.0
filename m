From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 31 May 2011 23:08:45 +0200
Subject: [PATCH 1/3] mach-u300: fix compilation error in timer
Message-ID: <1306876125-6711-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The introduction of the mmio timer accidentally referenced the
old clocksource struct which does not exist anymore. Fix this by
using a simple string instead.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/timer.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 891cf44..18d7fa0 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -411,8 +411,7 @@ static void __init u300_timer_init(void)
 	/* Use general purpose timer 2 as clock source */
 	if (clocksource_mmio_init(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC,
 			"GPT2", rate, 300, 32, clocksource_mmio_readl_up))
-		printk(KERN_ERR "timer: failed to initialize clock "
-		       "source %s\n", clocksource_u300_1mhz.name);
+		pr_err("timer: failed to initialize U300 clock source\n");
 
 	clockevents_calc_mult_shift(&clockevent_u300_1mhz,
 				    rate, APPTIMER_MIN_RANGE);
-- 
1.7.3.2
