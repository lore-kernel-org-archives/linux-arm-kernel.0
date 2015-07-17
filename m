From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 17 Jul 2015 10:41:11 +0530
Subject: [PATCH 17/18] ARM/iop/time: Migrate to new 'set-state' interface
In-Reply-To: <cover.1437101996.git.viresh.kumar@linaro.org>
References: <cover.1437101996.git.viresh.kumar@linaro.org>
Message-ID: <8d778377e598bd78d4ce788b20b1c74777c5d137.1437101996.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate iop driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/plat-iop/time.c | 70 +++++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 27 deletions(-)

diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
index 6ad65d8ae237..101e8f2c7abe 100644
--- a/arch/arm/plat-iop/time.c
+++ b/arch/arm/plat-iop/time.c
@@ -77,41 +77,57 @@ static int iop_set_next_event(unsigned long delta,
 
 static unsigned long ticks_per_jiffy;
 
-static void iop_set_mode(enum clock_event_mode mode,
-			 struct clock_event_device *unused)
+static int iop_set_periodic(struct clock_event_device *evt)
 {
 	u32 tmr = read_tmr0();
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		write_tmr0(tmr & ~IOP_TMR_EN);
-		write_tcr0(ticks_per_jiffy - 1);
-		write_trr0(ticks_per_jiffy - 1);
-		tmr |= (IOP_TMR_RELOAD | IOP_TMR_EN);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* ->set_next_event sets period and enables timer */
-		tmr &= ~(IOP_TMR_RELOAD | IOP_TMR_EN);
-		break;
-	case CLOCK_EVT_MODE_RESUME:
-		tmr |= IOP_TMR_EN;
-		break;
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_UNUSED:
-	default:
-		tmr &= ~IOP_TMR_EN;
-		break;
-	}
+	write_tmr0(tmr & ~IOP_TMR_EN);
+	write_tcr0(ticks_per_jiffy - 1);
+	write_trr0(ticks_per_jiffy - 1);
+	tmr |= (IOP_TMR_RELOAD | IOP_TMR_EN);
 
 	write_tmr0(tmr);
+	return 0;
+}
+
+static int iop_set_oneshot(struct clock_event_device *evt)
+{
+	u32 tmr = read_tmr0();
+
+	/* ->set_next_event sets period and enables timer */
+	tmr &= ~(IOP_TMR_RELOAD | IOP_TMR_EN);
+	write_tmr0(tmr);
+	return 0;
+}
+
+static int iop_shutdown(struct clock_event_device *evt)
+{
+	u32 tmr = read_tmr0();
+
+	tmr &= ~IOP_TMR_EN;
+	write_tmr0(tmr);
+	return 0;
+}
+
+static int iop_resume(struct clock_event_device *evt)
+{
+	u32 tmr = read_tmr0();
+
+	tmr |= IOP_TMR_EN;
+	write_tmr0(tmr);
+	return 0;
 }
 
 static struct clock_event_device iop_clockevent = {
-	.name		= "iop_timer0",
-	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.rating         = 300,
-	.set_next_event	= iop_set_next_event,
-	.set_mode	= iop_set_mode,
+	.name			= "iop_timer0",
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.rating			= 300,
+	.set_next_event		= iop_set_next_event,
+	.set_state_shutdown	= iop_shutdown,
+	.set_state_periodic	= iop_set_periodic,
+	.tick_resume		= iop_resume,
+	.set_state_oneshot	= iop_set_oneshot,
 };
 
 static irqreturn_t
-- 
2.4.0
