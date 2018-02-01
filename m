From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 1 Feb 2018 14:54:37 +0000
Subject: pr_debug in gic_send_sgi
In-Reply-To: <1517496055.10513.20.camel@redhat.com>
References: <1517496055.10513.20.camel@redhat.com>
Message-ID: <76ee7742-ddac-7b1f-8846-bb659d1cc5d8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/18 14:40, Mark Salter wrote:
> The gic_send_sgi() function for gicv3 has a pr_debug() in it which leads to
> a complaint from lockdep:
> 
> [  429.995788] GICv3: CPU10: ICC_SGI1R_EL1 5000400
> [  429.995789] ======================================================
> [  429.995791] WARNING: possible circular locking dependency detected
> [  429.995792] 4.15.0+ #1 Tainted: G        W       
> [  429.995794] ------------------------------------------------------
> [  429.995795] dynamic_debug01/1873 is trying to acquire lock:
> [  429.995797]  ((console_sem).lock){-...}, at: [<0000000099c891ec>] down_trylock+0x20/0x4c
> [  429.995802] 
> [  429.995803] but task is already holding lock:
> [  429.995804]  (&rq->lock){-.-.}, at: [<00000000842e1587>] __task_rq_lock+0x54/0xdc
> [  429.995809] 
> [  429.995811] which lock already depends on the new lock.
> [  429.995812] 
> [  429.995813] 
> [  429.995814] the existing dependency chain (in reverse order) is:
> [  429.995815] 
> [  429.995816] -> #2 (&rq->lock){-.-.}:
> [  429.995822]        __lock_acquire+0x3b4/0x6e0
> [  429.995823]        lock_acquire+0xf4/0x2a8
> [  429.995825]        _raw_spin_lock+0x4c/0x60
> [  429.995826]        task_fork_fair+0x3c/0x148
> [  429.995827]        sched_fork+0x10c/0x214
> [  429.995829]        copy_process.isra.32.part.33+0x4e8/0x14f0
> [  429.995830]        _do_fork+0xe8/0x78c
> [  429.995831]        kernel_thread+0x48/0x54
> [  429.995833]        rest_init+0x34/0x2a4
> [  429.995834]        start_kernel+0x45c/0x488
> [  429.995835] 
> [  429.995836] -> #1 (&p->pi_lock){-.-.}:
> [  429.995846]        __lock_acquire+0x3b4/0x6e0
> [  429.995850]        lock_acquire+0xf4/0x2a8
> [  429.995852]        _raw_spin_lock_irqsave+0x58/0x70
> [  429.995853]        try_to_wake_up+0x48/0x600
> [  429.995854]        wake_up_process+0x28/0x34
> [  429.995856]        __up.isra.0+0x60/0x6c
> [  429.995857]        up+0x60/0x68
> [  429.995858]        __up_console_sem+0x4c/0x7c
> [  429.995859]        console_unlock+0x328/0x634
> [  429.995864]        vprintk_emit+0x25c/0x390
> [  429.995866]        dev_vprintk_emit+0xc4/0x1fc
> [  429.995867]        dev_printk_emit+0x88/0xa8
> [  429.995870]        __dev_printk+0x58/0x9c
> [  429.995873]        _dev_info+0x84/0xa8
> [  429.995875]        usb_new_device+0x100/0x474
> [  429.995876]        hub_port_connect+0x280/0x92c
> [  429.995877]        hub_event+0x740/0xa84
> [  429.995881]        process_one_work+0x240/0x70c
> [  429.995884]        worker_thread+0x60/0x400
> [  429.995885]        kthread+0x110/0x13c
> [  429.995886]        ret_from_fork+0x10/0x18
> [  429.995888] 
> [  429.995889] -> #0 ((console_sem).lock){-...}:
> [  429.995898]        validate_chain.isra.34+0x6e4/0xa20
> [  429.995900]        __lock_acquire+0x3b4/0x6e0
> [  429.995903]        lock_acquire+0xf4/0x2a8
> [  429.995908]        _raw_spin_lock_irqsave+0x58/0x70
> [  429.995909]        down_trylock+0x20/0x4c
> [  429.995911]        __down_trylock_console_sem+0x3c/0x9c
> [  429.995912]        console_trylock+0x20/0xb0
> [  429.995913]        vprintk_emit+0x254/0x390
> [  429.995915]        vprintk_default+0x58/0x90
> [  429.995916]        vprintk_func+0xbc/0x164
> [  429.995919]        printk+0x80/0xa0
> [  429.995922]        __dynamic_pr_debug+0x84/0xac
> [  429.995924]        gic_raise_softirq+0x184/0x18c
> [  429.995925]        smp_cross_call+0xac/0x218
> [  429.995926]        smp_send_reschedule+0x3c/0x48
> [  429.995928]        resched_curr+0x60/0x9c
> [  429.995929]        check_preempt_curr+0x70/0xdc
> [  429.995930]        wake_up_new_task+0x310/0x470
> [  429.995931]        _do_fork+0x188/0x78c
> [  429.995933]        SyS_clone+0x44/0x50
> [  429.995934]        __sys_trace_return+0x0/0x4
> [  429.995935] 
> [  429.995936] other info that might help us debug this:
> [  429.995937] 
> [  429.995939] Chain exists of:
> [  429.995940]   (console_sem).lock --> &p->pi_lock --> &rq->lock
> [  429.995951] 
> [  429.995952]  Possible unsafe locking scenario:
> [  429.995954] 
> [  429.995955]        CPU0                    CPU1
> [  429.995956]        ----                    ----
> [  429.995957]   lock(&rq->lock);
> [  429.995961]                                lock(&p->pi_lock);
> [  429.995964]                                lock(&rq->lock);
> [  429.995968]   lock((console_sem).lock);
> [  429.995971] 
> [  429.995972]  *** DEADLOCK ***
> [  429.995973] 
> [  429.995974] 2 locks held by dynamic_debug01/1873:
> [  429.995978]  #0:  (&p->pi_lock){-.-.}, at: [<000000001366df53>] wake_up_new_task+0x40/0x470
> [  429.995989]  #1:  (&rq->lock){-.-.}, at: [<00000000842e1587>] __task_rq_lock+0x54/0xdc
> [  429.995996] 
> [  429.995998] stack backtrace:
> [  429.995999] CPU: 10 PID: 1873 Comm: dynamic_debug01 Tainted: G        W        4.15.0+ #1
> [  429.996001] Hardware name: GIGABYTE R120-T34-00/MT30-GS2-00, BIOS T48 10/02/2017
> [  429.996006] Call trace:
> [  429.996011]  dump_backtrace+0x0/0x188
> [  429.996012]  show_stack+0x24/0x2c
> [  429.996013]  dump_stack+0xa4/0xe0
> [  429.996014]  print_circular_bug.isra.31+0x29c/0x2b8
> [  429.996016]  check_prev_add.constprop.39+0x6c8/0x6dc
> [  429.996017]  validate_chain.isra.34+0x6e4/0xa20
> [  429.996018]  __lock_acquire+0x3b4/0x6e0
> [  429.996020]  lock_acquire+0xf4/0x2a8
> [  429.996023]  _raw_spin_lock_irqsave+0x58/0x70
> [  429.996028]  down_trylock+0x20/0x4c
> [  429.996030]  __down_trylock_console_sem+0x3c/0x9c
> [  429.996035]  console_trylock+0x20/0xb0
> [  429.996036]  vprintk_emit+0x254/0x390
> [  429.996037]  vprintk_default+0x58/0x90
> [  429.996038]  vprintk_func+0xbc/0x164
> [  429.996040]  printk+0x80/0xa0
> [  429.996041]  __dynamic_pr_debug+0x84/0xac
> [  429.996042]  gic_raise_softirq+0x184/0x18c
> [  429.996043]  smp_cross_call+0xac/0x218
> [  429.996045]  smp_send_reschedule+0x3c/0x48
> [  429.996046]  resched_curr+0x60/0x9c
> [  429.996047]  check_preempt_curr+0x70/0xdc
> [  429.996048]  wake_up_new_task+0x310/0x470
> [  429.996050]  _do_fork+0x188/0x78c
> [  429.996051]  SyS_clone+0x44/0x50
> [  429.996052]  __sys_trace_return+0x0/0x4
> [  430.214138] GICv3: CPU0: ICC_SGI1R_EL1 12000
> 
> This was seen while running ltp dynamic_debug01 test on a kernel with dynamic_debug
> enabled. You can also trigger it by manually enabling the pr_debug with:
> 
>   # echo -n 'func gic_send_sgi +p' >/sys/kernel/debug/dynamic_debug/control
> 
> This happens because the scheduler ends up using gic_send_sgi() for the
> smp_send_reschedule() and the underlying printk in pr_debug can lead to a call
> into the scheduler.
> 
> This can be avoided by creating a pr_debug_deferred() based on printk_deferred() if
> the message is worth keeping. I tried this out and it got rid of the lockdep warning
> but on a system with a lot of cores, it is so verbose that printk ends up throwing
> a lot of the messages away.

I'd definitely like this message to stay, as the way we coalesce SGIs is
pretty tricky (and will become trickier in the future). Can you instead
turn it into a pr_devel? I don't mind it being difficult to enable, as
this is very much a "I'm hacking the kernel" option.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
