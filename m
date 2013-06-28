From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Jun 2013 21:56:24 +0200
Subject: [PATCHv2 6/8] clocksource: sun4i: Remove TIMER_SCAL variable
In-Reply-To: <1372449386-1334-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1372449386-1334-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1372449386-1334-7-git-send-email-maxime.ripard@free-electrons.com>
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
index 6ef10d9..d6621c5 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -124,7 +124,6 @@ static u32 sun4i_timer_sched_read(void)
 
 static void __init sun4i_timer_init(struct device_node *node)
 {
-	unsigned long rate = 0;
 	struct clk *clk;
 	int ret, irq;
 	u32 val;
@@ -142,9 +141,7 @@ static void __init sun4i_timer_init(struct device_node *node)
 		panic("Can't get timer clock");
 	clk_prepare_enable(clk);
 
-	rate = clk_get_rate(clk);
-
-	writel(rate / (TIMER_SCAL * HZ),
+	writel(clk_get_rate(clk) / HZ,
 	       timer_base + TIMER_INTVAL_REG(0));
 
 	/* set clock source to HOSC, 16 pre-division */
@@ -168,8 +165,8 @@ static void __init sun4i_timer_init(struct device_node *node)
 
 	sun4i_clockevent.cpumask = cpumask_of(0);
 
-	clockevents_config_and_register(&sun4i_clockevent, rate / TIMER_SCAL,
-					0x1, 0xff);
+	clockevents_config_and_register(&sun4i_clockevent, clk_get_rate(clk),
+					0x1, 0xffffffff);
 
 	writel(~0, timer_base + TIMER_INTVAL_REG(1));
 	writel(TIMER_CTL_ENABLE | TIMER_CTL_AUTORELOAD | TIMER_CTL_CLK_SRC(TIMER_CTL_CLK_SRC_OSC24M),
-- 
1.8.3.1
