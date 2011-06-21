From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 21 Jun 2011 13:23:35 +0200
Subject: [PATCH 7/8] common: dma-mapping: change alloc/free_coherent method
	to more generic alloc/free_attrs
In-Reply-To: <BANLkTikFdrOuXsLCfvyA_V+p7S_fd72dyQ@mail.gmail.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-8-git-send-email-m.szyprowski@samsung.com>
	<BANLkTikFdrOuXsLCfvyA_V+p7S_fd72dyQ@mail.gmail.com>
Message-ID: <002401cc3005$a941c010$fbc54030$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, June 20, 2011 4:46 PM KyongHo Cho wrote:

> On Mon, Jun 20, 2011 at 4:50 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> 
> > ?struct dma_map_ops {
> > - ? ? ? void* (*alloc_coherent)(struct device *dev, size_t size,
> > - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dma_addr_t *dma_handle, gfp_t gfp);
> > - ? ? ? void (*free_coherent)(struct device *dev, size_t size,
> > - ? ? ? ? ? ? ? ? ? ? ? ? ? ? void *vaddr, dma_addr_t dma_handle);
> > + ? ? ? void* (*alloc)(struct device *dev, size_t size,
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dma_addr_t *dma_handle, gfp_t gfp,
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct dma_attrs *attrs);
> > + ? ? ? void (*free)(struct device *dev, size_t size,
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? void *vaddr, dma_addr_t dma_handle,
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct dma_attrs *attrs);
> > + ? ? ? int (*mmap)(struct device *, struct vm_area_struct *,
> > + ? ? ? ? ? ? ? ? ? ? ? ? void *, dma_addr_t, size_t, struct dma_attrs
> *attrs);
> > +
> > ? ? ? ?dma_addr_t (*map_page)(struct device *dev, struct page *page,
> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned long offset, size_t size,
> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? enum dma_data_direction dir,
> 
> I still don't agree with your idea that change alloc_coherent() with
> alloc().

> As I said before, we actually do not need dma_alloc_writecombine() anymore
> because it is not different from dma_alloc_coherent() in ARM.

You already got a reply that dropping dma_alloc_writecombine() is no
go on ARM.

> Most of other architectures do not have dma_alloc_writecombine().

That's not a problem. Once we agree on dma_alloc_attrs(), the drivers
can be changed to use DMA_ATTR_WRITE_COMBINE attribute. If the platform
doesn't support the attribute, it is just ignored. That's the whole
point of the attributes extension. Once a driver is converted to 
dma_alloc_attrs(), it can be used without any changes either on platforms
that supports some specific attributes or the one that doesn't implement
support for any of them.

> If you want dma_alloc_coherent() to allocate user virtual address,
> I believe that it is also available with mmap() you introduced.

Allocation is a separate operation from mapping to userspace. Mmap
operation should just map the buffer (represented by a cookie of type
dma_addr_t) to user address space.

Note that some drivers (like framebuffer drivers for example) also
needs to have both types of mapping - one for user space and one for
kernel virtual space.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
