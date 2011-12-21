From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Dec 2011 02:20:53 +0100
Subject: [PATCH] ARM: sp804: modernize clock event registration
Message-ID: <1324430453-3680-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the hardcoded shift value and lets the clockevent core
come up with suitable mult and div factors. Tested on the
Integrator/CP.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/common/timer-sp.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index 2393b5b..8794a34 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -143,7 +143,6 @@ static int sp804_set_next_event(unsigned long next,
 }
 
 static struct clock_event_device sp804_clockevent = {
-	.shift		= 32,
 	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.set_mode	= sp804_set_mode,
 	.set_next_event	= sp804_set_next_event,
@@ -169,13 +168,9 @@ void __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
 
 	clkevt_base = base;
 	clkevt_reload = DIV_ROUND_CLOSEST(rate, HZ);
-
 	evt->name = name;
 	evt->irq = irq;
-	evt->mult = div_sc(rate, NSEC_PER_SEC, evt->shift);
-	evt->max_delta_ns = clockevent_delta2ns(0xffffffff, evt);
-	evt->min_delta_ns = clockevent_delta2ns(0xf, evt);
 
 	setup_irq(irq, &sp804_timer_irq);
-	clockevents_register_device(evt);
+	clockevents_config_and_register(evt, rate, 0xf, 0xffffffff);
 }
-- 
1.7.6.4
