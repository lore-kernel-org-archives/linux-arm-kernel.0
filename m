From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Dec 2009 12:10:46 -0000
Subject: Perf Event support for ARMv7 (was: Re: [PATCH 5/5]
	arm/perfevents: implement perf event support for ARMv6)
In-Reply-To: <200912211243.07254.jpihet@mvista.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<1261155929.6094.11.camel@def-laptop>
	<000701ca822d$6de761a0$49b624e0$@deacon@arm.com>
	<200912211243.07254.jpihet@mvista.com>
Message-ID: <000901ca8236$a0e1adf0$e2a509d0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

* Jean Pihet wrote:

> > The maximum number of event counters on ARMv7 is currently 6 [Cortex-A9],
> > plus a cycle counter. Additionally, the number of event counters actually
> > available is implementation defined (the cycle counter is mandatory). You
> > can find out the number of event counters using the PMCR ((PMCR >> 11) &
> > 0x1f).
> I think we should support Cortex-A8 for now and add support for Cortex-A9 on
> top of it. IIUC a generic ARMV7 support is not possible so I will need
> separate handling for Cortex-A8 and -A9. Is that correct?
> 
> Unfortunately I do not have any -A9 HW for now. I will look at the spec in
> order to spot the differences between both PMNC units.

Sorry, I should've mentioned that the PMU hardware interface is the same
across all v7 cores. The only difference is the core-specific event numberings.
A9 is also available in MP configurations, but that shouldn't cause many problems
for perf. I can test on an A9MP once you have something you're happy with.

> > Ok - the events so far are defined by the v7 architecture.
> > Note that this doesn't necessarily mean they are all supported by
> > the core.
> Is there a way to detect the supported PMU events at run-time? Is it harmful
> to use unsupported events?

The unsupported events for a given core are documented in the TRM.
For example, A9 doesn't support 0x08 and 0x0E but does support all
the other events defined by the architecture. It then has its own
set of extensions listed in the TRM [Section 9.2.1].

> Ok so I will need to separate Cortex-A8 from -A9.

Yep - but it's an easy thing to do.

> > I've implemented this for oprofile, I'll post it as an RFC after Christmas
> > as I won't be able to respond in the meantime.
> Ok. Do you know how I can differentiate Cortex-A8 from -A9?

The bottom two bytes of the main cpuid (read_cpuid_id()) are 0xC080 and 0xC090
for the A8 and A9 respectively.

> I will post a new version with the corrections.

Excellent. I can comment on things tomorrow as well, but then I'm off.

> Cheers and a good celebration time,

Thanks. I'll post my oprofile patches when I return. They cover these issues
already so hopefully you can spot anything I've missed.

Will
