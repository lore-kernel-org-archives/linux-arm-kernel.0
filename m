From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 14 Dec 2009 16:33:12 +0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <1260807177.8106.50.camel@def-laptop>
References: <1260799481-29951-1-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-2-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-3-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-4-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-5-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-6-git-send-email-jamie.iles@picochip.com>
	<1260807177.8106.50.camel@def-laptop>
Message-ID: <20091214163312.GJ4141@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

On Mon, Dec 14, 2009 at 05:12:57PM +0100, Jean Pihet wrote:
> I have a question about other ARM implementations. Since all the code is
> in perf_event.c is it modular enough to allow the addition of other ARM
> implementations? The remarks are inlined below.
> 
> I am interested in supporting perf events for ARMv7. What do you think?
It should be possible, and not too difficult. The x86 perf events code
(arch/x86/kernel/cpu/perf_events.c) does exactly this. We would need to define
an arm_pmu structure that wraps up a 'struct pmu' and provides hooks for the
architecture specific call.

> > 
> > diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> > index 286a276..44ebf36 100644
> > --- a/arch/arm/kernel/Makefile
> > +++ b/arch/arm/kernel/Makefile
> > @@ -47,6 +47,7 @@ obj-$(CONFIG_CPU_XSC3)		+= xscale-cp0.o
> >  obj-$(CONFIG_CPU_MOHAWK)	+= xscale-cp0.o
> >  obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
> >  obj-$(CONFIG_CPU_HAS_PMU)	+= pmu.o
> > +obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
> >  AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
> >  
> >  ifneq ($(CONFIG_ARCH_EBSA110),y)
> > diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> > new file mode 100644
> > index 0000000..358fd31
> I have a generic question here: will #ifdef be needed to allow other ARM
> implementations (e.g. ARMv7)? Is it worth to do it that way or to
> duplicate this file for other ARM implementations?
We can probably do it without preprocessor magic as long as the coprocessor
instructions for the v6 counters still assemble under v7. We can do it all at
runtime like in the x86 code and return the correct pmu from
hw_perf_event_init().
> 
> > --- /dev/null
> > +++ b/arch/arm/kernel/perf_event.c
> > @@ -0,0 +1,1034 @@
> > +#undef DEBUG
> > +
> > +/*
> > + * ARMv6 performance counter support.
> ARMv6 only?
Yes, at the moment ;-)

[snip]
> > +enum arm_perf_types {
> > +	ARM_PERFCTR_ICACHE_MISS		= 0x0,
> > +	ARM_PERFCTR_IBUF_STALL		= 0x1,
> > +	ARM_PERFCTR_DDEP_STALL		= 0x2,
> > +	ARM_PERFCTR_ITLB_MISS		= 0x3,
> > +	ARM_PERFCTR_DTLB_MISS		= 0x4,
> > +	ARM_PERFCTR_BR_EXEC		= 0x5,
> > +	ARM_PERFCTR_BR_MISPREDICT	= 0x6,
> > +	ARM_PERFCTR_INSTR_EXEC		= 0x7,
> > +	ARM_PERFCTR_DCACHE_HIT		= 0x9,
> > +	ARM_PERFCTR_DCACHE_ACCESS	= 0xA,
> > +	ARM_PERFCTR_DCACHE_MISS		= 0xB,
> > +	ARM_PERFCTR_DCACHE_WBACK	= 0xC,
> > +	ARM_PERFCTR_SW_PC_CHANGE	= 0xD,
> > +	ARM_PERFCTR_MAIN_TLB_MISS	= 0xF,
> > +	ARM_PERFCTR_EXPL_D_ACCESS	= 0x10,
> > +	ARM_PERFCTR_LSU_FULL_STALL	= 0x11,
> > +	ARM_PERFCTR_WBUF_DRAINED	= 0x12,
> > +	ARM_PERFCTR_CPU_CYCLES		= 0xFF,
> > +	ARM_PERFCTR_NOP			= 0x20,
> > +};
> This needs an armv6 prefix in the name.
Agreed.

> > +/* The events for a given CPU. */
> > +struct cpu_hw_events {
> > +	/*
> > +	 * The events that are active on the CPU for the given index. Index 0
> > +	 * is reserved.
> > +	 */
> > +	struct perf_event	*events[ARMV6_MAX_HWEVENTS];
> > +
> > +	/*
> > +	 * A 1 bit for an index indicates that the counter is being used for
> > +	 * an event. A 0 means that the counter can be used.
> > +	 */
> > +	unsigned long		used_mask[BITS_TO_LONGS(ARMV6_MAX_HWEVENTS)];
> > +
> > +	/*
> > +	 * A 1 bit for an index indicates that the counter is actively being
> > +	 * used.
> > +	 */
> > +	unsigned long		active_mask[BITS_TO_LONGS(ARMV6_MAX_HWEVENTS)];
> > +};
> Will it need #ifdef for other ARM implementations, or a armv6 prefix?
We could make the bitmaps large enough to hold the biggest case then store the
maximum number events for each PMU type in its own structure.

As for making everything else implementation specific, if we adopted the same
method as x86 then we could easily do this.

Jamie
