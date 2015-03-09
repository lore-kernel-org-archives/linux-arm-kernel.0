From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 09 Mar 2015 20:09:49 +0000
Subject: [RFC PATCH v2 2/3] arm64: add IOMMU dma_ops
In-Reply-To: <20150309175904.GC8656@n2100.arm.linux.org.uk>
References: <cover.1423226542.git.robin.murphy@arm.com>
 <058e038009ac708a40197c80e07410914c2a162e.1423226542.git.robin.murphy@arm.com>
 <1423543151.18280.2.camel@mtksdaap41> <54D9F486.10501@arm.com>
 <1423901011.27922.7.camel@mhfsdcap03> <54E24D50.408@arm.com>
 <1425353927.4555.10.camel@mhfsdcap03> <54F5A5FE.3040506@arm.com>
 <54F7A121.3050103@codeaurora.org> <54F83B0C.9020606@arm.com>
 <20150309175904.GC8656@n2100.arm.linux.org.uk>
Message-ID: <54FDFE0D.8030807@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 09/03/15 17:59, Russell King - ARM Linux wrote:
[...]
>>>> For a noncoherent device, dma_map_single() will end up calling
>>> __dma_map_area() with the page offset and size of the original request, so
>>> the updated part gets flushed by VA, and the rest of the page isn't touched
>>> if it doesn't need to be. On the other hand if the page tables were
>>> allocated with dma_alloc_coherent() in the first place, then just calling
>>> dma_sync_single_for_device() for the updated region should suffice.
>
> That's wrong.  dma_sync_single_*() is not permitted to be called on
> coherently allocated memory.  Where coherent memory needs to be remapped,
> dma_sync_single_*() will panic the kernel.
>
> If it's in coherent memory, all you should need is the appropriate
> memory barrier to ensure that the DMA agent can see the writes.

You're quite right, that's the whole point of *coherent* allocations 
after all. I got my syncs and barriers muddled there.

>>> Where exactly would you call the dma_unmap? It seems a bit strange to
>>> be repeatedly calling dma_map and never calling dma_unmap. I don't see it
>>> explicitly forbidden in the docs anywhere to do this but it seems like
>>> it would be violating the implicit handoff of dma_map/dma_unmap.
>>
>> I think ideally you'd call dma_map_page when you first create the page
>> table, dma_sync_single_for_device on any update, and dma_unmap_page when you
>> tear it down, and you'd also use the appropriate DMA addresses everywhere
>> instead of physical addresses.
>
> No.
>
> dma_map_page()			ownership changes CPU->DMA
> dma_sync_single_for_cpu()	ownership changes DMA->CPU
> dma_sync_single_for_device()	ownership changes CPU->DMA
> dma_unmap_page()		ownership changes DMA->CPU
>
> It's invalid to miss out the pairing that give those ownership changes.

Thanks for the clarification - the wording in DMA-API.txt rather implies 
that in the DMA_TO_DEVICE case you only have to sync the updated data 
/after/ writing it. For the sake of purely getting pages flushed, would 
it be more reasonable then to call dma_map_single() followed immediately 
by dma_unmap_single_attrs() with DMA_ATTR_SKIP_CPU_SYNC? Since we know 
the IOMMU can never write back to memory  (ones that can are a different 
issue) it would be nice to be able to skip the extra invalidations 
somehow, without too heinously abusing the API.

Robin.
