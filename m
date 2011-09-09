From: santosh.shilimkar@ti.com (Santosh)
Date: Fri, 09 Sep 2011 09:47:07 +0530
Subject: [patch] ARM: smpboot: Enable interrupts after marking CPU
	online/active
In-Reply-To: <20110908215314.829452535@linutronix.de>
References: <20110908215314.829452535@linutronix.de>
Message-ID: <4E699343.7030505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 September 2011 03:27 AM, Thomas Gleixner wrote:
> Frank Rowand reported:
>
>   I have a consistent (every boot) hang on boot with the RT patches.
>   With a few hacks to get console output, I get:
>
>     rcu_preempt_state detected stalls on CPUs/tasks
>
>   I have also replicated the problem on the ARM RealView (in tree) and
>   without the RT patches.
>
>   The problem ended up being caused by the allowed cpus mask being set
>   to all possible cpus for the ksoftirqd on the secondary processors.
>   So the RCU softirq was never executing on the secondary cpu.
>
>   The problem was that ksoftirqd was woken on the secondary processors before
>   the secondary processors were online. This led to allowed cpus being set
>   to all cpus.
>
>      wake_up_process()
>         try_to_wake_up()
>            select_task_rq()
>               if (... || !cpu_online(cpu))
>                  select_fallback_rq(task_cpu(p), p)
>                     ...
>                     /* No more Mr. Nice Guy. */
>                     dest_cpu = cpuset_cpus_allowed_fallback(p)
>                        do_set_cpus_allowed(p, cpu_possible_mask)
>                           #  Thus ksoftirqd can now run on any cpu...
> </report>
>
> The reason is that the ARM SMP boot code for the secondary CPUs enables
> interrupts before the newly brought up CPU is marked online and
> active.
>
> That causes a wakeup of ksoftirqd or a wakeup of any other kernel
> thread which is affine to the brought up CPU break that threads
> affinity and therefor being scheduled on already online CPUs.
>
> This problem has been observed on x86 before and the only solution is
> to mark the CPU online and wait for the CPU active bit before the
> point where interrupts are enabled.
>
> This is safe as the percpu timer setup and the calibration code are
> not part of the critical setup path and the calibration code needs to
> have interrupts enabled anyway. We cannot schedule away at this point
> because we are still in the preempt disabled region which is released
> in cpu_idle().
>
> Reported-and-tested-by: Frank Rowand<frank.rowand@am.sony.com>
> Link:http://lkml.kernel.org/r/alpine.LFD.2.02.1109071115410.2723 at ionos
> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>

A while back, while debugging a CPU ONLINE issue, I cooked up the
similar patch based on the above race condition.

https://lkml.org/lkml/2011/6/20/79

But the issue I was facing was slightly different and that got sorted
out with fixing the re-calibration code.

Good to see that we have a test case which proves the race conditions,
I was describing.

Regards
Santosh
