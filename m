From: jpihet@mvista.com (Jean Pihet)
Date: Mon, 14 Dec 2009 17:57:42 +0100
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <20091214163312.GJ4141@wear.picochip.com>
References: <1260799481-29951-1-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-2-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-3-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-4-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-5-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-6-git-send-email-jamie.iles@picochip.com>
	<1260807177.8106.50.camel@def-laptop>
	<20091214163312.GJ4141@wear.picochip.com>
Message-ID: <1260809862.8106.53.camel@def-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

On Mon, 2009-12-14 at 16:33 +0000, Jamie Iles wrote:
> Hi Jean,
> 
> On Mon, Dec 14, 2009 at 05:12:57PM +0100, Jean Pihet wrote:
> > I have a question about other ARM implementations. Since all the code is
> > in perf_event.c is it modular enough to allow the addition of other ARM
> > implementations? The remarks are inlined below.
> > 
> > I am interested in supporting perf events for ARMv7. What do you think?
> It should be possible, and not too difficult. The x86 perf events code
> (arch/x86/kernel/cpu/perf_events.c) does exactly this. We would need to define
> an arm_pmu structure that wraps up a 'struct pmu' and provides hooks for the
> architecture specific call.
Ok I see. Let's have a generic code for ARM, then add the ARMv7 support
(including variations depending on the Cortex chip in use).

...
> > I have a generic question here: will #ifdef be needed to allow other ARM
> > implementations (e.g. ARMv7)? Is it worth to do it that way or to
> > duplicate this file for other ARM implementations?
> We can probably do it without preprocessor magic as long as the coprocessor
> instructions for the v6 counters still assemble under v7. We can do it all at
> runtime like in the x86 code and return the correct pmu from
> hw_perf_event_init().
Agree.

> > 
> > > --- /dev/null
> > > +++ b/arch/arm/kernel/perf_event.c
> > > @@ -0,0 +1,1034 @@
> > > +#undef DEBUG
> > > +
> > > +/*
> > > + * ARMv6 performance counter support.
> > ARMv6 only?
> Yes, at the moment ;-)
> 
> [snip]
> > > +enum arm_perf_types {
> > > +	ARM_PERFCTR_ICACHE_MISS		= 0x0,
> > > +	ARM_PERFCTR_IBUF_STALL		= 0x1,
> > > +	ARM_PERFCTR_DDEP_STALL		= 0x2,
> > > +	ARM_PERFCTR_ITLB_MISS		= 0x3,
> > > +	ARM_PERFCTR_DTLB_MISS		= 0x4,
> > > +	ARM_PERFCTR_BR_EXEC		= 0x5,
> > > +	ARM_PERFCTR_BR_MISPREDICT	= 0x6,
> > > +	ARM_PERFCTR_INSTR_EXEC		= 0x7,
> > > +	ARM_PERFCTR_DCACHE_HIT		= 0x9,
> > > +	ARM_PERFCTR_DCACHE_ACCESS	= 0xA,
> > > +	ARM_PERFCTR_DCACHE_MISS		= 0xB,
> > > +	ARM_PERFCTR_DCACHE_WBACK	= 0xC,
> > > +	ARM_PERFCTR_SW_PC_CHANGE	= 0xD,
> > > +	ARM_PERFCTR_MAIN_TLB_MISS	= 0xF,
> > > +	ARM_PERFCTR_EXPL_D_ACCESS	= 0x10,
> > > +	ARM_PERFCTR_LSU_FULL_STALL	= 0x11,
> > > +	ARM_PERFCTR_WBUF_DRAINED	= 0x12,
> > > +	ARM_PERFCTR_CPU_CYCLES		= 0xFF,
> > > +	ARM_PERFCTR_NOP			= 0x20,
> > > +};
> > This needs an armv6 prefix in the name.
> Agreed.
Ok.

...
> > Will it need #ifdef for other ARM implementations, or a armv6 prefix?
> We could make the bitmaps large enough to hold the biggest case then store the
> maximum number events for each PMU type in its own structure.
> 
> As for making everything else implementation specific, if we adopted the same
> method as x86 then we could easily do this.
Agree.

> 
> Jamie

Thanks,
Jean
