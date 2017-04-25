From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 25 Apr 2017 19:35:56 +0100
Subject: [RFC PATCH] drivers: dma-mapping: Do not attempt to create a
 scatterlist for from_coherent buffers
In-Reply-To: <20170425180525.GT17774@n2100.armlinux.org.uk>
References: <1493143059-2113-1-git-send-email-catalin.marinas@arm.com>
 <20170425180525.GT17774@n2100.armlinux.org.uk>
Message-ID: <20170425183556.GB18677@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 07:05:26PM +0100, Russell King - ARM Linux wrote:
> On Tue, Apr 25, 2017 at 06:57:39PM +0100, Catalin Marinas wrote:
> > Memory returned by dma_alloc_from_coherent() is not backed by struct
> > page and creating a scatterlist would use invalid page pointers. The
> > patch introduces the dma_vaddr_from_coherent() function and the
> > corresponding check in dma_get_sgtable_attrs().
> > 
> > Fixes: d2b7428eb0ca ("common: dma-mapping: introduce dma_get_sgtable() function")
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> > 
> > In a recent discussion around the iommu DMA ops on arm64, Russell
> > pointed out that dma_get_sgtable is not safe since the coherent DMA
> > memory is not always backed by struct page. Russell has queued an
> > arm-specific patch checking for pfn_valid() but I thought I'd make a
> > more generic fix. This patch aims to bring the dma_get_sgtable() API in
> > line with the dma_alloc/mmap/free with respect to the from_coherent
> > memory.
> 
> Sorry, I don't think this is the correct approach.
> 
> You're assuming that 'vaddr' will always be a valid lowmem address.
> That isn't always the case - some dma coherent allocations provide
> remapped memory.

I'm not assuming lowmem. The only thing this patch does is that if the
memory came from the dma_declare_coherent range, it returns -ENXIO. This
is in line with the dma_free_attrs() for example, which calls
dma_release_from_coherent(), but for sgtable this wouldn't make sense,
hence -ENXIO.

I agree with you that vaddr can be remapped (which is the case on arm64
as well) but it's the responsibility of the arch-specific
dma_ops->get_sgtable() to handle it properly (vmalloc_to_page etc.). The
fall-back dma_common_get_sgtable() does assume lowmem but it doesn't
mean that the arch DMA ops need to use it.

> The reason for dma_get_sgtable() existing is to coerce the DMA
> coherent memory into a scatterlist so that it can be passed through
> the dma_buf API - that's where the problem lies.  The dma_buf API
> needs fixing so that coherent memory can be sanely passed, and
> dma_get_sgtable() needs to be put out of its misery.

I agree but didn't dare to dig into this ;).

-- 
Catalin
