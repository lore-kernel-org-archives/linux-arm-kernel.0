From: mikpe@it.uu.se (Mikael Pettersson)
Date: Mon, 18 Feb 2013 10:08:53 +0100
Subject: ARM coherent allocs, Was: ixp4xx eth broken in 3.7.0/3.8-rc5?
In-Reply-To: <m3a9r2d5md.fsf_-_@intrepid.localdomain>
References: <20744.9777.937924.822371@pilspetsen.it.uu.se>
 <m34nhk9ef7.fsf@intrepid.localdomain>
 <m3a9r2d5md.fsf_-_@intrepid.localdomain>
Message-ID: <20769.61349.124371.633959@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Halasa writes:
 > Hi,
 > 
 > I'm not sure how is it supposed to work. Environment: IXP4xx CPU,
 > only 64 MB (of 256 MB) of RAM is available for PCI bus master DMA,
 > /dev/sda is a PATA CF or SATA SSD using CS5536-based PATA interface
 > (SATA - with a bridge) in DMA (PCI bus master) mode.
 > 
 > It works in PIO mode.
 > The problem seems to be this: pci_dev->dev.coherent_dma_mask is 0x3FFFFFF
 > (64MB-1). Yet __dma_alloc() called with GFP_DMA returns memory
 > physically located (dma_handle) above 64MB region.

Isn't that what the ARM-specific dma bounce allocator is supposed to
handle?  Or did e9da6e9905e639b0f842a244bc770b48ad0523e9 disable that one?

My ixp4xx box only has 64MB RAM so there is never any bouncing there,
in fact I patch my kernel to disable the bounce support entirely.

/Mikael

 > 
 > Bisecting shows this commit broke it:
 > 
 > > I haven't yet tried the Ethernet driver but it seems my IXP425 box
 > > doesn't like this while mounting a disk (PCI CS3356-based IDE CF card).
 > >
 > > commit e9da6e9905e639b0f842a244bc770b48ad0523e9
 > > Author: Marek Szyprowski <m.szyprowski@samsung.com>
 > > Date:   Mon Jul 30 09:11:33 2012 +0200
 > >
 > >     ARM: dma-mapping: remove custom consistent dma region
 > >
 > >     This patch changes dma-mapping subsystem to use generic vmalloc areas
 > >     for all consistent dma allocations. This increases the total size limit
 > >     of the consistent allocations and removes platform hacks and a lot of
 > >     duplicated code.
 > >
 > >     Atomic allocations are served from special pool preallocated on boot,
 > >     because vmalloc areas cannot be reliably created in atomic context.
 > 
 > I'm trying to understand it (current code as of v3.8rc-7):
 > 
 > static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 >                          gfp_t gfp, pgprot_t prot, bool is_coherent, const void *caller)
 > {
 >         u64 mask = get_coherent_dma_mask(dev);
 > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ This gets 64MB - 1
 >         struct page *page = NULL;
 >         void *addr;
 > 
 > #ifdef CONFIG_DMA_API_DEBUG
 >         u64 limit = (mask + 1) & ~mask;
 >         if (limit && size >= limit) {
 >                 dev_warn(dev, "coherent allocation too big (requested %#x mask %#llx)\n",
 >                         size, mask);
 >                 return NULL;
 >         }
 > #endif
 > 
 >         if (!mask)
 >                 return NULL;
 > 
 >         if (mask < 0xffffffffULL)
 >                 gfp |= GFP_DMA;
 > 
 >         /*
 >          * Following is a work-around (a.k.a. hack) to prevent pages
 >          * with __GFP_COMP being passed to split_page() which cannot
 >          * handle them.  The real problem is that this flag probably
 >          * should be 0 on ARM as it is not supported on this
 >          * platform; see CONFIG_HUGETLBFS.
 >          */
 >         gfp &= ~(__GFP_COMP);
 > 
 >         *handle = DMA_ERROR_CODE;
 >         size = PAGE_ALIGN(size);
 > 
 >         if (is_coherent || nommu())
 >                 addr = __alloc_simple_buffer(dev, size, gfp, &page);
 >         else if (!(gfp & __GFP_WAIT))
 >                 addr = __alloc_from_pool(size, &page);
 > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 >         else ...
 > 
 > Is the pool supposed to live in GFP_DMA area or should we use more
 > pools? We call __alloc_from_pool() but it knows nothing about our
 > device's coherent_dma_mask or GFP flags.
 > -- 
 > Krzysztof Halasa
 > 
