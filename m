From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 08 Nov 2016 15:53:23 +0100
Subject: [PATCH] iommu/dma-iommu: properly respect configured address space
 size
In-Reply-To: <d215c05c-b922-4bee-a2dc-695669a801f6@arm.com>
References: <CGME20161107130625eucas1p2dd23c07010b4f3eddb6c6540ed802246@eucas1p2.samsung.com>
 <1478523973-8828-1-git-send-email-m.szyprowski@samsung.com>
 <68e7a18b-739e-b73e-eacf-3cb6c1bd279a@arm.com>
 <8286728f-fab3-8179-5215-e156da426244@samsung.com>
 <d215c05c-b922-4bee-a2dc-695669a801f6@arm.com>
Message-ID: <6f2f3d37-dc6c-abdb-9692-8dcc9cad36f3@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,


On 2016-11-08 15:44, Robin Murphy wrote:
> On 08/11/16 13:41, Marek Szyprowski wrote:
>> On 2016-11-08 12:37, Robin Murphy wrote:
>>> On 07/11/16 13:06, Marek Szyprowski wrote:
>>>> When one called iommu_dma_init_domain() with size smaller than device's
>>>> DMA mask, the alloc_iova() will not respect it and always assume that
>>>> all
>>>> IOVA addresses will be allocated from the the (base ...
>>>> dev->dma_mask) range.
>>> Is that actually a problem for anything?
>> Yes, I found this issue while working on next version of ARM & ARM64
>> DMA-mapping/IOMMU integration patchset and adapting Exynos drivers for the
>> new IOMMU/DMA-mapping glue.
>>
>> Some Exynos devices (codec and camera isp) operate only on the limited (and
>> really small: 256M for example) DMA window. They use non-standard way of
>> addressing memory: an offset from the firmware base. However they still
>> have
>> 32bit DMA mask, as the firmware can be located basically everywhere in the
>> real DMA address space, but then they can access only next 256M from that
>> firmware base.
> OK, that's good to know, thanks. However, I think in this case it sounds
> like it's really the DMA mask that's the underlying problem - if those
> blocks themselves can only drive 28 address bits, then the struct
> devices representing them should have 28-bit DMA masks, and the
> "firmware base" of whoever's driving the upper bits modelled with a
> dma_pfn_offset. Even if they do have full 32-bit interfaces themselves,
> but are constrained to segment-offset addressing internally, I still
> think it would be tidier to represent things that way.
>
> At some point in dma-iommu development I did have support for DMA
> offsets upstream of the IOMMU, and am happy to reinstate it if there's a
> real use case (assuming you can't simply always set the firmware base to
> 0 when using the IOMMU).

That would indeed look a bit simpler, but I've already tried such approach
and the firmware crashes when its base in real DMA address space is set to
zero.

>>>> This patch fixes this issue by taking the configured address space size
>>>> parameter into account (if it is smaller than the device's dma_mask).
>>> TBH I've been pondering ripping the size stuff out of dma-iommu, as it
>>> all stems from me originally failing to understand what dma_32bit_pfn is
>>> actually for. The truth is that iova_domains just don't have a size or
>>> upper limit; however if devices with both large and small DMA masks
>>> share a domain, then the top-down nature of the allocator means that
>>> allocating for the less-capable devices would involve walking through
>>> every out-of-range entry in the tree every time. Having cached32_node
>>> based on dma_32bit_pfn just provides an optimised starting point for
>>> searching within the smaller mask.
>> Right, this dma_32bit_pfn was really misleading at the first glance,
>> but then I found that this was something like end_pfn in case of dma-iommu
>> code.
> Yes, that was my incorrect assumption - at the time I interpreted it as
> a de-facto upper limit which was still possible to allocate above in
> special circumstances, which turns out to be almost entirely backwards.
> I'd rather not bake that into the dma-iommu code any further if we can
> avoid it (I'll try throwing an RFC together to clear up what's there
> already).

Okay.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
