From: slash.tmp@free.fr (Mason)
Date: Mon, 04 May 2015 10:02:40 +0200
Subject: High-resolution timers not supported when using smp_twd on Cortex A9
Message-ID: <554727A0.3040601@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Resending to LAKML, add clocksource description ]

Hello,

I wanted to enable high-resolution timers on this Cortex A9 system,
but it seems there is more to it than just enabling

  CONFIG_HIGH_RES_TIMERS=y

(The system is limited to jiffy resolution.)

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_HZ=300

/proc/timer_list output attached

I'm using the TWD block (private timer and watchdog) for clock events.
Registered with twd_local_timer_register(&tangox_twd);

"4.1 About the private timer and watchdog blocks
The private timer and watchdog blocks have the following features:
- a 32-bit counter that generates an interrupt when it reaches zero
- an eight-bit prescaler value to qualify the clock period
- configurable single-shot or auto-reload modes
- configurable starting values for the counter
- the clock for these blocks is PERIPHCLK."

arch/arm/kernel/smp_twd.c

http://elinux.org/High_Resolution_Timers states

> 2. Check the event_handler for the Tick Device. If the event handlers
> is 'hrtimer_interrupt' then the clock is set up for high resolution
> handling. If the event handler is 'tick_handle_periodic', then the
> device is set up for regular tick-based handling.

And indeed:

Tick Device: mode:     0
Per CPU device: 0
Clock Event Device: local_timer
 max_delta_ns:   8598533124
 min_delta_ns:   1000
 mult:           2145336164
 shift:          32
 mode:           2
 next_event:     9223372036854775807 nsecs
 set_next_event: twd_set_next_event
 set_mode:       twd_set_mode
 event_handler:  tick_handle_periodic
 retries:        0


  clk->name = "local_timer";
  clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP;
  clk->rating = 350;
  clk->set_mode = twd_set_mode;
  clk->set_next_event = twd_set_next_event;
  clk->irq = twd_ppi;
  clk->cpumask = cpumask_of(cpu);

/*
 * x86(64) specific misfeatures:
 *
 * - Clockevent source stops in C3 State and needs broadcast support.
 */
#define CLOCK_EVT_FEAT_C3STOP		0x000008


$ git show 5388a6b2 arch/arm/kernel/smp_twd.c
commit 5388a6b266e9c3357353332ba0cd5549082887f1
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Mon Jul 26 13:19:43 2010 +0100

    ARM: SMP: Always enable clock event broadcast support
    
    The TWD local timers are unable to wake up the CPU when it is placed
    into a low power mode, eg. C3.  Therefore, we need to adapt things
    such that the TWD code can cope with this.
    
    We do this by always providing a broadcast tick function, and marking
    the fact that the TWD local timer will stop in low power modes.  This
    means that when the CPU is placed into a low power mode, the core
    timer code marks this fact, and allows an IPI to be given to the core.
    
    Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
    Cc: Catalin Marinas <catalin.marinas@arm.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 7c5f0c0..35882fb 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -132,7 +132,8 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
        twd_calibrate_rate();
 
        clk->name = "local_timer";
-       clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+       clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
+                       CLOCK_EVT_FEAT_C3STOP;
        clk->rating = 350;
        clk->set_mode = twd_set_mode;
        clk->set_next_event = twd_set_next_event;


