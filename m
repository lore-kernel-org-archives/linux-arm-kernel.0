From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 16 Oct 2011 22:58:20 +0200
Subject: [PATCH 1/2] ARM: at91: define CLOCK_TICK_RATE to bogus value except
	A91X40
Message-ID: <1318798701-2799-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a clocksource which renders CLOCK_TICK_RATE useless. Define
it to a bogus value to get rid of some ifdeffery.

use local LATCH for at91rm9200 timer

but keep it for A91X40 as we do not use a clocksource

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91rm9200_time.c    |    8 ++-
 arch/arm/mach-at91/include/mach/timex.h |   65 ++----------------------------
 2 files changed, 10 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
index 1dd69c8..a028cdf 100644
--- a/arch/arm/mach-at91/at91rm9200_time.c
+++ b/arch/arm/mach-at91/at91rm9200_time.c
@@ -32,6 +32,8 @@ static unsigned long last_crtr;
 static u32 irqmask;
 static struct clock_event_device clkevt;
 
+#define RM9200_TIMER_LATCH	((AT91_SLOW_CLOCK + HZ/2) / HZ)
+
 /*
  * The ST_CRTR is updated asynchronously to the master clock ... but
  * the updates as seen by the CPU don't seem to be strictly monotonic.
@@ -74,8 +76,8 @@ static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
 	if (sr & AT91_ST_PITS) {
 		u32	crtr = read_CRTR();
 
-		while (((crtr - last_crtr) & AT91_ST_CRTV) >= LATCH) {
-			last_crtr += LATCH;
+		while (((crtr - last_crtr) & AT91_ST_CRTV) >= RM9200_TIMER_LATCH) {
+			last_crtr += RM9200_TIMER_LATCH;
 			clkevt.event_handler(&clkevt);
 		}
 		return IRQ_HANDLED;
@@ -116,7 +118,7 @@ clkevt32k_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 	case CLOCK_EVT_MODE_PERIODIC:
 		/* PIT for periodic irqs; fixed rate of 1/HZ */
 		irqmask = AT91_ST_PITS;
-		at91_sys_write(AT91_ST_PIMR, LATCH);
+		at91_sys_write(AT91_ST_PIMR, RM9200_TIMER_LATCH);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		/* ALM for oneshot irqs, set by next_event()
diff --git a/arch/arm/mach-at91/include/mach/timex.h b/arch/arm/mach-at91/include/mach/timex.h
index 85820ad..5e917a6 100644
--- a/arch/arm/mach-at91/include/mach/timex.h
+++ b/arch/arm/mach-at91/include/mach/timex.h
@@ -23,70 +23,15 @@
 
 #include <mach/hardware.h>
 
-#if defined(CONFIG_ARCH_AT91RM9200)
+#ifdef CONFIG_ARCH_AT91X40
 
-#define CLOCK_TICK_RATE		(AT91_SLOW_CLOCK)
-
-#elif defined(CONFIG_ARCH_AT91SAM9260)
-
-#if defined(CONFIG_MACH_USB_A9260) || defined(CONFIG_MACH_QIL_A9260)
-#define AT91SAM9_MASTER_CLOCK	90000000
-#else
-#define AT91SAM9_MASTER_CLOCK	99300000
-#endif
-
-#define CLOCK_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
-
-#elif defined(CONFIG_ARCH_AT91SAM9261)
-
-#define AT91SAM9_MASTER_CLOCK	99300000
-#define CLOCK_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
-
-#elif defined(CONFIG_ARCH_AT91SAM9G10)
-
-#define AT91SAM9_MASTER_CLOCK	133000000
-#define CLOCK_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
-
-#elif defined(CONFIG_ARCH_AT91SAM9263)
-
-#if defined(CONFIG_MACH_USB_A9263)
-#define AT91SAM9_MASTER_CLOCK	90000000
-#else
-#define AT91SAM9_MASTER_CLOCK	99959500
-#endif
-
-#define CLOCK_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
-
-#elif defined(CONFIG_ARCH_AT91SAM9RL)
-
-#define AT91SAM9_MASTER_CLOCK	100000000
-#define CLOCK_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
-
-#elif defined(CONFIG_ARCH_AT91SAM9G20)
+#define AT91X40_MASTER_CLOCK	40000000
+#define CLOCK_TICK_RATE		(AT91X40_MASTER_CLOCK)
 
-#if defined(CONFIG_MACH_USB_A9G20)
-#define AT91SAM9_MASTER_CLOCK	133000000
 #else
-#define AT91SAM9_MASTER_CLOCK	132096000
-#endif
-
-#define CLOCK_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
-
-#elif defined(CONFIG_ARCH_AT91SAM9G45)
 
-#define AT91SAM9_MASTER_CLOCK	133333333
-#define CLOCK_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
-
-#elif defined(CONFIG_ARCH_AT91CAP9)
-
-#define AT91CAP9_MASTER_CLOCK	100000000
-#define CLOCK_TICK_RATE		(AT91CAP9_MASTER_CLOCK/16)
-
-#elif defined(CONFIG_ARCH_AT91X40)
-
-#define AT91X40_MASTER_CLOCK	40000000
-#define CLOCK_TICK_RATE		(AT91X40_MASTER_CLOCK)
+#define CLOCK_TICK_RATE		12345678
 
 #endif
 
-#endif
+#endif /* __ASM_ARCH_TIMEX_H */
-- 
1.7.7
