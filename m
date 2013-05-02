From: gmbnomis@gmail.com (Simon Baatz)
Date: Thu, 2 May 2013 21:38:36 +0200
Subject: [PATCH V3 2/2] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130502095431.GA20730@arm.com>
References: <20130418111608.GF27197@titan.lakedaemon.net>
 <20130418112201.GQ14496@n2100.arm.linux.org.uk>
 <20130418114016.GG27197@titan.lakedaemon.net>
 <20130418135104.GA18616@arm.com>
 <20130421220629.GA25571@schnuecks.de>
 <20130430112225.GD29766@arm.com>
 <20130430210403.GA18076@schnuecks.de>
 <20130501142206.GB17387@arm.com>
 <20130501190441.GA22227@schnuecks.de>
 <20130502095431.GA20730@arm.com>
Message-ID: <20130502193835.GA29144@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Thu, May 02, 2013 at 10:54:31AM +0100, Catalin Marinas wrote:
> On Wed, May 01, 2013 at 08:04:41PM +0100, Simon Baatz wrote:
> > On Wed, May 01, 2013 at 03:22:06PM +0100, Catalin Marinas wrote:
> > > On Tue, Apr 30, 2013 at 10:04:03PM +0100, Simon Baatz wrote:
> > > > On Tue, Apr 30, 2013 at 12:22:25PM +0100, Catalin Marinas wrote:
> > > > > On Sun, Apr 21, 2013 at 11:06:30PM +0100, Simon Baatz wrote:
> > > > > > On Thu, Apr 18, 2013 at 02:51:04PM +0100, Catalin Marinas wrote:
> > > > > > > On Thu, Apr 18, 2013 at 12:40:16PM +0100, Jason Cooper wrote:
> > > > ...
> > > > > > 
> > > > > > It is not the driver itself which is using the API, it is the
> > > > > > generic scatterlist memory iterator. And I don't think that this is
> > > > > > wrong, as I have tried to explain in [1].
> > > > > 
> > > > > Trying to remember what we've discussed over the past months on this
> > > > > topic. It looks like sg_miter_stop() does the right thing in calling
> > > > > flush_kernel_dcache_page(). Commit f8b63c1 (ARM: 6382/1: Remove
> > > > > superfluous flush_kernel_dcache_page()) removed this function entirely.
> > > > > The code previously had this comment - /* highmem pages are always
> > > > > flushed upon kunmap already */ which I think it wasn't fully correct
> > > > > either. The kunmap_atomic() flushes the caches but kunmap() doesn't, so
> > > > > I suspect we only get the flushing if SG_MITER_ATOMIC.
> > > > > 
> > > > > So it looks to me like flush_kernel_dcache_page() should be implemented
> > > > > even for highmem pages (with VIVT or aliasing VIPT, at least for non
> > > > > kmap_atomic addresses by checking for FIXADDR_START). If highmem is
> > > > > disabled, I suspect we still need this function since the calling code
> > > > > doesn't care whether kmap/kunmap was a no-op. But can we keep it as a
> > > > > simple call to __cpuc_flush_dcache_area(page_address(page), PAGE_SIZE)?
> > > > 
> > > > My first version ([1]) had:
> > > > 
> > > > 	if ((cache_is_vivt() || cache_is_vipt_aliasing()) && !PageHighMem(page))
> > > > 		__flush_kernel_dcache_page(page);
> > > > 
> > > > If I understand this correctly, you are proposing to remove the
> > > > highmem exclusion.
> > > 
> > > The highmem exclusion may have been there originally because of a
> > > comment suggesting that kunmap() does the flushing. This is the case
> > > only for kunmap_atomic() AFAICT (and maybe we could remove that as well
> > > and rely on flush_kernel_dcache_page() being called).
> > > 
> > > > And then in __flush_kernel_dcache_page():
> > > > 
> > > > 	mapping = page_mapping(page);
> > > > 
> > > > 	if (!mapping || mapping_mapped(mapping))
> > > > 		__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
> > > > 
> > > > I still prefer to have this condition here to avoid the flush when
> > > > there is no user mapping at all.  This is handled by lazy flushing
> > > > and is probably the most common case anyway (given how many people
> > > > seem to be affected by this problem).
> > > 
> > > Looking at the old thread, you said there is a case when this condition
> > > is not true (O_DIRECT case). If that's for a page cache page, then we
> > > can handle it lazily (for anonymous pages I don't think we can rely on
> > > lazy flushing since the kernel does not guarantee the clearing of the
> > > PG_arch_1 bit).
> > 
> > As Russel pointed out in a comment to a later version of the patch,
> > PG_arch_1 makes only sense for page cache pages. The condition above
> > is ok from my point of view (it is based on what flush_dcache_page()
> > uses):
> > 
> > - Page cache page without user space mapping:
> > mapping != NULL and mapping_mapped() == 0
> > 
> > -> no flush here; lazy flush based on PG_arch_1 later if needed (we
> >    rely on the proper initialization of the page to "dirty" here.)
> 
> Indeed.
> 
> > - Page cache page with user space mapping:
> > mapping != NULL and mapping_mapped() != 0
> > 
> > -> kernel mapping flushed here (user mapping can be assumed to be clean)
> 
> We had similar thoughts for AArch64 here and decided it's not needed, it
> can just clear the PG_arch_1 bit and do it lazily (patches not pushed
> yet, need more testing). This assumes that even if mapping_mapped(), the
> page is not actually mapped in user space and we eventually get a
> set_pte_at() call. That's what powerpc is doing.

