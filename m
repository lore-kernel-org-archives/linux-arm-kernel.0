From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2011 16:10:15 +0200
Subject: [PATCH 2/7] ARM: Samsung: update/rewrite Samsung SYSMMU (IOMMU)
	driver
In-Reply-To: <000001cc00bf$a3afc220$eb0f4660$%szyprowski@samsung.com>
References: <1303118804-5575-1-git-send-email-m.szyprowski@samsung.com>
	<201104211618.31418.arnd@arndb.de>
	<000001cc00bf$a3afc220$eb0f4660$%szyprowski@samsung.com>
Message-ID: <201104261610.15481.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 April 2011, Marek Szyprowski wrote:
> > * Create two codec devices in parallel and bind to both with your
> >   driver, ideally splitting up the resources between the two
> >   devices in a meaningful way.
> 
> Video codec has only standard 2 resources - ioregs and irq, so there
> is not much left for such splitting.

Ok, I see.

> > None of them are extremely nice, but it's not that hard either.
> > You should probably prototype a few of these approaches to see
> > which one is the least ugly one.
> 
> Ok. Today while iterating over the hardware requirements I noticed
> one more thing. Our codec hardware has one more, odd requirement for
> video buffers. The DMA addresses need to be aligned to 8KiB or 16KiB
> (depending on buffer type). Do you have any idea how this can be
> handled in a generic way?

I don't think you can force the mappings to be aligned to that size
in the streaming mapping, but you should be able to just align inside
of dma_map_single etc and map a larger region.

For the allocation functions (dma_alloc_coherent, dma_alloc_noncoherent),
using alloc_pages to allocate multiples of the size you need should
always give you aligned buffers because of the way that the underlying
buddy allocator works.

	Arnd
