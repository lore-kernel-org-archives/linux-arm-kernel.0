From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sat, 26 Sep 2009 21:52:10 +0200
Subject: [PATCH v2 4/4] iop: implement sched_clock()
Message-ID: <19134.28906.783581.37290@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a better sched_clock() to the IOP platform,
implemented using its new clocksource support.

Tested on n2100, compile-tested for all plat-iop machines.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
Changes v1 -> v2:
* implemented sched_clock()

 arch/arm/plat-iop/time.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -rupN linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/plat-iop/time.c linux-2.6.31.arm-iop-4-sched_clock/arch/arm/plat-iop/time.c
--- linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/plat-iop/time.c	2009-09-26 17:25:09.000000000 +0200
+++ linux-2.6.31.arm-iop-4-sched_clock/arch/arm/plat-iop/time.c	2009-09-26 17:24:29.000000000 +0200
@@ -66,6 +66,14 @@ static void __init iop_clocksource_set_h
 }
 
 /*
+ * IOP sched_clock() implementation via its clocksource.
+ */
+unsigned long long sched_clock(void)
+{
+	return cyc2ns(&iop_clocksource, iop_clocksource_read(NULL));
+}
+
+/*
  * IOP clockevents (interrupting timer 0).
  */
 static int iop_set_next_event(unsigned long delta,
