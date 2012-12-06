From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 6 Dec 2012 16:25:22 +0800
Subject: [PATCH V2 2/6] ARM: tegra20: cpuidle: add powered-down state
 for secondary CPU
In-Reply-To: <20121205105010.GA12999@e102568-lin.cambridge.arm.com>
References: <1354701715-24150-1-git-send-email-josephl@nvidia.com>
 <1354701715-24150-3-git-send-email-josephl@nvidia.com>
 <20121205105010.GA12999@e102568-lin.cambridge.arm.com>
Message-ID: <1354782322.13857.78.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-12-05 at 18:50 +0800, Lorenzo Pieralisi wrote:
> On Wed, Dec 05, 2012 at 10:01:49AM +0000, Joseph Lo wrote:
> >  static struct cpuidle_driver tegra_idle_driver = {
> >         .name = "tegra_idle",
> >         .owner = THIS_MODULE,
> >         .en_core_tk_irqen = 1,
> > +#ifdef CONFIG_PM_SLEEP
> > +       .state_count = 2,
> > +#else
> >         .state_count = 1,
> > +#endif
> 
> These hardcoded values are not nice.
> 
OK. I will change it to runtime detection when idle driver registration.

> >         .states = {
> >                 [0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
> > +#ifdef CONFIG_PM_SLEEP
> > +               [1] = {
> > +                       .enter                  = tegra20_idle_lp2,
> > +                       .exit_latency           = 5000,
> > +                       .target_residency       = 10000,
> > +                       .power_usage            = 0,
> > +                       .flags                  = CPUIDLE_FLAG_TIME_VALID,
> > +                       .name                   = "powered-down",
> > +                       .desc                   = "CPU power gated",
> > +               },
> > +#endif
> >         },
> >  };
> >
> >  static DEFINE_PER_CPU(struct cpuidle_device, tegra_idle_device);
> >
> > +#ifdef CONFIG_PM_SLEEP
> > +#ifdef CONFIG_SMP
> > +static bool tegra20_idle_enter_lp2_cpu_1(struct cpuidle_device *dev,
> > +                                        struct cpuidle_driver *drv,
> > +                                        int index)
> > +{
> > +       clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
> > +
> > +       smp_wmb();
> 
> Can you explain to me the need for this barrier ?
> 
Ah. The barrier was no need here. This function was been designed for
MPCore usage before. After some migrations, now it was be used for CPU1
only. Will remove it. Good catch here, thanks.

> > +
> > +       cpu_suspend(0, tegra20_sleep_cpu_secondary_finish);
> > +
> > +       tegra20_cpu_clear_resettable();
> > +
> > +       clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
> > +
> > +       return true;
> > +}
> > +#ifdef CONFIG_PM_SLEEP
> > +/*
> > + * tegra_pen_lock
> > + *
> > + * spinlock implementation with no atomic test-and-set and no coherence
> > + * using Peterson's algorithm on strongly-ordered registers
> > + * used to synchronize a cpu waking up from wfi with entering lp2 on idle
> > + *
> > + * SCRATCH37 = r1 = !turn (inverted from Peterson's algorithm)
> > + * on cpu 0:
> > + * SCRATCH38 = r2 = flag[0]
> > + * SCRATCH39 = r3 = flag[1]
> > + * on cpu1:
> > + * SCRATCH39 = r2 = flag[1]
> > + * SCRATCH38 = r3 = flag[0]
> > + *
> > + * must be called with MMU on
> > + * corrupts r0-r3, r12
> > + */
> > +ENTRY(tegra_pen_lock)
> > +       mov32   r3, TEGRA_PMC_VIRT
> > +       cpu_id  r0
> > +       add     r1, r3, #PMC_SCRATCH37
> > +       cmp     r0, #0
> > +       addeq   r2, r3, #PMC_SCRATCH38
> > +       addeq   r3, r3, #PMC_SCRATCH39
> > +       addne   r2, r3, #PMC_SCRATCH39
> > +       addne   r3, r3, #PMC_SCRATCH38
> > +
> > +       mov     r12, #1
> > +       str     r12, [r2]               @ flag[cpu] = 1
> > +       dsb
> > +       str     r12, [r1]               @ !turn = cpu
> > +1:     dsb
> > +       ldr     r12, [r3]
> > +       cmp     r12, #1                 @ flag[!cpu] == 1?
> > +       ldreq   r12, [r1]
> > +       cmpeq   r12, r0                 @ !turn == cpu?
> > +       beq     1b                      @ while !turn == cpu && flag[!cpu] == 1
> > +
> > +       mov     pc, lr                  @ locked
> > +ENDPROC(tegra_pen_lock)
> > +
> > +ENTRY(tegra_pen_unlock)
> > +       dsb
> > +       mov32   r3, TEGRA_PMC_VIRT
> > +       cpu_id  r0
> > +       cmp     r0, #0
> > +       addeq   r2, r3, #PMC_SCRATCH38
> > +       addne   r2, r3, #PMC_SCRATCH39
> > +       mov     r12, #0
> > +       str     r12, [r2]
> > +       mov     pc, lr
> > +ENDPROC(tegra_pen_unlock)
> 
> There is an ongoing work to make this locking scheme for MMU/coherency off
> paths ARM generic, and we do not want to merge yet another platform specific
> locking mechanism. I will point you to the patchset when it hits LAK.
> 
OK. So I need to wait the common locking scheme for this patchset. Does
it possible available before K3.9? Please remind me when it show up
here. Thanks.

> > +/*
> > + * tegra20_sleep_cpu_secondary_finish(unsigned long v2p)
> > + *
> > + * Enters WFI on secondary CPU by exiting coherency.
> > + */
> > +ENTRY(tegra20_sleep_cpu_secondary_finish)
> > +       mrc     p15, 0, r11, c1, c0, 1  @ save actlr before exiting coherency
> > +
> > +       /* Flush and disable the L1 data cache */
> > +       bl      tegra_disable_clean_inv_dcache
> > +
> > +       mov32   r0, TEGRA_PMC_VIRT + PMC_SCRATCH41
> > +       mov     r3, #CPU_RESETTABLE
> > +       str     r3, [r0]
> > +
> > +       bl      cpu_do_idle
> > +
> > +       /*
> > +        * cpu may be reset while in wfi, which will return through
> > +        * tegra_resume to cpu_resume
> > +        * or interrupt may wake wfi, which will return here
> > +        * cpu state is unchanged - MMU is on, cache is on, coherency
> > +        * is off, and the data cache is off
> > +        *
> > +        * r11 contains the original actlr
> > +        */
> > +
> > +       bl      tegra_pen_lock
> > +
> > +       mov32   r3, TEGRA_PMC_VIRT
> > +       add     r0, r3, #PMC_SCRATCH41
> > +       mov     r3, #CPU_NOT_RESETTABLE
> > +       str     r3, [r0]
> > +
> > +       bl      tegra_pen_unlock
> > +
> > +       /* Re-enable the data cache */
> > +       mrc     p15, 0, r10, c1, c0, 0
> > +       orr     r10, r10, #CR_C
> > +       mcr     p15, 0, r10, c1, c0, 0
> > +       isb
> > +
> > +       mcr     p15, 0, r11, c1, c0, 1  @ reenable coherency
> > +
> > +       /* Invalidate the TLBs & BTAC */
> > +       mov     r1, #0
> > +       mcr     p15, 0, r1, c8, c3, 0   @ invalidate shared TLBs
> > +       mcr     p15, 0, r1, c7, c1, 6   @ invalidate shared BTAC
> > +       dsb
> > +       isb
> > +
> > +       /* the cpu was running with coherency disabled,
> > +        * caches may be out of date */
> > +       bl      v7_flush_kern_cache_louis
> > +
> > +       ldmia   sp!, {r1 - r3}          @ pop phys pgd, virt SP, phys resume fn
> > +       mov     r0, #0                  @ return success
> > +       mov     sp, r2                  @ sp is stored in r2 by __cpu_suspend
> 
> This is not true. sp is retrieved from the r2 value popped above.
> Anyway, all this code is a copy'n'paste from __cpu_suspend. Now if I got
> what you want to do right, all you want to do is return to cpu_suspend
> with r0 == 0.
> 
> (1) You should not rely on the register layout of __cpu_suspend since if
>     it changes we have to patch this code as well. Do not rely on that.
> (2) Why do you want to return with r0 == 0 ? To me that's a mistery.
>     Is that because you want cpu_suspend to restore the page table
>     pointer ? Even in that case I am afraid I am against this code.
>     Usage of cpu_suspend must be consistent and you *must* not use it as a
>     plaster or rely on any specific register layout, it has to be used
>     for the purpose it has been designed for.
> 
Thank you for reviewing this so carefully.
I re-traced the sequence today. I think I only need to do something
below. And rely on the "cpu_suspend_abort" in "__cpu_suspend" to abort
"cpu_suspend".

ENTRY(tegra20_sleep_cpu_secondary_finish)
	stmfd sp!, {r4-r11, lr}

	...

	ldmfd sp!, {r4-r11, pc}
ENDPROC(tegra20_sleep_cpu_secondary_finish)

Thanks,
Joseph
