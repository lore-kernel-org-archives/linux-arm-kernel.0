From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 31 May 2012 11:00:17 +0800
Subject: Query about: ARM11 MPCore: preemption/task migration cache
 coherency
In-Reply-To: <4FC5F017.4050202@gmail.com>
References: <4FAA34A9.5020708@gmail.com>
 <20120511085150.GA17453@mudshark.cambridge.arm.com>
 <4FC45E6B.2070202@gmail.com>
 <20120530063858.GB6484@mudshark.cambridge.arm.com>
 <4FC5F017.4050202@gmail.com>
Message-ID: <20120531030016.GB29372@mbp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 30, 2012 at 11:01:59AM +0100, bill4carson wrote:
> On 2012?05?30? 14:38, Will Deacon wrote:
> > On Tue, May 29, 2012 at 06:28:11AM +0100, bill4carson wrote:
> >> --- a/arch/arm/mm/cache-v6.S
> >> +++ b/arch/arm/mm/cache-v6.S
> >> @@ -170,6 +170,10 @@ ENDPROC(v6_coherent_kern_range)
> >>    ENTRY(v6_flush_kern_dcache_area)
> >>           add     r1, r0, r1
> >>    1:
> >> +#ifdef CONFIG_SMP
> >> +       ldr     r2, [r0]                        @ read for ownership
> >> +       str     r2, [r0]                        @ write for ownership
> >> +#endif /* CONFIG_SMP */
> >>    #ifdef HARVARD_CACHE
> >>           mcr     p15, 0, r0, c7, c14, 1          @ clean&  invalidate D line
> >>    #else
> >
> > I don't think the invalidation is needed here, so you probably don't need to
> > hack this function at all.
...
> 1. task t runs on CPU 0, it executes one program in nand flash,
>     so first task t read *part* of this program into its local Dcache,
>     let's call it part_a;
> 
> 2. task t migrates from CPU0 onto CPU1, in there reads the rest of
>     program into its local Dcache, label it part_b;
> 
> 3. on CPU1, task t flush the whole address range of this program,
>     As with ARM11 MPCore, this flush is locally effective, after flush
>     part_a still resides in CPU0 L1 Dcache.
> 
> 4. When this program gets executed, CPU 1 fetch its instructions from
>     Icache, SCU will notice this action,
> 
>     Question:
>     At this point, is stale part_a in main memory *or* L1 Dcache part_a
>     in CPU0 routed into CPU1 as instruction?

This has been discussed in the past. The first thing is to disable
CONFIG_PREEMPT to make sure you are not preempted between page copying
and task execution. The code doing the page copy needs to call
flush_dcache_page() on the CPU where the copy occurred and Linux does a
non-lazy D-cache flush. But there are many situations where Linux
doesn't do this (you can google for flush_dcache_page and my name to
find a few places where I tried to fix this).

AFAIK, The SCU only snoops the D-cache, not the I-cache. We have a full
I-cache invalidation during task migration.

-- 
Catalin
