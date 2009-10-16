From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sat, 17 Oct 2009 00:00:51 +0200
Subject: [PATCH v3 4/4] iop: implement sched_clock()
Message-ID: <19160.60691.72229.932486@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a better sched_clock() to the IOP platform,
implemented using its new clocksource support.

Tested on n2100, compile-tested for all plat-iop machines.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
Changes v2 -> v3:
* bug fix: open-code cyc2ns() and use cs->mult_orig not cs->mult
* rebased on 2.6.32-rc5, use new clocksource_cyc2ns()

Changes v1 -> v2:
* implemented sched_clock()

 arch/arm/plat-iop/time.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff -rupN linux-2.6.32-rc5.arm-iop-3-generictime-v3/arch/arm/plat-iop/time.c linux-2.6.32-rc5.arm-iop-4-sched_clock-v3/arch/arm/plat-iop/time.c
--- linux-2.6.32-rc5.arm-iop-3-generictime-v3/arch/arm/plat-iop/time.c	2009-10-16 21:36:55.000000000 +0200
+++ linux-2.6.32-rc5.arm-iop-4-sched_clock-v3/arch/arm/plat-iop/time.c	2009-10-16 21:39:16.000000000 +0200
@@ -66,6 +66,17 @@ static void __init iop_clocksource_set_h
 }
 
 /*
+ * IOP sched_clock() implementation via its clocksource.
+ */
+unsigned long long sched_clock(void)
+{
+	cycle_t cyc = iop_clocksource_read(NULL);
+	struct clocksource *cs = &iop_clocksource;
+
+	return clocksource_cyc2ns(cyc, cs->mult, cs->shift);
+}
+
+/*
  * IOP clockevents (interrupting timer 0).
  */
 static int iop_set_next_event(unsigned long delta,
