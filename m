From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 22 Sep 2015 19:11:39 +0100
Subject: [PATCH v5 2/3] arm64: Add IOMMU dma_ops
In-Reply-To: <CAGS+omCDYrjpr--+sUzaKCxo12Eff6TC04RgroDgKvxHwK3t2Q@mail.gmail.com>
References: <cover.1438362603.git.robin.murphy@arm.com>
 <8a5abd0a9929aae160ccb74d7a8d9c3698f61910.1438362603.git.robin.murphy@arm.com>
 <CAGS+omCDYrjpr--+sUzaKCxo12Eff6TC04RgroDgKvxHwK3t2Q@mail.gmail.com>
Message-ID: <560199DB.60606@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dan,

On 22/09/15 18:12, Daniel Kurtz wrote:
> Hi Robin,
>
> On Sat, Aug 1, 2015 at 1:18 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>> Taking some inspiration from the arch/arm code, implement the
>> arch-specific side of the DMA mapping ops using the new IOMMU-DMA layer.
>>
>> Unfortunately the device setup code has to start out as a big ugly mess
>> in order to work usefully right now, as 'proper' operation depends on
>> changes to device probe and DMA configuration ordering, IOMMU groups for
>> platform devices, and default domain support in arm/arm64 IOMMU drivers.
>> The workarounds here need only exist until that work is finished.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>
> [snip]
>
>> +static void __iommu_sync_sg_for_cpu(struct device *dev,
>> +                                   struct scatterlist *sgl, int nelems,
>> +                                   enum dma_data_direction dir)
>> +{
>> +       struct scatterlist *sg;
>> +       int i;
>> +
>> +       if (is_device_dma_coherent(dev))
>> +               return;
>> +
>> +       for_each_sg(sgl, sg, nelems, i)
>> +               __dma_unmap_area(sg_virt(sg), sg->length, dir);
>> +}
>
> In an earlier review [0], Marek asked you to change the loop in
> __iommu_sync_sg_for_cpu loop() to loop over the virtual areas when
> invalidating/cleaning memory ranges.
>
> [0] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/328232.html
>
> However, this changed the meaning of the 'nelems' argument from what
> was for arm_iommu_sync_sg_for_cpu() in arch/arm/mm/dma-mapping.c:
>   "number of buffers to sync (returned from dma_map_sg)"
> to:
>   "number of virtual areas to sync (same as was passed to dma_map_sg)"
>
> This has caused some confusion by callers of dma_sync_sg_for_device()
> that must work for both arm & arm64 as illustrated by [1].
> [1] https://lkml.org/lkml/2015/9/21/250

Funnily enough, I happened to stumble across that earlier of my own 
volition, and felt obliged to respond ;)

> Based on the implementation of debug_dma_sync_sg_for_cpu() in
> lib/dma-debug.c, I think the arm interpretation of nelems (returned
> from dma_map_sg) is correct.

As I explained over on the other thread, you can only do cache 
maintenance on CPU addresses, and those haven't changed regardless of 
what mapping you set up in the IOMMU for the device to see, therefore 
iterating over the mapped DMA chunks makes no sense if you have no way 
to infer a CPU address from a DMA address alone (indeed, I struggled a 
bit to get this initially, hence Marek's feedback). Note that the 
arm_iommu_sync_sg_* code is iterating over entries using the original 
CPU address, offset and length fields in exactly that way, not using the 
DMA address/length fields at all, therefore if you pass in less than the 
original number of entries you'll simply miss out part of the buffer; 
what that code _does_ is indeed correct, but it's not the same thing as 
the comments imply, and the comments are wrong.

AFAICS, debug_dma_sync_sg_* still expects to be called with the original 
nents as well, it just bails out early after mapped_ents entries since 
any further entries won't have DMA addresses to check anyway.

I suspect the offending comments were simply copied from the 
arm_dma_sync_sg_* implementations, which rather counterintuitively _do_ 
operate on the mapped DMA addresses, because they might be flushing a 
bounced copy of the buffer instead of the original pages (and can depend 
on the necessary 1:1 DMA:CPU relationship either way).

Robin.

[0]:http://article.gmane.org/gmane.linux.kernel/2044263

>
> Therefore, I think we need an outer iteration over dma chunks, and an
> inner iteration that calls __dma_map_area() over the set virtual areas
> that correspond to that dma chunk, both here and for
> __iommu_sync_sg_for_device().  This will be complicated by the fact
> that iommu pages could actually be smaller than PAGE_SIZE, and offset
> within a single physical page.  Also, as an optimization, we would
> want to combine contiguous virtual areas into a single call to
> __dma_unmap_area().
>
> -Dan
>
