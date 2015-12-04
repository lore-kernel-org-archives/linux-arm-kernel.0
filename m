From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Dec 2015 17:15:54 +0000
Subject: [PATCH] drivers: dma-coherent: use ioremap_wc() for DMA_MEMORY_MAP
In-Reply-To: <CAPcyv4gti=49v4gUVjf=4nhxBCPPM3xmq6MQ2sBoBnKQbCS5MQ@mail.gmail.com>
References: <1448029226-4914-1-git-send-email-brian.starkey@arm.com>
 <20151204105000.GD10123@e104818-lin.cambridge.arm.com>
 <CAPcyv4gti=49v4gUVjf=4nhxBCPPM3xmq6MQ2sBoBnKQbCS5MQ@mail.gmail.com>
Message-ID: <20151204171554.GO10123@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2015 at 08:59:10AM -0800, Dan Williams wrote:
> On Fri, Dec 4, 2015 at 2:50 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Fri, Nov 20, 2015 at 02:20:26PM +0000, Brian Starkey wrote:
> >> When the DMA_MEMORY_MAP flag is used, memory which can be accessed
> >> directly should be returned, so use ioremap_wc() instead of ioremap().
> >> Also, ensure that the correct memset operation is used in
> >> dma_alloc_from_coherent() with respect to the region's flags.
> >>
> >> This fixes the below alignment fault on arm64, caused by invalid use
> >> of memset() on Device memory.
> >
> > This is indeed affecting both arm32 and arm64 systems.
> >
> >> diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
> >> index 55b8398..45358d0 100644
> >> --- a/drivers/base/dma-coherent.c
> >> +++ b/drivers/base/dma-coherent.c
> >> @@ -31,7 +31,10 @@ static int dma_init_coherent_memory(phys_addr_t phys_addr, dma_addr_t device_add
> >>       if (!size)
> >>               goto out;
> >>
> >> -     mem_base = ioremap(phys_addr, size);
> >> +     if (flags & DMA_MEMORY_MAP)
> >> +             mem_base = ioremap_wc(phys_addr, size);
> >> +     else
> >> +             mem_base = ioremap(phys_addr, size);
> >
> > I wonder whether a memremap() approach for the DMA_MEMORY_MAP case would
> > be better. This API was added recently by commit 92281dee825f ("arch:
> > introduce memremap()"). It only supports write-back and write-through
> > but we could add a MEMREMAP_WC flag for this case.
> 
> I originally included both MEMREMAP_WC and MEMREAMP_UC as potential
> flags to this api, but ultimately decided against it.  The memremap()
> api is meant for memory that is known to have no i/o side effects.  As
> far as I can see WC and UC usages are a muddy mix of "sometimes
> there's I/O side effects, but it depends by arch and driver".  In
> other words we can't drop the "__iomem" annotation from WC and UC
> mappings by default.

In this context, the dma_declare_coherent_memory(DMA_MEMORY_MAP)
implementation is aimed at normal RAM with no side effects as later
returned by dma_alloc_coherent(). To me it looks like memremap is better
suited here for the DMA_MEMORY_MAP case. As per the
Documentation/DMA-API.txt:

  DMA_MEMORY_MAP - request that the memory returned from
  dma_alloc_coherent() be directly writable.

which means no __iomem. Of course, we still need ioremap for
DMA_MEMORY_IO which is supposed to be written with memcpy_toio() etc.

Which memory type should be used is left to the driver and it should
pass the corresponding DMA_MEMORY_* flag.

-- 
Catalin
