From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Feb 2010 17:15:55 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1266445892.16346.306.camel@pasglop>
References: <1266445892.16346.306.camel@pasglop>
Message-ID: <1266599755.32546.38.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-02-17 at 22:31 +0000, Benjamin Herrenschmidt wrote:
> On Wed, 2010-02-17 at 20:44 +0000, Russell King - ARM Linux wrote:
> > No, because that'd probably bugger up the Sparc64 method of delaying
> > flush_dcache_page.
> >
> > This method works as follows:
> >
> > - a page cache page is allocated - this has PG_arch_1 clear.
> >
> > - IO happens on it and it's placed into the page cache.  PG_arch_1 is
> >   still clear.
> >
> > - someone calls read()/write() which accesses the page.  The generic
> >   file IO layers call flush_dcache_page() in response to
> > read()/write()
> >   fs calls.  flush_dcache_page() spots that the page is not yet mapped
> >   into userspace, and sets PG_arch_1 to mark the fact that the kernel
> >   mapping is dirty.
> >
> > - when someone maps the page, we check PG_arch_1 in update_mmu_cache.
> >   If PG_arch_1 is set, we flush the kernel mapping.
> >
> > Clearly, if we go around having drivers clearing PG_arch_1, this is
> > going to break horribly.
> 
> Ok, you do things very differently than us on ppc then. We clear
> PG_arch_1 in flush_dcache_page(), and we set it when the page has been
> cache cleaned for execution.

For this perspective it's not that different, just that we use the
negated PG_arch_1.

> We assume that anybody that dirties a page in the kernel will call
> flush_dcache_page() which removes our PG_arch_1 bit thus marking the
> page "dirty".

This assumption is not valid with some drivers like USB HCD doing PIO.
But, yes, that's how it should be done.

> Note that from experience, doing the check & flushes in
> update_mmu_cache() is racy on SMP. At least for I$/D$, we have the case
> where processor one does set_pte followed by update_mmu_cache(). The
> later isn't done yet but processor 2 sees the PTE now and starts using
> it, cache hasn't been fully flushed yet. You may avoid that race in some
> ways, but on ppc, I've stopped using that.

I think that's possible on ARM too. Having two threads on different
CPUs, one thread triggers a prefetch abort (instruction page fault) on
CPU0 but the second thread on CPU1 may branch into this page after
set_pte() (hence not fault) but before update_mmu_cache() doing the
flush.

On ARM11MPCore we flush the caches in flush_dcache_page() because the
cache maintenance operations weren't visible to the other CPUs.
Cortex-A9 broadcasts the cache operations in hardware so we can use lazy
flushing but with the race you pointed out.

Using set_pte_at() for delayed flushing may be a better option for ARM
as well (and maybe Documentation/cachetlb.txt updated).

Thanks.

-- 
Catalin
