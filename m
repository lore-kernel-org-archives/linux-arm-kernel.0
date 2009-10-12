From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Oct 2009 11:00:23 +0100
Subject: [PATCH] [ARM] force dcache flush if dcache_dirty bit set
In-Reply-To: <20091012.023744.157085851.davem@davemloft.net>
References: <1255337423-3158-1-git-send-email-ngupta@vflare.org>
	<20091012090710.GA29310@n2100.arm.linux.org.uk>
	<20091012.023744.157085851.davem@davemloft.net>
Message-ID: <20091012100023.GC29310@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2009 at 02:37:44AM -0700, David Miller wrote:
> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Date: Mon, 12 Oct 2009 10:07:10 +0100
> 
> > On Mon, Oct 12, 2009 at 02:20:23PM +0530, Nitin Gupta wrote:
> >> Same problem exists on mips too.
> > 
> > Nice catch.  This logic came from sparc64, so I think you'd want to talk
> > to davem about it as well.
> > 
> > In the mean time, submitting your fix to the patch system would be great,
> > thanks.
> 
> Sparc64 flushes unconditionally when there is no page mapping.
> So, it should be fine here.

Are you sure - I checked the sparc64 code before posting, and we're doing
the same thing.

Sparc64 update_mmu_cache:
        page = pfn_to_page(pfn);
        if (page && page_mapping(page)) {
                pg_flags = page->flags;
                if (pg_flags & (1UL << PG_dcache_dirty)) {
			/* do lazy flush */
		}
	}

Sparc64 flush_dcache_page:
        mapping = page_mapping(page);
        if (mapping && !mapping_mapped(mapping)) {
                set_dcache_dirty(page, this_cpu);
	}

ARM update_mmu_cache:
        page = pfn_to_page(pfn);
        mapping = page_mapping(page);
        if (mapping) {
                int dirty = test_and_clear_bit(PG_dcache_dirty, &page->flags);
                if (dirty)
                        /* do lazy flush */

ARM flush_dcache_page:
        struct address_space *mapping = page_mapping(page);
        if (!PageHighMem(page) && mapping && !mapping_mapped(mapping))
                set_bit(PG_dcache_dirty, &page->flags);

It looks identical to me.

The problem which has been identified is that when flush_dcache_page() is
called, there is a mapping, and so the page is marked for lazy flushing.
However, by the time update_mmu_cache() gets called, the mapping has gone
and so update_mmu_cache() does nothing.
