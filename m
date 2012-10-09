From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 9 Oct 2012 12:13:15 +0800
Subject: [PATCH 3/7] ARM: tegra30: cpuidle: add LP2 driver for
 secondary CPUs
In-Reply-To: <20121008163504.GC5377@e102568-lin.cambridge.arm.com>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
 <1349691981-31038-4-git-send-email-josephl@nvidia.com>
 <20121008163504.GC5377@e102568-lin.cambridge.arm.com>
Message-ID: <1349755995.15153.145.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

Thanks for your review.

On Tue, 2012-10-09 at 00:35 +0800, Lorenzo Pieralisi wrote:
> On Mon, Oct 08, 2012 at 11:26:17AM +0100, Joseph Lo wrote:
> > This supports power-gated (LP2) idle on secondary CPUs for Tegra30.
> > The secondary CPUs can go into LP2 state independently. When CPU goes
> > into LP2 state, it saves it's state and puts itself to flow controlled
> > WFI state. After that, it will been power gated.
> > 
> > Based on the work by:
> > Scott Williams <scwilliams@nvidia.com>
> > 
> > Signed-off-by: Joseph Lo <josephl@nvidia.com>
> > ---
...
> > +#ifdef CONFIG_PM_SLEEP
> > +static bool tegra30_idle_enter_lp2_cpu_n(struct cpuidle_device *dev,
> > +                                        struct cpuidle_driver *drv,
> > +                                        int index)
> > +{
> > +#ifdef CONFIG_SMP
> > +       clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
> > +
> > +       smp_wmb();
> > +
> > +       save_cpu_arch_register();
> > +
> > +       cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
> > +
> > +       restore_cpu_arch_register();
> > +
> > +       clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
> > +#endif
> 
> Can't you factor out this #ifdef out using an inline function ?
> 
OK. Will do.

> > +
> > +       return true;
> > +}
> > +
> > +static int __cpuinit tegra30_idle_lp2(struct cpuidle_device *dev,
> > +                                     struct cpuidle_driver *drv,
> > +                                     int index)
> > +{
> > +       bool entered_lp2 = false;
> > +
> > +       local_fiq_disable();
> > +
> > +       tegra_set_cpu_in_lp2(dev->cpu);
> > +       cpu_pm_enter();
> > +
> > +       if (dev->cpu == 0)
> 
> Logical cpu 0 ? Or you need a HW cpu 0 check here ? If you boot on a CPU
> that is different from HW CPU 0 (do not know if that's possible) you
> might have a problem.
> 
> [...]
> 
For Tegra20 & Tegra30, it's always physical CPU 0 here. And the CPU0 was
always the first boot CPU. I will change to

cpu = cpu_logical_map(dev->cpu);

Thanks for your remind.

> > +bool __cpuinit tegra_set_cpu_in_lp2(int cpu)
> > +{
> > +       bool last_cpu = false;
> > +
> > +       spin_lock(&tegra_lp2_lock);
> > +       BUG_ON(cpumask_test_cpu(cpu, &tegra_in_lp2));
> > +       cpumask_set_cpu(cpu, &tegra_in_lp2);
> > +
> > +       /*
> > +        * Update the IRAM copy used by the reset handler. The IRAM copy
> > +        * can't use used directly by cpumask_set_cpu() because it uses
> > +        * LDREX/STREX which requires the addressed location to be inner
> > +        * cacheable and sharable which IRAM isn't.
> > +        */
> > +       writel(tegra_in_lp2.bits[0], tegra_cpu_lp2_mask);
> > +       dsb();
> > +
> > +       if ((cpu == 0) && cpumask_equal(&tegra_in_lp2, cpu_online_mask))
> > +               last_cpu = true;
> 
> For cpu == 0, see above.
> 
> [...]
> 
Will use cpu_logical_map to get the physical CPU first, thanks.

> > +ENTRY(tegra_flush_l1_cache)
> > +       stmfd   sp!, {r4-r5, r7, r9-r11, lr}
> > +       dmb                                     @ ensure ordering
> > +
> > +       /* Disable the data cache */
> > +       mrc     p15, 0, r2, c1, c0, 0
> > +       bic     r2, r2, #CR_C
> > +       dsb
> > +       mcr     p15, 0, r2, c1, c0, 0
> > +
> > +       /* Flush data cache */
> > +       mov     r10, #0
> > +#ifdef CONFIG_PREEMPT
> > +       save_and_disable_irqs_notrace r9        @ make cssr&csidr read atomic
> > +#endif
> > +       mcr     p15, 2, r10, c0, c0, 0          @ select current cache level in cssr
> > +       isb                                     @ isb to sych the new cssr&csidr
> > +       mrc     p15, 1, r1, c0, c0, 0           @ read the new csidr
> > +#ifdef CONFIG_PREEMPT
> > +       restore_irqs_notrace r9
> > +#endif
> > +       and     r2, r1, #7                      @ extract the length of the cache lines
> > +       add     r2, r2, #4                      @ add 4 (line length offset)
> > +       ldr     r4, =0x3ff
> > +       ands    r4, r4, r1, lsr #3              @ find maximum number on the way size
> > +       clz     r5, r4                          @ find bit position of way size increment
> > +       ldr     r7, =0x7fff
> > +       ands    r7, r7, r1, lsr #13             @ extract max number of the index size
> > +loop2:
> > +       mov     r9, r4                          @ create working copy of max way size
> > +loop3:
> > +       orr     r11, r10, r9, lsl r5            @ factor way and cache number into r11
> > +       orr     r11, r11, r7, lsl r2            @ factor index number into r11
> > +       mcr     p15, 0, r11, c7, c14, 2         @ clean & invalidate by set/way
> > +       subs    r9, r9, #1                      @ decrement the way
> > +       bge     loop3
> > +       subs    r7, r7, #1                      @ decrement the index
> > +       bge     loop2
> > +finished:
> > +       mov     r10, #0                         @ swith back to cache level 0
> > +       mcr     p15, 2, r10, c0, c0, 0          @ select current cache level in cssr 
> > +       dsb
> > +       isb
> 
> This code is already in the kernel in cache-v7.S, please use that.
> We are just adding the new LoUIS API that probably does what you
> want, even though for Tegra, that is an A9 based platform I fail to
> understand why Level of Coherency differs from L1.
> 
> Can you explain to me please why Level of Coherency (LoC) is != from L1
> on Tegra ?
> 

Thanks for introducing the new LoUIS cache API. Did LoUIS been changed
by other HW? I checked the new LoUIS API. If LoUIS == 0, it means inner
shareable then it do nothing just return. But I need to flush L1 data
cache here to sync the coherency before CPU be power gated. And disable
data cache before flush is needed.

I can tell you the sequence that why we just do L1 data cache flush
here. Maybe I need to change the comment to "flush to point of
coherency" not "level of coherency".

For secondary CPUs:
* after cpu_suspend
* disable data cache and flush L1 data cache
* Turn off SMP coherency
* power gate CPU

For CPU0:
* outer_disable (flush and disable L2)
* cpu_suspend
* disable data cache and flush L1 data cache
* Turn off SMP coherency
* Turn off MMU
* shut off the CPU rail

So we only do flush to PoC.

And changing the sequence of secondary CPUs to belows maybe more
suitable?
* after cpu_suspend
* disable data cache and call to v7_flush_dcache_all
* Turn off SMP coherency
* power gate CPU

How do you think?

Thanks,
Joseph
