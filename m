From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 5 Feb 2015 10:53:27 +0000
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20150205105327.GC11344@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 10:14:30AM +0000, Krzysztof Kozlowski wrote:
> The complete() should not be used on offlined CPU. Rewrite the
> wait-complete mechanism with wait_on_bit_timeout().
> 
> The CPU triggering hot unplug (e.g. CPU0) will loop until some bit is
> cleared. In each iteration schedule_timeout() is used with initial sleep
> time of 1 ms. Later it is increased to 10 ms.
> 
> The dying CPU will clear the bit which is safe in that context.
> 
> This fixes following RCU warning on ARMv8 (Exynos 4412, Trats2) during
> suspend to RAM:

Nit: isn't Exynos4412 a quad-A9 (ARMv7 rather than ARMv8)?

> [   31.113925] ===============================
> [   31.113928] [ INFO: suspicious RCU usage. ]
> [   31.113935] 3.19.0-rc7-next-20150203 #1914 Not tainted
> [   31.113938] -------------------------------
> [   31.113943] kernel/sched/fair.c:4740 suspicious rcu_dereference_check() usage!
> [   31.113946]
> [   31.113946] other info that might help us debug this:
> [   31.113946]
> [   31.113952]
> [   31.113952] RCU used illegally from offline CPU!
> [   31.113952] rcu_scheduler_active = 1, debug_locks = 0
> [   31.113957] 3 locks held by swapper/1/0:
> [   31.113988]  #0:  ((cpu_died).wait.lock){......}, at: [<c005a114>] complete+0x14/0x44
> [   31.114012]  #1:  (&p->pi_lock){-.-.-.}, at: [<c004a790>] try_to_wake_up+0x28/0x300
> [   31.114035]  #2:  (rcu_read_lock){......}, at: [<c004f1b8>] select_task_rq_fair+0x5c/0xa04
> [   31.114038]
> [   31.114038] stack backtrace:
> [   31.114046] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.19.0-rc7-next-20150203 #1914
> [   31.114050] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [   31.114076] [<c0014ce4>] (unwind_backtrace) from [<c0011c30>] (show_stack+0x10/0x14)
> [   31.114091] [<c0011c30>] (show_stack) from [<c04dc048>] (dump_stack+0x70/0xbc)
> [   31.114105] [<c04dc048>] (dump_stack) from [<c004f83c>] (select_task_rq_fair+0x6e0/0xa04)
> [   31.114118] [<c004f83c>] (select_task_rq_fair) from [<c004a83c>] (try_to_wake_up+0xd4/0x300)
> [   31.114129] [<c004a83c>] (try_to_wake_up) from [<c00598a0>] (__wake_up_common+0x4c/0x80)
> [   31.114140] [<c00598a0>] (__wake_up_common) from [<c00598e8>] (__wake_up_locked+0x14/0x1c)
> [   31.114150] [<c00598e8>] (__wake_up_locked) from [<c005a134>] (complete+0x34/0x44)
> [   31.114167] [<c005a134>] (complete) from [<c04d6ca4>] (cpu_die+0x24/0x84)
> [   31.114179] [<c04d6ca4>] (cpu_die) from [<c005a508>] (cpu_startup_entry+0x328/0x358)
> [   31.114189] [<c005a508>] (cpu_startup_entry) from [<40008784>] (0x40008784)
> [   31.114226] CPU1: shutdown
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---
> Changes since v1:
> 1. Use adaptive sleep time when waiting for CPU die (idea and code
>    from Paul E. McKenney). Paul also acked the patch but I made evem more
>    changes.
> 
> 2. Add another bit (CPU_DIE_TIMEOUT_BIT) for synchronizing power down
>    failure in case:
>     CPU0 (killing)                           CPUx (killed)
>      wait_for_cpu_die
>      timeout
>                                               cpu_die()
>                                                clear_bit()
>                                                self power down
> 
>    In this case the bit would be cleared and CPU would be powered down
>    introducing wrong behavior in next power down sequence (CPU0 would
>    see the bit cleared).
>    I think that such race is still possible but was narrowed to very
>    short time frame. Any CPU up will reset the bit to proper values.

In the case of shutting down 2 CPUs in quick succession (without an
intervening boot of a CPU), surely this does not solve the potential
race on the wait_cpu_die variable?

I think we instead need a percpu synchronisation variable, which would
prevent racing on the value between CPUs, and a CPU would have to be
brought up before we could decide to kill it again. With that I think we
only need a single bit, too.

Thanks,
Mark.
