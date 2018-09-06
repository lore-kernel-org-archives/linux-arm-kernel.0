From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 6 Sep 2018 22:02:02 +0200
Subject: Timer on i.MX28 moving backwards
Message-ID: <20180906200202.et4whmzq22n4uajt@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

on an i.MX28 based machine running Linux 4.9.y-rt I added the following
patch:

diff --git a/drivers/clocksource/mmio.c b/drivers/clocksource/mmio.c
index c4f7d7a9b689..557e555e95b7 100644
--- a/drivers/clocksource/mmio.c
+++ b/drivers/clocksource/mmio.c
@@ -25,6 +25,13 @@ cycle_t clocksource_mmio_readl_up(struct clocksource *c)
 	return (cycle_t)readl_relaxed(to_mmio_clksrc(c)->reg);
 }
 
+cycle_t mxs_clocksource_mmio_readl_down(struct clocksource *c)
+{
+	cycle_t ret = ~(cycle_t)readl_relaxed(to_mmio_clksrc(c)->reg) & c->mask;
+	trace_printk("time = %llx\n", ret);
+	return ret;
+}
+
 cycle_t clocksource_mmio_readl_down(struct clocksource *c)
 {
 	return ~(cycle_t)readl_relaxed(to_mmio_clksrc(c)->reg) & c->mask;
diff --git a/drivers/clocksource/mxs_timer.c b/drivers/clocksource/mxs_timer.c
index 0ba0a913b41d..d78edf9345b2 100644
--- a/drivers/clocksource/mxs_timer.c
+++ b/drivers/clocksource/mxs_timer.c
@@ -217,7 +217,7 @@ static int __init mxs_clocksource_init(struct clk *timer_clk)
 		clocksource_register_hz(&clocksource_mxs, c);
 	else {
 		clocksource_mmio_init(mxs_timrot_base + HW_TIMROT_RUNNING_COUNTn(1),
-			"mxs_timer", c, 200, 32, clocksource_mmio_readl_down);
+			"mxs_timer", c, 200, 32, mxs_clocksource_mmio_readl_down);
 		sched_clock_register(mxs_read_sched_clock_v2, 32, c);
 	}
 
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 08398182f56e..dead82c9b19c 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -234,6 +234,7 @@ static inline void __clocksource_update_freq_khz(struct clocksource *cs, u32 khz
 extern int timekeeping_notify(struct clocksource *clock);
 
 extern cycle_t clocksource_mmio_readl_up(struct clocksource *);
+extern cycle_t mxs_clocksource_mmio_readl_down(struct clocksource *);
 extern cycle_t clocksource_mmio_readl_down(struct clocksource *);
 extern cycle_t clocksource_mmio_readw_up(struct clocksource *);
 extern cycle_t clocksource_mmio_readw_down(struct clocksource *);


And with this I got the following trace:

	$ grep mxs_clocksource_mmio_readl_down trace
	...
          <idle>-0     [000] d...1..  1647.391949: mxs_clocksource_mmio_readl_down: time = 349cfe51
          <idle>-0     [000] d...1..  1647.397639: mxs_clocksource_mmio_readl_down: time = 349f1436
          <idle>-0     [000] d..h2..  1647.397672: mxs_clocksource_mmio_readl_down: time = 349f1731
          <idle>-0     [000] dn.h1..  1647.397705: mxs_clocksource_mmio_readl_down: time = 349f1a2b
        profinet-250   [000] .......  1647.397821: mxs_clocksource_mmio_readl_down: time = 349f24e8
          <idle>-0     [000] d...1..  1647.398181: mxs_clocksource_mmio_readl_down: time = 349f466f
          <idle>-0     [000] d...1..  1647.399452: mxs_clocksource_mmio_readl_down: time = 349fbe0e
          <idle>-0     [000] d..h2..  1647.399488: mxs_clocksource_mmio_readl_down: time = 349fc16e
          <idle>-0     [000] dn.h1..  1647.399524: mxs_clocksource_mmio_readl_down: time = 349fc4b8
       mrp62439d-221   [000] .......  1647.400062: mxs_clocksource_mmio_readl_down: time = 349ff658
       mrp62439d-221   [000] .......  1647.400858: mxs_clocksource_mmio_readl_down: time = 34a04125
       mrp62439d-221   [000] d..h1..  1647.401013: mxs_clocksource_mmio_readl_down: time = 34a04f0f
       mrp62439d-221   [000] d..h...  1647.401059: mxs_clocksource_mmio_readl_down: time = 34a05484
       mrp62439d-221   [000] d..h3..  1647.401263: mxs_clocksource_mmio_readl_down: time = 34a06981
       mrp62439d-221   [000] d..h3..  1647.401263: mxs_clocksource_mmio_readl_down: time = 34a06ac3
       mrp62439d-221   [000] d..h3..  1647.401263: mxs_clocksource_mmio_readl_down: time = 34a06c39
       mrp62439d-221   [000] .......  1647.401263: mxs_clocksource_mmio_readl_down: time = 34a064ca

The interesting fact here is, that the values returned by
mxs_clocksource_mmio_readl_down are not completely monotonic: The last
value is smaller than the previous value.

Given that the jump backwards is that small, I think we can rule out an
overflow. (The input clk for the mx28 timer runs with 24 MHz, so one
complete turnaround takes 0x100000000 / 24000000 Hz = 178.95697 s.)

And this happens often:

	$ awk '/mxs_clocksource_mmio_readl_down/ { gsub(".*time = ", "0x"); time = strtonum($0); if (time - prev < 0) { printf "%x: %d\n", time, time - prev; } prev = time }' trace | wc -l
	106

(There is one false positive where the counter overflows, the trace
covers a time span of ~48 s. The 5 biggest backwards jumps are:
-183784, -79486, -38294, -6552, -5471; minimum: -1332)

Checking the Errata for i.MX28 there isn't anything documented affecting
TIMROT. Reading the Reference Manual I didn't find anything that would
explain a jump in the counter register.

I didn't try yet to reproduce this on another machine or with a newer
non-rt kernel, but I'd expect the same to happen there.

Does this ring a bell for someone? Does someone see an explanation that
doesn't include a hardware fault?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
