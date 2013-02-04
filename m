From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Feb 2013 14:10:53 +0000
Subject: [PATCHv2 1/2] ARM: dma-mapping: add support for CMA regions
 placed in highmem zone
In-Reply-To: <xa1tlib4b30n.fsf@mina86.com>
References: <1358350284-6972-2-git-send-email-m.szyprowski@samsung.com>
 <1359984182-6307-1-git-send-email-m.szyprowski@samsung.com>
 <xa1tlib4b30n.fsf@mina86.com>
Message-ID: <20130204141053.GD17786@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 02:51:52PM +0100, Michal Nazarewicz wrote:
> On Mon, Feb 04 2013, Marek Szyprowski wrote:
> > @@ -186,13 +186,24 @@ static u64 get_coherent_dma_mask(struct device *dev)
> >  
> >  static void __dma_clear_buffer(struct page *page, size_t size)
> >  {
> > -	void *ptr;
> >  	/*
> >  	 * Ensure that the allocated pages are zeroed, and that any data
> >  	 * lurking in the kernel direct-mapped region is invalidated.
> >  	 */
> > -	ptr = page_address(page);
> > -	if (ptr) {
> > +	if (PageHighMem(page)) {
> > +		phys_addr_t base = __pfn_to_phys(page_to_pfn(page));
> > +		phys_addr_t end = base + size;
> > +		while (size > 0) {
> > +			void *ptr = kmap_atomic(page);
> > +			memset(ptr, 0, PAGE_SIZE);
> > +			dmac_flush_range(ptr, ptr + PAGE_SIZE);
> > +			kunmap_atomic(ptr);
> > +			page++;
> > +			size -= PAGE_SIZE;
> > +		}
> > +		outer_flush_range(base, end);
> > +	} else {
> > +		void *ptr = page_address(page);
> 
> There used to be a ?if (ptr)? check which is now missing.  Why is that?

Because lowmem pages always have an address.
