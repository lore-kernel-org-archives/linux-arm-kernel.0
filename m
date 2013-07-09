From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 09 Jul 2013 10:52:34 -0600
Subject: CPU hotplug issue w/ 0647065 clocksource: Add generic dummy timer
 driver
In-Reply-To: <20130709163518.GD830@codeaurora.org>
References: <51DAF895.1020700@wwwdotorg.org>
 <20130709005837.GC830@codeaurora.org> <51DC34AD.30009@wwwdotorg.org>
 <20130709163518.GD830@codeaurora.org>
Message-ID: <51DC3FD2.9070308@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2013 10:35 AM, Stephen Boyd wrote:
> On 07/09, Stephen Warren wrote:
>> On 07/08/2013 06:58 PM, Stephen Boyd wrote:
>>> On 07/08, Stephen Warren wrote:
>>>> CPU hotplug (replug) on Tegra HW seems to be occasionally broken due to
>>>> commit 0647065 "clocksource: Add generic dummy timer driver" in
>>>> linux-next. Reverting that commit solves the issue.
>>>
>>> We found some breakage during boot that has been fixed by two
>>> commits in linus' tree already. Do you know if you have these two
>>> patches
>>>
>>> 1f73a9806bdd07a5106409bbcab3884078bd34fe
>>> 07bd1172902e782f288e4d44b1fde7dec0f08b6f
>>
>> I didn't before since I was using next-20130705, but I just tried
>> next-20130709 which does have those two commits, and I still see the issue.
>>
> 
> Ok can you get the output of /proc/timer_list and send it back

Sure, it's below. I took another snapshot after unplugging then
re-plugging CPU1, and there was no difference except in the actual time
values and list of queued events (at ~line 12). The set of timers,
modes, etc. were all the same.

