From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 9 Oct 2012 10:42:16 +0100
Subject: [PATCH 3/7] ARM: tegra30: cpuidle: add LP2 driver for secondary
 CPUs
In-Reply-To: <1349774337.16173.8.camel@jlo-ubuntu-64.nvidia.com>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
 <1349691981-31038-4-git-send-email-josephl@nvidia.com>
 <20121008163504.GC5377@e102568-lin.cambridge.arm.com>
 <1349755995.15153.145.camel@jlo-ubuntu-64.nvidia.com>
 <20121009083804.GA11840@e102568-lin.cambridge.arm.com>
 <1349774337.16173.8.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <20121009094215.GC11840@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 10:18:57AM +0100, Joseph Lo wrote:
> On Tue, 2012-10-09 at 16:38 +0800, Lorenzo Pieralisi wrote:
> > On Tue, Oct 09, 2012 at 05:13:15AM +0100, Joseph Lo wrote:
> > 
> > [...]
> > 
> > > > > +ENTRY(tegra_flush_l1_cache)
> > > > > +       stmfd   sp!, {r4-r5, r7, r9-r11, lr}
> > > > > +       dmb                                     @ ensure ordering
> > > > > +
> > > > > +       /* Disable the data cache */
> > > > > +       mrc     p15, 0, r2, c1, c0, 0
> > > > > +       bic     r2, r2, #CR_C
> > > > > +       dsb
> > > > > +       mcr     p15, 0, r2, c1, c0, 0
> > > > > +
> > > > > +       /* Flush data cache */
> > > > > +       mov     r10, #0
> > > > > +#ifdef CONFIG_PREEMPT
> > > > > +       save_and_disable_irqs_notrace r9        @ make cssr&csidr read atomic
> > > > > +#endif
> > > > > +       mcr     p15, 2, r10, c0, c0, 0          @ select current cache level in cssr
> > > > > +       isb                                     @ isb to sych the new cssr&csidr
> > > > > +       mrc     p15, 1, r1, c0, c0, 0           @ read the new csidr
> > > > > +#ifdef CONFIG_PREEMPT
> > > > > +       restore_irqs_notrace r9
> > > > > +#endif
> > > > > +       and     r2, r1, #7                      @ extract the length of the cache lines
> > > > > +       add     r2, r2, #4                      @ add 4 (line length offset)
> > > > > +       ldr     r4, =0x3ff
> > > > > +       ands    r4, r4, r1, lsr #3              @ find maximum number on the way size
> > > > > +       clz     r5, r4                          @ find bit position of way size increment
> > > > > +       ldr     r7, =0x7fff
> > > > > +       ands    r7, r7, r1, lsr #13             @ extract max number of the index size
> > > > > +loop2:
> > > > > +       mov     r9, r4                          @ create working copy of max way size
> > > > > +loop3:
> > > > > +       orr     r11, r10, r9, lsl r5            @ factor way and cache number into r11
> > > > > +       orr     r11, r11, r7, lsl r2            @ factor index number into r11
> > > > > +       mcr     p15, 0, r11, c7, c14, 2         @ clean & invalidate by set/way
> > > > > +       subs    r9, r9, #1                      @ decrement the way
> > > > > +       bge     loop3
> > > > > +       subs    r7, r7, #1                      @ decrement the index
> > > > > +       bge     loop2
> > > > > +finished:
> > > > > +       mov     r10, #0                         @ swith back to cache level 0
> > > > > +       mcr     p15, 2, r10, c0, c0, 0          @ select current cache level in cssr 
> > > > > +       dsb
> > > > > +       isb
> > > > 
> > > > This code is already in the kernel in cache-v7.S, please use that.
> > > > We are just adding the new LoUIS API that probably does what you
> > > > want, even though for Tegra, that is an A9 based platform I fail to
> > > > understand why Level of Coherency differs from L1.
> > > > 
> > > > Can you explain to me please why Level of Coherency (LoC) is != from L1
> > > > on Tegra ?
> > > > 
> > > 
> > > Thanks for introducing the new LoUIS cache API. Did LoUIS been changed
> > > by other HW? I checked the new LoUIS API. If LoUIS == 0, it means inner
> > > shareable then it do nothing just return. But I need to flush L1 data
> > > cache here to sync the coherency before CPU be power gated. And disable
> > > data cache before flush is needed.
> > 
> > I understand that, that's why I am asking. To me LoUIS and LoC should
> > both be the same for A9 based platforms and they should both represent
> > a cache level that *includes* L1.
> > 
> > Can you provide me with the CLIDR value for Tegra3 please ?
> > 
> 
> I just checked the CLIDR of both Tegra20 and Tegra30. It's 0x09200003.
> It looks I can use this new LoUIS api, right? :)

You do not have to, since LoUIS == LoC, but that would be appreciated.

If you execute:

v7_flush_dcache_all

That would do the same thing on current Tegra(s).

If you want to reuse the same code for future A15/A7 processors then yes,

v7_flush_dcache_louis

is what you want to call, and that works for current Tegra(s) as well since,
as I mentioned LoUIS == LoC there.

Overall, using the new LoUIS API for single core shutdown is the best
option, since it should work for current and future cores.

Thanks,
Lorenzo
