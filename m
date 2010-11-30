From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 30 Nov 2010 11:02:43 +0000
Subject: [PATCH 5/8] ARM: hw_breakpoint: don't advertise reserved
	breakpoints
In-Reply-To: <004001cb9077$25b2e4a0$7118ade0$@deacon@arm.com>
References: <1291052088-17243-1-git-send-email-will.deacon@arm.com>
	<1291052088-17243-6-git-send-email-will.deacon@arm.com>
	<20101130100100.GA4398@pulham.picochip.com>
	<004001cb9077$25b2e4a0$7118ade0$@deacon@arm.com>
Message-ID: <20101130110243.GD4398@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 10:12:51AM -0000, Will Deacon wrote:
> Hi Jamie,
> 
> > > +	/*
> > > +	 * FIXME: When a watchpoint fires, the only way to work out which
> > > +	 * watchpoint it was is by disassembling the faulting instruction
> > > +	 * and working out the address of the memory access.
> > > +	 *
> > > +	 * Furthermore, we can only do this if the watchpoint was precise
> > > +	 * since imprecise watchpoints prevent us from calculating register
> > > +	 * based addresses.
> > > +	 *
> > > +	 * For the time being, we only report 1 watchpoint register so we
> > > +	 * always know which watchpoint fired. In the future we can either
> > > +	 * add a disassembler and address generation emulator, or we can
> > > +	 * insert a check to see if the DFAR is set on watchpoint exception
> > > +	 * entry [the ARM ARM states that the DFAR is UNKNOWN, but
> > > +	 * experience shows that it is set on some implementations].
> > > +	 */
> > > +
> > > +#if 0
> > > +	int wrps;
> > > +	u32 didr;
> > > +	ARM_DBG_READ(c0, 0, didr);
> > > +	wrps = ((didr >> 28) & 0xf) + 1;
> > > +#endif
> > > +	int wrps = 1;
> > > +
> > > +	if (core_has_mismatch_brps() && wrps >= get_num_brp_resources())
> > > +		wrps = get_num_brp_resources() - 1;
> > > +
> > > +	return wrps;
> > > +}
> > Hi Will,
> > 
> > Minor nitpick, is the comment above still valid? It looks like this could
> > return something other than 1. Is this to handle the case when there aren't
> > any watchpoint registers?
> 
> The comment still stands because we can't determine which watchpoint fired
> if we allow more than one. Since we must reserve a breakpoint to handle stepping
> over the watchpoint, we need to ensure that we truncate the number of usable
> watchpoints to be the number of breakpoints - 1 (so that there is always 1
> hardware breakpoint available).
> 
> Currently, all the code above ends up doing is checking that we have more than
> 1 breakpoint available if we want watchpoints.
> 
> I could update the comment to say that we might advertise 0 watchpoints in the
> case that only 1 breakpoint is available if you like?
It was more out of curiosity really! If you're in there again it might be 
worth updating the comment otherwise it's not obvious why the code doesn't 
just return a static 1.

Jamie
