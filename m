From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jan 2010 13:58:59 +0000
Subject: [RFC 08/18] arm: msm: set L2CR1 to enable prefetch and
	burstonScorpion.
In-Reply-To: <1263303176.29654.71.camel@pc1117.cambridge.arm.com>
References: <20100111234540.GN7925@n2100.arm.linux.org.uk>
	<1263293501.29654.40.camel@pc1117.cambridge.arm.com>
	<20100112114441.GB27771@n2100.arm.linux.org.uk>
	<1263303176.29654.71.camel@pc1117.cambridge.arm.com>
Message-ID: <20100112135859.GF27771@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 01:32:56PM +0000, Catalin Marinas wrote:
> On Tue, 2010-01-12 at 11:44 +0000, Russell King - ARM Linux wrote:
> > What you're asking for is bith platform and CPU dependent - which makes
> > it much more difficult to generalize.  It also throws a spanner in the
> > works for the DT people.
> 
> If it would only be CPU dependent, we could just add some ID checking in
> proc-v*.S and but for some cases it's also platform dependent (like
> secure vs. non-secure vs. secure monitor API).
> 
> > > An alternative would be to briefly enable the MMU for the initialisation
> > > (using a temporary page table) than disable it and switch to the proper
> > > one built via create_mapping(). This would allow some initialisation
> > > code to be written in C (though I'm not sure it's worth the effort).
> > 
> > How would that work?  You're saying on one hand that there's initialization
> > which needs to be done before the MMU is initialized, and in this paragraph
> > you're saying it can be done while the MMU is initialized and enabled.
> 
> Standard (architecture) MMU initialisation without additional
> optimisation bits (similar to what we have in the decompressor). It
> won't support SMP, shared page tables etc.

That's more or less what is done already - up to the point where the
proper page tables are setup by paging_init().

> > Actually, what you describe is what's already being done by the head.S
> > code - we already build a temporary page table and enable the MMU so that
> > we can get the C code running to setup the page tables properly.
> 
> Yes, that's the table I was referring to. It could be even made not to
> depend on CONFIG_SMP and always make it UP (no shared bit, this way it
> would be simpler to run SMP kernel on UP hardware by doing some checks
> later).
