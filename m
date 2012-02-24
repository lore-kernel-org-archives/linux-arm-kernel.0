From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Feb 2012 16:22:43 +0000
Subject: [PATCH] arm/io.h: add macros to read/write big/little endian
 register
In-Reply-To: <1330028738.20389.34.camel@pasglop>
References: <734349b4b6a4548703c723583d8ee1253184df37.1329988640.git.viresh.kumar@st.com>
 <201202231233.05622.arnd@arndb.de> <1330028738.20389.34.camel@pasglop>
Message-ID: <201202241622.43468.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 February 2012, Benjamin Herrenschmidt wrote:

> > The mistake on ppc was to make them private to one architecture instead of
> > coming up with a well-defined set of accessors that are provided on all
> > architectures.
> 
> That was never going to fly, we already have too many.

It's certainly not easy to get consensus across arch maintainers, especially
for a topic that is so complex as this one. On the other hand, we did add
the readl_relaxed family just recently to all architectures, and I think
it was good to do it this way.
 
> >  We certainly have too many accessors already between
> > inl/readl/ioread32/__raw_readl/readl_relaxed/in_le32, which makes this
> > rather confusing, but IMHO there is still the need for cleanup and
> > addition of missing variants like cpu-endian non-relaxed and
> > big-endian relaxed as well as a replacement for __raw_* that actually
> > defines them to something useful across architectures.
> 
> Right, the _relaxed don't have clear semantics and we do need "real"
> relaxed ones badly as in "don't have memory barriers". Currently, a
> driver that wants to avoid the sync's we have all over the place in our
> accessors for performance reasons has to use __raw_* and thus handle
> endian manually as well, which sucks since it also cannot use the
> reverse-load/store instructions in that case.

Using __raw_* is actually worse since it's not really well-defined 
what that means across architectures. We recently had a bug where
gcc would create byte-wise accesses on registers that are marked
"packed" by a driver writer, because the __raw_writel function just
does a cast to a variable of larger alignment, which is undefined
(IIRC, but maybe just implementation defined) in C.

> I tried to propose a uniform set a while back, but that never went
> anywhere, I should have fought harder. You are welcome to bring that
> back on the table :-)

Since the _relaxed version comes from ARM, it's basically defined
to be convenient there, which means it is synchronized against the
instruction stream (spinlock, most importantly) but not against
DMA, because that tends to be expensive.

> > 2. change the ppc definition of the readl_relaxed() family to something
> > useful (fixed endian, relaxed ordering, iomem (possibly including PCI
> > -- same as in_le32 but without the ordering guarantee) and make any
> > driver that wants to be portable use those accessors with explicit I/O
> > barriers on spinlocks and DMA.
> 
> Last I looked, __relaxed() had a completely different meaning (relaxed
> ordering -on-the-bus- which is a totally different thing, so iirc only
> one arch ever implemented it).

I think you may be confusing it with relaxed ordering on DMA. Having
MMIO with relaxed ordering between the accesses would be silly. The
only reason we have it on ARM is to remove the need to do an expensive
synchronization against a DMA operation on the same bus. IIRC that
would let you do an "eieio" instead of a full "sync" on powerpc but
should only be used in drivers that don't do DMA.

	Arnd
