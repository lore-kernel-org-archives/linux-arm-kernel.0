From: juri.lelli@arm.com (Juri Lelli)
Date: Tue, 24 Nov 2015 16:27:50 +0000
Subject: suspicious RCU usage on 4.4-rc2 ARM platform
Message-ID: <20151124162750.GE20439@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

I'm hitting these splats while running simple hotplug tests on an ARM
TC2 platform. The following seems to cure it, but I don't think it never
made it to mainline:

 https://lkml.org/lkml/2015/5/12/892 
 
Any reason why?

Thanks,

- Juri

root at genericarmv7a:~# [  283.868236] CPU0 attaching NULL sched-domain.
[  283.882257] CPU1 attaching NULL sched-domain.
[  283.895367] CPU2 attaching NULL sched-domain.
[  283.908464] CPU3 attaching NULL sched-domain.
[  283.921571] CPU4 attaching NULL sched-domain.
[  283.935655] CPU0 attaching sched-domain:
[  283.947419]  domain 0: span 0,3-4 level MC
[  283.959718]   groups: 0 3 4
[  283.968142]   domain 1: span 0,2-4 level DIE
[  283.980960]    groups: 0,3-4 (cpu_capacity = 3072) 2
[  283.996070] CPU2 attaching sched-domain:
[  284.007833]  domain 0: span 0,2-4 level DIE
[  284.020669]   groups: 2 0,3-4 (cpu_capacity = 3072)
[  284.035526] CPU3 attaching sched-domain:
[  284.047286]  domain 0: span 0,3-4 level MC
[  284.059577]   groups: 3 4 0
[  284.068046]   domain 1: span 0,2-4 level DIE
[  284.080873]    groups: 0,3-4 (cpu_capacity = 3072) 2
[  284.096048] CPU4 attaching sched-domain:
[  284.107814]  domain 0: span 0,3-4 level MC
[  284.120378]   groups: 4 0 3
[  284.128832]   domain 1: span 0,2-4 level DIE
[  284.141654]    groups: 0,3-4 (cpu_capacity = 3072) 2
[  284.204863]
[  284.204868] ===============================
[  284.204871] [ INFO: suspicious RCU usage. ]
[  284.204878] 4.4.0-rc2+ #278 Not tainted
[  284.204882] -------------------------------
[  284.204888] /media/hdd1tb/work/integration/kernel/include/trace/events/sched.h:89 suspicious rcu_dereference_check() usage!
[  284.204891]
[  284.204891] other info that might help us debug this:
[  284.204891]
[  284.204896]
[  284.204896] RCU used illegally from offline CPU!
[  284.204896] rcu_scheduler_active = 1, debug_locks = 1
[  284.204901] 2 locks held by swapper/1/0:
[  284.204928]  #0:  ((cpu_died).wait.lock){......}, at: [<c0053f97>] complete+0x13/0x30
[  284.204951]  #1:  (&p->pi_lock){-.-.-.}, at: [<c003fe27>] try_to_wake_up+0x23/0x390
[  284.204955]
[  284.204955] stack backtrace:
[  284.204962] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.4.0-rc2+ #278
[  284.204966] Hardware name: ARM-Versatile Express
[  284.204981] [<c0014225>] (unwind_backtrace) from [<c0010e25>] (show_stack+0x11/0x14)
[  284.204993] [<c0010e25>] (show_stack) from [<c02ed79d>] (dump_stack+0x55/0x78)
[  284.205003] [<c02ed79d>] (dump_stack) from [<c004004d>] (try_to_wake_up+0x249/0x390)
[  284.205011] [<c004004d>] (try_to_wake_up) from [<c005396b>] (__wake_up_common+0x37/0x58)
[  284.205018] [<c005396b>] (__wake_up_common) from [<c005399f>] (__wake_up_locked+0x13/0x18)
[  284.205025] [<c005399f>] (__wake_up_locked) from [<c0053fa9>] (complete+0x25/0x30)
[  284.205032] [<c0053fa9>] (complete) from [<c0012e6d>] (arch_cpu_idle_dead+0x29/0x6c)
[  284.205039] [<c0012e6d>] (arch_cpu_idle_dead) from [<c005441d>] (cpu_startup_entry+0x2f5/0x330)
[  284.205047] [<c005441d>] (cpu_startup_entry) from [<80009431>] (0x80009431)
[  284.205054]
[  284.205057] ===============================
[  284.205060] [ INFO: suspicious RCU usage. ]
[  284.205064] 4.4.0-rc2+ #278 Not tainted
[  284.205066] -------------------------------
[  284.205071] /media/hdd1tb/work/integration/kernel/kernel/sched/fair.c:4938 suspicious rcu_dereference_check() usage!
[  284.205074]
[  284.205074] other info that might help us debug this:
[  284.205074]
[  284.205078]
[  284.205078] RCU used illegally from offline CPU!
[  284.205078] rcu_scheduler_active = 1, debug_locks = 1
[  284.205081] 3 locks held by swapper/1/0:
[  284.205098]  #0:  ((cpu_died).wait.lock){......}, at: [<c0053f97>] complete+0x13/0x30
[  284.205116]  #1:  (&p->pi_lock){-.-.-.}, at: [<c003fe27>] try_to_wake_up+0x23/0x390
[  284.205133]  #2:  (rcu_read_lock){......}, at: [<c0046eae>] select_task_rq_fair+0x32/0x894
[  284.205136]
[  284.205136] stack backtrace:
[  284.205141] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.4.0-rc2+ #278
[  284.205145] Hardware name: ARM-Versatile Express
[  284.205154] [<c0014225>] (unwind_backtrace) from [<c0010e25>] (show_stack+0x11/0x14)
[  284.205163] [<c0010e25>] (show_stack) from [<c02ed79d>] (dump_stack+0x55/0x78)
[  284.205171] [<c02ed79d>] (dump_stack) from [<c00473e7>] (select_task_rq_fair+0x56b/0x894)
[  284.205180] [<c00473e7>] (select_task_rq_fair) from [<c003fef1>] (try_to_wake_up+0xed/0x390)
[  284.205188] [<c003fef1>] (try_to_wake_up) from [<c005396b>] (__wake_up_common+0x37/0x58)
[  284.205195] [<c005396b>] (__wake_up_common) from [<c005399f>] (__wake_up_locked+0x13/0x18)
[  284.205201] [<c005399f>] (__wake_up_locked) from [<c0053fa9>] (complete+0x25/0x30)
[  284.205208] [<c0053fa9>] (complete) from [<c0012e6d>] (arch_cpu_idle_dead+0x29/0x6c)
[  284.205215] [<c0012e6d>] (arch_cpu_idle_dead) from [<c005441d>] (cpu_startup_entry+0x2f5/0x330)
[  284.205221] [<c005441d>] (cpu_startup_entry) from [<80009431>] (0x80009431)
[  284.205228]
[  284.205231] ===============================
[  284.205234] [ INFO: suspicious RCU usage. ]
[  284.205238] 4.4.0-rc2+ #278 Not tainted
[  284.205241] -------------------------------
[  284.205245] /media/hdd1tb/work/integration/kernel/include/trace/events/ipi.h:35 suspicious rcu_dereference_check() usage!
[  284.205247]
[  284.205247] other info that might help us debug this:
[  284.205247]
[  284.205251]
[  284.205251] RCU used illegally from offline CPU!
[  284.205251] rcu_scheduler_active = 1, debug_locks = 1
[  284.205255] 2 locks held by swapper/1/0:
[  284.205271]  #0:  ((cpu_died).wait.lock){......}, at: [<c0053f97>] complete+0x13/0x30
[  284.205289]  #1:  (&p->pi_lock){-.-.-.}, at: [<c003fe27>] try_to_wake_up+0x23/0x390
[  284.205292]
[  284.205292] stack backtrace:
[  284.205297] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.4.0-rc2+ #278
[  284.205300] Hardware name: ARM-Versatile Express
[  284.205310] [<c0014225>] (unwind_backtrace) from [<c0010e25>] (show_stack+0x11/0x14)
[  284.205318] [<c0010e25>] (show_stack) from [<c02ed79d>] (dump_stack+0x55/0x78)
[  284.205325] [<c02ed79d>] (dump_stack) from [<c0012a97>] (smp_cross_call+0x6f/0xf0)
[  284.205334] [<c0012a97>] (smp_cross_call) from [<c003ff8b>] (try_to_wake_up+0x187/0x390)
[  284.205341] [<c003ff8b>] (try_to_wake_up) from [<c005396b>] (__wake_up_common+0x37/0x58)
[  284.205348] [<c005396b>] (__wake_up_common) from [<c005399f>] (__wake_up_locked+0x13/0x18)
[  284.205355] [<c005399f>] (__wake_up_locked) from [<c0053fa9>] (complete+0x25/0x30)
[  284.205361] [<c0053fa9>] (complete) from [<c0012e6d>] (arch_cpu_idle_dead+0x29/0x6c)
[  284.205368] [<c0012e6d>] (arch_cpu_idle_dead) from [<c005441d>] (cpu_startup_entry+0x2f5/0x330)
[  284.205375] [<c005441d>] (cpu_startup_entry) from [<80009431>] (0x80009431)
[  284.205634]
[  284.205637] ===============================
[  284.205640] [ INFO: suspicious RCU usage. ]
[  284.205644] 4.4.0-rc2+ #278 Not tainted
[  284.205647] -------------------------------
[  284.205651] /media/hdd1tb/work/integration/kernel/kernel/sched/core.c:1680 suspicious rcu_dereference_check() usage!
[  284.205654]
[  284.205654] other info that might help us debug this:
[  284.205654]
[  284.205658]
[  284.205658] RCU used illegally from offline CPU!
[  284.205658] rcu_scheduler_active = 1, debug_locks = 1
[  284.205662] 3 locks held by swapper/1/0:
[  284.205678]  #0:  ((cpu_died).wait.lock){......}, at: [<c0053f97>] complete+0x13/0x30
[  284.205696]  #1:  (&p->pi_lock){-.-.-.}, at: [<c003fe27>] try_to_wake_up+0x23/0x390
[  284.205714]  #2:  (rcu_read_lock){......}, at: [<c003cde0>] ttwu_stat+0x30/0x218
[  284.205716]
[  284.205716] stack backtrace:
[  284.205721] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.4.0-rc2+ #278
[  284.205725] Hardware name: ARM-Versatile Express
[  284.205735] [<c0014225>] (unwind_backtrace) from [<c0010e25>] (show_stack+0x11/0x14)
[  284.205744] [<c0010e25>] (show_stack) from [<c02ed79d>] (dump_stack+0x55/0x78)
[  284.205752] [<c02ed79d>] (dump_stack) from [<c003cf45>] (ttwu_stat+0x195/0x218)
[  284.205761] [<c003cf45>] (ttwu_stat) from [<c003ffbf>] (try_to_wake_up+0x1bb/0x390)
[  284.205769] [<c003ffbf>] (try_to_wake_up) from [<c005396b>] (__wake_up_common+0x37/0x58)
[  284.205776] [<c005396b>] (__wake_up_common) from [<c005399f>] (__wake_up_locked+0x13/0x18)
[  284.205783] [<c005399f>] (__wake_up_locked) from [<c0053fa9>] (complete+0x25/0x30)
[  284.205789] [<c0053fa9>] (complete) from [<c0012e6d>] (arch_cpu_idle_dead+0x29/0x6c)
[  284.205796] [<c0012e6d>] (arch_cpu_idle_dead) from [<c005441d>] (cpu_startup_entry+0x2f5/0x330)
[  284.205802] [<c005441d>] (cpu_startup_entry) from [<80009431>] (0x80009431)
[  284.207658] CPU1: shutdown
[
