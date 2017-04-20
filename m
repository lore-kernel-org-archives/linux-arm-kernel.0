From: cyndis@kapsi.fi (Mikko Perttunen)
Date: Thu, 20 Apr 2017 12:44:42 +0300
Subject: [PATCH] [RFC] gpu: host1x: shut up warning about DMA API misuse
In-Reply-To: <CAK8P3a3JJrA_4Zur47ngWmR7VeKBopJLNZCaqOPzzmnFoV3=Ew@mail.gmail.com>
References: <20170419182413.866327-1-arnd@arndb.de>
 <8df7c5a9-c71c-4ee9-9bc2-9c861cf9796c@kapsi.fi>
 <CAK8P3a3JJrA_4Zur47ngWmR7VeKBopJLNZCaqOPzzmnFoV3=Ew@mail.gmail.com>
Message-ID: <46945c47-2e4e-270d-b551-b207c538e5cb@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.04.2017 11:25, Arnd Bergmann wrote:
> On Thu, Apr 20, 2017 at 9:02 AM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
>> On 19.04.2017 21:24, Arnd Bergmann wrote:
>>>
>>> When dma_addr_t and phys_addr_t are not the same size, we get a warning
>>> from the dma_alloc_wc function:
>>>
>>> drivers/gpu/host1x/cdma.c: In function 'host1x_pushbuffer_init':
>>> drivers/gpu/host1x/cdma.c:94:48: error: passing argument 3 of
>>> 'dma_alloc_wc' from incompatible pointer type
>>> [-Werror=incompatible-pointer-types]
>>>    pb->mapped = dma_alloc_wc(host1x->dev, size, &pb->phys,
>>>                                                 ^
>>> In file included from drivers/gpu/host1x/cdma.c:22:0:
>>> include/linux/dma-mapping.h:761:37: note: expected 'dma_addr_t * {aka long
>>> long unsigned int *}' but argument is of type 'phys_addr_t * {aka unsigned
>>> int *}'
>>>  static noinline_if_stackbloat void *dma_alloc_wc(struct device *dev,
>>> size_t size,
>>>                                      ^~~~~~~~~~~~
>>> drivers/gpu/host1x/cdma.c:113:48: error: passing argument 3 of
>>> 'dma_alloc_wc' from incompatible pointer type
>>> [-Werror=incompatible-pointer-types]
>>>    pb->mapped = dma_alloc_wc(host1x->dev, size, &pb->phys,
>>>                                                 ^
>>> In file included from drivers/gpu/host1x/cdma.c:22:0:
>>> include/linux/dma-mapping.h:761:37: note: expected 'dma_addr_t * {aka long
>>> long unsigned int *}' but argument is of type 'phys_addr_t * {aka unsigned
>>> int *}'
>>>  static noinline_if_stackbloat void *dma_alloc_wc(struct device *dev,
>>> size_t size,
>>>                                      ^~~~~~~~~~~~
>>>
>>> The problem here is that dma_alloc_wc() returns a pointer to a dma_addr_t
>>> that may already be translated by an IOMMU, but the driver passes this
>>> into iommu_map() as a physical address. This works by accident only when
>>> the IOMMU does not get registered with the DMA API and there is a 1:1
>>> mapping between physical addresses as seen by the CPU and the device.
>>>
>>> The fundamental problem here is the lack of a generic API to do what the
>>> driver wants: allocating CPU-visible memory for use by a device through
>>> user-defined IOMMU settings. Neither the dma-mapping API nor the IOMMU
>>> API can do this by itself, and combining the two is not well-defined.
>>>
>>> This patch addresses the type mismatch by adding a third pointer into the
>>> push_buffer structure: in addition to the address as seen from the CPU
>>> and the address inside of the local IOMMU domain, the pb->alloc pointer
>>> is the token returned by dma_alloc_wc(), and this is what we later need
>>> to pass into dma_free_wc().
>>>
>>> The address we pass into iommu_map() however is the physical address
>>> computed from virt_to_phys(), assuming that the pointer we have here
>>> is part of the linear mapping (which is also questionable, e.g. when we
>>> have a non-coherent device on ARM32 this may be false). Also, when
>>> the DMA API uses the IOMMU to allocate the pointer for the default
>>> domain, we end up with two IOMMU mappings for the same physical address.
>>>
>>
>> I think we have a "policy" on Tegra that the DMA API will never allocate
>> using the IOMMU (Thierry can elaborate on this), which is why I wrote the
>> code with that assumption. Essentially, we have made the DMA API into the
>> API that allocates CPU-visible memory.
>
> I don't think this can be a per-platform policy.

Yeah, now that we are using the ARM SMMU on T186 onwards it's more 
difficult than when we were using the Tegra SMMU, so we'll probably have 
to change that.

The goal of the current code is to allocate memory from the CMA, so one 
option would be to change it to use dma_alloc_from_contiguous. That way 
we wouldn't get the double IOMMU mapping, which would be nice.

>
>> Considering that, I'm wondering if we can just have a temporary local
>> dma_addr_t and then cast that to phys_addr_t, combined with a good comment?
>
> That was my first approach, and it does address the warning, but
> I did not send it because it still felt too wrong.
>
>      Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
