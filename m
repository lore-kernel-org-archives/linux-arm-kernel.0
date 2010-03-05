From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 05 Mar 2010 16:52:40 +0000
Subject: [RFC PATCH] ARM: Assume new page cache pages have dirty D-cache
In-Reply-To: <20100304214435.GJ13417@n2100.arm.linux.org.uk>
References: <20100304214435.GJ13417@n2100.arm.linux.org.uk>
Message-ID: <1267807960.2581.5.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-03-04 at 21:44 +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 04, 2010 at 06:36:42PM +0000, Catalin Marinas wrote:
> > ARM: Assume new page cache pages have dirty D-cache
> >
> > From: Catalin Marinas <catalin.marinas@arm.com>
> >
> > There are places in Linux where writes to newly allocated page cache
> > pages happen without a subsequent call to flush_dcache_page() (several
> > PIO drivers including USB HCD). This patch changes the meaning of
> > PG_arch_1 to be PG_dcache_clean and always flush the D-cache for a newly
> > mapped page in update_mmu_cache().
> >
> > The patch also sets the PG_arch_1 bit in the DMA cache maintenance
> > function to avoid additional cache flushing in update_mmu_cache().
> 
> As I just realised, this is going to subject all pages placed into
> userspace with a D cache flush - even anonymous pages, and those
> which we've been careful to deal with the cache issues already (eg,
> via the COW page copying code.)
> 
> I think all the copypage functions need to set PG_dcache_clean on the
> new pages once their copy has completed.

As Ben said, I think we can set PG_dcache_clean in the
clear/copy_user_page() functions. My doubt with these functions is the
highmem cases where kunmap_atomic() only flushes the D-cache in one
situation, the other just calling kunmap_high() which doesn't seem to do
anything to the caches.

But for non-aliasing VIPT, do we actually need the D-cache flushing in
kunmap_atomic() or copy_user_page()? If we default to new page being
dirty, I think we can remove the cache cleaning from this function and
leave it for update_mmu_cache (or set_pte_at but that's for a different
patch).

-- 
Catalin
