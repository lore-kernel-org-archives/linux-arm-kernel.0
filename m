From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 14 Oct 2013 16:06:46 +0100
Subject: [PATCH v2 11/12] cpuidle: mvebu: Add initial CPU idle support
 for Armada 370/XP SoC
In-Reply-To: <525BFC34.6020300@free-electrons.com>
References: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
 <1379066801-16276-12-git-send-email-gregory.clement@free-electrons.com>
 <20130913161654.GA5408@e102568-lin.cambridge.arm.com>
 <525BFC34.6020300@free-electrons.com>
Message-ID: <20131014150646.GC9996@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

[CC'ed Nico for the cache cleaning inline asm macros]

On Mon, Oct 14, 2013 at 03:14:12PM +0100, Gregory CLEMENT wrote:

[...]

> >> +ENTRY(armada_370_xp_cpu_suspend)
> >> +/* Save ARM registers */
> >> +       stmfd   sp!, {r4 - r11, lr}     @ save registers on stack
> >> +
> >> +       bl armada_370_xp_pmsu_idle_prepare
> >> +       /*
> >> +        * Invalidate L1 data cache. Even though only invalidate is
> >> +        * necessary exported flush API is used here. Doing clean
> >> +        * on already clean cache would be almost NOP.
> >> +        */
> >> +       bl v7_flush_dcache_all
> >> +
> >> +       /*
> >> +        * Clear the SCTLR.C bit to prevent further data cache
> >> +        * allocation. Clearing SCTLR.C would make all the data accesses
> >> +        * strongly ordered and would not hit the cache.
> >> +        */
> >> +       mrc     p15, 0, r0, c1, c0, 0
> >> +       bic     r0, r0, #(1 << 2)       @ Disable the C bit
> >> +       mcr     p15, 0, r0, c1, c0, 0
> >> +       isb
> >> +
> >> +       bl v7_flush_dcache_all
> >> +
> > 
> > This code looks familiar and the first cache flush is not needed.
> > 
> > look at arch/arm/mach-vexpress/tc2_pm.c -> tc2_pm_down()
> > 
> > I know that probably the SMP bit in ACTLR is managed differently in this
> > architecture but still, cache flushing should still apply and the TC2
> > sequence is the proper one, unless you explain to me why that does not
> > work on this chipset.
> 
> Here we follow the advices you gave in your presentation at Linaro Connect
> Q2-2012: "Idling ARMs in a Busy World: Linux Power Management for ARM
> multi-cluster systems"
> http://www.linaro.org/documents/download/84a5990d6f227c90e3d3a3ad2af0e22c4fd1d0bd4a6c7
> at p21.
> 
> Quoting the author of the original version od the code :
> "Since the second flush is almost NOPs, I preferred to keep them both in the same sequence."
>

This code comes from arch/arm/mach-omap2/sleep44xx.S

First flush is not necessary and should be removed, from here and from
the file above as well; the proper sequence is in:

arch/arm/mach-vexpress/tc2_pm.c

(which is described in the presentation link you provided)

and Nico also managed to write inline assembly macros that are meant
to be upstreamed soon to carry out the cache cleaning ops you need
here.

I understand that the second clean is _almost_ NOPs, but that's no good
reason to write the sequence this way. I will repeat myself: first flush
is not necessary and as such should be removed.

> > 
> >> +       /* Data memory barrier and Data sync barrier */
> >> +       dsb
> >> +       dmb
> >> +
> >> +       bl armada_370_xp_disable_snoop_ena
> >> +
> >> +       dsb                             @ Data Synchronization Barrier
> >> +
> >> +/*
> >> + * ===================================
> >> + * == WFI instruction => Enter idle ==
> >> + * ===================================
> >> + */
> >> +
> >> +       wfi                             @ wait for interrupt
> > 
> > Here core is running out of coherency and I do not see any tlb invalidation in
> > the resume path from non-OFF mode. Please can you elaborate on this ?
> > 
> 
> The TLB invalidation should take place in /arch/arm/kernel/suspend.c  cpu_suspend( )
> in case the return value is 0 caused by cpu_suspend_abort.
> Did we missed something?

Yes, you did, cpu_suspend_abort returns 1 (ie failure), so no tlb invalidation
is carried out in cpu_suspend(); tlbs are invalidated only when core resumes
through cpu_resume. I do not have details of the coherent interconnect used
in this board/chip, but if the power down procedure fails and the core has
run outside coherency in the idle thread, tlbs must be invalidated.

> > I have further comments on the set (in particular on the inner workings
> > of coherency and how CPUs get in and out of idle - ie how this is
> > managed by the power controller) but I will keep them for next version,
> > when the first set of review comments is addressed.
> > 
> 
> You can make your comments on the last version I have just sent.

Ok, cheers.

> Thanks for your review

Thank you,
Lorenzo
