From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 13 Jan 2017 12:17:24 +0000
Subject: [PATCH] iommu/dma: Add support for DMA_ATTR_FORCE_CONTIGUOUS
In-Reply-To: <CAMuHMdWBfTm_QRuB7x-ZDh0bgGmHokqm7=F2b0rjQTYzizC9hA@mail.gmail.com>
References: <1484305674-15018-1-git-send-email-geert+renesas@glider.be>
 <d336ef3b-4fe6-5ebb-9fed-071fa79028df@arm.com>
 <CAMuHMdWBfTm_QRuB7x-ZDh0bgGmHokqm7=F2b0rjQTYzizC9hA@mail.gmail.com>
Message-ID: <0e5c066f-ddf6-30ce-392e-79bd0f401a18@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/17 11:59, Geert Uytterhoeven wrote:
> Hi Robin,
> 
> On Fri, Jan 13, 2017 at 12:32 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 13/01/17 11:07, Geert Uytterhoeven wrote:
>>> Add support for DMA_ATTR_FORCE_CONTIGUOUS to the generic IOMMU DMA code.
>>> This allows to allocate physically contiguous DMA buffers on arm64
>>> systems with an IOMMU.
>>
>> Can anyone explain what this attribute is actually used for? I've never
>> quite figured it out.
> 
> My understanding is that DMA_ATTR_FORCE_CONTIGUOUS is needed when using
> an IOMMU but wanting the buffers to be both contiguous in IOVA space and
> physically contiguous to allow passing to devices without IOMMU.
> 
> Main users are graphic and remote processors.

Sure, I assumed it must be to do with buffer sharing, but the systems
I'm aware of which have IOMMUs in their media subsystems tend to have
them in front of every IP block involved, so I was curious as to what
bit of non-IOMMU hardware wanted to play too. The lone in-tree use in
the Exynos DRM driver was never very revealing, and the new one I see in
the Qualcomm PIL driver frankly looks redundant to me.

Robin.

>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
> 
>>> @@ -265,6 +272,20 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>>>       /* IOMMU can map any pages, so himem can also be used here */
>>>       gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
>>>
>>> +     if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
>>> +             int order = get_order(count << PAGE_SHIFT);
>>> +             struct page *page;
>>> +
>>> +             page = dma_alloc_from_contiguous(dev, count, order);
>>> +             if (!page)
>>> +                     return NULL;
>>> +
>>> +             while (count--)
>>> +                     pages[i++] = page++;
>>> +
>>> +             return pages;
>>> +     }
>>> +
>>
>> This is really yuck. Plus it's entirely pointless to go through the
>> whole page array/scatterlist dance when we know the buffer is going to
>> be physically contiguous - it should just be allocate, map, done. I'd
>> much rather see standalone iommu_dma_{alloc,free}_contiguous()
>> functions, and let the arch code handle dispatching appropriately.
> 
> Fair enough.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
