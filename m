From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 12 Jan 2010 14:41:18 +0000
Subject: [RFC 08/18] arm: msm: set L2CR1 to enable prefetch
	andburstonScorpion.
In-Reply-To: <20100112135859.GF27771@n2100.arm.linux.org.uk>
References: <20100111234540.GN7925@n2100.arm.linux.org.uk>
	<1263293501.29654.40.camel@pc1117.cambridge.arm.com>
	<20100112114441.GB27771@n2100.arm.linux.org.uk>
	<1263303176.29654.71.camel@pc1117.cambridge.arm.com>
	<20100112135859.GF27771@n2100.arm.linux.org.uk>
Message-ID: <1263307279.29654.102.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-01-12 at 13:58 +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 12, 2010 at 01:32:56PM +0000, Catalin Marinas wrote:
> > On Tue, 2010-01-12 at 11:44 +0000, Russell King - ARM Linux wrote:
> > > Actually, what you describe is what's already being done by the head.S
> > > code - we already build a temporary page table and enable the MMU so that
> > > we can get the C code running to setup the page tables properly.
> >
> > Yes, that's the table I was referring to. It could be even made not to
> > depend on CONFIG_SMP and always make it UP (no shared bit, this way it
> > would be simpler to run SMP kernel on UP hardware by doing some checks
> > later).
> 
> From what I remember, there's a problem where the TTB flags don't match
> the memory which the page tables live in, so we had to make the two
> match - and it's not possible to change the TTB flags and the page
> tables simultaneously, certainly not without turning the MMU off, doing
> the modification and turning it back on again.

Indeed, it would need turning the MMU off and on again when switching to
a new page table.

I tried in the past to run an SMP kernel on UP platform (and gave up
because of lack of time) and the main issue was the shared setting of
the page tables where exclusives wound no longer work on UP. Anyway, I
think this subject diverges from the original discussion (maybe for a
different thread).

> > We still have things like the SMP/nAMP mode which is Cortex-A9 and
> > ARM11MPCore specific. There is also the TLB ops broadcasting bit in
> > ACTLR which is also specific to ARM Ltd cores and some of these bits
> > may not be accessible directly if you run in non-secure mode.
> 
> If you're running in non-secure mode and the parts of the system you
> don't have access to haven't already been setup, you're running in a
> crippled environment - so this isn't really an argument.

My argument was that ACTLR is implementation-defined, so other cores
like Scorpion may have a different meaning for such bits (Daniel's
patches are probably held in the moderation queue, I only saw your
replies).

> > > It strikes me that things are just becoming excessively complicated with
> > > these seemingly "catch-22" issues.  Maybe a totally different approach is
> > > needed - such as requiring some of this low level setup to be done by the
> > > platform's boot loader?
> >
> > Ideally, yes, it would be nice if these were done by the boot loader. We
> > would have to define some clear requirements or at least saying that
> > Linux only touches the architectured registers and not the
> > implementation defined ones. But I'm not sure how feasible this would
> > be.
> 
> Unless we do something like this, we're going to end up with lots of
> bits of additional platform specific non-conditional assembly in the
> early kernel boot path.

As a gatekeeper, maybe you could just reject such patches and enforce
the implementation-specific bits setting in the boot loader. That's also
true for the SMP/nAMP mode setting on A9 and 11MPCore.

> > There is also the CPU hotplug case where CPUs come back via the setup
> > function and may need to touch bits like SMP/nAMP. This should work
> > together with a boot monitor.
> 
> How does the CPU get back to the setup function?  Is the hardware aware
> of the address of our setup function?  I don't think so, so I don't buy
> this argument.
> 
> If the CPU is reset (eg, because power has been removed), it's going to
> want to start executing from the reset vector - which means it will come
> back to us via the boot loader.

It depends on what you put in the reset vector (on RealView, address 0
gets remapped to RAM). It is true that it can come back online via the
boot loader (especially if Linux is running in non-secure mode). There
are a few complications like the boot loader being around (flash) and
the kernel knowing its address but it's doable.

-- 
Catalin
