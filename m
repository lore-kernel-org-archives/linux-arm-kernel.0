From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Jan 2012 20:18:57 +0000
Subject: [PATCH] arm: fix build failure in code for mach-bcmring/dma.c
In-Reply-To: <4F1DACA7.1030501@broadcom.com>
References: <1327266579-21951-1-git-send-email-paul.gortmaker@windriver.com>
 <20120122211723.GB12326@n2100.arm.linux.org.uk>
 <4F1DACA7.1030501@broadcom.com>
Message-ID: <20120123201857.GA1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2012 at 10:53:27AM -0800, Jiandong Zheng wrote:
> On 1/22/2012 1:17 PM, Russell King - ARM Linux wrote:
>> On Sun, Jan 22, 2012 at 04:09:39PM -0500, Paul Gortmaker wrote:
>>> Upstream commit 99d1717dd7fecf2b10195b0d864323b952b4eba0
>>>
>>>         "ARM: Add init_consistent_dma_size()"
>>>
>>> essentially did this:
>>>
>>> -#define CONSISTENT_BASE                (CONSISTENT_END - CONSISTENT_DMA_SIZE)
>>> +unsigned long consistent_base = CONSISTENT_END - DEFAULT_CONSISTENT_DMA_SIZE;
>>>
>>> but the bcmring code was still using the old CONSISTENT_BASE
>>> macro.  Update it to now use the dynamic variable that reflects
>>> the ability to resize early at boot.  To do so involves putting
>>> the variable alongside of init_consistent_dma_size in dma-mapping.h
>>
>> Oh god, what are the bcmring people doing with this variable?
>>
>> DMA_MemType_t dma_mem_type(void *addr)
>> {
>>          unsigned long addrVal = (unsigned long)addr;
>>
>>          if (addrVal>= CONSISTENT_BASE) {
>>                  /* NOTE: DMA virtual memory space starts at 0xFFxxxxxx */
>>
>>                  /* dma_alloc_xxx pages are physically and virtually contiguous */
>>
>>                  return DMA_MEM_TYPE_DMA;
>>          }
>>
> Originally VMALLOC_END was used and it was changes to CONSISTENT_BASE in  
> 6a40b33270564d706396f1b514a988d3c by Nicolas and merged to linux-next,  
> at a time it caused build error because CONSISTENT_BASE was no longer  
> available in linux-next.
>
> Can someone knows the context comment on these changes?
>
>> int dma_mem_supports_dma(void *addr)
>> {
>>          DMA_MemType_t memType = dma_mem_type(addr);
>>
>>          return (memType == DMA_MEM_TYPE_DMA)
>> #if ALLOW_MAP_OF_KMALLOC_MEMORY
>>              || (memType == DMA_MEM_TYPE_KMALLOC)
>> #endif
>>              || (memType == DMA_MEM_TYPE_USER);
>> }
>>
>> ...
>>          case DMA_MEM_TYPE_DMA:
>>                  {
>>                          /* dma_alloc_xxx pages are physically contiguous */
>>
>>                          atomic_inc(&gDmaStatMemTypeCoherent);
>>
>>                          physAddr = (vmalloc_to_pfn(mem)<<  PAGE_SHIFT) + offset;
>>
>>                          dma_sync_single_for_cpu(NULL, physAddr, numBytes,
>>                                                  memMap->dir);
>>                          rc = dma_map_add_segment(memMap, region, mem, physAddr,
>>                                                   numBytes);
>>                          break;
>>
>> That's invalid for one thing.  Calling dma_sync_single_xxx with this
>> made-up stuff isn't guaranteed to work - and certainly won't have the
>> desired effect on ARM.  Not only that, but it's completely unnecessary
>> for DMA coherent memory.
>>
>> So really, this code is broken.  It needs to be fixed, rather than fixing
>> the core ARM code to allow this brokenness to persist.
>>
> I will take a look. As this code has been there for a while, is there  
> something changed in, for example, DMA API I should be aware of?

No, it's always been a broken since the DMA API was invented:

1. You're accessing the memory via a special mapping of the pages.
2. dma_sync_single_xxx() flush only the kernel's direct mapped pages
   and none of the special mappings.
3. VIVT caches alias when the same page is mapped to two or more
   virtual addresses.

Those are the ARM architecture reasons - but there's another:

4. The kernel API requires that dma_sync_single_xxx() be used on memory
   which has previously been mapped using dma_map_single(), but which
   hasn't been unmapped yet with dma_unmap_single().

(Note: memory obtained from dma_alloc_coherent() etc will BUG if passed
to dma_map_single() - only kernel direct mapped pages can be passed via
this interface.)

Lucky, though, memory allocated in the DMA coherent/write alloc zone will
not be marked as cacheable, so there's no need to call dma_sync_single_xxx()
on it.  The second lucky point is that there shouldn't be any cache lines
in the kernel direct mapped pages associated with the remapped pages, so
this won't have any effect other than waste CPU cycles.

In any case, I'm not sure why you think you need to classify the virtual
address pointer - if you're using the APIs as per their design, you'll
be passing into them the right addresses.  What I've been able to work
out from my quick look at dma.c is that it's used to work out what parts
of the DMA API to call (and apparantly buggily at that).

Moreover, from what I can see, dma.c is unused by code in the mainline
kernel - I couldn't find any reference to dma_map_mem() or
dma_init_mem_map() both of which seem to be pre-requisits for using
this code.  Obviously you have drivers which use it.

What can be done to clean this up?
