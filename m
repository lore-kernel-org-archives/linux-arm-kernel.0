From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 12 Jan 2010 13:32:56 +0000
Subject: [RFC 08/18] arm: msm: set L2CR1 to enable prefetch and
	burstonScorpion.
In-Reply-To: <20100112114441.GB27771@n2100.arm.linux.org.uk>
References: <20100111234540.GN7925@n2100.arm.linux.org.uk>
	<1263293501.29654.40.camel@pc1117.cambridge.arm.com>
	<20100112114441.GB27771@n2100.arm.linux.org.uk>
Message-ID: <1263303176.29654.71.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-01-12 at 11:44 +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 12, 2010 at 10:51:41AM +0000, Catalin Marinas wrote:
> > We discussed in the past but the thread died. There are various bits
> > that may need to be enabled before the CPU is initialised but it is
> > highly dependent on the hardware configuration and not only the CPU
> > type. For example, Cortex-A8/A9 may have some bits in the ACTLR register
> > which are fine to set on RealView but not on OMAP because the kernel
> > there is running in non-secure mode. Now Scorpion has other needs.
> >
> > Since such initialisation would run before the MMU is enabled, should we
> > add an additional per-platform macro to be invoked before the CPU is set
> > up? A pointer in the machine_desc structure to an asm routine would also
> > work assuming that care is taken to calculate the phys address and the
> > code is position independent.
> 
> What you're asking for is bith platform and CPU dependent - which makes
> it much more difficult to generalize.  It also throws a spanner in the
> works for the DT people.

If it would only be CPU dependent, we could just add some ID checking in
proc-v*.S and but for some cases it's also platform dependent (like
secure vs. non-secure vs. secure monitor API).
> 
> > An alternative would be to briefly enable the MMU for the initialisation
> > (using a temporary page table) than disable it and switch to the proper
> > one built via create_mapping(). This would allow some initialisation
> > code to be written in C (though I'm not sure it's worth the effort).
> 
> How would that work?  You're saying on one hand that there's initialization
> which needs to be done before the MMU is initialized, and in this paragraph
> you're saying it can be done while the MMU is initialized and enabled.

Standard (architecture) MMU initialisation without additional
optimisation bits (similar to what we have in the decompressor). It
won't support SMP, shared page tables etc.

> Actually, what you describe is what's already being done by the head.S
> code - we already build a temporary page table and enable the MMU so that
> we can get the C code running to setup the page tables properly.

Yes, that's the table I was referring to. It could be even made not to
depend on CONFIG_SMP and always make it UP (no shared bit, this way it
would be simpler to run SMP kernel on UP hardware by doing some checks
later).

We still have things like the SMP/nAMP mode which is Cortex-A9 and
ARM11MPCore specific. There is also the TLB ops broadcasting bit in
ACTLR which is also specific to ARM Ltd cores and some of these bits may
not be accessible directly if you run in non-secure mode.

> It strikes me that things are just becoming excessively complicated with
> these seemingly "catch-22" issues.  Maybe a totally different approach is
> needed - such as requiring some of this low level setup to be done by the
> platform's boot loader?

Ideally, yes, it would be nice if these were done by the boot loader. We
would have to define some clear requirements or at least saying that
Linux only touches the architectured registers and not the
implementation defined ones. But I'm not sure how feasible this would
be.

There is also the CPU hotplug case where CPUs come back via the setup
function and may need to touch bits like SMP/nAMP. This should work
together with a boot monitor.

-- 
Catalin
