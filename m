From: amit.kachhap@linaro.org (amit kachhap)
Date: Tue, 13 Sep 2011 19:00:53 +0530
Subject: [patch] ARM: smpboot: Enable interrupts after marking CPU
	online/active
In-Reply-To: <20110908215314.829452535@linutronix.de>
References: <20110908215314.829452535@linutronix.de>
Message-ID: <CADGdYn6V_eQJZ4=irMbSS7XJj4MJVeALxcrWdD7o2bGs1sEJZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

This movement of set_cpu_online before percpu_timer_setup is usefull
for samsung exyno4 platforms where the external gic timer
initialisation needs the secondary cpu to be online.
In addition to your modifications the following changes fixes the race
condition crash happening when sched_mc configuration flags
(CONFIG_ARM_CPU_TOPOLOGY, CONFIG_SCHED_MC ,CONFIG_SCHED_SMT) are
enabled. Sched_mc patches are recently submitted by Vincent and
accepted by Russell.(https://lkml.org/lkml/2011/7/5/209). I have not
attached the crash log here. If needed i can do so.

---
 arch/arm/kernel/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 8cb94c8..04a8630 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -316,6 +316,7 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
         * interrupts otherwise a wakeup of a kernel thread affine to
         * this CPU might break the affinity and let hell break lose.
         */
+       smp_store_cpu_info(cpu);
        set_cpu_online(cpu, true);
        while (!cpu_active(cpu))
                cpu_relax();
@@ -330,7 +331,6 @@ asmlinkage void __cpuinit secondary_start_kernel(void)

        calibrate_delay();

-       smp_store_cpu_info(cpu);

        /*
         * OK, it's off to the idle thread for us

Thanks,
Amit Daniel


On Fri, Sep 9, 2011 at 3:27 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Frank Rowand reported:
>
> ?I have a consistent (every boot) hang on boot with the RT patches.
> ?With a few hacks to get console output, I get:
>
> ? rcu_preempt_state detected stalls on CPUs/tasks
>
> ?I have also replicated the problem on the ARM RealView (in tree) and
> ?without the RT patches.
>
> ?The problem ended up being caused by the allowed cpus mask being set
> ?to all possible cpus for the ksoftirqd on the secondary processors.
> ?So the RCU softirq was never executing on the secondary cpu.
>
> ?The problem was that ksoftirqd was woken on the secondary processors before
> ?the secondary processors were online. This led to allowed cpus being set
> ?to all cpus.
>
> ? ?wake_up_process()
> ? ? ? try_to_wake_up()
> ? ? ? ? ?select_task_rq()
> ? ? ? ? ? ? if (... || !cpu_online(cpu))
> ? ? ? ? ? ? ? ?select_fallback_rq(task_cpu(p), p)
> ? ? ? ? ? ? ? ? ? ...
> ? ? ? ? ? ? ? ? ? /* No more Mr. Nice Guy. */
> ? ? ? ? ? ? ? ? ? dest_cpu = cpuset_cpus_allowed_fallback(p)
> ? ? ? ? ? ? ? ? ? ? ?do_set_cpus_allowed(p, cpu_possible_mask)
> ? ? ? ? ? ? ? ? ? ? ? ? # ?Thus ksoftirqd can now run on any cpu...
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
> Reported-and-tested-by: Frank Rowand <frank.rowand@am.sony.com>
> Link: http://lkml.kernel.org/r/alpine.LFD.2.02.1109071115410.2723 at ionos
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> ?arch/arm/kernel/smp.c | ? 21 ++++++++++++---------
> ?1 file changed, 12 insertions(+), 9 deletions(-)
>
> Index: linux-2.6/arch/arm/kernel/smp.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/kernel/smp.c
> +++ linux-2.6/arch/arm/kernel/smp.c
> @@ -305,6 +305,18 @@ asmlinkage void __cpuinit secondary_star
> ? ? ? ? * Enable local interrupts.
> ? ? ? ? */
> ? ? ? ?notify_cpu_starting(cpu);
> +
> + ? ? ? /*
> + ? ? ? ?* OK, now it's safe to let the boot CPU continue. ?Wait for
> + ? ? ? ?* the CPU migration code to notice that the CPU is online
> + ? ? ? ?* before we continue. We need to do that before we enable
> + ? ? ? ?* interrupts otherwise a wakeup of a kernel thread affine to
> + ? ? ? ?* this CPU might break the affinity and let hell break lose.
> + ? ? ? ?*/
> + ? ? ? set_cpu_online(cpu, true);
> + ? ? ? while (!cpu_active(cpu))
> + ? ? ? ? ? ? ? cpu_relax();
> +
> ? ? ? ?local_irq_enable();
> ? ? ? ?local_fiq_enable();
>
> @@ -318,15 +330,6 @@ asmlinkage void __cpuinit secondary_star
> ? ? ? ?smp_store_cpu_info(cpu);
>
> ? ? ? ?/*
> - ? ? ? ?* OK, now it's safe to let the boot CPU continue. ?Wait for
> - ? ? ? ?* the CPU migration code to notice that the CPU is online
> - ? ? ? ?* before we continue.
> - ? ? ? ?*/
> - ? ? ? set_cpu_online(cpu, true);
> - ? ? ? while (!cpu_active(cpu))
> - ? ? ? ? ? ? ? cpu_relax();
> -
> - ? ? ? /*
> ? ? ? ? * OK, it's off to the idle thread for us
> ? ? ? ? */
> ? ? ? ?cpu_idle();
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
