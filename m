From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat,  6 Jul 2013 00:18:43 +0200
Subject: [PATCHv4 08/10] clocksource: sun4i: Remove TIMER_SCAL variable
In-Reply-To: <1373062725-19625-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1373062725-19625-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1373062725-19625-9-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The prescaler is only used when using the internal low frequency
oscillator (at 32kHz). Since we're using the higher frequency oscillator
at 24MHz, we can just remove it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clocksource/sun4i_timer.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index dd78b63..3217adc 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -34,8 +34,6 @@
 #define TIMER_INTVAL_REG(val)	(0x10 * (val) + 0x14)
 #define TIMER_CNTVAL_REG(val)	(0x10 * (val) + 0x18)
 
-#define TIMER_SCAL		16
-
 static void __iomem *timer_base;
 
 /*
@@ -168,8 +166,7 @@ static void __init sun4i_timer_init(struct device_node *node)
 	clocksource_mmio_init(timer_base + TIMER_CNTVAL_REG(1), node->name,
 			      rate, 300, 32, clocksource_mmio_readl_down);
 
-	writel(rate / (TIMER_SCAL * HZ),
-	       timer_base + TIMER_INTVAL_REG(0));
+	writel(rate / HZ, timer_base + TIMER_INTVAL_REG(0));
 
 	/* set clock source to HOSC, 16 pre-division */
 	val = readl(timer_base + TIMER_CTL_REG(0));
@@ -192,8 +189,8 @@ static void __init sun4i_timer_init(struct device_node *node)
 
 	sun4i_clockevent.cpumask = cpumask_of(0);
 
-	clockevents_config_and_register(&sun4i_clockevent, rate / TIMER_SCAL,
-					0x1, 0xff);
+	clockevents_config_and_register(&sun4i_clockevent, rate, 0x1,
+					0xffffffff);
 }
 CLOCKSOURCE_OF_DECLARE(sun4i, "allwinner,sun4i-timer",
 		       sun4i_timer_init);
-- 
1.8.3.2