> Timer List Version: v0.7
> HRTIMER_MAX_CLOCK_BASES: 4
> now at 75889089000 nsecs
> 
> cpu: 0
>  clock 0:
>   .base:       c0c376a0
>   .index:      0
>   .resolution: 1 nsecs
>   .get_time:   ktime_get
>   .offset:     0 nsecs
> active timers:
>  #0: <c0c384c0>, menu_hrtimer_notify, S:01, hrtimer_start, swapper/0/0
>  # expires at 75889183000-75889183000 nsecs [in 94000 to 94000 nsecs]
>  #1: <c0c379a8>, tick_sched_timer, S:01, hrtimer_start_range_ns, swapper/0/0
>  # expires at 75890000000-75890000000 nsecs [in 911000 to 911000 nsecs]
>  #2: <def3a550>, ehci_hrtimer_func, S:01, hrtimer_start_range_ns, swapper/0/0
>  # expires at 75921594000-75922594000 nsecs [in 32505000 to 33505000 nsecs]
>  #3: <def3ad50>, ehci_hrtimer_func, S:01, hrtimer_start_range_ns, setfont/436
>  # expires at 75921599000-75922599000 nsecs [in 32510000 to 33510000 nsecs]
>  #4: <defd3990>, it_real_fn, S:01, hrtimer_start, syslogd/590
>  # expires at 102888764000-102888764000 nsecs [in 26999675000 to 26999675000 nsecs]
>  #5: <defd3990>, it_real_fn, S:01, hrtimer_start, syslogd/590
>  # expires at 102888764000-102888764000 nsecs [in 26999675000 to 26999675000 nsecs]
>  #6: <df7c1b30>, hrtimer_wakeup, S:01, hrtimer_start_range_ns, avahi-daemon/352
>  # expires at 117911912000-117961554999 nsecs [in 42022823000 to 42072465999 nsecs]
>  #7: <dd857a90>, hrtimer_wakeup, S:01, hrtimer_start_range_ns, dhclient/690
>  # expires at 267143504000-267243504000 nsecs [in 191254415000 to 191354415000 nsecs]
>  #8: <de8eff28>, hrtimer_wakeup, S:01, hrtimer_start_range_ns, atd/557
>  # expires at 3611972607000-3611972657000 nsecs [in 3536083518000 to 3536083568000 nsecs]
>  clock 1:
>   .base:       c0c376d8
>   .index:      1
>   .resolution: 1 nsecs
>   .get_time:   ktime_get_real
>   .offset:     24375428000 nsecs
> active timers:
>  clock 2:
>   .base:       c0c37710
>   .index:      2
>   .resolution: 1 nsecs
>   .get_time:   ktime_get_boottime
>   .offset:     0 nsecs
> active timers:
>  clock 3:
>   .base:       c0c37748
>   .index:      3
>   .resolution: 1 nsecs
>   .get_time:   ktime_get_clocktai
>   .offset:     24375428000 nsecs
> active timers:
>   .expires_next   : 75889329000 nsecs
>   .hres_active    : 1
>   .nr_events      : 4712
>   .nr_retries     : 2
>   .nr_hangs       : 0
>   .max_hang_time  : 0 nsecs
>   .nohz_mode      : 2
>   .last_tick      : 75740000000 nsecs
>   .tick_stopped   : 0
>   .idle_jiffies   : 4294944869
>   .idle_calls     : 13615
>   .idle_sleeps    : 5374
>   .idle_entrytime : 75889188000 nsecs
>   .idle_waketime  : 75881026000 nsecs
>   .idle_exittime  : 75881243000 nsecs
>   .idle_sleeptime : 61747543000 nsecs
>   .iowait_sleeptime: 7327300000 nsecs
>   .last_jiffies   : 4294944884
>   .next_jiffies   : 4294944885
>   .idle_expires   : 75930000000 nsecs
> jiffies: 4294944884
> 
> cpu: 1
>  clock 0:
>   .base:       c0c3f6a0
>   .index:      0
>   .resolution: 1 nsecs
>   .get_time:   ktime_get
>   .offset:     0 nsecs
> active timers:
>  #0: <c0c3f9a8>, tick_sched_timer, S:01, hrtimer_start_range_ns, swapper/1/0
>  # expires at 75900000000-75900000000 nsecs [in 10911000 to 10911000 nsecs]
>  #1: <de835b30>, hrtimer_wakeup, S:01, hrtimer_start_range_ns, console-kit-dae/734
>  # expires at 79000444000-79026433999 nsecs [in 3111355000 to 3137344999 nsecs]
>  #2: <de833b30>, hrtimer_wakeup, S:01, hrtimer_start_range_ns, rpcbind/487
>  # expires at 101235760000-101265759998 nsecs [in 25346671000 to 25376670998 nsecs]
>  #3: <debdff28>, hrtimer_wakeup, S:01, hrtimer_start_range_ns, rwhod/668
>  # expires at 193712567000-193712617000 nsecs [in 117823478000 to 117823528000 nsecs]
>  #4: <de9abb30>, hrtimer_wakeup, S:01, hrtimer_start_range_ns, NetworkManager/543
>  # expires at 313000895000-313100895000 nsecs [in 237111806000 to 237211806000 nsecs]
>  clock 1:
>   .base:       c0c3f6d8
>   .index:      1
>   .resolution: 1 nsecs
>   .get_time:   ktime_get_real
>   .offset:     24375428000 nsecs
> active timers:
>  clock 2:
>   .base:       c0c3f710
>   .index:      2
>   .resolution: 1 nsecs
>   .get_time:   ktime_get_boottime
>   .offset:     0 nsecs
> active timers:
>  clock 3:
>   .base:       c0c3f748
>   .index:      3
>   .resolution: 1 nsecs
>   .get_time:   ktime_get_clocktai
>   .offset:     24375428000 nsecs
> active timers:
>   .expires_next   : 75900000000 nsecs
>   .hres_active    : 1
>   .nr_events      : 4578
>   .nr_retries     : 1
>   .nr_hangs       : 0
>   .max_hang_time  : 0 nsecs
>   .nohz_mode      : 2
>   .last_tick      : 75890000000 nsecs
>   .tick_stopped   : 0
>   .idle_jiffies   : 4294944884
>   .idle_calls     : 6538
>   .idle_sleeps    : 1104
>   .idle_entrytime : 75891066000 nsecs
>   .idle_waketime  : 75821610000 nsecs
>   .idle_exittime  : 75887089000 nsecs
>   .idle_sleeptime : 67621307000 nsecs
>   .iowait_sleeptime: 4203885000 nsecs
>   .last_jiffies   : 4294944885
>   .next_jiffies   : 4294944886
>   .idle_expires   : 120710000000 nsecs
> jiffies: 4294944885
> 
> Tick Device: mode:     1
> Broadcast device
> Clock Event Device: timer0
>  max_delta_ns:   536870948000
>  min_delta_ns:   1000
>  mult:           4294967
>  shift:          32
>  mode:           3
>  next_event:     75922594000 nsecs
>  set_next_event: tegra_timer_set_next_event
>  set_mode:       tegra_timer_set_mode
>  event_handler:  tick_handle_oneshot_broadcast
>  retries:        0
> 
> tick_broadcast_mask: 00000000
> tick_broadcast_oneshot_mask: 00000000
> 
> Tick Device: mode:     1
> Per CPU device: 0
> Clock Event Device: local_timer
>  max_delta_ns:   17179869180
>  min_delta_ns:   1000
>  mult:           536870912
>  shift:          31
>  mode:           3
>  next_event:     75900000000 nsecs
>  set_next_event: twd_set_next_event
>  set_mode:       twd_set_mode
>  event_handler:  hrtimer_interrupt
>  retries:        0
> 
> Tick Device: mode:     1
> Per CPU device: 1
> Clock Event Device: local_timer
>  max_delta_ns:   17179869180
>  min_delta_ns:   1000
>  mult:           536870912
>  shift:          31
>  mode:           3
>  next_event:     75900000000 nsecs
>  set_next_event: twd_set_next_event
>  set_mode:       twd_set_mode
>  event_handler:  hrtimer_interrupt
>  retries:        0
