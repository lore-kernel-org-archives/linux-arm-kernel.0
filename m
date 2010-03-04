From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 05 Mar 2010 08:25:01 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267691180.31654.93.camel@mulgrave.site>
References: <20100302211049V.fujita.tomonori@lab.ntt.co.jp>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<1267572594.2173.25.camel@pasglop>
	<20100303124624Z.fujita.tomonori@lab.ntt.co.jp>
	<1267593032.16696.1.camel@pasglop>
	<1267594809.4383.27.camel@mulgrave.site>
	<1267668019.22204.20.camel@pasglop>
	<1267691180.31654.93.camel@mulgrave.site>
Message-ID: <1267737901.22204.67.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Still, you do need to flush I when a page cache page is recycled.
> 
> Technically not if we've got all the I flushing when mapped executable
> sorted out.  This is one of the dangers of over flushing ... if we start
> flushing where we don't need it "just to be sure" we end up papering
> over holes in the operating system and make catching actual bugs in
> operations a lot harder.

Well, ok so we are talking past each other here :-) So let me try to
summarize what we do, and then write up what I'd like to be able to do
but can't quite see how to get there just yet.

On PPC, we keep track of whether a page is "cache clean" with PG_arch1. 

We only bother with flushing it when mapping it and yes, it's an
expensive operation.

We do it from within set_pte_at() and/or ptep_set_access_flags(), at
which point w test PG_arch_1, and if clear, do the flush and set it.

On systems that support per-page exec permission, we optimize things a
bit, in that unless this is an exec fault, we "skip" the flush when
mapping the page and filter out the exec permission (so that's a read
access for example). We later do the flush when exec is attempted.

On systems that don't (earlier 32-bit powerpc), we -have- to flush any
mapped page sadly as one could be mapped for read and actually executed
from. This is -not- a case of "let userspace shoot themselves in the
foot", letting stale icache leak through to userspace here is actually a
security hole in theory (granted, unlikely but we got barked at enough
when we tried to optimize that out).

Now, when we do the flush as described above, we do both D$ and I$
passes at once.

It would be indeed nice to be able to avoid the D$ flush when the page
was the target of a DMA operation, since the D$ flush is the most
expensive part of the process.

However, I don't see how to do that without having a separate page bit
to keep track of the D$ vs. I$ state. For example, if we use PG_arch_1
exclusively for D$, and always flush I$ on mapping to userspace, we end
up with a lot of I$ spurrious flushes any time glibc text for example is
mapped into a new process.

> The other thing you might not appreciate in ppc land is that for a lot
> of other systems (well, like parisc) flushing a dirty cache line is
> incredibly expensive (because we halt the CPU to wait for the memory
> eviction), 

Same here. High end server PPCs have the I$ snoop the D$ but on all the
other ones, we pay a dear price for those flushes, which is why I'm
trying to see how I could exploit the trick of not doing the D$ side
flush at least for targets of DMA ops, but as I said, I can't see how it
can be done properly without another tracking bit in struct page.

> so ideally we want to flush as late as possible to give the
> natural operations a chance to clean most of the cache lines.  Flushing
> a clean cache line on parisc as well as invalidations are fast
> operations.  That's why the kmap makes the most sense to us for
> implementing PIO ops ... it's the farthest point we can flush the cache
> at (because beyond it we've lost the mapping the VIPT cache requires to

Cheers,
Ben.

> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
