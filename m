From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sun, 18 Oct 2009 00:48:35 +0200
Subject: [PATCH] Make MIPS dynamic clocksource/clockevent clock code generic
Message-ID: <1255819715-19763-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the clocksource_set_clock() and clockevent_set_clock()
from the MIPS timer code into clockchips and clocksource where
it belongs. The patch was triggered by code posted by Mikael
Pettersson duplicating this code for the IOP ARM system. The
function signatures where altered slightly to fit into their
destination header files, unsigned int changed to u32 and inlined.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mikael Pettersson <mikpe@it.uu.se>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
Ralf has stated in earlier conversation that this should be moved,
now we risk duplicating code so let's move it.

I don't have access to a MIPS cross-compiler so please can the
MIPS people test this?

Can you test it on the IOP too, Mikael?
---
 arch/mips/include/asm/time.h |    4 ----
 arch/mips/kernel/time.c      |   33 ---------------------------------
 include/linux/clockchips.h   |   24 ++++++++++++++++++++++++
 include/linux/clocksource.h  |   24 +++++++++++++++++++++++-
 4 files changed, 47 insertions(+), 38 deletions(-)

diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index df6a430..e9b3f92 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -84,8 +84,4 @@ static inline int init_mips_clocksource(void)
 #endif
 }
 
-extern void clocksource_set_clock(struct clocksource *cs, unsigned int clock);
-extern void clockevent_set_clock(struct clock_event_device *cd,
-		unsigned int clock);
-
 #endif /* _ASM_TIME_H */
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 1f467d5..fb74974 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -71,39 +71,6 @@ EXPORT_SYMBOL(perf_irq);
 
 unsigned int mips_hpt_frequency;
 
-void __init clocksource_set_clock(struct clocksource *cs, unsigned int clock)
-{
-	u64 temp;
-	u32 shift;
-
-	/* Find a shift value */
-	for (shift = 32; shift > 0; shift--) {
-		temp = (u64) NSEC_PER_SEC << shift;
-		do_div(temp, clock);
-		if ((temp >> 32) == 0)
-			break;
-	}
-	cs->shift = shift;
-	cs->mult = (u32) temp;
-}
-
-void __cpuinit clockevent_set_clock(struct clock_event_device *cd,
-	unsigned int clock)
-{
-	u64 temp;
-	u32 shift;
-
-	/* Find a shift value */
-	for (shift = 32; shift > 0; shift--) {
-		temp = (u64) clock << shift;
-		do_div(temp, NSEC_PER_SEC);
-		if ((temp >> 32) == 0)
-			break;
-	}
-	cd->shift = shift;
-	cd->mult = (u32) temp;
-}
-
 /*
  * This function exists in order to cause an error due to a duplicate
  * definition if platform code should have its own implementation.  The hook
diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index 3a1dbba..41aa95e 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -115,6 +115,30 @@ static inline unsigned long div_sc(unsigned long ticks, unsigned long nsec,
 	return (unsigned long) tmp;
 }
 
+/**
+ * clockevent_set_clock - dynamically calculates an appropriate shift
+ *			  and mult value for a clocksource given a
+ *			  known clock frequency
+ * @dev:	Clockevent device to initialize
+ * @hz:		Clockevent clock frequency in Hz
+ */
+static inline void clockevent_set_clock(struct clock_event_device *dev, u32 hz)
+{
+	u64 temp;
+	u32 shift;
+
+	/* Find a shift value */
+	for (shift = 32; shift > 0; shift--) {
+		temp = (u64) hz << shift;
+		do_div(temp, NSEC_PER_SEC);
+		if ((temp >> 32) == 0)
+			break;
+	}
+	dev->shift = shift;
+	dev->mult = (u32) temp;
+}
+
+
 /* Clock event layer functions */
 extern unsigned long clockevent_delta2ns(unsigned long latch,
 					 struct clock_event_device *evt);
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 9ea40ff..807fb37 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -257,6 +257,29 @@ static inline u32 clocksource_hz2mult(u32 hz, u32 shift_constant)
 }
 
 /**
+ * clocksource_set_clock - dynamically calculates an appropriate shift
+ *			   and mult value for a clocksource given a
+ *			   known clock frequency
+ * @cs:		Clocksource to initialize
+ * @hz:		Clocksource frequency in Hz
+ */
+static inline void clocksource_set_clock(struct clocksource *cs, u32 hz)
+{
+	u64 temp;
+	u32 shift;
+
+	/* Find a shift value */
+	for (shift = 32; shift > 0; shift--) {
+		temp = (u64) NSEC_PER_SEC << shift;
+		do_div(temp, hz);
+		if ((temp >> 32) == 0)
+			break;
+	}
+	cs->shift = shift;
+	cs->mult = (u32) temp;
+}
+
+/**
  * clocksource_cyc2ns - converts clocksource cycles to nanoseconds
  *
  * Converts cycles to nanoseconds, using the given mult and shift.
@@ -268,7 +291,6 @@ static inline s64 clocksource_cyc2ns(cycle_t cycles, u32 mult, u32 shift)
 	return ((u64) cycles * mult) >> shift;
 }
 
-
 /* used to install a new clocksource */
 extern int clocksource_register(struct clocksource*);
 extern void clocksource_unregister(struct clocksource*);
-- 
1.6.2.5
