From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Dec 2017 12:00:12 +0000
Subject: WARNING: suspicious RCU usage
In-Reply-To: <20171210113930.zimywmxzsutwzzmz@linux-u7w5.ap.freescale.net>
References: <20171210113930.zimywmxzsutwzzmz@linux-u7w5.ap.freescale.net>
Message-ID: <20171210120012.GM10595@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Paul

Annoyingly, it looks like calling "complete()" from a dying CPU is
triggering the RCU usage warning.  From what I remember, this is an
old problem, and we still have no better solution for this other than
to persist with the warning.

I suspect the following lockdep warning is triggered by the RCU code
bringing the console semaphore into the mix of locks.

On Sun, Dec 10, 2017 at 07:39:33PM +0800, Peng Fan wrote:
> Hi All,
> 
> I met an RCU warning when test suspend/resume on i.MX6Q-SDB(4 cortex-A9 cores).
> The suspend/resume function still work, but I do not have good idea about
> the RCU warning. Please help if you any ideas.
> 
> The defconfig is imx_v6_v7_defconfig of "4.15.0-rc2-00483-g4ded3bec65a0"
> 
> Test log:
> root at imx6qpdlsolox:~# /unit_tests/Power_Management/suspend_quick_auto.sh
> 
> ---- Running < suspend_quick_auto.sh > test ----
> 
> ---- Running < /unit_tests/SRTC/rtcwakeup.out > test ----
> 
> rtcwakeup.out: wakeup from "mem" using rtc0 at Thu Sep  7 00:06:21 2017
> [   21.688752] PM: suspend entry (deep)
> [   21.693550] PM: Syncing filesystems ... done.
> [   21.728528] Freezing user space processes ... (elapsed 0.002 seconds) done.
> [   21.739020] OOM killer disabled.
> [   21.742326] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> [   21.816672] PM: suspend devices took 0.060 seconds
> [   21.832558] Disabling non-boot CPUs ...
> [   21.932773]
> [   21.933333] =============================
> [   21.933338] WARNING: suspicious RCU usage
> [   21.933342] 4.15.0-rc2-00483-g4ded3bec65a0 #85 Not tainted
> [   21.933348] -----------------------------
> [   21.933354] kernel/sched/fair.c:6333 suspicious rcu_dereference_check() usage!
> [   21.933358]
> [   21.933358] other info that might help us debug this:
> [   21.933358]
> [   21.933364]
> [   21.933364] RCU used illegally from offline CPU!
> [   21.933364] rcu_scheduler_active = 2, debug_locks = 0
> [   21.933369] 3 locks held by swapper/2/0:
> [   21.933373]  #0:  ((cpu_died).wait.lock){....}, at: [<4f528fc4>] complete+0x1c/0x58
> [   21.933396]  #1:  (&p->pi_lock){-.-.}, at: [<656ae3ef>] try_to_wake_up+0x28/0x368
> [   21.933415]  #2:  (rcu_read_lock){....}, at: [<73be2596>] select_task_rq_fair+0x150/0xf0c
> [   21.933433]
> [   21.933433] stack backtrace:
> [   21.933441] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.15.0-rc2-00483-g4ded3bec65a0 #85
> [   21.933445] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   21.933448] Backtrace:
> [   21.933459] [<c010c890>] (dump_backtrace) from [<c010cb60>] (show_stack+0x18/0x1c)
> [   21.933466]  r7:00000000 r6:60070093 r5:00000000 r4:c107bd50
> [   21.933475] [<c010cb48>] (show_stack) from [<c09eca50>] (dump_stack+0xb4/0xe8)
> [   21.933484] [<c09ec99c>] (dump_stack) from [<c016e47c>] (lockdep_rcu_suspicious+0xb0/0x110)
> [   21.933493]  r9:c0f7a380 r8:c107cd92 r7:c0cfc5c8 r6:000018bd r5:c0cff438 r4:ec0a0cc0
> [   21.933503] [<c016e3cc>] (lockdep_rcu_suspicious) from [<c015a4e8>] (select_task_rq_fair+0xcf8/0xf0c)
> [   21.933509]  r7:00000000 r6:00000000 r5:00000000 r4:00000000
> [   21.933518] [<c01597f0>] (select_task_rq_fair) from [<c01505e4>] (try_to_wake_up+0x108/0x368)
> [   21.933526]  r10:c1009290 r9:c0f7a380 r8:c01597f0 r7:40070093 r6:ec8e1e00 r5:00000000
> [   21.933531]  r4:ec8e1980
> [   21.933540] [<c01504dc>] (try_to_wake_up) from [<c0150918>] (default_wake_function+0x14/0x18)
> [   21.933548]  r10:00000000 r9:00000000 r8:c0150904 r7:00000000 r6:c100e470 r5:00000001
> [   21.933552]  r4:c100e464
> [   21.933562] [<c0150904>] (default_wake_function) from [<c0166bd4>] (__wake_up_common+0x94/0x154)
> [   21.933572] [<c0166b40>] (__wake_up_common) from [<c0166d8c>] (__wake_up_locked+0x20/0x28)
> [   21.933580]  r10:00000000 r9:412fc09a r8:c0f79840 r7:c1009174 r6:60070093 r5:c100e44c
> [   21.933584]  r4:c100e448
> [   21.933594] [<c0166d6c>] (__wake_up_locked) from [<c0167970>] (complete+0x48/0x58)
> [   21.933605] [<c0167928>] (complete) from [<c010fb98>] (arch_cpu_idle_dead+0x3c/0xa4)
> [   21.933611]  r7:c1009174 r6:00000004 r5:00000002 r4:c0db0054
> [   21.933622] [<c010fb5c>] (arch_cpu_idle_dead) from [<c0167d2c>] (do_idle+0x170/0x230)
> [   21.933629]  r5:c1009128 r4:ec0b0000
> [   21.933638] [<c0167bbc>] (do_idle) from [<c0168178>] (cpu_startup_entry+0x20/0x24)
> [   21.933647]  r10:00000000 r9:412fc09a r8:1000406a r7:c107dbe0 r6:10c0387d r5:00000002
> [   21.933653]  r4:00000085 r3:ec0a0cc0
> [   21.933663] [<c0168158>] (cpu_startup_entry) from [<c010fd48>] (secondary_start_kernel+0x148/0x174)
> [   21.933672] [<c010fc00>] (secondary_start_kernel) from [<10101a0c>] (0x10101a0c)
> [   21.933677]  r5:00000051 r4:3c08c06a
> [   21.991289] Enabling non-boot CPUs ...
> [   22.278265] CPU1 is up
> [   22.281305] CPU2 is up
> [   22.284299] CPU3 is up
> [   23.183405]
> [   23.183409] ======================================================
> [   23.183413] WARNING: possible circular locking dependency detected
> [   23.183415] 4.15.0-rc2-00483-g4ded3bec65a0 #85 Not tainted
> [   23.183418] ------------------------------------------------------
> [   23.183421] swapper/2/0 is trying to acquire lock:
> [   23.183423]  ((console_sem).lock){....}, at: [<66600b38>] down_trylock+0x14/0x34
> [   23.183431]
> [   23.183433] but task is already holding lock:
> [   23.183435]  (&p->pi_lock){-.-.}, at: [<656ae3ef>] try_to_wake_up+0x28/0x368
> [   23.183442]
> [   23.183444] which lock already depends on the new lock.
> [   23.183446]
> [   23.183448]
> [   23.183450] the existing dependency chain (in reverse order) is:
> [   23.183452]
> [   23.183453] -> #1 (&p->pi_lock){-.-.}:
> [   23.183461]        lock_acquire+0x70/0x90
> [   23.183463]        _raw_spin_lock_irqsave+0x40/0x54
> [   23.183466]        try_to_wake_up+0x28/0x368
> [   23.183468]        wake_up_process+0x18/0x1c
> [   23.183470]        __up+0x3c/0x40
> [   23.183472]        up+0x54/0x68
> [   23.183474]        __up_console_sem+0x34/0x60
> [   23.183476]        console_unlock+0x374/0x4d0
> [   23.183478]        vprintk_emit+0x220/0x2bc
> [   23.183480]        dev_vprintk_emit+0x9c/0x1d4
> [   23.183483]        dev_printk_emit+0x28/0x30
> [   23.183485]        __dev_printk+0x4c/0x90
> [   23.183487]        dev_warn+0x3c/0x48
> [   23.183489]        _request_firmware+0x448/0x610
> [   23.183491]        request_firmware_work_func+0x34/0x6c
> [   23.183493]        process_one_work+0x254/0x4f0
> [   23.183496]        worker_thread+0x40/0x5a8
> [   23.183498]        kthread+0x144/0x194
> [   23.183500]        ret_from_fork+0x14/0x20
> [   23.183501]
> [   23.183503] -> #0 ((console_sem).lock){....}:
> [   23.183510]        __lock_acquire+0x131c/0x14a8
> [   23.183513]        lock_acquire+0x70/0x90
> [   23.183515]        _raw_spin_lock_irqsave+0x40/0x54
> [   23.183517]        down_trylock+0x14/0x34
> [   23.183519]        __down_trylock_console_sem+0x2c/0x88
> [   23.183522]        console_trylock+0x18/0x60
> [   23.183524]        vprintk_emit+0x214/0x2bc
> [   23.183526]        vprintk_default+0x28/0x30
> [   23.183528]        vprintk_func+0x78/0xcc
> [   23.183530]        printk+0x28/0x30
> [   23.183532]        lockdep_rcu_suspicious+0x30/0x110
> [   23.183535]        select_task_rq_fair+0xcf8/0xf0c
> [   23.183537]        try_to_wake_up+0x108/0x368
> [   23.183539]        default_wake_function+0x14/0x18
> [   23.183541]        __wake_up_common+0x94/0x154
> [   23.183543]        __wake_up_locked+0x20/0x28
> [   23.183545]        complete+0x48/0x58
> [   23.183548]        arch_cpu_idle_dead+0x3c/0xa4
> [   23.183550]        do_idle+0x170/0x230
> [   23.183552]        cpu_startup_entry+0x20/0x24
> [   23.183554]        secondary_start_kernel+0x148/0x174
> [   23.183556]        0x10101a0c
> [   23.183557]
> [   23.183560] other info that might help us debug this:
> [   23.183561]
> [   23.183563]  Possible unsafe locking scenario:
> [   23.183565]
> [   23.183567]        CPU0                    CPU1
> [   23.183569]        ----                    ----
> [   23.183571]   lock(&p->pi_lock);
> [   23.183576]                                lock((console_sem).lock);
> [   23.183581]                                lock(&p->pi_lock);
> [   23.183586]   lock((console_sem).lock);
> [   23.183590]
> [   23.183592]  *** DEADLOCK ***
> [   23.183594]
> [   23.183596] 3 locks held by swapper/2/0:
> [   23.183597]  #0:  ((cpu_died).wait.lock){....}, at: [<4f528fc4>] complete+0x1c/0x58
> [   23.183605]  #1:  (&p->pi_lock){-.-.}, at: [<656ae3ef>] try_to_wake_up+0x28/0x368
> [   23.183613]  #2:  (rcu_read_lock){....}, at: [<73be2596>] select_task_rq_fair+0x150/0xf0c
> [   23.183621]
> [   23.183623] stack backtrace:
> [   23.183626] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.15.0-rc2-00483-g4ded3bec65a0 #85
> [   23.183629] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   23.183630] Backtrace:
> [   23.183635] [<c010c890>] (dump_backtrace) from [<c010cb60>] (show_stack+0x18/0x1c)
> [   23.183638]  r7:00000000 r6:60070093 r5:00000000 r4:c107bd50
> [   23.183641] [<c010cb48>] (show_stack) from [<c09eca50>] (dump_stack+0xb4/0xe8)
> [   23.183643] [<c09ec99c>] (dump_stack) from [<c016e750>] (print_circular_bug+0x218/0x3c8)
> [   23.183646]  r9:00000000 r8:ec0a0cc0 r7:c11a4120 r6:c11a4120 r5:ec0a11e0 r4:c11a8700
> [   23.183649] [<c016e538>] (print_circular_bug) from [<c016f938>] (check_prev_add+0x42c/0x7b4)
> [   23.183652]  r10:c1029bac r9:ec0a0cc0 r8:ec0a11e0 r7:ec0a1220 r6:ec0a11e0 r5:00000000
> [   23.183654]  r4:ec0a0cc0 r3:ec0a11e0
> [   23.183657] [<c016f50c>] (check_prev_add) from [<c0172678>] (__lock_acquire+0x131c/0x14a8)
> [   23.183660]  r10:c1029bac r9:ec0a0cc0 r8:ec0a11e0 r7:c17cad80 r6:00000001 r5:00000000
> [   23.183661]  r4:ec0a1220
> [   23.183664] [<c017135c>] (__lock_acquire) from [<c017307c>] (lock_acquire+0x70/0x90)
> [   23.183667]  r10:00000000 r9:60070093 r8:00000001 r7:00000001 r6:60070093 r5:00000000
> [   23.183669]  r4:ffffe000
> [   23.183672] [<c017300c>] (lock_acquire) from [<c0a094dc>] (_raw_spin_lock_irqsave+0x40/0x54)
> [   23.183674]  r8:00000000 r7:00000004 r6:c016b368 r5:60070093 r4:c101ba28
> [   23.183677] [<c0a0949c>] (_raw_spin_lock_irqsave) from [<c016b368>] (down_trylock+0x14/0x34)
> [   23.183679]  r6:c017cb30 r5:c101ba28 r4:00000000
> [   23.183682] [<c016b354>] (down_trylock) from [<c017b684>] (__down_trylock_console_sem+0x2c/0x88)
> [   23.183684]  r5:60070093 r4:00000000
> [   23.183687] [<c017b658>] (__down_trylock_console_sem) from [<c017b6f8>] (console_trylock+0x18/0x60)
> [   23.183690]  r6:00000006 r5:c017cb30 r4:00000000
> [   23.183692] [<c017b6e0>] (console_trylock) from [<c017cb30>] (vprintk_emit+0x214/0x2bc)
> [   23.183694]  r5:00000000 r4:00000000
> [   23.183697] [<c017c91c>] (vprintk_emit) from [<c017cd74>] (vprintk_default+0x28/0x30)
> [   23.183700]  r10:ec8e1980 r9:c0f7a380 r8:c107cd92 r7:c0cfc5c8 r6:000018bd r5:c0cffdfc
> [   23.183702]  r4:c1009290
> [   23.183705] [<c017cd4c>] (vprintk_default) from [<c017e130>] (vprintk_func+0x78/0xcc)
> [   23.183707] [<c017e0b8>] (vprintk_func) from [<c017da50>] (printk+0x28/0x30)
> [   23.183709]  r5:c0cff438 r4:ec0a0cc0
> [   23.183712] [<c017da2c>] (printk) from [<c016e3fc>] (lockdep_rcu_suspicious+0x30/0x110)
> [   23.183715]  r3:ec0b1df0 r2:c0cfc5c8 r1:000018bd r0:c0cffdfc
> [   23.183718] [<c016e3cc>] (lockdep_rcu_suspicious) from [<c015a4e8>] (select_task_rq_fair+0xcf8/0xf0c)
> [   23.183720]  r7:00000000 r6:00000000 r5:00000000 r4:00000000
> [   23.183723] [<c01597f0>] (select_task_rq_fair) from [<c01505e4>] (try_to_wake_up+0x108/0x368)
> [   23.183726]  r10:c1009290 r9:c0f7a380 r8:c01597f0 r7:40070093 r6:ec8e1e00 r5:00000000
> [   23.183728]  r4:ec8e1980
> [   23.183731] [<c01504dc>] (try_to_wake_up) from [<c0150918>] (default_wake_function+0x14/0x18)
> [   23.183734]  r10:00000000 r9:00000000 r8:c0150904 r7:00000000 r6:c100e470 r5:00000001
> [   23.183736]  r4:c100e464
> [   23.183739] [<c0150904>] (default_wake_function) from [<c0166bd4>] (__wake_up_common+0x94/0x154)
> [   23.183741] [<c0166b40>] (__wake_up_common) from [<c0166d8c>] (__wake_up_locked+0x20/0x28)
> [   23.183744]  r10:00000000 r9:412fc09a r8:c0f79840 r7:c1009174 r6:60070093 r5:c100e44c
> [   23.183746]  r4:c100e448
> [   23.183749] [<c0166d6c>] (__wake_up_locked) from [<c0167970>] (complete+0x48/0x58)
> [   23.183752] [<c0167928>] (complete) from [<c010fb98>] (arch_cpu_idle_dead+0x3c/0xa4)
> [   23.183754]  r7:c1009174 r6:00000004 r5:00000002 r4:c0db0054
> [   23.183757] [<c010fb5c>] (arch_cpu_idle_dead) from [<c0167d2c>] (do_idle+0x170/0x230)
> [   23.183759]  r5:c1009128 r4:ec0b0000
> [   23.183762] [<c0167bbc>] (do_idle) from [<c0168178>] (cpu_startup_entry+0x20/0x24)
> [   23.183765]  r10:00000000 r9:412fc09a r8:1000406a r7:c107dbe0 r6:10c0387d r5:00000002
> [   23.183767]  r4:00000085 r3:ec0a0cc0
> [   23.183770] [<c0168158>] (cpu_startup_entry) from [<c010fd48>] (secondary_start_kernel+0x148/0x174)
> [   23.183773] [<c010fc00>] (secondary_start_kernel) from [<10101a0c>] (0x10101a0c)
> [   23.183775]  r5:00000051 r4:3c08c06a
> [   23.471735] ata1: SATA link down (SStatus 0 SControl 300)
> [   23.899204] PM: resume devices took 0.750 seconds
> [   23.903961] OOM killer enabled.
> [   23.907111] Restarting tasks ... done.
> [   23.938591] PM: suspend exit
> ===============================
> suspend 1 times
> ===============================
> 
> Thanks,
> Peng.
> 
> -- 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
