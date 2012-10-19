From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 19 Oct 2012 12:58:07 +0800
Subject: Do we need to fix below dump during cpu hot plug operation?
In-Reply-To: <20121019015621.GA17360@nchen-desktop>
References: <20121019015621.GA17360@nchen-desktop>
Message-ID: <20121019045802.GA21078@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 09:56:22AM +0800, Peter Chen wrote:
> Hi all,
> 
> When doing system suspend/resume or CPU hot plug at SMP platform (like 
> Freescale i.mx6Q sabrelite board), if local time is enabled, 
> there is a clk_get_rate at twd_timer_setup during the atomic context.
> So, if mutex_lock debug is enabled, there will be below dump message.
> Although it will not affect future system use, it is boring message.
> 
Thanks for reporting, Peter.

We should fix the warning.  Having not turned on those warning options
in imx defconfig might be the reason that we had not noticed it.

Since the driver is able to update the twd_timer_rate whenever clock
rate changes after system boots up, the clk_get_rate call in
twd_timer_setup should be only needed when we get a valid twd_clk at
the first time.  So let's move clk_get_rate call into if (!twd_clk)
block just after twd_get_clock().

Linus, Russell,

Does it seem to be a valid fix?

Shawn

8<---

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index e1f9069..c1f54a1 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -273,13 +273,13 @@ static int __cpuinit twd_timer_setup(struct clock_event_device *clk)
 {
        struct clock_event_device **this_cpu_clk;

-       if (!twd_clk)
+       if (!twd_clk) {
                twd_clk = twd_get_clock();
-
-       if (!IS_ERR_OR_NULL(twd_clk))
-               twd_timer_rate = clk_get_rate(twd_clk);
-       else
+               if (!IS_ERR_OR_NULL(twd_clk))
+                       twd_timer_rate = clk_get_rate(twd_clk);
+       } else {
                twd_calibrate_rate();
+       }

        __raw_writel(0, twd_base + TWD_TIMER_CONTROL);


> BUG: sleeping function called from invalid context at /home/b29397/work/code/git/linus/linux-2.6/kernel/mutex.c:269
> no locks held by swapper/1/0.
> irq event stamp: 279320
> hardirqs last  enabled at (279319): [<80052bd0>] idle_task_exit+0x16c/0x1a0
> hardirqs last disabled at (279320): [<8051a470>] cpu_die+0x28/0x98
> softirqs last  enabled at (279304): [<8002ae3c>] _local_bh_enable+0x14/0x18
> softirqs last disabled at (279303): [<8002aea8>] irq_enter+0x68/0x78
> Backtrace: 
> [<8001284c>] (dump_backtrace+0x0/0x10c) from [<8052b614>] (dump_stack+0x18/0x1c)
>  r7:8062b070 r6:0000010d r5:00000000 r4:bf88c000
> [<8052b5fc>] (dump_stack+0x0/0x1c) from [<80050bb4>] (__might_sleep+0x1ec/0x238)
> [<800509c8>] (__might_sleep+0x0/0x238) from [<8052cf60>] (mutex_lock_nested+0x38/0x3bc)
>  r7:00000000 r6:bf88c000 r5:808b19e0 r4:808a5360
> [<8052cf28>] (mutex_lock_nested+0x0/0x3bc) from [<803e2108>] (clk_get_rate+0x1c/0x84)
> [<803e20ec>] (clk_get_rate+0x0/0x84) from [<8052900c>] (twd_timer_setup+0x28c/0x2e0)
>  r5:808b19e0 r4:817c0200
> [<80528d80>] (twd_timer_setup+0x0/0x2e0) from [<805288b8>] (percpu_timer_setup+0x6c/0xdc)
>  r9:412fc09a r8:1000406a r7:808b19d8 r6:bf88c000 r5:80879c14
> r4:817c0200
> [<8052884c>] (percpu_timer_setup+0x0/0xdc) from [<80528a68>] (secondary_start_kernel+0x140/0x19c)
>  r5:80879c14 r4:00000001
> [<80528928>] (secondary_start_kernel+0x0/0x19c) from [<10528248>] (0x10528248)
>  r7:808b19d8 r6:10c03c7d r5:0000001f r4:4f87806a
> BUG: scheduling while atomic: swapper/1/0/0x40000002
> no locks held by swapper/1/0.
> Modules linked in:
> irq event stamp: 279320
> hardirqs last  enabled at (279319): [<80052bd0>] idle_task_exit+0x16c/0x1a0
> hardirqs last disabled at (279320): [<8051a470>] cpu_die+0x28/0x98
> softirqs last  enabled at (279304): [<8002ae3c>] _local_bh_enable+0x14/0x18
> softirqs last disabled at (279303): [<8002aea8>] irq_enter+0x68/0x78
> Backtrace: 
> [<8001284c>] (dump_backtrace+0x0/0x10c) from [<8052b614>] (dump_stack+0x18/0x1c)
>  r7:00000001 r6:bf88c000 r5:bf890000 r4:bf890000
> [<8052b5fc>] (dump_stack+0x0/0x1c) from [<800539b4>] (__schedule_bug+0x5c/0x7c)
> [<80053958>] (__schedule_bug+0x0/0x7c) from [<8052e1a8>] (__schedule+0x620/0x6e0)
>  r5:bf890000 r4:819215c0
> [<8052db88>] (__schedule+0x0/0x6e0) from [<8052e320>] (_cond_resched+0x44/0x58)
> [<8052e2dc>] (_cond_resched+0x0/0x58) from [<8052cf64>] (mutex_lock_nested+0x3c/0x3bc)
>  r5:808b19e0 r4:808a5360
> [<8052cf28>] (mutex_lock_nested+0x0/0x3bc) from [<803e2108>] (clk_get_rate+0x1c/0x84)
> [<803e20ec>] (clk_get_rate+0x0/0x84) from [<8052900c>] (twd_timer_setup+0x28c/0x2e0)
>  r5:808b19e0 r4:817c0200
> [<80528d80>] (twd_timer_setup+0x0/0x2e0) from [<805288b8>] (percpu_timer_setup+0x6c/0xdc)
>  r9:412fc09a r8:1000406a r7:808b19d8 r6:bf88c000 r5:80879c14
> r4:817c0200
> [<8052884c>] (percpu_timer_setup+0x0/0xdc) from [<80528a68>] (secondary_start_kernel+0x140/0x19c)
>  r5:80879c14 r4:00000001
> [<80528928>] (secondary_start_kernel+0x0/0x19c) from [<10528248>] (0x10528248)
>  r7:808b19d8 r6:10c03c7d r5:0000001f r4:4f87806a
> 
> -- 
> 
> Best Regards,
> Peter Chen
> 