For arm64 only I-/D-cache coherency is relevant, right? In this case,
that may be right (but you may want to have a look at what
xol_get_insn_slot() in kernel/events/uprobes.c does.  I don't know
what kind of pages it handles, but this looks suspicious. And I think
uprobes are also available for powerpc).

However, if you can have aliases in D-cache this is needed.  See
below to trigger this on pages that are already mapped
to user space (direct I/O into a memory mapped file).
 
> > - Anonymous page:
> > mapping == NULL
> > 
> > -> kernel mapping flushed here (user mapping can be assumed to be clean)
> 
> I don't think it should care about anonymous pages at all. I put a
> WARN_ON(!mapping) in flush_dcache_page() and it hasn't triggered yet,
> though not intensive testing.

I assume that you inhibited the call to flush_dcache_page() in
__get_user_pages() for anon pages.  Otherwise, you will be flooded
with warnings.

DIY steps to produce both cases:
(We will need software encryption, thus I need to remove the hardware
encryption module mv_cesa on my hardware first)

# rmmod mv_cesa     
# wget -O mapping_tests.c http://ubuntuone.com/0jF9fNsguN8BvI1Z8fsBVI
# gcc -o mapping_tests mapping_tests.c
# dd if=/dev/urandom of=map.out bs=4k count=10
# dd if=/dev/urandom of=cdevice.img bs=4k count=10
# losetup /dev/loop0 cdevice.img 
# cryptsetup -c aes create c_sda2 /dev/loop0
<enter any passphrase>
# ./mapping_tests

cryptsetup will already trigger the warning and mapping_tests should
flood your console.
 
Since flush_kernel_dcache_page() is supposed to handle user space
pages, it must flush the kernel mapping in these cases.  Running the
above on a device driver using an unpatched
flush_kernel_dcache_page() yields:

# ./mapping_tests 
Anonymous page: differs!
User space mapped page: differs!

It is even needed in flush_dcache_page() as long as everybody
continues to use flush_dcache_page() instead of
flush_kernel_dcache_page() when appropriate...
(This is probably the main reason why the problem I reported is so
uncommon: Everybody seems to use flush_dcache_page() and since it
flushes the kernel mapping in these cases, everything is fine.)

> > > > Additionally, although we can assume that the page is kmapped,
> > > > page_address(page) can still be NULL for a highmem page, right?
> > > 
> > > It looks like kmap() always sets page_address(page) but I'm not sure
> > > about kmap_atomic(), it doesn't seem to.
> > 
> > Hmm, in __flush_dcache_page() we have the following code to flush the
> > kernel mapping:
> > 
> > void __flush_dcache_page(struct address_space *mapping, struct page *page)
> > {
> > 	/*
> > 	 * Writeback any data associated with the kernel mapping of this
> > 	 * page.  This ensures that data in the physical page is mutually
> > 	 * coherent with the kernels mapping.
> > 	 */
> > 	if (!PageHighMem(page)) {
> > 		__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
> > 	} else {
> > 		void *addr = kmap_high_get(page);
> > 		if (addr) {
> > 			__cpuc_flush_dcache_area(addr, PAGE_SIZE);
> > 			kunmap_high(page);
> > 		} else if (cache_is_vipt()) {
> > 			/* unmapped pages might still be cached */
> > 			addr = kmap_atomic(page);
> > 			__cpuc_flush_dcache_area(addr, PAGE_SIZE);
> > 			kunmap_atomic(addr);
> > 		}
> > 	}
> > ...
> > 
> > 
> > We probably should reuse it in flush_kernel_dcache_page() to flush
> > the kernel mapping. (The last else clause looks strange though)
> 
> I think it makes sense to reuse this logic in
> flush_kernel_dcache_page(). If the page is already mapped with kmap,
> then kmap_high_get() should return the actual address. If it was mapped
> with kmap_atomic, kmap_high_get() would return NULL, hence the 'else'
> clause and the additional kmap_atomic(). The cache_is_vipt() check is
> useful because kunmap_atomic() would flush VIVT caches anyway.

Yes, but why don't we flush for VIPT _aliasing_ already in
kunmap_atomic? Why do we need to do anything for non-aliasing VIPT
here?
 
> As for __flush_dcache_page() called from other places like
> flush_dcache_page(), because of this 'else if' clause it looks like it
> misses flushing unmapped highmem pages on VIVT cache.

How many users do we have with VIVT D-caches using highmem? (This is
not a rhetorical questions, I have no idea.  However, I would assume
that this use case is almost non-existent.)

- Simon
