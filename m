From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 6 May 2013 00:26:47 +0200
Subject: [PATCH V3 2/2] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130503100242.GB29962@arm.com>
References: <20130418114016.GG27197@titan.lakedaemon.net>
 <20130418135104.GA18616@arm.com>
 <20130421220629.GA25571@schnuecks.de>
 <20130430112225.GD29766@arm.com>
 <20130430210403.GA18076@schnuecks.de>
 <20130501142206.GB17387@arm.com>
 <20130501190441.GA22227@schnuecks.de>
 <20130502095431.GA20730@arm.com>
 <20130502193835.GA29144@schnuecks.de>
 <20130503100242.GB29962@arm.com>
Message-ID: <20130505222645.GA1433@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 03, 2013 at 11:02:42AM +0100, Catalin Marinas wrote:
> On Thu, May 02, 2013 at 08:38:36PM +0100, Simon Baatz wrote:
> > On Thu, May 02, 2013 at 10:54:31AM +0100, Catalin Marinas wrote:
> > > On Wed, May 01, 2013 at 08:04:41PM +0100, Simon Baatz wrote:
> > > > On Wed, May 01, 2013 at 03:22:06PM +0100, Catalin Marinas wrote:
> > > > > On Tue, Apr 30, 2013 at 10:04:03PM +0100, Simon Baatz wrote:
> > > > > > On Tue, Apr 30, 2013 at 12:22:25PM +0100, Catalin Marinas wrote:
> > > > > > > On Sun, Apr 21, 2013 at 11:06:30PM +0100, Simon Baatz wrote:
> > > > > > > > On Thu, Apr 18, 2013 at 02:51:04PM +0100, Catalin Marinas wrote:
> > > > > > > > > On Thu, Apr 18, 2013 at 12:40:16PM +0100, Jason Cooper wrote:
...
> 
> I haven't run the tests but I can see  why it fails without
> flush_kernel_dcache_page(). So I think this function needs to be
> implemented for aliasing VIPT or VIVT caches.
> 
> > It is even needed in flush_dcache_page() as long as everybody
> > continues to use flush_dcache_page() instead of
> > flush_kernel_dcache_page() when appropriate...
> > (This is probably the main reason why the problem I reported is so
> > uncommon: Everybody seems to use flush_dcache_page() and since it
> > flushes the kernel mapping in these cases, everything is fine.)
> 
> That's why for non-aliasing VIPT we could make it just a clear_bit() and
> let the callers fix their API usage.

Do you mean the unnecessary flush for anon pages or also the D/I
flush for user space mapped page cache pages?

For anon pages, that was the content of the patch you acked ([1])
once.  However, Russel did not like the idea to use the
PG_dcache_clean bit also for anon pages.

I have a newer version that does the following: Do nothing for
mapping == NULL on non-aliasing VIPT in flush_dcache_page().  In
__sync_icache_dcache() flush if mapping == NULL (always on aliasing
VIPT, only if pte_exec() on non-aliasing VIPT).
 
> > > > > > Additionally, although we can assume that the page is kmapped,
> > > > > > page_address(page) can still be NULL for a highmem page, right?
> > > > > 
> > > > > It looks like kmap() always sets page_address(page) but I'm not sure
> > > > > about kmap_atomic(), it doesn't seem to.
> > > > 
> > > > Hmm, in __flush_dcache_page() we have the following code to flush the
> > > > kernel mapping:
> > > > 
> > > > void __flush_dcache_page(struct address_space *mapping, struct page *page)
> > > > {
> > > > 	/*
> > > > 	 * Writeback any data associated with the kernel mapping of this
> > > > 	 * page.  This ensures that data in the physical page is mutually
> > > > 	 * coherent with the kernels mapping.
> > > > 	 */
> > > > 	if (!PageHighMem(page)) {
> > > > 		__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
> > > > 	} else {
> > > > 		void *addr = kmap_high_get(page);
> > > > 		if (addr) {
> > > > 			__cpuc_flush_dcache_area(addr, PAGE_SIZE);
> > > > 			kunmap_high(page);
> > > > 		} else if (cache_is_vipt()) {
> > > > 			/* unmapped pages might still be cached */
> > > > 			addr = kmap_atomic(page);
> > > > 			__cpuc_flush_dcache_area(addr, PAGE_SIZE);
> > > > 			kunmap_atomic(addr);
> > > > 		}
> > > > 	}
> > > > ...
> > > > 
> > > > 
> > > > We probably should reuse it in flush_kernel_dcache_page() to flush
> > > > the kernel mapping. (The last else clause looks strange though)
> > > 
> > > I think it makes sense to reuse this logic in
> > > flush_kernel_dcache_page(). If the page is already mapped with kmap,
> > > then kmap_high_get() should return the actual address. If it was mapped
> > > with kmap_atomic, kmap_high_get() would return NULL, hence the 'else'
> > > clause and the additional kmap_atomic(). The cache_is_vipt() check is
> > > useful because kunmap_atomic() would flush VIVT caches anyway.
> > 
> > Yes, but why don't we flush for VIPT _aliasing_ already in
> > kunmap_atomic?
> 
> Some comment from Nico on the list, it seems that highmem does not work
> with aliasing VIPT caches:
> 
> http://article.gmane.org/gmane.linux.ports.arm.kernel/85114
> 
> > Why do we need to do anything for non-aliasing VIPT here?
> 
> Do you mean __flush_dcache_page()? I don't think we need.
> 
> > > As for __flush_dcache_page() called from other places like
> > > flush_dcache_page(), because of this 'else if' clause it looks like it
> > > misses flushing unmapped highmem pages on VIVT cache.
> > 
> > How many users do we have with VIVT D-caches using highmem? (This is
> > not a rhetorical questions, I have no idea.  However, I would assume
> > that this use case is almost non-existent.)
> 
> I don't really know. Maybe Nico has more info.
> 
> So my proposal:
> 
> 1. Non-aliasing VIPT - defer any D-cache flushing until
>    __sync_icache_dcache() (and fix callers like uprobes)

See above, not sure whether we can also get rid of the I-cache flush.

> 2. Aliasing VIPT or VIVT - flush the aliases as before in
>    flush_dcache_page()

Yes.

> 3. Aliasing VIPT or VIVT - implement flush_kernel_dcache_page() for all
>    pages (don't check for PageHighmem)

Ok, I will update the first version of my patch.

> 4. VIVT - remove cache flushing from kunmap_atomic and rely on
>    flush_kernel_dcache_page()
> 
> I'm not entirely sure about 4 but at the moment kunmap() doesn't flush
> caches, only kunmap_atomic() so it looks like an inconsistency.

Not sure either. 

- Simon

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-October/124291.html
