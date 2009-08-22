From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sat, 22 Aug 2009 14:04:55 +0200 (MEST)
Subject: [RFC/RFT 1/3] iop: clocksource support
Message-ID: <200908221204.n7MC4t2v029350@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the IOP platform to expose the free-running
timer 1 as a clocksource object. This timer is now also
properly initialised, which requires a new write_tcr1()
function from the mach implementation code. Apart from the
explicit initialisation, there is no functional change in
how timer 1 is programmed.

The one concern I have is whether the clocksource .shift
value of 20 is appropriate for timer frequencies in the
200/266/333 MHz range which seem to be typical for IOP.

Tested on n2100, compile-tested for all plat-iop machines.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
 arch/arm/include/asm/hardware/iop3xx.h    |    5 +++++
 arch/arm/mach-iop13xx/include/mach/time.h |    5 +++++
 arch/arm/plat-iop/time.c                  |   27 +++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff -rupN linux-2.6.31-rc7/arch/arm/include/asm/hardware/iop3xx.h linux-2.6.31-rc7.arm-iop-1-clocksource/arch/arm/include/asm/hardware/iop3xx.h
--- linux-2.6.31-rc7/arch/arm/include/asm/hardware/iop3xx.h	2008-10-11 10:43:49.000000000 +0200
+++ linux-2.6.31-rc7.arm-iop-1-clocksource/arch/arm/include/asm/hardware/iop3xx.h	2009-08-22 12:06:28.000000000 +0200
@@ -259,6 +259,11 @@ static inline u32 read_tcr1(void)
 	return val;
 }
 
+static inline void write_tcr1(u32 val)
+{
+	asm volatile("mcr p6, 0, %0, c3, c1, 0" : : "r" (val));
+}
+
 static inline void write_trr0(u32 val)
 {
 	asm volatile("mcr p6, 0, %0, c4, c1, 0" : : "r" (val));
diff -rupN linux-2.6.31-rc7/arch/arm/mach-iop13xx/include/mach/time.h linux-2.6.31-rc7.arm-iop-1-clocksource/arch/arm/mach-iop13xx/include/mach/time.h
--- linux-2.6.31-rc7/arch/arm/mach-iop13xx/include/mach/time.h	2008-12-25 15:54:13.000000000 +0100
+++ linux-2.6.31-rc7.arm-iop-1-clocksource/arch/arm/mach-iop13xx/include/mach/time.h	2009-08-22 12:06:28.000000000 +0200
@@ -90,6 +90,11 @@ static inline u32 read_tcr1(void)
 	return val;
 }
 
+static inline void write_tcr1(u32 val)
+{
+	asm volatile("mcr p6, 0, %0, c3, c9, 0" : : "r" (val));
+}
+
 static inline void write_trr0(u32 val)
 {
 	asm volatile("mcr p6, 0, %0, c4, c9, 0" : : "r" (val));
diff -rupN linux-2.6.31-rc7/arch/arm/plat-iop/time.c linux-2.6.31-rc7.arm-iop-1-clocksource/arch/arm/plat-iop/time.c
--- linux-2.6.31-rc7/arch/arm/plat-iop/time.c	2008-12-25 15:54:14.000000000 +0100
+++ linux-2.6.31-rc7.arm-iop-1-clocksource/arch/arm/plat-iop/time.c	2009-08-22 12:06:28.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/timex.h>
 #include <linux/io.h>
+#include <linux/clocksource.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
@@ -26,6 +27,23 @@
 #include <asm/mach/time.h>
 #include <mach/time.h>
 
+/*
+ * IOP clocksource (free-running timer 1).
+ */
+static cycle_t iop_clocksource_read(struct clocksource *unused)
+{
+	return 0xffffffffu - read_tcr1();
+}
+
+static struct clocksource iop_clocksource = {
+	.name 		= "iop_timer1",
+	.rating		= 300,
+	.read		= iop_clocksource_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.shift 		= 20,	/* ??? crude guesstimate */
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
 static unsigned long ticks_per_jiffy;
 static unsigned long ticks_per_usec;
 static unsigned long next_jiffy_time;
@@ -99,8 +117,17 @@ void __init iop_init_time(unsigned long 
 	 */
 	write_trr0(ticks_per_jiffy - 1);
 	write_tmr0(timer_ctl);
+
+	/*
+	 * Set up free-running clocksource timer 1.
+	 */
 	write_trr1(0xffffffff);
+	write_tcr1(0xffffffff);
 	write_tmr1(timer_ctl);
+	iop_clocksource.mult =
+		clocksource_hz2mult(tick_rate,
+				    iop_clocksource.shift);
+	clocksource_register(&iop_clocksource);
 
 	setup_irq(IRQ_IOP_TIMER0, &iop_timer_irq);
 }
