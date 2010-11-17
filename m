From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 17 Nov 2010 14:45:17 +0100
Subject: [PATCH] nomadik: prevent sched_clock() wraparound v3
Message-ID: <1290001517-17010-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current implementation of sched_clock() for the Nomadik
family is based on the clock source that will wrap around without
any compensation. Currently on the Ux500 after 1030 seconds.

Utilize cnt32_to_63 to expand the sched_clock() counter to 63
bits and introduce a keepwarm() timer to assure that sched clock
and this cnt32_to_63 is called atleast once every half period.

When I print out the actual wrap-around time, and using
a year (3600*24*365 seconds) as minumum wrap limit I get an
actual wrap-around of:
sched_clock: using 55 bits @ 8333125 Hz wrap in 50041 days
I.e circa 137 years which should be fair enough.

Cc: Alessandro Rubini <rubini@unipv.it>
Cc: Colin Cross <ccross@google.com>
Cc: Rabin Vincent <rabin.vincent@stericsson.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <johnstul@us.ibm.com>
Cc: Harald Gustafsson <harald.gustafsson@ericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
Version 3:

In this version of the patch I have taken the approach of making
sched_clock() based on the clock source timer, calculating mult
and shift from a minimum of a year. The multing and shifting will
overflow the 64 bit limit, and this makes a tradeoff similar
to what is found in the Orion architecture, but a bit more
explicit and reusing the mult/shift calculation code from the
clocksource.

Thanks to the kernel community that has been very helpful in
guiding this design.
---
 arch/arm/plat-nomadik/timer.c |   87 ++++++++++++++++++++++++++++++++++++-----
 1 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index aedf9c1..d1eb143 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2008 STMicroelectronics
  * Copyright (C) 2010 Alessandro Rubini
+ * Copyright (C) 2010 Linus Walleij
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2, as
@@ -16,11 +17,13 @@
 #include <linux/clk.h>
 #include <linux/jiffies.h>
 #include <linux/err.h>
+#include <linux/cnt32_to_63.h>
+#include <linux/timer.h>
 #include <asm/mach/time.h>
 
 #include <plat/mtu.h>
 
-void __iomem *mtu_base; /* ssigned by machine code */
+void __iomem *mtu_base; /* Assigned by machine code */
 
 /*
  * Kernel assumes that sched_clock can be called early
@@ -48,16 +51,78 @@ static struct clocksource nmdk_clksrc = {
 /*
  * Override the global weak sched_clock symbol with this
  * local implementation which uses the clocksource to get some
- * better resolution when scheduling the kernel. We accept that
- * this wraps around for now, since it is just a relative time
- * stamp. (Inspired by OMAP implementation.)
+ * better resolution when scheduling the kernel.
+ *
+ * Because the hardware timer period may be quite short
+ * (32.3 secs on the 133 MHz MTU timer selection on ux500)
+ * and because cnt32_to_63() needs to be called at least once per
+ * half period to work properly, a kernel keepwarm() timer is set up
+ * to ensure this requirement is always met.
+ *
+ * Also the sched_clock timer will wrap around at some point,
+ * here we set it to run continously for a year.
+ */
+#define SCHED_CLOCK_MIN_WRAP 3600*24*365
+static struct timer_list cnt32_to_63_keepwarm_timer;
+static u32 sched_mult;
+static u32 sched_shift;
+
+unsigned long long sched_clock(void)
+{
+	u64 cycles;
+
+	if (unlikely(!mtu_base))
+		return 0;
+
+	cycles = cnt32_to_63(-readl(mtu_base + MTU_VAL(0)));
+	cycles &= 0x7FFFFFFFFFFFFFFFLLU;
+	return (cycles * sched_mult) >> sched_shift;
+}
+
+/* Just kick sched_clock every so often */
+static void cnt32_to_63_keepwarm(unsigned long data)
+{
+	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
+	(void) sched_clock();
+}
+
+/*
+ * Set up a timer to keep sched_clock():s 32_to_63 algorithm warm
+ * once in half a 32bit timer wrap interval.
  */
-unsigned long long notrace sched_clock(void)
+static void __init nmdk_sched_clock_init(unsigned long rate)
 {
-	return clocksource_cyc2ns(nmdk_clksrc.read(
-				  &nmdk_clksrc),
-				  nmdk_clksrc.mult,
-				  nmdk_clksrc.shift);
+	u32 v;
+	unsigned long delta;
+	u64 days;
+
+	/* Find the apropriate mult and shift factors */
+	clocks_calc_mult_shift(&sched_mult, &sched_shift,
+			       rate, NSEC_PER_SEC, SCHED_CLOCK_MIN_WRAP);
+	/* We need to multiply by atleast 2 to get rid of bit 63 */
+	BUG_ON(sched_mult < 2);
+
+	/* Let's see what we get, take max counter and scale it */
+	days = 0xFFFFFFFFFFFFFFFFLLU >> sched_shift;
+	do_div(days, rate);
+	do_div(days, (3600*24));
+
+	pr_debug("sched_clock: using %d bits @ %lu Hz wrap in %lu days\n",
+		(64 - sched_shift), rate, (unsigned long) days);
+
+	/*
+	 * Program a timer to kick us at half 32bit wraparound
+	 * Formula: seconds per wrap = (2^32) / f
+	 */
+	v = 0xFFFFFFFFUL / rate;
+	/* We want half of the wrap time to keep cnt32_to_63 warm */
+	v /= 2;
+	pr_debug("sched_clock: prescaled timer rate: %lu Hz, "
+		 "initialize keepwarm timer every %d seconds\n", rate, v);
+	/* Convert seconds to jiffies */
+	delta = msecs_to_jiffies(v*1000);
+	setup_timer(&cnt32_to_63_keepwarm_timer, cnt32_to_63_keepwarm, delta);
+	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + delta));
 }
 
 /* Clockevent device: use one-shot mode */
@@ -161,13 +226,15 @@ void __init nmdk_timer_init(void)
 	writel(0, mtu_base + MTU_BGLR(0));
 	writel(cr | MTU_CRn_ENA, mtu_base + MTU_CR(0));
 
-	/* Now the scheduling clock is ready */
+	/* Now the clock source is ready */
 	nmdk_clksrc.read = nmdk_read_timer;
 
 	if (clocksource_register(&nmdk_clksrc))
 		pr_err("timer: failed to initialize clock source %s\n",
 		       nmdk_clksrc.name);
 
+	nmdk_sched_clock_init(rate);
+
 	/* Timer 1 is used for events */
 
 	clockevents_calc_mult_shift(&nmdk_clkevt, rate, MTU_MIN_RANGE);
-- 
1.6.3.3
