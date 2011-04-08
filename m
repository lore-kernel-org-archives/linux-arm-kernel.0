From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 8 Apr 2011 15:50:21 -0400 (EDT)
Subject: [PATCH 2/2] ARM: fix personality flag propagation across an exec
In-Reply-To: <20110408191035.GA5573@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1104072251390.28032@xanadu.home>
	<20110408072931.GB27450@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104080856000.28032@xanadu.home>
	<20110408191035.GA5573@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1104081536390.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Apr 2011, Russell King - ARM Linux wrote:

> On Fri, Apr 08, 2011 at 09:00:07AM -0400, Nicolas Pitre wrote:
> > On Fri, 8 Apr 2011, Russell King - ARM Linux wrote:
> > 
> > > On Thu, Apr 07, 2011 at 10:52:53PM -0400, Nicolas Pitre wrote:
> > > >  	/*
> > > > +	 * Inherit most personality flags from parent, except for those
> > > > +	 * we're about to choose.  Beware: PER_LINUX_32BIT carries flag bits
> > > > +	 * outside of PER_MASK.
> > > > +	 */
> > > > +	personality &= ~(PER_MASK | PER_LINUX | PER_LINUX_32BIT);
> > > 
> > > PER_LINUX and PER_LINUX_32BIT aren't bitflags - the LSB is a numeric
> > > personality ID.  So this looks wrong.
> > 
> > >From include/linux/personality.h:
> > 
> > enum {
> >         PER_LINUX =             0x0000,
> >         PER_LINUX_32BIT =       0x0000 | ADDR_LIMIT_32BIT,
> >         PER_LINUX_FDPIC =       0x0000 | FDPIC_FUNCPTRS,
> >         PER_SVR4 =              0x0001 | STICKY_TIMEOUTS | MMAP_PAGE_ZERO,
> >         [...]
> > 
> > So this is a combination of a personality ID and flag bits.  And the 
> > only difference between PER_LINUX and PER_LINUX_32BIT is one of those 
> > flag bits.
> 
> Yes but its wrong to clear the bitmask using ~PER_LINUX etc.
> 
> What you want to be doing is:
> 
> 	personality &= ~(PER_MASK | ADDR_LIMIT_32BIT);
> 
> so you're clearing the LSB being the personality type, and the 32-bit
> address limit.

Sure.

However, if we're only setting the address limit flag here, wouldn't it 
be better to leave the current personality type as is and only set/clear 
the ADDR_LIMIT_32BIT flag?  Something like:

	unsigned int personality = current->personality;
        if ((eflags & EF_ARM_EABI_MASK) == EF_ARM_EABI_UNKNOWN &&
            (eflags & EF_ARM_APCS_26))
                personality &= ~ADDR_LIMIT_32BIT;
        else
                personality |= ADDR_LIMIT_32BIT;
        set_personality(personality);

Or is the actual personality type not supposed to be inherited?

I also notice that bad_syscall() is broken if extra flags such as 
ADDR_NO_RANDOMIZE are added to the current personality (will send a 
patch for that as well).


Nicolas
