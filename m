From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 16 Nov 2010 10:11:30 +0100
Subject: [PATCH] nomadik: prevent sched_clock() wraparound
Message-ID: <1289898690-29910-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current implementation of sched_clock() for the Nomadik
family is based on the clock source that will wrap around without
any compensation. Currently on the Ux500 after 1030 seconds.
Utilize cnt32_to_63 to expand the sched_clock() counter to 63
bits and introduce a keepwarm() timer to assure that sched clock
and this cnt32_to_63 is called atleast once every half period.

Cc: Alessandro Rubini <rubini@unipv.it>
Cc: Colin Cross <ccross@google.com>
Cc: Rabin Vincent <rabin.vincent@stericsson.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <johnstul@us.ibm.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
In this version of the patch I have taken the approach of making
sched_clock() based on the clock source timer, reusing the mult
and div settings from the clock source but expanding the counter
to 63 bits before doing so since sched_clock() need to be
continous.

This way I believe I take most of the mailing list feedback from
LKML into account.

This should probably go into the next rc or so since it's a very
real bug.
---
 arch/arm/plat-nomadik/timer.c |   64 ++++++++++++++++++++++++++++++++++------
 1 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index aedf9c1..69272e8 100644
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
@@ -48,16 +51,55 @@ static struct clocksource nmdk_clksrc = {
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
  */
-unsigned long long notrace sched_clock(void)
+static struct timer_list cnt32_to_63_keepwarm_timer;
+
+unsigned long long sched_clock(void)
+{
+	unsigned long long v;
+
+	if (unlikely(!mtu_base))
+		return 0;
+
+	v = cnt32_to_63(-readl(mtu_base + MTU_VAL(0)));
+	/* The highest bit is not valid */
+	v &= 0x7FFFFFFFFFFFFFFFLLU;
+	return clocksource_cyc2ns(v, nmdk_clksrc.mult, nmdk_clksrc.shift);
+}
+
+/* Just kick sched_clock every so often */
+static void cnt32_to_63_keepwarm(unsigned long data)
 {
-	return clocksource_cyc2ns(nmdk_clksrc.read(
-				  &nmdk_clksrc),
-				  nmdk_clksrc.mult,
-				  nmdk_clksrc.shift);
+	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
+	(void) sched_clock();
+}
+
+/*
+ * Set up a timer to keep sched_clock():s 32_to_63 algorithm warm
+ * once in half a 32bit timer wrap interval.
+ */
+static void __init nmdk_sched_clock_init(unsigned long rate)
+{
+	u32 v;
+	unsigned long delta;
+
+	/* Formula: seconds per wrap = (2^32) / f */
+	v = 0xFFFFFFFFUL / rate;
+	/* We want half of the wrap time to keep cnt32_to_63 warm */
+	v /= 2;
+	pr_debug("sched_clock: prescaled timer rate: %lu, "
+		 "initialize keepwarm timer every %d seconds\n", rate, v);
+	/* Convert seconds to jiffies */
+	delta = msecs_to_jiffies(v*1000);
+	setup_timer(&cnt32_to_63_keepwarm_timer, cnt32_to_63_keepwarm, delta);
+	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + delta));
 }
 
 /* Clockevent device: use one-shot mode */
@@ -161,13 +203,15 @@ void __init nmdk_timer_init(void)
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
