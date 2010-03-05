From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 05 Mar 2010 15:34:10 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267740711.30572.5.camel@e102109-lin.cambridge.arm.com>
References: <20100226210030.GC23933@n2100.arm.linux.org.uk>
	<1267316072.23523.1842.camel@pasglop>
	<1267333263.2762.11.camel@mulgrave.site>
	<20100302211049V.fujita.tomonori@lab.ntt.co.jp>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<20100303215437.GF2579@ucw.cz>
	<1267709756.6526.380.camel@e102109-lin.cambridge.arm.com>
	<20100304135128.GA12191@atrey.karlin.mff.cuni.cz>
	<1267712512.31654.176.camel@mulgrave.site>
	<1267716578.6526.483.camel@e102109-lin.cambridge.arm.com>
	<20100304154103.GA9384@linux-sh.org>
	<1267726049.6526.543.camel@e102109-lin.cambridge.arm.com>
	<1267738660.22204.77.camel@pasglop>
	<1267740711.30572.5.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1267763650.22204.92.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-03-04 at 22:11 +0000, Catalin Marinas wrote:
> On Thu, 2010-03-04 at 21:37 +0000, Benjamin Herrenschmidt wrote:
> > On Thu, 2010-03-04 at 18:07 +0000, Catalin Marinas wrote:
> > > I'm not familiar with SH but for PIO devices the flushing shouldn't be
> > > more aggressive. For the DMA devices, Russell suggested that we mark
> > > the page as clean (set PG_dcache_clean) in the DMA API to avoid the
> > > default flushing.
> > 
> > I really like that idea, as I said earlier, but I'm worried about the I$
> > side of things. IE. What I'm trying to say is that I can't see how to do
> > that optimisation without ending up with missing I$ invalidations or
> > doing way too many of them, unless we have a separate bit to track I$
> > state.
> 
> But does this optimisation really matter? I think with careful checking
> in set_pte_at(), you are not going to invalidate the I-cache more than
> necessary. If the original page wasn't pte_present() you would need to
> do the I-cache invalidation. The other cases where set_pte_at() is
> called for LRU (pte_young) or COW (pte_write) we can avoid the extra
> invalidation.

No. Not on PIPT (or non aliasing VIPT).

Take your typical glibc text page. This is a struct page that will be
mapped in almost every process in your system. You do not want to do the
icache inval every time. Once it's been cleaned once, it's clean for
subsequent mappings. Only VIVT needs such multiple invalidates I suppose
though in this case you probably do everything differently anyways.

Cheers,
Ben.
