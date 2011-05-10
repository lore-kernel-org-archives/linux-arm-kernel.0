From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 May 2011 08:28:58 +0100
Subject: [PATCH 05/13] ARM: update sa1100 to reflect PXA updates
In-Reply-To: <20110510072700.GA29869@n2100.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
Message-ID: <E1QJhNK-0000yd-4V@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update sa1100 clockevents code to reflect what its later derivative
does with clockevents_calc_mult_shift().  Use OSSR_M* constants too.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/time.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
index ae4f3d8..51c0529 100644
--- a/arch/arm/mach-sa1100/time.c
+++ b/arch/arm/mach-sa1100/time.c
@@ -92,7 +92,6 @@ sa1100_osmr0_set_mode(enum clock_event_mode mode, struct clock_event_device *c)
 static struct clock_event_device ckevt_sa1100_osmr0 = {
 	.name		= "osmr0",
 	.features	= CLOCK_EVT_FEAT_ONESHOT,
-	.shift		= 32,
 	.rating		= 200,
 	.set_next_event	= sa1100_osmr0_set_next_event,
 	.set_mode	= sa1100_osmr0_set_mode,
@@ -120,14 +119,13 @@ static struct irqaction sa1100_timer_irq = {
 
 static void __init sa1100_timer_init(void)
 {
-	OIER = 0;		/* disable any timer interrupts */
-	OSSR = 0xf;		/* clear status on all timers */
+	OIER = 0;
+	OSSR = OSSR_M0 | OSSR_M1 | OSSR_M2 | OSSR_M3;
 
 	init_fixed_sched_clock(&cd, sa1100_update_sched_clock, 32,
 			       3686400, SC_MULT, SC_SHIFT);
 
-	ckevt_sa1100_osmr0.mult =
-		div_sc(3686400, NSEC_PER_SEC, ckevt_sa1100_osmr0.shift);
+	clockevents_calc_mult_shift(&ckevt_sa1100_osmr0, 3686400, 4);
 	ckevt_sa1100_osmr0.max_delta_ns =
 		clockevent_delta2ns(0x7fffffff, &ckevt_sa1100_osmr0);
 	ckevt_sa1100_osmr0.min_delta_ns =
-- 
1.7.4.4