(The system's clocksource is a 27 MHz 32-bit counter.)

If I remove the CLOCK_EVT_FEAT_C3STOP flag, then hrtimers are enabled,
but I assume I would then run into problems in low-power mode, going by
Russell's commit message.

Do I have to use a platform-specific clockevent source if I want
high-resolution timers on the system?

Regards.

-------------- next part --------------
Timer List Version: v0.7
HRTIMER_MAX_CLOCK_BASES: 4
now at 12676030854 nsecs

cpu: 0
 clock 0:
  .base:       e7ae51e8
  .index:      0
  .resolution: 3333333 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: sched_clock_timer, sched_clock_poll, S:01
 # expires at 139188754399-139188754399 nsecs [in 126512723545 to 126512723545 nsecs]
 clock 1:
  .base:       e7ae5220
  .index:      1
  .resolution: 3333333 nsecs
  .get_time:   ktime_get_real
  .offset:     0 nsecs
active timers:
 clock 2:
  .base:       e7ae5258
  .index:      2
  .resolution: 3333333 nsecs
  .get_time:   ktime_get_boottime
  .offset:     0 nsecs
active timers:
 clock 3:
  .base:       e7ae5290
  .index:      3
  .resolution: 3333333 nsecs
  .get_time:   ktime_get_clocktai
  .offset:     0 nsecs
active timers:
  .expires_next   : 9223372036854775807 nsecs
  .hres_active    : 0
  .nr_events      : 0
  .nr_retries     : 0
  .nr_hangs       : 0
  .max_hang_time  : 0 nsecs
  .nohz_mode      : 0
  .last_tick      : 0 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 0
  .idle_calls     : 0
  .idle_sleeps    : 0
  .idle_entrytime : 12674854298 nsecs
  .idle_waketime  : 0 nsecs
  .idle_exittime  : 0 nsecs
  .idle_sleeptime : 10273031792 nsecs
  .iowait_sleeptime: 10232749 nsecs
  .last_jiffies   : 0
  .next_jiffies   : 0
  .idle_expires   : 0 nsecs
jiffies: 4294880982

cpu: 1
 clock 0:
  .base:       e7aed1e8
  .index:      0
  .resolution: 3333333 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 clock 1:
  .base:       e7aed220
  .index:      1
  .resolution: 3333333 nsecs
  .get_time:   ktime_get_real
  .offset:     0 nsecs
active timers:
 clock 2:
  .base:       e7aed258
  .index:      2
  .resolution: 3333333 nsecs
  .get_time:   ktime_get_boottime
  .offset:     0 nsecs
active timers:
 clock 3:
  .base:       e7aed290
  .index:      3
  .resolution: 3333333 nsecs
  .get_time:   ktime_get_clocktai
  .offset:     0 nsecs
active timers:
  .expires_next   : 9223372036854775807 nsecs
  .hres_active    : 0
  .nr_events      : 0
  .nr_retries     : 0
  .nr_hangs       : 0
  .max_hang_time  : 0 nsecs
  .nohz_mode      : 0
  .last_tick      : 0 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 0
  .idle_calls     : 0
  .idle_sleeps    : 0
  .idle_entrytime : 12673422372 nsecs
  .idle_waketime  : 0 nsecs
  .idle_exittime  : 0 nsecs
  .idle_sleeptime : 12455789892 nsecs
  .iowait_sleeptime: 15649739 nsecs
  .last_jiffies   : 0
  .next_jiffies   : 0
  .idle_expires   : 0 nsecs
jiffies: 4294880982

Tick Device: mode:     0
Broadcast device
Clock Event Device: <NULL>
tick_broadcast_mask: 00000000
tick_broadcast_oneshot_mask: 00000000

Tick Device: mode:     0
Per CPU device: 0
Clock Event Device: local_timer
 max_delta_ns:   8598533124
 min_delta_ns:   1000
 mult:           2145336164
 shift:          32
 mode:           2
 next_event:     9223372036854775807 nsecs
 set_next_event: twd_set_next_event
 set_mode:       twd_set_mode
 event_handler:  tick_handle_periodic
 retries:        0

Tick Device: mode:     0
Per CPU device: 1
Clock Event Device: local_timer
 max_delta_ns:   8598533124
 min_delta_ns:   1000
 mult:           2145336164
 shift:          32
 mode:           2
 next_event:     9223372036854775807 nsecs
 set_next_event: twd_set_next_event
 set_mode:       twd_set_mode
 event_handler:  tick_handle_periodic
 retries:        0
