From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 26 Aug 2014 15:00:28 +0200
Subject: [PATCH v2 0/4] CMA & device tree, once again
In-Reply-To: <53E56B16.5030402@codeaurora.org>
References: <1405321966-28184-1-git-send-email-m.szyprowski@samsung.com>
 <53E56B16.5030402@codeaurora.org>
Message-ID: <53FC84EC.1050800@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-08-09 02:28, Laura Abbott wrote:
> On 7/14/2014 12:12 AM, Marek Szyprowski wrote:
>> Hello,
>>
>> This is one more respin of the patches which add support for creating
>> reserved memory regions defined in device tree. The last attempt
>> (http://lists.linaro.org/pipermail/linaro-mm-sig/2014-February/003738.html)
>> ended in merging only half of the code, so right now we have complete
>> documentation merged and only basic code, which implements a half of it
>> is written in the documentation. Although the merged patches allow to
>> reserve memory, there is no way of using it for devices and drivers.
>>
>> This situation makes CMA rather useless, as the main architecture (ARM),
>> which used it, has been converted from board-file based system
>> initialization to device tree. Thus there is no place to use direct
>> calls to dma_declare_contiguous() and some new solution, which bases on
>> device tree, is urgently needed.
>>
>> This patch series fixes this issue. It provides two, already widely
>> discussed and already present in the kernel, drivers for reserved
>> memory: first based on DMA-coherent allocator, second using Contiguous
>> Memory Allocator. The first one nicely implements typical 'carved out'
>> reserved memory way of allocating contiguous buffers in a kernel-style
>> way. The memory is used exclusively by devices assigned to the given
>> memory region. The second one allows to reuse reserved memory for
>> movable kernel pages (like disk buffers, anonymous memory) and migrates
>> it out when device to allocates contiguous memory buffer. Both driver
>> provides memory buffers via standard dma-mapping API.
>>
>> The patches have been rebased on top of latest CMA and mm changes merged
>> to akmp kernel tree.
>>
>> To define a 64MiB CMA region following node is needed:
>>
>> multimedia_reserved: multimedia_mem_region {
>> 	compatible = "shared-dma-pool";
>> 	reusable;
>> 	size = <0x4000000>;
>> 	alignment = <0x400000>;
>> };
>>
>> Similarly, one can define 64MiB region with DMA coherent memory:
>>
>> multimedia_reserved: multimedia_mem_region {
>> 	compatible = "shared-dma-pool";
>> 	no-map;
>> 	size = <0x4000000>;
>> 	alignment = <0x400000>;
>> };
>>
> Longer term, I think it would be good if we didn't have to use no-map with
> the coherent memory. With no-map and dma-coherent.c right now, not only
> do you lose out on the physical memory space, you also have to give up
> the same amount of vmalloc space for mapping. On arm32, if you have the default
> 240MB vmalloc space, 64M is ~25% of the vmalloc space. At least on arm you can
> make this up by remapping the memory as coherent.
>
> I haven't seen this picked up anywhere yet so you are welcome to add
>
> Tested-by: Laura Abbott <lauraa@codeaurora.org>

Right, when the code reaches mainline I will add code which will remove 
no-map
requirement. Changing memory attributes can be handled in this case the same
way as for CMA.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
