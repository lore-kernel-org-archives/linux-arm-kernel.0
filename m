From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Sep 2013 17:30:52 +0100
Subject: KVM virtual timer issue with trinity
Message-ID: <20130906163052.GG30450@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

Running trinity as a normal user in a KVM guest on my TC2 (A15s only)
eventually leads to a situation where responsiveness is extremely sluggish.
Further investigation shows that issuing a `sleep 1' command never returns.
This seems to be because the virtual timer has stopped generating interrupts
on CPU0 (CPU1 seems ok).

Dumping the timer state (see below), it looks like CPU0's timer expired in
the past, but we're perhaps not receiving the interrupt. The trinity logs
don't reveal anything obvious (and they're huge, so I can't include them
here).

I can reproduce this in an hour or so, so if you want me to try anything out
in the host, I can give it a go. I'm using 3.11 as both the guest and host.

Cheers,

Will

--->8

[11541.362023] SysRq : Show clockevent devices & pending hrtimers (no others)
[11541.363101] Timer List Version: v0.7
[11541.363708] HRTIMER_MAX_CLOCK_BASES: 4
[11541.364310] now at 5129233591727 nsecs
[11541.364904] 
[11541.365229] cpu: 0
[11541.365693]  clock 0:
[11541.366134]   .base:       c0d4a390
[11541.366787]   .index:      0
[11541.367263]   .resolution: 10000000 nsecs
[11541.367853]   .get_time:   ktime_get
[11541.368619]   .offset:     0 nsecs
[11541.369217] active timers:
[11541.369653]  clock 1:
[11541.370088]   .base:       c0d4a3c8
[11541.370682]   .index:      1
[11541.371161]   .resolution: 10000000 nsecs
[11541.371796]   .get_time:   ktime_get_real
[11541.372554]   .offset:     0 nsecs
[11541.373152] active timers:
[11541.373583]  clock 2:
[11541.374019]   .base:       c0d4a400
[11541.374613]   .index:      2
[11541.374923]   .resolution: 10000000 nsecs
[11541.375231]   .get_time:   ktime_get_boottime
[11541.375717]   .offset:     0 nsecs
[11541.376062] active timers:
[11541.376300]  clock 3:
[11541.376543]   .base:       c0d4a438
[11541.376908]   .index:      3
[11541.377200]   .resolution: 10000000 nsecs
[11541.377536]   .get_time:   ktime_get_clocktai
[11541.378067]   .offset:     0 nsecs
[11541.378384] active timers:
[11541.378627]   .expires_next   : 9223372036854775807 nsecs
[11541.379098]   .hres_active    : 0
[11541.379365]   .nr_events      : 0
[11541.379821]   .nr_retries     : 0
[11541.380123]   .nr_hangs       : 0
[11541.380465]   .max_hang_time  : 0 nsecs
[11541.380761]   .nohz_mode      : 0
[11541.381050]   .last_tick      : 0 nsecs
[11541.381378]   .tick_stopped   : 0
[11541.381774]   .idle_jiffies   : 0
[11541.382074]   .idle_calls     : 0
[11541.382398]   .idle_sleeps    : 0
[11541.382617]   .idle_entrytime : 5129231914602 nsecs
[11541.382903]   .idle_waketime  : 0 nsecs
[11541.383090]   .idle_exittime  : 0 nsecs
[11541.383414]   .idle_sleeptime : 2975892703837 nsecs
[11541.383699]   .iowait_sleeptime: 3517584 nsecs
[11541.383960]   .last_jiffies   : 0
[11541.384190]   .next_jiffies   : 0
[11541.384419]   .idle_expires   : 0 nsecs
[11541.384619] jiffies: 450207
[11541.384786] 
[11541.384959] cpu: 1
[11541.385104]  clock 0:
[11541.385301]   .base:       c0d52390
[11541.385527]   .index:      0
[11541.385737]   .resolution: 10000000 nsecs
[11541.385932]   .get_time:   ktime_get
[11541.386257]   .offset:     0 nsecs
[11541.386493] active timers:
[11541.386680]  clock 1:
[11541.386833]   .base:       c0d523c8
[11541.387023]   .index:      1
[11541.387267]   .resolution: 10000000 nsecs
[11541.387500]   .get_time:   ktime_get_real
[11541.387881]   .offset:     0 nsecs
[11541.388143] active timers:
[11541.388291]  clock 2:
[11541.388436]   .base:       c0d52400
[11541.388670]   .index:      2
[11541.388877]   .resolution: 10000000 nsecs
[11541.389088]   .get_time:   ktime_get_boottime
[11541.389454]   .offset:     0 nsecs
[11541.389667] active timers:
[11541.389861]  clock 3:
[11541.390000]   .base:       c0d52438
[11541.390263]   .index:      3
[11541.390442]   .resolution: 10000000 nsecs
[11541.390693]   .get_time:   ktime_get_clocktai
[11541.391068]   .offset:     0 nsecs
[11541.391291] active timers:
[11541.391441]   .expires_next   : 9223372036854775807 nsecs
[11541.391804]   .hres_active    : 0
[11541.392024]   .nr_events      : 0
[11541.392249]   .nr_retries     : 0
[11541.392409]   .nr_hangs       : 0
[11541.392623]   .max_hang_time  : 0 nsecs
[11541.392787]   .nohz_mode      : 0
[11541.392998]   .last_tick      : 0 nsecs
[11541.393172]   .tick_stopped   : 0
[11541.393390]   .idle_jiffies   : 0
[11541.393570]   .idle_calls     : 0
[11541.393780]   .idle_sleeps    : 0
[11541.393985]   .idle_entrytime : 5129231913018 nsecs
[11541.394253]   .idle_waketime  : 0 nsecs
[11541.394512]   .idle_exittime  : 0 nsecs
[11541.394682]   .idle_sleeptime : 3235159309412 nsecs
[11541.394964]   .iowait_sleeptime: 1765958 nsecs
[11541.395225]   .last_jiffies   : 0
[11541.395443]   .next_jiffies   : 0
[11541.395606]   .idle_expires   : 0 nsecs
[11541.395793] jiffies: 450207
[11541.395940] 
[11541.396087] Tick Device: mode:     0
[11541.396297] Broadcast device
[11541.396485] Clock Event Device: <NULL>
[11541.396746] tick_broadcast_mask: 00000000
[11541.396912] tick_broadcast_oneshot_mask: 00000000
[11541.397233] 
[11541.397360] Tick Device: mode:     0
[11541.397572] Per CPU device: 0
[11541.397739] Clock Event Device: arch_sys_timer
[11541.397985]  max_delta_ns:   89478485381
[11541.398242]  min_delta_ns:   1000
[11541.398416]  mult:           103079215
[11541.398629]  shift:          32
[11541.398789]  mode:           3
[11541.399002]  next_event:     4802080000000 nsecs
[11541.399292]  set_next_event: arch_timer_set_next_event_virt
[11541.399658]  set_mode:       arch_timer_set_mode_virt
[11541.399991]  event_handler:  tick_handle_periodic
[11541.400357]  retries:        0
[11541.400585] 
[11541.400693] Tick Device: mode:     0
[11541.400857] Per CPU device: 1
[11541.401084] Clock Event Device: arch_sys_timer
[11541.401331]  max_delta_ns:   89478485381
[11541.401479]  min_delta_ns:   1000
[11541.401682]  mult:           103079215
[11541.401912]  shift:          32
[11541.402128]  mode:           3
[11541.402324]  next_event:     5352510000000 nsecs
[11541.402615]  set_next_event: arch_timer_set_next_event_virt
[11541.402949]  set_mode:       arch_timer_set_mode_virt
[11541.403228]  event_handler:  tick_handle_periodic
[11541.403564]  retries:        0
[11541.403782] 
