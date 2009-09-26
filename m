From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sat, 26 Sep 2009 21:50:14 +0200
Subject: [PATCH v2 1/4] iop: clocksource support
Message-ID: <19134.28790.414164.307145@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the IOP platform to expose the free-running
timer 1 as a clocksource object. This timer is now also
properly initialised, which requires a new write_tcr1()
function from the mach-specific code. Apart from the
explicit initialisation, there is no functional change
in how timer 1 is programmed.

Tested on n2100, compile-tested for all plat-iop machines.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
Changes v1 -> v2:
* rebased on 2.6.31
* replaced static guess for the clocksource .shift value
  with code to compute it at runtime, based on similar
  code used in the mips kernel

 arch/arm/include/asm/hardware/iop3xx.h    |    5 +++
 arch/arm/mach-iop13xx/include/mach/time.h |    5 +++
 arch/arm/plat-iop/time.c                  |   45 ++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff -rupN linux-2.6.31/arch/arm/include/asm/hardware/iop3xx.h linux-2.6.31.arm-iop-1-clocksource-v2/arch/arm/include/asm/hardware/iop3xx.h
--- linux-2.6.31/arch/arm/include/asm/hardware/iop3xx.h	2008-10-11 10:43:49.000000000 +0200
+++ linux-2.6.31.arm-iop-1-clocksource-v2/arch/arm/include/asm/hardware/iop3xx.h	2009-09-21 10:26:06.000000000 +0200
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
diff -rupN linux-2.6.31/arch/arm/mach-iop13xx/include/mach/time.h linux-2.6.31.arm-iop-1-clocksource-v2/arch/arm/mach-iop13xx/include/mach/time.h
--- linux-2.6.31/arch/arm/mach-iop13xx/include/mach/time.h	2008-12-25 15:54:13.000000000 +0100
+++ linux-2.6.31.arm-iop-1-clocksource-v2/arch/arm/mach-iop13xx/include/mach/time.h	2009-09-21 10:26:06.000000000 +0200
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
diff -rupN linux-2.6.31/arch/arm/plat-iop/time.c linux-2.6.31.arm-iop-1-clocksource-v2/arch/arm/plat-iop/time.c
--- linux-2.6.31/arch/arm/plat-iop/time.c	2008-12-25 15:54:14.000000000 +0100
+++ linux-2.6.31.arm-iop-1-clocksource-v2/arch/arm/plat-iop/time.c	2009-09-21 10:26:06.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/timex.h>
 #include <linux/io.h>
+#include <linux/clocksource.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
@@ -26,6 +27,43 @@
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
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static void __init iop_clocksource_set_hz(struct clocksource *cs, unsigned int hz)
+{
+	u64 temp;
+	u32 shift;
+
+	/* Find shift and mult values for hz. */
+	shift = 32;
+	do {
+		temp = (u64) NSEC_PER_SEC << shift;
+		do_div(temp, hz);
+		if ((temp >> 32) == 0)
+			break;
+	} while (--shift != 0);
+
+	cs->shift = shift;
+	cs->mult = (u32) temp;
+
+	printk(KERN_INFO "clocksource: %s uses shift %u mult %#x\n",
+	       cs->name, cs->shift, cs->mult);
+}
+
 static unsigned long ticks_per_jiffy;
 static unsigned long ticks_per_usec;
 static unsigned long next_jiffy_time;
@@ -99,8 +137,15 @@ void __init iop_init_time(unsigned long 
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
+	iop_clocksource_set_hz(&iop_clocksource, tick_rate);
+	clocksource_register(&iop_clocksource);
 
 	setup_irq(IRQ_IOP_TIMER0, &iop_timer_irq);
 }
