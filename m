From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 17 Dec 2009 14:33:40 +0100
Subject: [PATCH 1/2] arm/at91: Don't disable irqs in set_next_event and
	set_mode callbacks
In-Reply-To: <1259231164-21242-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1259231164-21242-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1261056821-28521-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

on AT91 the timer irq is shared, so the handler might be entered without
irqs being disabled.  Though this should not happen as the timer irq is
registered early, there have been some reports on the mailing list.

To make debugging that problem easier next time it pops up a WARN_ON is
added in the handler if irqs are not off.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Magnus Damm <damm@opensource.se>
Cc: Hugh Dickins <hugh@veritas.com>
Cc: John Stultz <johnstul@us.ibm.com>
---
 arch/arm/mach-at91/at91rm9200_time.c  |   20 ++++++--------------
 arch/arm/mach-at91/at91sam926x_time.c |   11 ++++++-----
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
index 309f351..f494ce9 100644
--- a/arch/arm/mach-at91/at91rm9200_time.c
+++ b/arch/arm/mach-at91/at91rm9200_time.c
@@ -58,6 +58,12 @@ static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
 {
 	u32	sr = at91_sys_read(AT91_ST_SR) & irqmask;
 
+	/*
+	 * irqs should be disabled here, but as the irq is shared they are only
+	 * guaranteed to be off if the timer irq is registered first.
+	 */
+	WARN_ON(!irqs_disabled());
+
 	/* simulate "oneshot" timer with alarm */
 	if (sr & AT91_ST_ALMS) {
 		clkevt.event_handler(&clkevt);
@@ -132,24 +138,11 @@ clkevt32k_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 static int
 clkevt32k_next_event(unsigned long delta, struct clock_event_device *dev)
 {
-	unsigned long	flags;
 	u32		alm;
 	int		status = 0;
 
 	BUG_ON(delta < 2);
 
-	/* Use "raw" primitives so we behave correctly on RT kernels. */
-	raw_local_irq_save(flags);
-
-	/*
-	 * According to Thomas Gleixner irqs are already disabled here.  Simply
-	 * removing raw_local_irq_save above (and the matching
-	 * raw_local_irq_restore) was not accepted.  See
-	 * http://thread.gmane.org/gmane.linux.ports.arm.kernel/41174
-	 * So for now (2008-11-20) just warn once if irqs were not disabled ...
-	 */
-	WARN_ON_ONCE(!raw_irqs_disabled_flags(flags));
-
 	/* The alarm IRQ uses absolute time (now+delta), not the relative
 	 * time (delta) in our calling convention.  Like all clockevents
 	 * using such "match" hardware, we have a race to defend against.
@@ -169,7 +162,6 @@ clkevt32k_next_event(unsigned long delta, struct clock_event_device *dev)
 	alm += delta;
 	at91_sys_write(AT91_ST_RTAR, alm);
 
-	raw_local_irq_restore(flags);
 	return status;
 }
 
diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
index 4bd56ae..786f172 100644
--- a/arch/arm/mach-at91/at91sam926x_time.c
+++ b/arch/arm/mach-at91/at91sam926x_time.c
@@ -62,16 +62,12 @@ static struct clocksource pit_clk = {
 static void
 pit_clkevt_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 {
-	unsigned long	flags;
-
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		/* update clocksource counter, then enable the IRQ */
-		raw_local_irq_save(flags);
+		/* update clocksource counter */
 		pit_cnt += pit_cycle * PIT_PICNT(at91_sys_read(AT91_PIT_PIVR));
 		at91_sys_write(AT91_PIT_MR, (pit_cycle - 1) | AT91_PIT_PITEN
 				| AT91_PIT_PITIEN);
-		raw_local_irq_restore(flags);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		BUG();
@@ -100,6 +96,11 @@ static struct clock_event_device pit_clkevt = {
  */
 static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
 {
+	/*
+	 * irqs should be disabled here, but as the irq is shared they are only
+	 * guaranteed to be off if the timer irq is registered first.
+	 */
+	WARN_ON(!irqs_disabled());
 
 	/* The PIT interrupt may be disabled, and is shared */
 	if ((pit_clkevt.mode == CLOCK_EVT_MODE_PERIODIC)
-- 
1.6.5.2
