From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Feb 2011 12:29:53 +0000
Subject: [RFC PATCH 2/2] ARMv7: Invalidate the TLB before freeing page
	tables
In-Reply-To: <20110215113242.GD4152@n2100.arm.linux.org.uk>
References: <20110214173958.21717.30746.stgit@e102109-lin.cambridge.arm.com>
	<20110215103127.GC4152@n2100.arm.linux.org.uk>
	<1297767748.14691.15.camel@e102109-lin.cambridge.arm.com>
	<20110215113242.GD4152@n2100.arm.linux.org.uk>
Message-ID: <1297772993.14691.24.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-02-15 at 11:32 +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 15, 2011 at 11:02:28AM +0000, Catalin Marinas wrote:
> > On Tue, 2011-02-15 at 10:31 +0000, Russell King - ARM Linux wrote:
> > > We already have support for doing this, and Peter Zijlstra posted patches
> > > to convert ARM to use a generic implementation of the TLB shootdown code.
> > >
> > > http://marc.info/?l=linux-kernel&m=129604765010347&w=2
> > >
> > > Does this patch solve your problem?
> >
> > I don't think it does. Peter's patch moves the ARM TLB support to the
> > generic one which is a good clean-up, however it doesn't look like
> > anything is invalidating the TLB entry between pmd_clear() and
> > pte_free(), only after.
> 
> Can we please stop thinking "ooh, lets use generic code, that's good" ?
> It's a rediculous attitude.  The reason we have our own version is because
> the generic version is too heavy for our UP implementations and it doesn't
> do what we need to do there.
> 
> I believe we should stick with our own version for UP, and switch over to
> the generic version for SMP.

Whatever we do, the issue with A15 is valid for both UP and SMP since we
can get an interrupt which allocates a page previously hosting a pte but
before the TLB was invalidated.

I'll follow up on your patch as well.

-- 
Catalin
