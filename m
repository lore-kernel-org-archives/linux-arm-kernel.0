From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 2 Feb 2017 19:35:39 +0100
Subject: [PATCH v3] arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to
 IOMMU
In-Reply-To: <30026398-c5d3-1806-33b6-ba2b59ec2703@arm.com>
References: <1485861178-22694-1-git-send-email-geert+renesas@glider.be>
 <30026398-c5d3-1806-33b6-ba2b59ec2703@arm.com>
Message-ID: <CAMuHMdVDPP64zdXef095D=Ji+ZuY39mQg54e_4SKH0TgZMhKwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Thu, Feb 2, 2017 at 2:15 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 31/01/17 11:12, Geert Uytterhoeven wrote:
>> Add support for allocating physically contiguous DMA buffers on arm64
>> systems with an IOMMU.  This can be useful when two or more devices
>> with different memory requirements are involved in buffer sharing.
>>
>> Note that as this uses the CMA allocator, setting the
>> DMA_ATTR_FORCE_CONTIGUOUS attribute has a runtime-dependency on
>> CONFIG_DMA_CMA, just like on arm32.

>> @@ -625,7 +651,8 @@ static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
>>
>>       size = PAGE_ALIGN(size);
>>       /*
>> -      * @cpu_addr will be one of 3 things depending on how it was allocated:
>> +      * @cpu_addr will be one of 4 things depending on how it was allocated:
>> +      * - A remapped array of pages for contiguous allocations.
>>        * - A remapped array of pages from iommu_dma_alloc(), for all
>>        *   non-atomic allocations.
>>        * - A non-cacheable alias from the atomic pool, for atomic
>> @@ -637,6 +664,12 @@ static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
>>       if (__in_atomic_pool(cpu_addr, size)) {
>>               iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
>>               __free_from_pool(cpu_addr, size);
>> +     } else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
>> +             struct page *page = phys_to_page(dma_to_phys(dev, handle));
>
> handle is the IOVA returned by the original iommu_dma_map_page() call,
> so I can't see this working very well. I was about to naively suggest
> virt_to_page(cpu_addr), except of course cpu_addr isn't going to be a
> linear map address :(

You're right: upon closer look, this will free the wrong pages in the CMA
allocator. Funny, that the system didn't scream...

Thanks for noticing, I'll look into fixing that...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
