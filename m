From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Sun, 07 Oct 2012 09:02:34 +0200
Subject: Mismatched aliases with DMA mappings?
In-Reply-To: <20120924095242.GA2122@linaro.org>
References: <20120921152127.GA2106@linaro.org>
 <CAH9JG2XskuxgPwHwF+3SiaMWQhFMf0x3V=d=33cV1oKuppE8PA@mail.gmail.com>
 <20120924095242.GA2122@linaro.org>
Message-ID: <5071290A.6030902@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm sorry for very late response but I was busy with other urgent items 
after getting back from holidays.

On 9/24/2012 11:52 AM, Dave Martin wrote:
> On Sat, Sep 22, 2012 at 02:22:07PM +0900, Kyungmin Park wrote:

>> I just show how CMA addresses mismatched aliases codes.
>>
>> In reserve function, it declares the require memory size with base
>> address. At that time it calles 'dma_contiguous_early_fixup()'. it
>> just registered address and size.
>>
>> void __init dma_contiguous_early_fixup(phys_addr_t base, unsigned long
>> size)
>> {
>>         dma_mmu_remap[dma_mmu_remap_num].base = base;
>>         dma_mmu_remap[dma_mmu_remap_num].size = size;
>>         dma_mmu_remap_num++;
>> }
>>
>> These registerd base and size will be remap at dma_contiguous_remap
>> function at paging_init.
>>
>> void __init dma_contiguous_remap(void)
>> {
>>         int i;
>>         for (i = 0; i < dma_mmu_remap_num; i++) {
>>                 phys_addr_t start = dma_mmu_remap[i].base;
>>                 phys_addr_t end = start + dma_mmu_remap[i].size;
>>                 struct map_desc map;
>>                 unsigned long addr;
>>
>>                 if (end > arm_lowmem_limit)
>>                         end = arm_lowmem_limit;
>>                 if (start >= end)
>>                         continue;
>>
>>                 map.pfn = __phys_to_pfn(start);
>>                 map.virtual = __phys_to_virt(start);
>>                 map.length = end - start;
>>                 map.type = MT_MEMORY_DMA_READY;
>>
>>                 /*
>>                  * Clear previous low-memory mapping
>>                  */
>>                 for (addr = __phys_to_virt(start); addr <
>> __phys_to_virt(end);
>>                      addr += PMD_SIZE)
>>                         pmd_clear(pmd_off_k(addr));
>>
>>                 iotable_init(&map, 1);
>>         }
>> }
>
> OK, so it looks like this is done early and can't happen after the
> kernel has booted (?)

Right, the changes in the linear mapping for CMA areas are done very 
early to make sure that the proper mapping will be available for all 
processes in the system (CMA changes the size of the pages used for 
holding low memory linear mappings from 1MiB/2MiB 1-level sections to 
4KiB pages which require 2 levels of pte). Once the kernel has fully 
started it is not (easily) possible to alter the linear mappings.

> Do you know whether the linear alias for DMA memory is removed when
> not using CMA?

Nope, when standard page_alloc() implementation of dma mapping is used 
there exist 2 mappings for each allocated buffer: one in linear low 
memory kernel mapping (cache'able) and the second created by the 
dma-mapping subsystem (non-cache'able or writecombined). Right now no 
one observed any issues caused by such situation assuming that no 
process is accessing linear cache'able lowmem mappings when dma 
non-cache'able mapping exist.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
