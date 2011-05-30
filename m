From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 30 May 2011 16:08:11 +0200
Subject: [PATCH 1/2] mach-u300: fix compilation error in timer
Message-ID: <1306764491-28369-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The introduction of the mmio timer accidentally referenced the
old clocksource struct which does not exist anymore. Fix this by
using a simple string instead. This also fixes a compilation
warning by casting the address to (void __iomem *).

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/timer.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 891cf44..5e886a4 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -409,10 +409,10 @@ static void __init u300_timer_init(void)
 		U300_TIMER_APP_VBASE + U300_TIMER_APP_EGPT2);
 
 	/* Use general purpose timer 2 as clock source */
-	if (clocksource_mmio_init(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC,
+	if (clocksource_mmio_init((void __iomem *)
+				  U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC,
 			"GPT2", rate, 300, 32, clocksource_mmio_readl_up))
-		printk(KERN_ERR "timer: failed to initialize clock "
-		       "source %s\n", clocksource_u300_1mhz.name);
+		pr_err("timer: failed to initialize U300 clock source\n");
 
 	clockevents_calc_mult_shift(&clockevent_u300_1mhz,
 				    rate, APPTIMER_MIN_RANGE);
-- 
1.7.3.2
