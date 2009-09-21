From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Sep 2009 22:26:37 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <20090921201043.GA14700@shareable.org>
References: <1253435940.498.15.camel@pc1117.cambridge.arm.com>
	<20090920093139.GA1704@n2100.arm.linux.org.uk>
	<20090920190227.GB5413@n2100.arm.linux.org.uk>
	<4AB6B0AB.8040307@arm.com> <20090921083109.GC20006@shareable.org>
	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>
	<20090921085425.GC27357@n2100.arm.linux.org.uk>
	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>
	<20090921100751.GF27357@n2100.arm.linux.org.uk>
	<20090921201043.GA14700@shareable.org>
Message-ID: <20090921212637.GG30821@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2009 at 09:10:43PM +0100, Jamie Lokier wrote:
> Russell King - ARM Linux wrote:
> > On Mon, Sep 21, 2009 at 10:44:23AM +0100, Catalin Marinas wrote:
> > > I would still call this I-D cache coherency issue since the two caches
> > > have a different view of the RAM but I agree that the D-cache is the one
> > > holding the data (with a slight chance for the I-cache not to be in sync
> > > with main RAM, though we could treat it separately).
> > > 
> > > We can sort out the D-cache issue with your approach for cleaning it in
> > > the copy_user_highpage() function, but, as I said, we affect the
> > > standard CoW mechanism for data pages quite a lot.
> > 
> > Let me restate my approach more clearly:
> > 
> > 1. Remember that a VMA has been executable.
> > 2. Only do the additional handing if the VMA has been executable.
> 
> Sorry, I'm a little confused, and I'm trying to understand what I can
> safely assume is reliable when using mprotect.
> 
> If the problem is data in the D-cache not being flushed to be read as
> data from a text page (i.e. nothing to do with I-cache, it's all about
> the D-cache between different mappings), why is the previous
> executableness of the VMA relevant to the solution?

We're using the previous state to indicate what the likely future state
of the page is going to be.

> And here's a little something:
> 
> http://www.mail-archive.com/aufs-users at lists.sourceforge.net/msg02093.html
> 
> It's about MIPS, but has an awful lot of things in common with the bug
> being discussed in this thread: dynamic linker, constants embedded in
> the code, using mprotect rx->rw->rx, missing I-cache flush, only
> affects COW, copy_user_highpage(), is worked around by switching the
> cache from write-back to write-through...
> 
> Useful?

Depends.  ARMv7 has the requirement that memory is not mapped in using
different cache settings (we already violate that, and ARM Ltd's aware
of that, but no one yet knows how to solve it in Linux.)

Given that, I'm not sure we want to dig ourselves deeper into having
mappings of differing cache attributes - we actually want to eliminate
them.

> I found that while searching to see if mprotect rw->rx implies I-cache
> flush.  On IRIX it's explicitly documented to, in fact it has
> PROT_EXEC_NOFLUSH in case you want to optimise that away :-) Haven't
> found anything to confirm or deny it for Linux or anything else,
> though.

Linux has no hook for doing this; you can't even detect it via mprotect()
because the old vm_flags are overwritten before any arch code gets a
look-in.

> Hopefully it's clear that munmap of the region, followed by mmap
> PROT_READ|PROTE_EXEC to restore the mapping with different permissions
> (when it has a backing file) - hopefully it's clear that _that_ will
> do the needed I-cache flush.

Not necessarily, especially if the file is mapped using MAP_PRIVATE.
