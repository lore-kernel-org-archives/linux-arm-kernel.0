From: mikpe@it.uu.se (Mikael Pettersson)
Date: Tue, 29 Dec 2009 16:27:12 +0100
Subject: [PATCH] ixp4xx: implement sched_clock()
Message-ID: <19258.8144.467520.52849@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a better sched_clock() to the ixp4xx platform,
implemented via its clocksource support.

This is based on the sched_clock() I implemented for
the IOP platform. Tested on a ds101 ixp420 machine.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
 arch/arm/mach-ixp4xx/common.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff -rupN linux-2.6.33-rc2/arch/arm/mach-ixp4xx/common.c linux-2.6.33-rc2.arm-ixp4xx-sched_clock/arch/arm/mach-ixp4xx/common.c
--- linux-2.6.33-rc2/arch/arm/mach-ixp4xx/common.c	2009-12-26 15:20:55.000000000 +0100
+++ linux-2.6.33-rc2.arm-ixp4xx-sched_clock/arch/arm/mach-ixp4xx/common.c	2009-12-26 15:39:01.000000000 +0100
@@ -427,6 +427,17 @@ static void __init ixp4xx_clocksource_in
 }
 
 /*
+ * sched_clock()
+ */
+unsigned long long sched_clock(void)
+{
+	cycle_t cyc = ixp4xx_get_cycles(NULL);
+	struct clocksource *cs = &clocksource_ixp4xx;
+
+	return clocksource_cyc2ns(cyc, cs->mult, cs->shift);
+}
+
+/*
  * clockevents
  */
 static int ixp4xx_set_next_event(unsigned long evt,
