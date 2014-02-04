From: john.stultz@linaro.org (John Stultz)
Date: Tue, 04 Feb 2014 12:46:03 -0800
Subject: Weird sched_clock behaviour during boot with -rc1
In-Reply-To: <20140204183641.GA25127@mudshark.cambridge.arm.com>
References: <20140204183641.GA25127@mudshark.cambridge.arm.com>
Message-ID: <52F1518B.9010109@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/2014 10:36 AM, Will Deacon wrote:
> Hi guys,
>
> Booting -rc1 on my TC2 gives the following strange entries in the dmesg:
>
>
>   Uncompressing Linux... done, booting the kernel.
>   [    0.000000] Booting Linux on physical CPU 0x0
>
>   [...]
>
>   [    0.000000]   HighMem zone: 329728 pages, LIFO batch:31
>   [    7.789662] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956969942ns
>   [    0.000129] PERCPU: Embedded 9 pages/cpu @ee7bd000 s12800 r8192 d15872 u36864
>
>   [...]
>
>   [    0.868297] NR_IRQS:16 nr_irqs:16 16
>   [    0.886350] Architected cp15 timer(s) running at 24.00MHz (phys).
>   [ 2915.164998] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 2863311519744ns
>   [    0.000002] Switching to timer-based delay loop
>   [    0.014249] Console: colour dummy device 80x30
>
>
> so it looks like something whacky goes on during sched_clock registration.
> Sure enough, we're doing a pr_info in-between updating cs.* and calling
> update_sched_clock(), so moving the print sorts things out (diff below).

Yea... we have to be particularly careful with sched_clock to avoid
locks since we don't want to deadlock, but in this case
sched_clock_register is a little too relaxed here.

Stephen: Would it make sense to set cd.suspended = true at the top of
the registration? That should block any sched_clock calls from getting
half-updated data, but still allow the sched_clock_update function to work.


> What I can't figure out is why this has suddenly started happening with
> 3.14. Any ideas?

No clue. I'm guessing something like timing changes in the printk paths
that call sched_clock?

I suspect your patch to move the print down will also be a good idea
along with the suspending sched_clock while we register new ones.

thanks
-john
