From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Thu, 04 Mar 2010 13:56:20 +0530
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267668019.22204.20.camel@pasglop>
References: <20100302211049V.fujita.tomonori@lab.ntt.co.jp>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<1267572594.2173.25.camel@pasglop>
	<20100303124624Z.fujita.tomonori@lab.ntt.co.jp>
	<1267593032.16696.1.camel@pasglop>
	<1267594809.4383.27.camel@mulgrave.site>
	<1267668019.22204.20.camel@pasglop>
Message-ID: <1267691180.31654.93.camel@mulgrave.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-03-04 at 13:00 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2010-03-03 at 11:10 +0530, James Bottomley wrote:
> > On Wed, 2010-03-03 at 16:10 +1100, Benjamin Herrenschmidt wrote:
> > > On Wed, 2010-03-03 at 12:47 +0900, FUJITA Tomonori wrote:
> > > > The ways to improve the approach (introducing PG_arch_2 or marking a
> > > > page clean on dma_unmap_* with DMA_FROM_DEVICE like ia64 does) is up
> > > > to architectures. 
> > > 
> > > How does the above work ? IE, the dma unmap will flush the D side but
> > > not the I side ... or is the ia64 flush primitive magic enough to do
> > > both ?
> > 
> > The point is that in a well regulated system, the I cache shouldn't need
> > extra flushing in the kernel.  We should only be faulting in R-X pages.
> > If we're operating on RWX pages (i.e. self modifying code), it's the job
> > of userspace to keep I/D coherency.
> > 
> > So the only case the kernel needs to worry about is the R-X fault case
> > for executable text code.
> 
> Still, you do need to flush I when a page cache page is recycled.

Technically not if we've got all the I flushing when mapped executable
sorted out.  This is one of the dangers of over flushing ... if we start
flushing where we don't need it "just to be sure" we end up papering
over holes in the operating system and make catching actual bugs in
operations a lot harder.

The other thing you might not appreciate in ppc land is that for a lot
of other systems (well, like parisc) flushing a dirty cache line is
incredibly expensive (because we halt the CPU to wait for the memory
eviction), so ideally we want to flush as late as possible to give the
natural operations a chance to clean most of the cache lines.  Flushing
a clean cache line on parisc as well as invalidations are fast
operations.  That's why the kmap makes the most sense to us for
implementing PIO ops ... it's the farthest point we can flush the cache
at (because beyond it we've lost the mapping the VIPT cache requires to
flush).

James
