From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 17 Dec 2009 14:33:41 +0100
Subject: [PATCH 2/2] arm/{pxa, sa1100,
	nomadik}: Don't disable irqs in set_next_event and set_mode
In-Reply-To: <1261056821-28521-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1259231164-21242-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1261056821-28521-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1261056821-28521-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These functions are called with irqs already off.  This commit removes
the calls to raw_local_irq_save and raw_local_irq_restore on platforms
that don't have to use a shared interrupt for their timekeeping.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nicolas Pitre <nico@marvell.com>
Cc: Magnus Damm <damm@opensource.se>
Cc: Alessandro Rubini <rubini@unipv.it>
Cc: STEricsson <STEricsson_nomadik_linux@list.st.com>
Cc: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
---
Hello,

@Eric, IIRC you stoped objecting to just remove the irq saving after
Russell's analysis, but I cannot find your mail.  Do I remember right?

Best regards
Uwe

 arch/arm/mach-pxa/time.c      |   10 +---------
 arch/arm/mach-sa1100/time.c   |    8 +-------
 arch/arm/plat-nomadik/timer.c |    9 +--------
 3 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-pxa/time.c b/arch/arm/mach-pxa/time.c
index 750c448..293e40a 100644
--- a/arch/arm/mach-pxa/time.c
+++ b/arch/arm/mach-pxa/time.c
@@ -76,14 +76,12 @@ pxa_ost0_interrupt(int irq, void *dev_id)
 static int
 pxa_osmr0_set_next_event(unsigned long delta, struct clock_event_device *dev)
 {
-	unsigned long flags, next, oscr;
+	unsigned long next, oscr;
 
-	raw_local_irq_save(flags);
 	OIER |= OIER_E0;
 	next = OSCR + delta;
 	OSMR0 = next;
 	oscr = OSCR;
-	raw_local_irq_restore(flags);
 
 	return (signed)(next - oscr) <= MIN_OSCR_DELTA ? -ETIME : 0;
 }
@@ -91,23 +89,17 @@ pxa_osmr0_set_next_event(unsigned long delta, struct clock_event_device *dev)
 static void
 pxa_osmr0_set_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 {
-	unsigned long irqflags;
-
 	switch (mode) {
 	case CLOCK_EVT_MODE_ONESHOT:
-		raw_local_irq_save(irqflags);
 		OIER &= ~OIER_E0;
 		OSSR = OSSR_M0;
-		raw_local_irq_restore(irqflags);
 		break;
 
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_SHUTDOWN:
 		/* initializing, released, or preparing for suspend */
-		raw_local_irq_save(irqflags);
 		OIER &= ~OIER_E0;
 		OSSR = OSSR_M0;
-		raw_local_irq_restore(irqflags);
 		break;
 
 	case CLOCK_EVT_MODE_RESUME:
diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
index b9cbb56..74b6e0e 100644
--- a/arch/arm/mach-sa1100/time.c
+++ b/arch/arm/mach-sa1100/time.c
@@ -35,14 +35,12 @@ static irqreturn_t sa1100_ost0_interrupt(int irq, void *dev_id)
 static int
 sa1100_osmr0_set_next_event(unsigned long delta, struct clock_event_device *c)
 {
-	unsigned long flags, next, oscr;
+	unsigned long next, oscr;
 
-	raw_local_irq_save(flags);
 	OIER |= OIER_E0;
 	next = OSCR + delta;
 	OSMR0 = next;
 	oscr = OSCR;
-	raw_local_irq_restore(flags);
 
 	return (signed)(next - oscr) <= MIN_OSCR_DELTA ? -ETIME : 0;
 }
@@ -50,16 +48,12 @@ sa1100_osmr0_set_next_event(unsigned long delta, struct clock_event_device *c)
 static void
 sa1100_osmr0_set_mode(enum clock_event_mode mode, struct clock_event_device *c)
 {
-	unsigned long flags;
-
 	switch (mode) {
 	case CLOCK_EVT_MODE_ONESHOT:
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_SHUTDOWN:
-		raw_local_irq_save(flags);
 		OIER &= ~OIER_E0;
 		OSSR = OSSR_M0;
-		raw_local_irq_restore(flags);
 		break;
 
 	case CLOCK_EVT_MODE_RESUME:
diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index 62f18ad..fa7cb3a 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -49,24 +49,17 @@ static struct clocksource nmdk_clksrc = {
 static void nmdk_clkevt_mode(enum clock_event_mode mode,
 			     struct clock_event_device *dev)
 {
-	unsigned long flags;
-
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		/* enable interrupts -- and count current value? */
-		raw_local_irq_save(flags);
+		/* count current value? */
 		writel(readl(mtu_base + MTU_IMSC) | 1, mtu_base + MTU_IMSC);
-		raw_local_irq_restore(flags);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		BUG(); /* Not supported, yet */
 		/* FALLTHROUGH */
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_UNUSED:
-		/* disable irq */
-		raw_local_irq_save(flags);
 		writel(readl(mtu_base + MTU_IMSC) & ~1, mtu_base + MTU_IMSC);
-		raw_local_irq_restore(flags);
 		break;
 	case CLOCK_EVT_MODE_RESUME:
 		break;
-- 
1.6.5.2
