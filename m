From: will.deacon@arm.com (Will Deacon)
Date: Wed, 20 Jan 2010 13:40:08 -0000
Subject: Perf Event support for ARMv7 (was: Re: [PATCH 5/5]
	arm/perfevents: implement perf event support for ARMv6)
In-Reply-To: <201001151630.07874.jpihet@mvista.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<200912291458.20609.jpihet@mvista.com>
	<000101ca8d5e$3ce84e20$b6b8ea60$@deacon@arm.com>
	<201001151630.07874.jpihet@mvista.com>
Message-ID: <000d01ca99d6$14edcba0$3ec962e0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

Sorry for the delay in getting back to you, I've had a few technical
problems with my machine. Anyway, here we go:

* Jean Pihet wrote:
<snip>
> > 0x0c is HW_BRANCH_INSTRUCTIONS and 0x10 is HW_BRANCH_MISSES.
> > 0x12 is the number of predictable branch instructions executed, so the
> > mispredict rate is 0x10/0x12. These events are defined for v7, so A8 should
> > take these definitions too.
> From the spec I read 0x0c is 'SW write of the PC', is that equivalent to
> HW_BRANCH_INSTRUCTIONS?

This event counts:
	- All branch instructions
	- Instructions that explicitly write the PC
	- Exception generating instructions

I think this is suitable for HW_BRANCH_INSTRUCTIONS, but if anybody feels
differently then maybe we should reconsider.

> For A8 I am using:
> - ARMV7_PERFCTR_PC_BRANCH_TAKEN (0x53),
> - ARMV7_PERFCTR_PC_BRANCH_FAILED (0x52)
> 
> For A9 it is unsupported for now.
> 
> Do you think I should use 0x0c and 0x10 for both A8 and A9? How to get the
> accesses and misses count directly?

I think we should define the `standard' set (i.e. those that perf supports by
name) using the v7 events, so in this case then use 0x0c and 0x10 for both A8
and A9. The core-specific definitions can then always be accessed as raw events.
As I mentioned, I think this is important if people decide to compare the counts
between two cores.

> > We could use 0x01 for icache miss, 0x03 for dcache miss and 0x04 for dcache
> > access.
> Ok changed to the following. Is that correct?
> Note that A8 uses specific events for I cache in order to make them comparable
> to each other. I cache miss could use 0x01 also. Cf. remark below for more.
> 
> Cortex-A8:
> - D cache access: ARMV7_PERFCTR_DCACHE_ACCESS (0x04),
> - D cache miss: ARMV7_PERFCTR_DCACHE_REFILL (0x03) instead of
> ARMV7_PERFCTR_L1_DATA_MISS (0x49),
> - I cache access: ARMV7_PERFCTR_L1_DATA_MISS (0x50),
> - I cache miss: ARMV7_PERFCTR_L1_INST_MISS (0x4a).
> 
> Cortex-A9:
> - D cache access: ARMV7_PERFCTR_DCACHE_ACCESS (0x04),
> - D cache miss: ARMV7_PERFCTR_DCACHE_REFILL (0x03),
> - I cache access: Not supported,
> - I cache miss: ARMV7_PERFCTR_IFETCH_MISS (0x01).

Hmm, this is an interesting one. I suppose comparison between events on a given
core (i.e. A8) is preferable, so I agree with you here. Due to the lack of I-cache
access events on A9, there's nothing we can do to get a fair cross-core comparison.
[minor note: You've called the I-cache access event ARMV7_PERFCTR_L1_DATA_MISS!]
 
> > > +	[C(L1I)] = {
> > > +		[C(OP_READ)] = {
> > > +			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_L1_INST,
> > > +			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L1_INST_MISS,
> > > +		},
> > > +		[C(OP_WRITE)] = {
> > > +			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_L1_INST,
> > > +			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L1_INST_MISS,
> > > +		},
> > > +		[C(OP_PREFETCH)] = {
> > > +			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
> > > +			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
> > > +		},
> > > +	},
> >
> > Same thing here. I'd suggest using 0x01 instead of 0x4a.
> Ok is it preferred to keep the ARMV7_PERFCTR_L1_ events for both accesses and
> misses in order to make the events counts comparable to each other? On the
> other end using 0x01 allows the comparison between A8 and A9.
> I am OK to change it, just let me know.

After thinking about this above, I agree with you; let's use the
ARMV7_PERFCTR_L1_ events to allow for event comparisons on the A8. Comparing with
an A9 is a non-starter because the I-cache accesses can't be counted there.

> > > +/*
> > > + * Available counters
> > > + */
> > > +#define ARMV7_CNT0 		0	/* First event counter */
> > > +#define ARMV7_CCNT 		31	/* Cycle counter */
> > > +
> > > +#define ARMV7_A8_CNTMAX		5	/* Cortex-A8: up to 4 counters + CCNT */
> > > +#define ARMV7_A9_CNTMAX		32	/* Cortex-A9: up to 31 counters + CCNT*/
> >
> > Actually, A9 has a maximum number of 6 event counters + CCNT.
> Cf. remark above. The code is generic enough and supports up to the 1+31
> events as defined in the A8 and A9 TRMs. The number of counters is
> dynamically read from the PMNC registers. Should that be compared against the
> given maximum (1+4 for A8, 1+6 for A9)? That looks like overkill.

Sure, I was just referring to ARMV7_A9_CNTMAX being artificially high.
You'll never see more than 6 event counters on an A9.

> > It might also be
> > worth adding a cpu_architecture() check to the v6 test just in case a
> > v7 core conflicts with the mask.
> Jamie, what do you think?

I forgot that looked at the MMU. Oh well, the ordering will have to matter.

Cheers,

Will
