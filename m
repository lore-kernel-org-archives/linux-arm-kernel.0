From: jonas.aberg@stericsson.com (Jonas Aaberg)
Date: Thu, 2 Sep 2010 09:30:32 +0200
Subject: [PATCH 2/3] plat-nomadik: Added suspend/resume support for MTU timer.
In-Reply-To: <1283412633-9883-1-git-send-email-jonas.aberg@stericsson.com>
References: <1283412633-9883-1-git-send-email-jonas.aberg@stericsson.com>
Message-ID: <1283412633-9883-2-git-send-email-jonas.aberg@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Alessandro Rubini <rubini@unipv.it>
Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
---
 arch/arm/plat-nomadik/timer.c |   80 ++++++++++++++++++++++++++++++-----------
 1 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index d673888..7d2d965 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/arm/mach-nomadik/timer.c
+ *  linux/arch/arm/plat-nomadik/timer.c
  *
  * Copyright (C) 2008 STMicroelectronics
  * Copyright (C) 2010 Alessandro Rubini
@@ -75,7 +75,7 @@ static void nmdk_clkevt_mode(enum clock_event_mode mode,
 		cr = readl(mtu_base + MTU_CR(1));
 		writel(0, mtu_base + MTU_LR(1));
 		writel(cr | MTU_CRn_ENA, mtu_base + MTU_CR(1));
-		writel(0x2, mtu_base + MTU_IMSC);
+		writel(1 << 1, mtu_base + MTU_IMSC);
 		break;
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_UNUSED:
@@ -127,36 +127,78 @@ static struct irqaction nmdk_timer_irq = {
 	.dev_id		= &nmdk_clkevt,
 };
 
+static void nmdk_timer_reset(void)
+{
+	u32 cr = MTU_CRn_32BITS | MTU_CRn_ENA;
+	struct clk *clk0;
+
+	clk0 = clk_get_sys("mtu0", NULL);
+
+	clk_enable(clk0);
+
+	if (clk_get_rate(clk0) > (16 << 20))
+		cr |= MTU_CRn_PRESCALE_16;
+	else
+		cr |= MTU_CRn_PRESCALE_1;
+
+	/* Timer 0, the free running clocksource */
+	writel(0, mtu_base + MTU_CR(0));
+	writel(0, mtu_base + MTU_LR(0));
+	writel(0, mtu_base + MTU_BGLR(0));
+	writel(cr, mtu_base + MTU_CR(0));
+
+	/* Timer 1, clock event */
+	writel(0, mtu_base + MTU_CR(1));
+	writel(0, mtu_base + MTU_LR(1));
+	writel(1 << 1, mtu_base + MTU_IMSC);
+	writel(cr | MTU_CRn_ONESHOT, mtu_base + MTU_CR(1));
+}
+
+#ifdef CONFIG_PM
+void nmdk_timer_suspend(void)
+{
+	struct clk *clk0;
+
+	/* No interrupts */
+	writel(0, mtu_base + MTU_IMSC);
+	/* Off */
+	writel(0, mtu_base + MTU_CR(0));
+	writel(0, mtu_base + MTU_CR(1));
+
+	clk0 = clk_get_sys("mtu0", NULL);
+
+	clk_disable(clk0);
+}
+
+void nmdk_timer_resume(void)
+{
+	nmdk_timer_reset();
+}
+#endif
+
 void __init nmdk_timer_init(void)
 {
 	unsigned long rate;
 	struct clk *clk0;
-	u32 cr;
 
+	/*
+	 * On MTU block 0: timer0 is used as source,
+	 * timer1 is used for events.
+	 */
 	clk0 = clk_get_sys("mtu0", NULL);
 	BUG_ON(IS_ERR(clk0));
 
-	clk_enable(clk0);
-
 	/*
-	 * Tick rate is 2.4MHz for Nomadik and 110MHz for ux500:
+	 * Tick rate is 2.4MHz for Nomadik and 100 or 133MHz for ux500:
 	 * use a divide-by-16 counter if it's more than 16MHz
 	 */
-	cr = MTU_CRn_32BITS;;
 	rate = clk_get_rate(clk0);
-	if (rate > 16 << 20) {
+	if (rate > (16 << 20))
 		rate /= 16;
-		cr |= MTU_CRn_PRESCALE_16;
-	} else {
-		cr |= MTU_CRn_PRESCALE_1;
-	}
+
 	clocksource_calc_mult_shift(&nmdk_clksrc, rate, MTU_MIN_RANGE);
 
-	/* Timer 0 is the free running clocksource */
-	writel(cr, mtu_base + MTU_CR(0));
-	writel(0, mtu_base + MTU_LR(0));
-	writel(0, mtu_base + MTU_BGLR(0));
-	writel(cr | MTU_CRn_ENA, mtu_base + MTU_CR(0));
+	nmdk_timer_reset();
 
 	/* Now the scheduling clock is ready */
 	nmdk_clksrc.read = nmdk_read_timer;
@@ -165,12 +207,8 @@ void __init nmdk_timer_init(void)
 		pr_err("timer: failed to initialize clock source %s\n",
 		       nmdk_clksrc.name);
 
-	/* Timer 1 is used for events */
-
 	clockevents_calc_mult_shift(&nmdk_clkevt, rate, MTU_MIN_RANGE);
 
-	writel(cr | MTU_CRn_ONESHOT, mtu_base + MTU_CR(1)); /* off, currently */
-
 	nmdk_clkevt.max_delta_ns =
 		clockevent_delta2ns(0xffffffff, &nmdk_clkevt);
 	nmdk_clkevt.min_delta_ns =
-- 
1.6.3.3
