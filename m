From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 30 Jul 2013 15:34:46 -0700
Subject: Enable arm_global_timer for Zynq brakes boot
In-Reply-To: <51F77D93.4030505@linaro.org>
References: <51E72DCA.9070500@codeaurora.org>
 <f5b76049-7e5b-4dd0-9863-19cfd1d599b9@TX2EHSMHS006.ehs.local>
 <51E7435B.3060605@codeaurora.org>
 <ff4d40be-7177-4a55-ab2f-dff11fa18642@DB9EHSMHS009.ehs.local>
 <51ED8DF2.60600@codeaurora.org> <20130722201348.GI453@xsjandreislx>
 <0735ab8c-0f80-4b64-b2b2-8d4553482c2a@CO9EHSMHS013.ehs.local>
 <51F66565.7010600@linaro.org>
 <8d56935e-2a20-46c7-b80a-f779572dd839@CO1EHSMHS014.ehs.local>
 <51F77D93.4030505@linaro.org>
Message-ID: <829dbb20-0f14-4a3b-8da9-1f7b1b5b8b59@DB8EHSMHS005.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 10:47:15AM +0200, Daniel Lezcano wrote:
> On 07/30/2013 02:03 AM, S?ren Brinkmann wrote:
> > Hi Daniel,
> > 
> > On Mon, Jul 29, 2013 at 02:51:49PM +0200, Daniel Lezcano wrote:
> > (snip)
> >>
> >> the CPUIDLE_FLAG_TIMER_STOP flag tells the cpuidle framework the local
> >> timer will be stopped when entering to the idle state. In this case, the
> >> cpuidle framework will call clockevents_notify(ENTER) and switches to a
> >> broadcast timer and will call clockevents_notify(EXIT) when exiting the
> >> idle state, switching the local timer back in use.
> > 
> > I've been thinking about this, trying to understand how this makes my
> > boot attempts on Zynq hang. IIUC, the wrongly provided TIMER_STOP flag
> > would make the timer core switch to a broadcast device even though it
> > wouldn't be necessary. But shouldn't it still work? It sounds like we do
> > something useless, but nothing wrong in a sense that it should result in
> > breakage. I guess I'm missing something obvious. This timer system will
> > always remain a mystery to me.
> > 
> > Actually this more or less leads to the question: What is this
> > 'broadcast timer'. I guess that is some clockevent device which is
> > common to all cores? (that would be the cadence_ttc for Zynq). Is the
> > hang pointing to some issue with that driver?
> 
> If you look at the /proc/timer_list, which timer is used for broadcasting ?

So, the correct run results (full output attached).

The vanilla kernel uses the twd timers as local timers and the TTC as
broadcast device:
	Tick Device: mode:     1                                                         
	Broadcast device  
	Clock Event Device: ttc_clockevent

When I remove the offending CPUIDLE flag and add the DT fragment to
enable the global timer, the twd timers are still used as local timers
and the broadcast device is the global timer:
	Tick Device: mode:     1                                                         
	Broadcast device                                                                 
	Clock Event Device: arm_global_timer

Again, since boot hangs in the actually broken case, I don't see way to
obtain this information for that case.

	Thanks,
	S?ren

-------------- next part --------------
# cat /proc/timer_list 
Timer List Version: v0.7
HRTIMER_MAX_CLOCK_BASES: 4
now at 55591467929 nsecs

cpu: 0
 clock 0:
  .base:       c148e718
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: <c1490670>, menu_hrtimer_notify, S:01, hrtimer_start, swapper/0/0
 # expires at 55591646361-55591646361 nsecs [in 178432 to 178432 nsecs]
 clock 1:
  .base:       c148e750
  .index:      1
  .resolution: 1 nsecs
  .get_time:   ktime_get_real
  .offset:     0 nsecs
active timers:
 clock 2:
  .base:       c148e788
  .index:      2
  .resolution: 1 nsecs
  .get_time:   ktime_get_boottime
  .offset:     0 nsecs
active timers:
 clock 3:
  .base:       c148e7c0
  .index:      3
  .resolution: 1 nsecs
  .get_time:   ktime_get_clocktai
  .offset:     0 nsecs
