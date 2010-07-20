From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 20 Jul 2010 17:01:27 +0100
Subject: [RFC PATCH] ARM: Allow lazy cache flushing via PG_arch_1 for
	highmem pages
In-Reply-To: <alpine.LFD.2.00.1007201715470.25803@xanadu.home>
References: <20100720124102.7163.46919.stgit@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1007201458430.24916@xanadu.home>
	<alpine.LFD.2.00.1007201715470.25803@xanadu.home>
Message-ID: <1279641687.10002.45.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-07-20 at 16:17 +0100, Nicolas Pitre wrote:
> On Tue, 20 Jul 2010, Nicolas Pitre wrote:
> 
> > On Tue, 20 Jul 2010, Catalin Marinas wrote:
> >
> > > Current flush_dcache_page() implementation does not allow lazy cache
> > > flushing for highmem pages (introduced by commit d73cd42) on the
> > > assumption that the temporary kmap mapping would disappear. A subsequent
> > > commit (7e5a69e) allows __flush_dcache_page() to handle highmem pages so
> > > we can allow lazy cache flushing even for highmem pages.
> >
> > Actually this has been in the back of my mind for a while.  The
> > reasoning in d73cd42 is flawed, irrespective of the changes in 7e5a69e. 
> > Even without the later, it should have been possible to lazily flush the
> > himem pages because they get flushed anyway the moment their virtual
> > mapping goes away through flush_cache_kmaps().  What the second commit
> > is doing is making highmem usable on a VIPT system while it was totally
> > unacounted for and broken before.
> >
> > Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> BTW, while I agree with the patch, you might have guessed that I prefer
> that the commit message be changed to more reflect reality.

I didn't figure out what you meant exactly since without 7e5a69e,
__flush_dcache_page() called from update_mmu_cache() may fault.

Anyway, does this sound ok? Thanks.


ARM: Allow lazy cache flushing via PG_arch_1 for highmem pages

From: Catalin Marinas <catalin.marinas@arm.com>

Commit d73cd42 forced non-lazy cache flushing of highmem pages in
flush_dcache_page(). This isn't needed since __flush_dcache_page()
(called lazily from update_mmu_cache) can handle highmem pages (fixed by
commit 7e5a69e).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mm/flush.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index c6844cb..87dd5ff 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -247,7 +247,7 @@ void flush_dcache_page(struct page *page)
 	mapping = page_mapping(page);
 
 #ifndef CONFIG_SMP
-	if (!PageHighMem(page) && mapping && !mapping_mapped(mapping))
+	if (mapping && !mapping_mapped(mapping))
 		set_bit(PG_dcache_dirty, &page->flags);
 	else
 #endif
