From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 7 Dec 2015 08:19:27 -0800
Subject: [PATCH] drivers: dma-coherent: use ioremap_wc() for DMA_MEMORY_MAP
In-Reply-To: <20151207132823.GC13179@e106950-lin.cambridge.arm.com>
References: <1448029226-4914-1-git-send-email-brian.starkey@arm.com>
 <20151204105000.GD10123@e104818-lin.cambridge.arm.com>
 <CAPcyv4gti=49v4gUVjf=4nhxBCPPM3xmq6MQ2sBoBnKQbCS5MQ@mail.gmail.com>
 <20151204171554.GO10123@e104818-lin.cambridge.arm.com>
 <20151207132823.GC13179@e106950-lin.cambridge.arm.com>
Message-ID: <CAPcyv4iUHoQ2DRP-K-BA33mjdHwUxY2JX5M1-dP+bN-Rr6ewyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 7, 2015 at 5:28 AM, Brian Starkey <brian.starkey@arm.com> wrote:
> On Fri, Dec 04, 2015 at 05:15:54PM +0000, Catalin Marinas wrote:
>>
>> On Fri, Dec 04, 2015 at 08:59:10AM -0800, Dan Williams wrote:
>>>
>>> On Fri, Dec 4, 2015 at 2:50 AM, Catalin Marinas <catalin.marinas@arm.com>
>>> wrote:
>>> > On Fri, Nov 20, 2015 at 02:20:26PM +0000, Brian Starkey wrote:
>>> >> When the DMA_MEMORY_MAP flag is used, memory which can be accessed
>>> >> directly should be returned, so use ioremap_wc() instead of ioremap().
>>> >> Also, ensure that the correct memset operation is used in
>>> >> dma_alloc_from_coherent() with respect to the region's flags.
>>> >>
>>> >> This fixes the below alignment fault on arm64, caused by invalid use
>>> >> of memset() on Device memory.
>>> >
>>> > This is indeed affecting both arm32 and arm64 systems.
>>> >
>>> >> diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
>>> >> index 55b8398..45358d0 100644
>>> >> --- a/drivers/base/dma-coherent.c
>>> >> +++ b/drivers/base/dma-coherent.c
>>> >> @@ -31,7 +31,10 @@ static int dma_init_coherent_memory(phys_addr_t
>>> >> phys_addr, dma_addr_t device_add
>>> >>       if (!size)
>>> >>               goto out;
>>> >>
>>> >> -     mem_base = ioremap(phys_addr, size);
>>> >> +     if (flags & DMA_MEMORY_MAP)
>>> >> +             mem_base = ioremap_wc(phys_addr, size);
>>> >> +     else
>>> >> +             mem_base = ioremap(phys_addr, size);
>>> >
>>> > I wonder whether a memremap() approach for the DMA_MEMORY_MAP case
>>> > would
>>> > be better. This API was added recently by commit 92281dee825f ("arch:
>>> > introduce memremap()"). It only supports write-back and write-through
>>> > but we could add a MEMREMAP_WC flag for this case.
>>>
>>> I originally included both MEMREMAP_WC and MEMREAMP_UC as potential
>>> flags to this api, but ultimately decided against it.  The memremap()
>>> api is meant for memory that is known to have no i/o side effects.  As
>>> far as I can see WC and UC usages are a muddy mix of "sometimes
>>> there's I/O side effects, but it depends by arch and driver".  In
>>> other words we can't drop the "__iomem" annotation from WC and UC
>>> mappings by default.
>
>
> The DMA_MEMORY_MAP flag is pretty much a statement of "no side-
> effects", so as Catalin says it would fit OK here. That said, if it's
> not possible to deprecate ioremap_wc() in the same way as
> ioremap_cache() then I wonder if there's even much benefit in adding
> it to memremap().

I don't see a problem adding a _WC option to memremap.

The only difference is that it can't replace ioremap_wc.  I.e. unlike
_WB, and _WT case where ioremap_cache and ioremap_wt are now
deprecated we'd have ioremap_wc continuing to live alongside
memremap(..., MEMREMAP_WC).
