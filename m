From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 30 Jul 2013 15:14:43 -0700
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
Message-ID: <b8d1f8ab-e9b2-4f16-9935-4af249bd5375@CH1EHSMHS041.ehs.local>
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

In case of a vanilla kernel and with my patches for enabling the global
timer (I removed the wrongly set flag from the C2 state + adding the DT
fragment to use the GT), this is what I see (full output from timer_list
attached):
	Tick Device: mode:     1
	Broadcast device
	Clock Event Device: xttcps_clockevent

And the local timer seems to be the arm twd timer (also in both cases).

I don't think I can gather this information for the actual broken case,
but AFAIK, there shouldn't be any other timer be capable of this for
Zynq.

	S?ren

-------------- next part --------------
Timer List Version: v0.7
HRTIMER_MAX_CLOCK_BASES: 3
now at 76779317814 nsecs

cpu: 0
 clock 0:
  .base:       c14a0c90
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: <c14a2b50>, menu_hrtimer_notify, S:01, hrtimer_start, swapper/0/0
 # expires at 76779328789-76779328789 nsecs [in 10975 to 10975 nsecs]
 #1: <c14a0dd8>, tick_sched_timer, S:01, hrtimer_start, swapper/0/0
 # expires at 76800000000-76800000000 nsecs [in 20682186 to 20682186 nsecs]
 #2: <ed956e40>, timerfd_tmrproc, S:01, hrtimer_start, systemd/1
 # expires at 93249172026-93249172026 nsecs [in 16469854212 to 16469854212 nsecs]
 #3: <ed956c00>, timerfd_tmrproc, S:01, hrtimer_start, systemd/1
 # expires at 900000055806-900000055806 nsecs [in 823220737992 to 823220737992 nsecs]
 clock 1:
  .base:       c14a0cc8
  .index:      1
  .resolution: 1 nsecs
  .get_time:   ktime_get_real
  .offset:     975789465870609368 nsecs
active timers:
 clock 2:
  .base:       c14a0d00
  .index:      2
  .resolution: 1 nsecs
  .get_time:   ktime_get_boottime
  .offset:     0 nsecs
active timers:
  .expires_next   : 76779492678 nsecs
  .hres_active    : 1
  .nr_events      : 2449
  .nr_retries     : 66
  .nr_hangs       : 0
  .max_hang_time  : 0 nsecs
  .nohz_mode      : 2
  .last_tick      : 76780000000 nsecs
  .tick_stopped   : 1
  .idle_jiffies   : 4294944973
  .idle_calls     : 3114
  .idle_sleeps    : 981
  .idle_entrytime : 76779354678 nsecs
  .idle_waketime  : 76779336246 nsecs
  .idle_exittime  : 76769862116 nsecs
  .idle_sleeptime : 70735903990 nsecs
  .iowait_sleeptime: 18432 nsecs
  .last_jiffies   : 4294944973
  .next_jiffies   : 4294944976
  .idle_expires   : 76800000000 nsecs
jiffies: 4294944973

cpu: 1
 clock 0:
  .base:       c14a9c90
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: <c14a9dd8>, tick_sched_timer, S:01, hrtimer_start_range_ns, swapper/1/0
 # expires at 76780000000-76780000000 nsecs [in 682186 to 682186 nsecs]
 clock 1:
  .base:       c14a9cc8
  .index:      1
  .resolution: 1 nsecs
  .get_time:   ktime_get_real
  .offset:     975789465870609368 nsecs
active timers:
 clock 2:
  .base:       c14a9d00
  .index:      2
  .resolution: 1 nsecs
  .get_time:   ktime_get_boottime
  .offset:     0 nsecs
active timers:
  .expires_next   : 76780000000 nsecs
  .hres_active    : 1
  .nr_events      : 2257
  .nr_retries     : 61
  .nr_hangs       : 0
  .max_hang_time  : 0 nsecs
  .nohz_mode      : 2
  .last_tick      : 76700000000 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 4294944965
  .idle_calls     : 2998
  .idle_sleeps    : 444
  .idle_entrytime : 76771944950 nsecs
  .idle_waketime  : 76768498136 nsecs
  .idle_exittime  : 76768498136 nsecs
  .idle_sleeptime : 72124544054 nsecs
  .iowait_sleeptime: 4276262 nsecs
  .last_jiffies   : 4294944973
  .next_jiffies   : 4294944974
  .idle_expires   : 78880000000 nsecs
jiffies: 4294944973


Tick Device: mode:     1
Broadcast device
Clock Event Device: xttcps_clockevent
 max_delta_ns:   1207932479
 min_delta_ns:   18432
 mult:           233015
 shift:          32
 mode:           1
 next_event:     9223372036854775807 nsecs
 set_next_event: xttcps_set_next_event
 set_mode:       xttcps_set_mode
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
 next_event:     76800000000 nsecs
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
 next_event:     76780000000 nsecs
 set_next_event: twd_set_next_event
 set_mode:       twd_set_mode
 event_handler:  hrtimer_interrupt
 retries:        0
