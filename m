From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 13 Jun 2017 10:03:28 +0100
Subject: [PATCH] arm64/dma-mapping: Fix null-pointer check
In-Reply-To: <20170612205028.y7a652hd46dakxdu@codeaurora.org>
References: <20170610194110.27712-1-ohaugan@codeaurora.org>
 <20170612122903.GC24187@e104818-lin.cambridge.arm.com>
 <20170612205028.y7a652hd46dakxdu@codeaurora.org>
Message-ID: <20170613090328.GA3302@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 01:50:28PM -0700, Olav Haugan wrote:
> On 17-06-12 13:29:04, Catalin Marinas wrote:
> > On Sat, Jun 10, 2017 at 12:41:10PM -0700, Olav Haugan wrote:
> > > @@ -149,6 +140,11 @@ static void *__dma_alloc(struct device *dev, size_t size,
> > >  	bool coherent = is_device_dma_coherent(dev);
> > >  	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, false);
> > >  
> > > +	if (!dev) {
> > > +		WARN_ONCE(1, "Use an actual device structure for DMA allocation\n");
> > > +		return NULL;
> > > +	}
> > > +
> > >  	size = PAGE_ALIGN(size);
> > >  
> > >  	if (!coherent && !gfpflags_allow_blocking(flags)) {
> > > @@ -192,8 +188,13 @@ static void __dma_free(struct device *dev, size_t size,
> > >  		       void *vaddr, dma_addr_t dma_handle,
> > >  		       unsigned long attrs)
> > >  {
> > > -	void *swiotlb_addr = phys_to_virt(dma_to_phys(dev, dma_handle));
> > > +	void *swiotlb_addr;
> > >  
> > > +	if (!dev) {
> > > +		WARN_ONCE(1, "Use an actual device structure for DMA free\n");
> > > +		return;
> > > +	}
> > > +	swiotlb_addr = phys_to_virt(dma_to_phys(dev, dma_handle));
> > 
> > I don't think we need the checks anymore. With commit 1dccb598df54
> > ("arm64: simplify dma_get_ops") __generic_dma_ops() returns
> > dummy_dma_ops when dev == NULL, so the above __dma_alloc/__dma_free
> > functions would not be called.
> 
> We don't need the check in is_device_dma_coherent() either then right?

Right. The only user of this function outside
arch/arm64/mm/dma-mapping.c is Xen (shared with arm32 under
arch/arm/xen/) but since arm32 doesn't do this NULL check either, we
should be fine.

-- 
Catalin
