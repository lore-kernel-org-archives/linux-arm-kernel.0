From: dsaxena@linaro.org (Deepak Saxena)
Date: Thu, 4 Aug 2011 06:46:16 -0700
Subject: [PATCH 02/12] ARM: at91: Remove LATCH and CLOCK_TICK_RATE dependency
In-Reply-To: <cover.1312455035.git.dsaxena@linaro.org>
References: <cover.1312455035.git.dsaxena@linaro.org>
Message-ID: <20110804134616.GC919@plexity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of work to remove the global CLOCK_TICK_RATE symbol,
this patch defines a sub-arch local value for use by the
at91 code.  Once all LATCH and CLOCK_TICK_RATE references
are removed, we will remove all the definitions across
sub-arches.

Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
---
 arch/arm/mach-at91/at91rm9200_time.c      |    6 +-
 arch/arm/mach-at91/include/mach/at91_st.h |   63 +++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
index 1dd69c8..61a6d0c 100644
--- a/arch/arm/mach-at91/at91rm9200_time.c
+++ b/arch/arm/mach-at91/at91rm9200_time.c
@@ -74,8 +74,8 @@ static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
 	if (sr & AT91_ST_PITS) {
 		u32	crtr = read_CRTR();
 
-		while (((crtr - last_crtr) & AT91_ST_CRTV) >= LATCH) {
-			last_crtr += LATCH;
+		while (((crtr - last_crtr) & AT91_ST_CRTV) >= AT91_TIMER_LATCH) {
+			last_crtr += AT91_TIMER_LATCH;
 			clkevt.event_handler(&clkevt);
 		}
 		return IRQ_HANDLED;
@@ -116,7 +116,7 @@ clkevt32k_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 	case CLOCK_EVT_MODE_PERIODIC:
 		/* PIT for periodic irqs; fixed rate of 1/HZ */
 		irqmask = AT91_ST_PITS;
-		at91_sys_write(AT91_ST_PIMR, LATCH);
+		at91_sys_write(AT91_ST_PIMR, AT91_TIMER_LATCH);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		/* ALM for oneshot irqs, set by next_event()
diff --git a/arch/arm/mach-at91/include/mach/at91_st.h b/arch/arm/mach-at91/include/mach/at91_st.h
index 8847173..7d55a49 100644
--- a/arch/arm/mach-at91/include/mach/at91_st.h
+++ b/arch/arm/mach-at91/include/mach/at91_st.h
@@ -46,4 +46,67 @@
 #define	AT91_ST_CRTR		(AT91_ST + 0x24)	/* Current Real-time Register */
 #define		AT91_ST_CRTV		(0xfffff << 0)		/* Current Real-Time Value */
 
+#if defined(CONFIG_ARCH_AT91RM9200)
+
+#define AT91_TICK_RATE		(AT91_SLOW_CLOCK)
+
+#elif defined(CONFIG_ARCH_AT91SAM9260)
+
+#if defined(CONFIG_MACH_USB_A9260) || defined(CONFIG_MACH_QIL_A9260)
+#define AT91SAM9_MASTER_CLOCK	90000000
+#else
+#define AT91SAM9_MASTER_CLOCK	99300000
+#endif
+
+#define AT91_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
+
+#elif defined(CONFIG_ARCH_AT91SAM9261)
+
+#define AT91SAM9_MASTER_CLOCK	99300000
+#define AT91_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
+
+#elif defined(CONFIG_ARCH_AT91SAM9G10)
+
+#define AT91SAM9_MASTER_CLOCK	133000000
+#define AT91_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
+
+#elif defined(CONFIG_ARCH_AT91SAM9263)
+
+#if defined(CONFIG_MACH_USB_A9263)
+#define AT91SAM9_MASTER_CLOCK	90000000
+#else
+#define AT91SAM9_MASTER_CLOCK	99959500
+#endif
+
+#define AT91_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
+
+#elif defined(CONFIG_ARCH_AT91SAM9RL)
+
+#define AT91SAM9_MASTER_CLOCK	100000000
+#define AT91_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
+
+#elif defined(CONFIG_ARCH_AT91SAM9G20)
+
+#define AT91SAM9_MASTER_CLOCK	132096000
+#define AT91_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
+
+#elif defined(CONFIG_ARCH_AT91SAM9G45)
+
+#define AT91SAM9_MASTER_CLOCK	133333333
+#define AT91_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
+
+#elif defined(CONFIG_ARCH_AT91CAP9)
+
+#define AT91CAP9_MASTER_CLOCK	100000000
+#define AT91_TICK_RATE		(AT91CAP9_MASTER_CLOCK/16)
+
+#elif defined(CONFIG_ARCH_AT91X40)
+
+#define AT91X40_MASTER_CLOCK	40000000
+#define AT91_TICK_RATE		(AT91X40_MASTER_CLOCK)
+
+#endif
+
+#define AT91_TIMER_LATCH  	((AT91_TICK_RATE + HZ/2) / HZ)
+
 #endif
-- 
1.7.4.1
