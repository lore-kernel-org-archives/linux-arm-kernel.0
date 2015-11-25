From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Wed, 25 Nov 2015 02:50:34 +0100
Subject: [PATCH] ARM: ep93xx: Fix clocksource registration
Message-ID: <565513EA.6020603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clocksource_mmio_init() explicitly checks for counter's width and refuses to
register anything with resolution higher than 32 bits. We need to use
clocksource_register_hz() directly to repair HIGH_RES_TIMERS.

=== Before ===

$ cat /sys/bus/clocksource/devices/clocksource0/available_clocksource
jiffies

$ cat /proc/timer_list
[...]
cpu: 0
 clock 0:
  .base:       c0388ae0
  .index:      0
  .resolution: 10000000 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
[...]
Tick Device: mode:     0
Per CPU device: 0
Clock Event Device: timer1
 max_delta_ns:   8446860587738
 min_delta_ns:   1967
 mult:           1091929
 shift:          31
 mode:           3
 next_event:     130610000000 nsecs
 set_next_event: ep93xx_clkevt_set_next_event
 shutdown: ep93xx_clkevt_shutdown
 oneshot:  ep93xx_clkevt_shutdown
 resume:   ep93xx_clkevt_shutdown
 event_handler:  tick_handle_periodic
 retries:        0

=== After ===

$ cat /sys/bus/clocksource/devices/clocksource0/available_clocksource
timer4

$ cat /proc/timer_list
[...]
cpu: 0
 clock 0:
  .base:       c0388b40
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
[...]
Tick Device: mode:     1
Per CPU device: 0
Clock Event Device: timer1
 max_delta_ns:   8446860587738
 min_delta_ns:   1967
 mult:           1091929
 shift:          31
 mode:           3
 next_event:     101000000000 nsecs
 set_next_event: ep93xx_clkevt_set_next_event
 shutdown: ep93xx_clkevt_shutdown
 oneshot:  ep93xx_clkevt_shutdown
 resume:   ep93xx_clkevt_shutdown
 event_handler:  hrtimer_interrupt
 retries:        1771

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 arch/arm/Kconfig                    |  1 -
 arch/arm/mach-ep93xx/timer-ep93xx.c | 13 ++++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0365cbb..c655597 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -422,7 +422,6 @@ config ARCH_EP93XX
 	select ARM_VIC
 	select AUTO_ZRELADDR
 	select CLKDEV_LOOKUP
-	select CLKSRC_MMIO
 	select CPU_ARM920T
 	select GENERIC_CLOCKEVENTS
 	help
diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/arch/arm/mach-ep93xx/timer-ep93xx.c
index e5f7911..893992b 100644
--- a/arch/arm/mach-ep93xx/timer-ep93xx.c
+++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
@@ -68,6 +68,14 @@ cycle_t ep93xx_clocksource_read(struct clocksource *c)
 	return (cycle_t) ret;
 }

+static struct clocksource timer4_clocksource = {
+	.name	= "timer4",
+	.rating	= 200,
+	.read	= ep93xx_clocksource_read,
+	.mask	= CLOCKSOURCE_MASK(40),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
 static int ep93xx_clkevt_set_next_event(unsigned long next,
 					struct clock_event_device *evt)
 {
@@ -128,9 +136,8 @@ void __init ep93xx_timer_init(void)
 	/* Enable and register clocksource and sched_clock on timer 4 */
 	writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE,
 	       EP93XX_TIMER4_VALUE_HIGH);
-	clocksource_mmio_init(NULL, "timer4",
-			      EP93XX_TIMER4_RATE, 200, 40,
-			      ep93xx_clocksource_read);
+	if (clocksource_register_hz(&timer4_clocksource, EP93XX_TIMER4_RATE))
+		pr_warn("Failed to register Timer4 as clocksource");
 	sched_clock_register(ep93xx_read_sched_clock, 40,
 			     EP93XX_TIMER4_RATE);
