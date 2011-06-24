From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 24 Jun 2011 09:20:27 +0200
Subject: [Linaro-mm-sig] [PATCH 7/8] common: dma-mapping: change
	alloc/free_coherent method to more generic alloc/free_attrs
In-Reply-To: <BANLkTinDN-FF5=8uj9pP58Ny0-LUMtjh=g@mail.gmail.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-8-git-send-email-m.szyprowski@samsung.com>
	<BANLkTikFdrOuXsLCfvyA_V+p7S_fd72dyQ@mail.gmail.com>
	<002401cc3005$a941c010$fbc54030$%szyprowski@samsung.com>
	<BANLkTinDN-FF5=8uj9pP58Ny0-LUMtjh=g@mail.gmail.com>
Message-ID: <000001cc323f$3114d8c0$933e8a40$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, June 22, 2011 2:01 AM KyongHo Cho wrote:

> 2011/6/21 Marek Szyprowski <m.szyprowski@samsung.com>:
> >
> > You already got a reply that dropping dma_alloc_writecombine() is no
> > go on ARM.
> >
> Yes.
> 
> > That's not a problem. Once we agree on dma_alloc_attrs(), the drivers
> > can be changed to use DMA_ATTR_WRITE_COMBINE attribute. If the platform
> > doesn't support the attribute, it is just ignored. That's the whole
> > point of the attributes extension. Once a driver is converted to
> > dma_alloc_attrs(), it can be used without any changes either on platforms
> > that supports some specific attributes or the one that doesn't implement
> > support for any of them.
> >
> I just worried that removing an existing construct is not a simple job.
> You introduced 3 attributes: DMA_ATTR_WRITE_COMBINE, ***COHERENT and
> ***NO_KERNEL_VADDR

COHERENT is the default behavior when no attribute is provided. I also
don't want to remove existing calls to dma_alloc_coherent() and 
dma_alloc_writecombine() from the drivers. This can be done later, once
dma_alloc_attrs() API will stabilize.

> I replied earlier, I also indicated that write combining option for
> dma_alloc_*() is required.
> But it does not mean dma_map_ops must support that.
> I think dma_alloc_writecombine() can be implemented regardless of
> dma_map_ops.

The discussion about the need of dma_alloc_attrs() has been performed on
Memory Management Summit at Linaro Meeting in Budapest. It simplifies the
API and provides full backward compatibility for existing drivers.
 
> > Allocation is a separate operation from mapping to userspace. Mmap
> > operation should just map the buffer (represented by a cookie of type
> > dma_addr_t) to user address space.
> >
> > Note that some drivers (like framebuffer drivers for example) also
> > needs to have both types of mapping - one for user space and one for
> > kernel virtual space.
> 
> I meant that I think DMA_ATTR_NOKERNELVADDR is not required because
> you also introduced mmap callback.

I've already said that mmap callback is not related to the fact that the
buffer has been allocated with or without respective kernel virtual space
mapping. I really don't get what do you mean here.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