active timers:
  .expires_next   : 55591705658 nsecs
  .hres_active    : 1
  .nr_events      : 917
  .nr_retries     : 34
  .nr_hangs       : 0
  .max_hang_time  : 0 nsecs
  .nohz_mode      : 2
  .last_tick      : 55590000000 nsecs
  .tick_stopped   : 1
  .idle_jiffies   : 4294942854
  .idle_calls     : 1977
  .idle_sleeps    : 250
  .idle_entrytime : 55591578522 nsecs
  .idle_waketime  : 55591578522 nsecs
  .idle_exittime  : 55582307145 nsecs
  .idle_sleeptime : 52623799592 nsecs
  .iowait_sleeptime: 0 nsecs
  .last_jiffies   : 4294942855
  .next_jiffies   : 4294949450
  .idle_expires   : 121540000000 nsecs
jiffies: 4294942855

cpu: 1
 clock 0:
  .base:       c1497718
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: <c1497ac8>, tick_sched_timer, S:01, hrtimer_start_range_ns, swapper/1/0
 # expires at 55600000000-55600000000 nsecs [in 8532071 to 8532071 nsecs]
 #1: <ed851c80>, timerfd_tmrproc, S:01, hrtimer_start, systemd/1
 # expires at 102214419661-102214419661 nsecs [in 46622951732 to 46622951732 nsecs]
 #2: <ed92fc80>, timerfd_tmrproc, S:01, hrtimer_start, systemd/1
 # expires at 900000055748-900000055748 nsecs [in 844408587819 to 844408587819 nsecs]
 clock 1:
  .base:       c1497750
  .index:      1
  .resolution: 1 nsecs
  .get_time:   ktime_get_real
  .offset:     0 nsecs
active timers:
 clock 2:
  .base:       c1497788
  .index:      2
  .resolution: 1 nsecs
  .get_time:   ktime_get_boottime
  .offset:     0 nsecs
active timers:
 clock 3:
  .base:       c14977c0
  .index:      3
  .resolution: 1 nsecs
  .get_time:   ktime_get_clocktai
  .offset:     0 nsecs
active timers:
  .expires_next   : 55600000000 nsecs
  .hres_active    : 1
  .nr_events      : 921
  .nr_retries     : 20
  .nr_hangs       : 0
  .max_hang_time  : 0 nsecs
  .nohz_mode      : 2
  .last_tick      : 55590000000 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 4294942854
  .idle_calls     : 1482
  .idle_sleeps    : 234
  .idle_entrytime : 55584131929 nsecs
  .idle_waketime  : 55584058200 nsecs
  .idle_exittime  : 55584131929 nsecs
  .idle_sleeptime : 53182424229 nsecs
  .iowait_sleeptime: 0 nsecs
  .last_jiffies   : 4294942854
  .next_jiffies   : 4294949632
  .idle_expires   : 56520692335 nsecs
jiffies: 4294942855

Tick Device: mode:     1
Broadcast device
Clock Event Device: ttc_clockevent
 max_delta_ns:   1207932479
 min_delta_ns:   18432
 mult:           233015
 shift:          32
 mode:           3
 next_event:     9223372036854775807 nsecs
 set_next_event: ttc_set_next_event
 set_mode:       ttc_set_mode
 event_handler:  tick_handle_oneshot_broadcast
 retries:        5

tick_broadcast_mask: 00000003
tick_broadcast_oneshot_mask: 00000000

Tick Device: mode:     1
Per CPU device: 0
Clock Event Device: local_timer
 max_delta_ns:   12884902005
 min_delta_ns:   1000
 mult:           715827876
 shift:          31
 mode:           3
 next_event:     55592004140 nsecs
 set_next_event: twd_set_next_event
 set_mode:       twd_set_mode
 event_handler:  hrtimer_interrupt
 retries:        0

Tick Device: mode:     1
Per CPU device: 1
Clock Event Device: local_timer
 max_delta_ns:   12884902005
 min_delta_ns:   1000
 mult:           715827876
 shift:          31
 mode:           3
 next_event:     55600000000 nsecs
 set_next_event: twd_set_next_event
 set_mode:       twd_set_mode
 event_handler:  hrtimer_interrupt
 retries:        0

#

-------------- next part --------------
# cat /proc/timer_list 
Timer List Version: v0.7
HRTIMER_MAX_CLOCK_BASES: 4
now at 246603578154 nsecs

cpu: 0
 clock 0:
  .base:       c148e718
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: <c1490670>, menu_hrtimer_notify, S:01, hrtimer_start, swapper/0/0
 # expires at 246603698006-246603698006 nsecs [in 120539 to 120539 nsecs]
 #1: <c148eac8>, tick_sched_timer, S:01, hrtimer_start, swapper/0/0
 # expires at 252080000000-252080000000 nsecs [in 5476422533 to 5476422533 nsecs]
 #2: <ed9faa80>, timerfd_tmrproc, S:01, hrtimer_start, systemd/1
 # expires at 900000053569-900000053569 nsecs [in 653396476102 to 653396476102 nsecs]
 clock 1:
  .base:       c148e750
  .index:      1
  .resolution: 1 nsecs
  .get_time:   ktime_get_real
  .offset:     0 nsecs
