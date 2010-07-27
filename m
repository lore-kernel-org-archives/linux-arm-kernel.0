From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Tue, 27 Jul 2010 23:21:37 +0900
Subject: [PATCHv2 2/4] mm: cma: Contiguous Memory Allocator added
In-Reply-To: <20100727065842.40ae76c8@bike.lwn.net>
References: <20100727120841.GC11468@n2100.arm.linux.org.uk>
	<003701cb2d89$adae4580$090ad080$%szyprowski@samsung.com>
	<20100727065842.40ae76c8@bike.lwn.net>
Message-ID: <20100727232106Z.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Jul 2010 06:58:42 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> On Tue, 27 Jul 2010 14:45:58 +0200
> Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> 
> > > How does one obtain the CPU address of this memory in order for the CPU
> > > to access it?  
> > 
> > Right, we did not cover such case. In CMA approach we tried to separate
> > memory allocation from the memory mapping into user/kernel space. Mapping
> > a buffer is much more complicated process that cannot be handled in a
> > generic way, so we decided to leave this for the device drivers. Usually
> > video processing devices also don't need in-kernel mapping for such
> > buffers at all.
> 
> Still...that *is* why I suggested an interface which would return both
> the DMA address and a kernel-space virtual address, just like the DMA
> API does...  Either that, or just return the void * kernel address and

The DMA API for coherent memory (dma_alloc_coherent) returns both an
DMA address and a kernel-space virtual address because it does both
allocation and mapping.

However, other DMA API (dma_map_*) returns only an DMA address because
it does only mapping.

I think that if we need new API for coherent memory, we could
unify it with the DMA API for coherent memory.

IMO, it's cleaner to having two separate APIs for allocation and
mapping (except for coherent memory). The drivers have been working
in that way.
