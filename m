From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 28 May 2010 19:34:46 +0200
Subject: [PATCH] ARM: nomadik MTU to use dynamic shift and mult assignment
Message-ID: <1275068086-18051-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the hard-coded shift values for the MTU timer, since
the different platforms using this has very different running
frequencies doing this dynamically is a better idea. Also take
this opportunity to make a more through shutdown of the MTU
clockevent when requested.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/plat-nomadik/include/plat/mtu.h |    6 ++++++
 arch/arm/plat-nomadik/timer.c            |   14 ++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-nomadik/include/plat/mtu.h b/arch/arm/plat-nomadik/include/plat/mtu.h
index 42c9072..65704a3 100644
--- a/arch/arm/plat-nomadik/include/plat/mtu.h
+++ b/arch/arm/plat-nomadik/include/plat/mtu.h
@@ -1,6 +1,12 @@
 #ifndef __PLAT_MTU_H
 #define __PLAT_MTU_H
 
+/*
+ * Guaranteed runtime conversion range in seconds for
+ * the clocksource and clockevent.
+ */
+#define MTU_MIN_RANGE 4
+
 /* should be set by the platform code */
 extern void __iomem *mtu_base;
 
diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index 08aaa4a..ea3ca86 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -42,7 +42,6 @@ static struct clocksource nmdk_clksrc = {
 	.rating		= 200,
 	.read		= nmdk_read_timer_dummy,
 	.mask		= CLOCKSOURCE_MASK(32),
-	.shift		= 20,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -82,6 +81,12 @@ static void nmdk_clkevt_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_UNUSED:
 		/* disable irq */
 		writel(0, mtu_base + MTU_IMSC);
+		/* disable timer */
+		cr = readl(mtu_base + MTU_CR(1));
+		cr &= ~MTU_CRn_ENA;
+		writel(cr, mtu_base + MTU_CR(1));
+		/* load some high default value */
+		writel(0xffffffff, mtu_base + MTU_LR(1));
 		break;
 	case CLOCK_EVT_MODE_RESUME:
 		break;
@@ -98,7 +103,6 @@ static int nmdk_clkevt_next(unsigned long evt, struct clock_event_device *ev)
 static struct clock_event_device nmdk_clkevt = {
 	.name		= "mtu_1",
 	.features	= CLOCK_EVT_FEAT_ONESHOT,
-	.shift		= 32,
 	.rating		= 200,
 	.set_mode	= nmdk_clkevt_mode,
 	.set_next_event	= nmdk_clkevt_next,
@@ -151,6 +155,7 @@ void __init nmdk_timer_init(void)
 	} else {
 		cr |= MTU_CRn_PRESCALE_1;
 	}
+	clocksource_calc_mult_shift(&nmdk_clksrc, rate, MTU_MIN_RANGE);
 
 	/* Timer 0 is the free running clocksource */
 	writel(cr, mtu_base + MTU_CR(0));
@@ -158,7 +163,6 @@ void __init nmdk_timer_init(void)
 	writel(0, mtu_base + MTU_BGLR(0));
 	writel(cr | MTU_CRn_ENA, mtu_base + MTU_CR(0));
 
-	nmdk_clksrc.mult = clocksource_hz2mult(rate, nmdk_clksrc.shift);
 	/* Now the scheduling clock is ready */
 	nmdk_clksrc.read = nmdk_read_timer;
 
@@ -175,8 +179,10 @@ void __init nmdk_timer_init(void)
 	} else {
 		cr |= MTU_CRn_PRESCALE_1;
 	}
+	clockevents_calc_mult_shift(&nmdk_clkevt, rate, MTU_MIN_RANGE);
+
 	writel(cr | MTU_CRn_ONESHOT, mtu_base + MTU_CR(1)); /* off, currently */
-	nmdk_clkevt.mult = div_sc(rate, NSEC_PER_SEC, nmdk_clkevt.shift);
+
 	nmdk_clkevt.max_delta_ns =
 		clockevent_delta2ns(0xffffffff, &nmdk_clkevt);
 	nmdk_clkevt.min_delta_ns =
-- 
1.6.3.3
