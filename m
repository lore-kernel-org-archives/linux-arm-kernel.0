From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 17 Sep 2009 14:07:29 +0200
Subject: [PATCH 1/5] U300 sched_clock implementation v2
Message-ID: <1253189249-30672-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the long debated sched_clock() override for the weak
in-kernel jiffybased sched_clock(). The implementation is more or
less identical to the one used in arch/arm/plat-omap/common.c
and at last attempt to merge this the merge was postponed at the
request of Peter Zijlstra due to pending discussions regarding
generalized clocksource-based sched_clock() implementations by
adding a flag to the clocksource. However that discussion ended
up with the generic code needing to be rewritten and Paul Mundt
see no reason not to proceed with this for the time being as it
can be easily converted once the generic code is in place.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Mundt <lethal@linux-sh.org>
---
 arch/arm/mach-u300/timer.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index cce5320..26d26f5 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -346,6 +346,21 @@ static struct clocksource clocksource_u300_1mhz = {
 	.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+/*
+ * Override the global weak sched_clock symbol with this
+ * local implementation which uses the clocksource to get some
+ * better resolution when scheduling the kernel. We accept that
+ * this wraps around for now, since it is just a relative time
+ * stamp. (Inspired by OMAP implementation.)
+ */
+unsigned long long notrace sched_clock(void)
+{
+	return clocksource_cyc2ns(clocksource_u300_1mhz.read(
+				  &clocksource_u300_1mhz),
+				  clocksource_u300_1mhz.mult,
+				  clocksource_u300_1mhz.shift);
+}
+
 
 /*
  * This sets up the system timers, clock source and clock event.
-- 
1.6.2.1
