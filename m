From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 25 Feb 2012 08:03:11 +1100
Subject: [PATCH] arm/io.h: add macros to read/write big/little endian
 register
In-Reply-To: <201202241622.43468.arnd@arndb.de>
References: <734349b4b6a4548703c723583d8ee1253184df37.1329988640.git.viresh.kumar@st.com>
 <201202231233.05622.arnd@arndb.de> <1330028738.20389.34.camel@pasglop>
 <201202241622.43468.arnd@arndb.de>
Message-ID: <1330117391.20389.47.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-02-24 at 16:22 +0000, Arnd Bergmann wrote:
> 
> It's certainly not easy to get consensus across arch maintainers, especially
> for a topic that is so complex as this one. On the other hand, we did add
> the readl_relaxed family just recently to all architectures, and I think
> it was good to do it this way.

Well, nobody added _relaxed ones to powerpc (at least not meaningful
ones) nor do I remember being CCed on the patch going in :-) In any
case, see below.

> Using __raw_* is actually worse since it's not really well-defined 
> what that means across architectures. We recently had a bug where
> gcc would create byte-wise accesses on registers that are marked
> "packed" by a driver writer, because the __raw_writel function just
> does a cast to a variable of larger alignment, which is undefined
> (IIRC, but maybe just implementation defined) in C.

Right, __raw_* is basically useless as an abstraction.

> > I tried to propose a uniform set a while back, but that never went
> > anywhere, I should have fought harder. You are welcome to bring that
> > back on the table :-)
> 
> Since the _relaxed version comes from ARM, it's basically defined
> to be convenient there, which means it is synchronized against the
> instruction stream (spinlock, most importantly) but not against
> DMA, because that tends to be expensive.

Argh. Crap. And why did you synchronize it with locks ? Seriously,
synchronizing vs. instruction stream is horribly costly for IO and
generally non-sensical. (The sync. vs a lock isn't even vs. instruction
stream, it's also a storage ordering issue).

Anyways, if you require the semantic of synchronizing against locks then
power will have to keep sync's in there which totally defeats the
purpose for us :-(

Was that ever discussed with CC on the most likely to be affected archs
such as us ? Looks like not...

> > > 2. change the ppc definition of the readl_relaxed() family to something
> > > useful (fixed endian, relaxed ordering, iomem (possibly including PCI
> > > -- same as in_le32 but without the ordering guarantee) and make any
> > > driver that wants to be portable use those accessors with explicit I/O
> > > barriers on spinlocks and DMA.
> > 
> > Last I looked, __relaxed() had a completely different meaning (relaxed
> > ordering -on-the-bus- which is a totally different thing, so iirc only
> > one arch ever implemented it).
> 
> I think you may be confusing it with relaxed ordering on DMA. Having
> MMIO with relaxed ordering between the accesses would be silly.

Well, my memory might be blurry, but back when I tried to get that
sorted at least one arch (and it wasn't ARM from memory) had _relaxed
accessors and the meaning of _relaxed was ... something else. Really.
Unless I was lied to :-)

> only reason we have it on ARM is to remove the need to do an expensive
> synchronization against a DMA operation on the same bus. IIRC that
> would let you do an "eieio" instead of a full "sync" on powerpc but
> should only be used in drivers that don't do DMA.

That wouldn't solve the problem with locks. Besides, we'd want "relaxed"
to not have eieio either wouldn't we ?

Cheers,
Ben.