active timers:
 clock 2:
  .base:       c148e788
  .index:      2
  .resolution: 1 nsecs
  .get_time:   ktime_get_boottime
  .offset:     0 nsecs
active timers:
 clock 3:
  .base:       c148e7c0
  .index:      3
  .resolution: 1 nsecs
  .get_time:   ktime_get_clocktai
  .offset:     0 nsecs
active timers:
  .expires_next   : 246603871523 nsecs
  .hres_active    : 1
  .nr_events      : 935
  .nr_retries     : 0
  .nr_hangs       : 0
  .max_hang_time  : 0 nsecs
  .nohz_mode      : 2
  .last_tick      : 246600000000 nsecs
  .tick_stopped   : 1
  .idle_jiffies   : 4294961955
  .idle_calls     : 1974
  .idle_sleeps    : 259
  .idle_entrytime : 246603709947 nsecs
  .idle_waketime  : 246603700671 nsecs
  .idle_exittime  : 246594690344 nsecs
  .idle_sleeptime : 243604071460 nsecs
  .iowait_sleeptime: 0 nsecs
  .last_jiffies   : 4294961956
  .next_jiffies   : 4294962504
  .idle_expires   : 252080000000 nsecs
jiffies: 4294961956

cpu: 1
 clock 0:
  .base:       c1497718
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: <c1497ac8>, tick_sched_timer, S:01, hrtimer_start_range_ns, swapper/1/0
 # expires at 246610000000-246610000000 nsecs [in 6422533 to 6422533 nsecs]
 clock 1:
  .base:       c1497750
  .index:      1
  .resolution: 1 nsecs
  .get_time:   ktime_get_real
  .offset:     0 nsecs
active timers:
 clock 2:
  .base:       c1497788
  .index:      2
  .resolution: 1 nsecs
  .get_time:   ktime_get_boottime
  .offset:     0 nsecs
active timers:
 clock 3:
  .base:       c14977c0
  .index:      3
  .resolution: 1 nsecs
  .get_time:   ktime_get_clocktai
  .offset:     0 nsecs
active timers:
  .expires_next   : 246610000000 nsecs
  .hres_active    : 1
  .nr_events      : 882
  .nr_retries     : 0
  .nr_hangs       : 0
  .max_hang_time  : 0 nsecs
  .nohz_mode      : 2
  .last_tick      : 245680000000 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 4294961863
  .idle_calls     : 1405
  .idle_sleeps    : 272
  .idle_entrytime : 246596515784 nsecs
  .idle_waketime  : 244320007598 nsecs
  .idle_exittime  : 246593639546 nsecs
  .idle_sleeptime : 243941063708 nsecs
  .iowait_sleeptime: 0 nsecs
  .last_jiffies   : 4294961955
  .next_jiffies   : 4294961956
  .idle_expires   : 361550000000 nsecs
jiffies: 4294961956

Tick Device: mode:     1
Broadcast device
Clock Event Device: arm_global_timer
 max_delta_ns:   12884902005
 min_delta_ns:   1000
 mult:           715827876
 shift:          31
 mode:           1
 next_event:     9223372036854775807 nsecs
 set_next_event: gt_clockevent_set_next_event
 set_mode:       gt_clockevent_set_mode
 event_handler:  tick_handle_oneshot_broadcast
 retries:        0

tick_broadcast_mask: 00000000
tick_broadcast_oneshot_mask: 00000000

Tick Device: mode:     1
Per CPU device: 0
Clock Event Device: local_timer
 max_delta_ns:   12884902005
 min_delta_ns:   1000
 mult:           715827876
 shift:          31
 mode:           3
 next_event:     246604040852 nsecs
 set_next_event: twd_set_next_event
 set_mode:       twd_set_mode
 event_handler:  hrtimer_interrupt
 retries:        0

Tick Device: mode:     1
Per CPU device: 1
Clock Event Device: local_timer
 max_delta_ns:   12884902005
 min_delta_ns:   1000
 mult:           715827876
 shift:          31
 mode:           3
 next_event:     246610000000 nsecs
 set_next_event: twd_set_next_event
 set_mode:       twd_set_mode
 event_handler:  hrtimer_interrupt
 retries:        0

## 
