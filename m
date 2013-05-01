From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 1 May 2013 15:22:06 +0100
Subject: [PATCH V3 2/2] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130430210403.GA18076@schnuecks.de>
References: <20121008202040.GC4625@n2100.arm.linux.org.uk>
 <20121008230733.GA17819@schnuecks.de>
 <20121118211005.GW22106@titan.lakedaemon.net>
 <20130418111608.GF27197@titan.lakedaemon.net>
 <20130418112201.GQ14496@n2100.arm.linux.org.uk>
 <20130418114016.GG27197@titan.lakedaemon.net>
 <20130418135104.GA18616@arm.com>
 <20130421220629.GA25571@schnuecks.de>
 <20130430112225.GD29766@arm.com>
 <20130430210403.GA18076@schnuecks.de>
Message-ID: <20130501142206.GB17387@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 30, 2013 at 10:04:03PM +0100, Simon Baatz wrote:
> On Tue, Apr 30, 2013 at 12:22:25PM +0100, Catalin Marinas wrote:
> > On Sun, Apr 21, 2013 at 11:06:30PM +0100, Simon Baatz wrote:
> > > On Thu, Apr 18, 2013 at 02:51:04PM +0100, Catalin Marinas wrote:
> > > > On Thu, Apr 18, 2013 at 12:40:16PM +0100, Jason Cooper wrote:
> ...
> > > 
> > > It is not the driver itself which is using the API, it is the
> > > generic scatterlist memory iterator. And I don't think that this is
> > > wrong, as I have tried to explain in [1].
> > 
> > Trying to remember what we've discussed over the past months on this
> > topic. It looks like sg_miter_stop() does the right thing in calling
> > flush_kernel_dcache_page(). Commit f8b63c1 (ARM: 6382/1: Remove
> > superfluous flush_kernel_dcache_page()) removed this function entirely.
> > The code previously had this comment - /* highmem pages are always
> > flushed upon kunmap already */ which I think it wasn't fully correct
> > either. The kunmap_atomic() flushes the caches but kunmap() doesn't, so
> > I suspect we only get the flushing if SG_MITER_ATOMIC.
> > 
> > So it looks to me like flush_kernel_dcache_page() should be implemented
> > even for highmem pages (with VIVT or aliasing VIPT, at least for non
> > kmap_atomic addresses by checking for FIXADDR_START). If highmem is
> > disabled, I suspect we still need this function since the calling code
> > doesn't care whether kmap/kunmap was a no-op. But can we keep it as a
> > simple call to __cpuc_flush_dcache_area(page_address(page), PAGE_SIZE)?
> 
> My first version ([1]) had:
> 
> 	if ((cache_is_vivt() || cache_is_vipt_aliasing()) && !PageHighMem(page))
> 		__flush_kernel_dcache_page(page);
> 
> If I understand this correctly, you are proposing to remove the
> highmem exclusion.

The highmem exclusion may have been there originally because of a
comment suggesting that kunmap() does the flushing. This is the case
only for kunmap_atomic() AFAICT (and maybe we could remove that as well
and rely on flush_kernel_dcache_page() being called).

> And then in __flush_kernel_dcache_page():
> 
> 	mapping = page_mapping(page);
> 
> 	if (!mapping || mapping_mapped(mapping))
> 		__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
> 
> I still prefer to have this condition here to avoid the flush when
> there is no user mapping at all.  This is handled by lazy flushing
> and is probably the most common case anyway (given how many people
> seem to be affected by this problem).

Looking at the old thread, you said there is a case when this condition
is not true (O_DIRECT case). If that's for a page cache page, then we
can handle it lazily (for anonymous pages I don't think we can rely on
lazy flushing since the kernel does not guarantee the clearing of the
PG_arch_1 bit).

> Additionally, although we can assume that the page is kmapped,
> page_address(page) can still be NULL for a highmem page, right?

It looks like kmap() always sets page_address(page) but I'm not sure
about kmap_atomic(), it doesn't seem to.

-- 
Catalin
