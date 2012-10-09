From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 9 Oct 2012 09:38:05 +0100
Subject: [PATCH 3/7] ARM: tegra30: cpuidle: add LP2 driver for secondary
 CPUs
In-Reply-To: <1349755995.15153.145.camel@jlo-ubuntu-64.nvidia.com>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
 <1349691981-31038-4-git-send-email-josephl@nvidia.com>
 <20121008163504.GC5377@e102568-lin.cambridge.arm.com>
 <1349755995.15153.145.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <20121009083804.GA11840@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 05:13:15AM +0100, Joseph Lo wrote:

[...]

> > > +ENTRY(tegra_flush_l1_cache)
> > > +       stmfd   sp!, {r4-r5, r7, r9-r11, lr}
> > > +       dmb                                     @ ensure ordering
> > > +
> > > +       /* Disable the data cache */
> > > +       mrc     p15, 0, r2, c1, c0, 0
> > > +       bic     r2, r2, #CR_C
> > > +       dsb
> > > +       mcr     p15, 0, r2, c1, c0, 0
> > > +
> > > +       /* Flush data cache */
> > > +       mov     r10, #0
> > > +#ifdef CONFIG_PREEMPT
> > > +       save_and_disable_irqs_notrace r9        @ make cssr&csidr read atomic
> > > +#endif
> > > +       mcr     p15, 2, r10, c0, c0, 0          @ select current cache level in cssr
> > > +       isb                                     @ isb to sych the new cssr&csidr
> > > +       mrc     p15, 1, r1, c0, c0, 0           @ read the new csidr
> > > +#ifdef CONFIG_PREEMPT
> > > +       restore_irqs_notrace r9
> > > +#endif
> > > +       and     r2, r1, #7                      @ extract the length of the cache lines
> > > +       add     r2, r2, #4                      @ add 4 (line length offset)
> > > +       ldr     r4, =0x3ff
> > > +       ands    r4, r4, r1, lsr #3              @ find maximum number on the way size
> > > +       clz     r5, r4                          @ find bit position of way size increment
> > > +       ldr     r7, =0x7fff
> > > +       ands    r7, r7, r1, lsr #13             @ extract max number of the index size
> > > +loop2:
> > > +       mov     r9, r4                          @ create working copy of max way size
> > > +loop3:
> > > +       orr     r11, r10, r9, lsl r5            @ factor way and cache number into r11
> > > +       orr     r11, r11, r7, lsl r2            @ factor index number into r11
> > > +       mcr     p15, 0, r11, c7, c14, 2         @ clean & invalidate by set/way
> > > +       subs    r9, r9, #1                      @ decrement the way
> > > +       bge     loop3
> > > +       subs    r7, r7, #1                      @ decrement the index
> > > +       bge     loop2
> > > +finished:
> > > +       mov     r10, #0                         @ swith back to cache level 0
> > > +       mcr     p15, 2, r10, c0, c0, 0          @ select current cache level in cssr 
> > > +       dsb
> > > +       isb
> > 
> > This code is already in the kernel in cache-v7.S, please use that.
> > We are just adding the new LoUIS API that probably does what you
> > want, even though for Tegra, that is an A9 based platform I fail to
> > understand why Level of Coherency differs from L1.
> > 
> > Can you explain to me please why Level of Coherency (LoC) is != from L1
> > on Tegra ?
> > 
> 
> Thanks for introducing the new LoUIS cache API. Did LoUIS been changed
> by other HW? I checked the new LoUIS API. If LoUIS == 0, it means inner
> shareable then it do nothing just return. But I need to flush L1 data
> cache here to sync the coherency before CPU be power gated. And disable
> data cache before flush is needed.

I understand that, that's why I am asking. To me LoUIS and LoC should
both be the same for A9 based platforms and they should both represent
a cache level that *includes* L1.

Can you provide me with the CLIDR value for Tegra3 please ?

> 
> I can tell you the sequence that why we just do L1 data cache flush
> here. Maybe I need to change the comment to "flush to point of
> coherency" not "level of coherency".
> 
> For secondary CPUs:
> * after cpu_suspend
> * disable data cache and flush L1 data cache
    ^(1)
> * Turn off SMP coherency
    ^(2)

Two steps above, one assembly function, no access to any data whatsoever
please.

> * power gate CPU
> 
> For CPU0:
> * outer_disable (flush and disable L2)

I guess L2 cannot be retained on Tegra ?

> * cpu_suspend
> * disable data cache and flush L1 data cache
> * Turn off SMP coherency
> * Turn off MMU
> * shut off the CPU rail
> 
> So we only do flush to PoC.
> 
> And changing the sequence of secondary CPUs to belows maybe more
> suitable?

Yes, basically because the net effect should be identical.

Lorenzo

> * after cpu_suspend
> * disable data cache and call to v7_flush_dcache_all
> * Turn off SMP coherency
> * power gate CPU
> 
