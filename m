From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 May 2011 08:28:17 +0100
Subject: [PATCH 03/13] ARM: omap1: delete useless interrupt handler
In-Reply-To: <20110510072700.GA29869@n2100.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
Message-ID: <E1QJhMf-0000yV-78@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP1 clocksource interrupt handler just increments a variable
which otherwise isn't used, so this seems to be unnecessary.  Tony
Lindgren confirms, so lets remove it.

Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap at vger.kernel.org
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/time.c |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index 6885d2f..e2c29b4 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -189,20 +189,6 @@ static __init void omap_init_mpu_timer(unsigned long rate)
  * ---------------------------------------------------------------------------
  */
 
-static unsigned long omap_mpu_timer2_overflows;
-
-static irqreturn_t omap_mpu_timer2_interrupt(int irq, void *dev_id)
-{
-	omap_mpu_timer2_overflows++;
-	return IRQ_HANDLED;
-}
-
-static struct irqaction omap_mpu_timer2_irq = {
-	.name		= "mpu_timer2",
-	.flags		= IRQF_DISABLED,
-	.handler	= omap_mpu_timer2_interrupt,
-};
-
 static cycle_t mpu_read(struct clocksource *cs)
 {
 	return ~omap_mpu_timer_read(1);
@@ -247,7 +233,6 @@ static void __init omap_init_clocksource(unsigned long rate)
 	static char err[] __initdata = KERN_ERR
 			"%s: can't register clocksource!\n";
 
-	setup_irq(INT_TIMER2, &omap_mpu_timer2_irq);
 	omap_mpu_timer_start(1, ~0, 1);
 	init_sched_clock(&cd, mpu_update_sched_clock, 32, rate);
 
-- 
1.7.4.4
