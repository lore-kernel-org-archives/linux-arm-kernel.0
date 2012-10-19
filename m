From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 20 Oct 2012 00:15:54 +0800
Subject: [PATCH v2] ARM: SMP_TWD: make setup()/stop() reentrant
In-Reply-To: <1350640589-31821-1-git-send-email-linus.walleij@linaro.org>
References: <1350640589-31821-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20121019161549.GE21078@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 11:56:29AM +0200, Linus Walleij wrote:
> This makes the SMP_TWD clock .setup()/.stop() pair reentrant by
> not re-fetching the clk and re-registering the clock event every
> time .setup() is called. We also make sure to call the
> clk_enable()/clk_disable() pair on subsequent calls.
> 
> As it has been brought to my knowledge that this pair is going
> to be called from atomic contexts for CPU clusters coming and
> going, the clk_prepare()/clk_unprepare() calls cannot be called
> on subsequent .setup()/.stop() iterations.
> 
> The patch assumes that the code will make sure that
> twd_set_mode() is called through .set_mode() on the clock
> event *after* the .setup() call, so that the timer registers
> are fully re-programmed after a new .setup() cycle.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Reported-by: Peter Chen <peter.chen@freescale.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Peter/Shawn: can you please respond with a Tested-by from your
> system(s) to indicate if this works as expected?

Yes, it fixes the sleep-in-atomic warning.  However I'm having some
issue with the resume function now.  See below for details.

It's getting late here.  I will investigate it tomorrow if I do not
anything back from you.

Shawn

$ echo mem > /sys/power/state
PM: Syncing filesystems ... done.
PM: Preparing system for mem sleep
mmc1: card e1c3 removed
Freezing user space processes ... (elapsed 0.01 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.03 seconds) done.
PM: Entering mem sleep
PM: suspend of devices complete after 4.651 msecs
PM: suspend devices took 0.010 seconds
PM: late suspend of devices complete after 1.437 msecs
PM: noirq suspend of devices complete after 2.167 msecs
Disabling non-boot CPUs ...
CPU1: shutdown
CPU2: shutdown
CPU3: shutdown
Enabling non-boot CPUs ...
CPU1: Booted secondary processor
CPU1 is up
CPU2: Booted secondary processor
CPU2 is up
CPU3: Booted secondary processor
CPU3 is up
PM: noirq resume of devices complete after 1.030 msecs
PM: early resume of devices complete after 1.553 msecs
PM: resume of devices complete after 4.179 msecs
PM: resume devices took 0.010 seconds
PM: Finishing wakeup.
Restarting tasks ... done.
mmc1: new high speed SDHC card at address e1c3
mmcblk0: mmc1:e1c3 SD04G 3.69 GiB
 mmcblk0: p1 p2 p3
libphy: 2188000.ethernet:01 - Link is Down
libphy: 2188000.ethernet:01 - Link is Up - 100/Full
INFO: rcu_sched detected stalls on CPUs/tasks: { 1} (detected by 0, t=6002 jiffies)
Backtrace:
[<80011e74>] (dump_backtrace+0x0/0x10c) from [<804d8d84>] (dump_stack+0x18/0x1c)
 r6:8069db00 r5:806b4800 r4:8144bb00 r3:00000000
[<804d8d6c>] (dump_stack+0x0/0x1c) from [<80080d78>] (rcu_check_callbacks+0x598/0x624)
[<800807e0>] (rcu_check_callbacks+0x0/0x624) from [<8002e31c>] (update_process_times+0x40/0x54)
[<8002e2dc>] (update_process_times+0x0/0x54) from [<8005f928>] (tick_sched_timer+0x88/0xec)
 r6:8144ba18 r5:00000014 r4:9c341e08 r3:20000013
[<8005f8a0>] (tick_sched_timer+0x0/0xec) from [<80043214>] (__run_hrtimer.isra.18+0x4c/0xe0)
 r8:9c341767 r7:8005f8a0 r6:8144b880 r5:8144b8d0 r4:8144ba18
[<800431c8>] (__run_hrtimer.isra.18+0x0/0xe0) from [<80043c68>] (hrtimer_interrupt+0x120/0x2c0)
 r7:00000001 r6:8144b880 r5:00000000 r4:8144b8d0
[<80043b48>] (hrtimer_interrupt+0x0/0x2c0) from [<8001401c>] (twd_handler+0x34/0x48)
[<80013fe8>] (twd_handler+0x0/0x48) from [<8007b5e8>] (handle_percpu_devid_irq+0x88/0xa8)
 r4:bf807600 r3:80013fe8
[<8007b560>] (handle_percpu_devid_irq+0x0/0xa8) from [<80077cb8>] (generic_handle_irq+0x28/0x38)
 r8:00000000 r7:0000001d r6:806a0000 r5:8069e02c r4:0000001d
r3:8007b560
[<80077c90>] (generic_handle_irq+0x0/0x38) from [<8000ee94>] (handle_IRQ+0x54/0xb4)
 r4:806a9258 r3:00000180
[<8000ee40>] (handle_IRQ+0x0/0xb4) from [<80008504>] (gic_handle_irq+0x30/0x64)
 r8:806ad048 r7:f4000100 r6:806a1f00 r5:806a8970 r4:f400010c
r3:00000000
[<800084d4>] (gic_handle_irq+0x0/0x64) from [<8000e124>] (__irq_svc+0x44/0x5c)
Exception stack(0x806a1f00 to 0x806a1f48)
1f00: 00000001 00000001 00000000 806abd48 806a0000 806a0000 806e9088 804e2aa4
1f20: 806ad048 806a0000 00000000 806a1f54 806a1f18 806a1f48 8006629c 8000f1c0
1f40: 20000013 ffffffff
 r7:806a1f34 r6:ffffffff r5:20000013 r4:8000f1c0
[<8000f198>] (default_idle+0x0/0x44) from [<8000f338>] (cpu_idle+0x54/0x104)
[<8000f2e4>] (cpu_idle+0x0/0x104) from [<804c8534>] (rest_init+0xc4/0xec)
[<804c8470>] (rest_init+0x0/0xec) from [<8066183c>] (start_kernel+0x2bc/0x30c)
 r7:80691f50 r6:806e8fc0 r5:ffffffff r4:806a8f90
[<80661580>] (start_kernel+0x0/0x30c) from [<10008044>] (0x10008044)
