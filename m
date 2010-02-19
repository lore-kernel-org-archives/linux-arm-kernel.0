From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Feb 2010 17:36:51 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1266599755.32546.38.camel@e102109-lin.cambridge.arm.com>
References: <1266445892.16346.306.camel@pasglop>
	<1266599755.32546.38.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1266601011.32546.48.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-02-19 at 17:15 +0000, Catalin Marinas wrote:
> On Wed, 2010-02-17 at 22:31 +0000, Benjamin Herrenschmidt wrote:
> > On Wed, 2010-02-17 at 20:44 +0000, Russell King - ARM Linux wrote:
> > > No, because that'd probably bugger up the Sparc64 method of delaying
> > > flush_dcache_page.
> > >
> > > This method works as follows:
> > >
> > > - a page cache page is allocated - this has PG_arch_1 clear.
> > >
> > > - IO happens on it and it's placed into the page cache.  PG_arch_1 is
> > >   still clear.
> > >
> > > - someone calls read()/write() which accesses the page.  The generic
> > >   file IO layers call flush_dcache_page() in response to
> > > read()/write()
> > >   fs calls.  flush_dcache_page() spots that the page is not yet mapped
> > >   into userspace, and sets PG_arch_1 to mark the fact that the kernel
> > >   mapping is dirty.
> > >
> > > - when someone maps the page, we check PG_arch_1 in update_mmu_cache.
> > >   If PG_arch_1 is set, we flush the kernel mapping.
> > >
> > > Clearly, if we go around having drivers clearing PG_arch_1, this is
> > > going to break horribly.
> >
> > Ok, you do things very differently than us on ppc then. We clear
> > PG_arch_1 in flush_dcache_page(), and we set it when the page has been
> > cache cleaned for execution.
> 
> For this perspective it's not that different, just that we use the
> negated PG_arch_1.

I got your point now (after reading the replies on linux-arch :)).

So PPC assumes that if PG_arch_1 is clear (the default), the page wasn't
cleaned. If there is no call to flush_dcache_page() but the page gets
mapped to user space, update_mmu_cache() (or set_pte_at()) would simply
assume that the page was dirtied, flush the caches and set this bit.

We could easily do this on ARM as well and assume that the page is dirty
if !PG_arch_1. But it only partially solves the problem (only for
faulted-in pages).

If a page is already mapped in user space, flush_dcache_page() on ARM
does the flushing rather than deferring it to update_mmu_cache(). The
PIO HCD drivers, however, don't call flush_dcache_page(). Is it possible
that the HCD could transfer data into a page cache page already mapped
in user space? My understanding is that the scenario above is possible.

-- 
Catalin
