From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 12 Nov 2013 22:41:04 +0100
Subject: [PATCH 2/4] ARM: netx: stop using mach/timex.h
In-Reply-To: <1384292466-31725-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1384292466-31725-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1384292466-31725-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach/timex.h is the last remaining header that is unused for multiarch
builds but necessary for singlearch builds. To allow to get rid of it
for singlearch builds, too, drop its usage in netx arch code by
substituting CLOCK_TICK_RATE by a local cpp symbol.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-netx/time.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-netx/time.c b/arch/arm/mach-netx/time.c
index 6df42e6..0e29902 100644
--- a/arch/arm/mach-netx/time.c
+++ b/arch/arm/mach-netx/time.c
@@ -28,6 +28,8 @@
 #include <asm/mach/time.h>
 #include <mach/netx-regs.h>
 
+#define NETX_CLOCK_FREQ 100000000
+
 #define TIMER_CLOCKEVENT 0
 #define TIMER_CLOCKSOURCE 1
 
@@ -137,11 +139,11 @@ void __init netx_timer_init(void)
 			NETX_GPIO_COUNTER_CTRL(TIMER_CLOCKSOURCE));
 
 	clocksource_mmio_init(NETX_GPIO_COUNTER_CURRENT(TIMER_CLOCKSOURCE),
-		"netx_timer", CLOCK_TICK_RATE, 200, 32, clocksource_mmio_readl_up);
+		"netx_timer", NETX_CLOCK_FREQ, 200, 32, clocksource_mmio_readl_up);
 
 	/* with max_delta_ns >= delta2ns(0x800) the system currently runs fine.
 	 * Adding some safety ... */
 	netx_clockevent.cpumask = cpumask_of(0);
-	clockevents_config_and_register(&netx_clockevent, CLOCK_TICK_RATE,
+	clockevents_config_and_register(&netx_clockevent, NETX_CLOCK_FREQ,
 					0xa00, 0xfffffffe);
 }
-- 
1.8.4.2
