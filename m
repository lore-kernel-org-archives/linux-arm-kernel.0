From: lorenx4@gmail.com (Lorenzo Nava)
Date: Wed, 20 May 2015 00:09:09 +0200
Subject: [RFC] arm: DMA-API contiguous cacheable memory
In-Reply-To: <20150519163436.GZ21251@e104818-lin.cambridge.arm.com>
References: <CAE=W-e24oDH5RZfPftRg_xYBiG+b9Sj09vpyay9EwqOo9cVX1w@mail.gmail.com>
 <20150519163436.GZ21251@e104818-lin.cambridge.arm.com>
Message-ID: <CAE=W-e2XJA_d2GSG8wd7jr0nGj6D_juMtr-Wbd6VLLZMOLWr5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 6:34 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Mon, May 18, 2015 at 10:56:06PM +0200, Lorenzo Nava wrote:
>> it's been a while since I've started working with DMA on ARM processor
>> for a smart camera project. Typically the requirements is to have a
>> large memory area which can be accessed by both DMA and user. I've
>> already noticed that many people wonder about which would be the best
>> way to have data received from DMA mapped in user space and, more
>> important, mapped in a cacheable area of memory. Having a memory
>> mapped region which is cacheable is very important if the user must
>> access the data and make some sort of processing on that.
>> My question is: why don't we introduce a function in the DMA-API
>> interface for ARM processors which allows to allocate a contiguous and
>> cacheable area of memory (> 4MB)?
>> This new function can take advantage of the CMA mechanism as
>> dma_alloc_coherent() function does, but using different PTE attribute
>> for the allocated pages. Basically making a function similar to
>> arm_dma_alloc() and set the attributes differently would do the trick:
>>
>> pgprot_t prot = __pgprot_modify(prot, L_PTE_MT_MASK,
>>         L_PTE_MT_WRITEALLOC | L_PTE_XN)
>
> We already have a way to specify whether a device is coherent via the
> "dma-coherent" DT property. This allows the correct dma_map_ops to be
> set for a device. For cache coherent devices, the
> arm_coherent_dma_alloc() and __dma_alloc() should return cacheable
> memory.
>
> However, looking at the code, it seems that __dma_alloc() does not use
> the CMA when is_coherent == true, though you would hit a limit on the
> number of pages that can be allocated.
>
> As for mmap'ing to user space, there is arm_dma_mmap(). This one sets
> the vm_page_prot to what __get_dma_pgprot() returns which is always
> non-cacheable.
>
> I haven't checked the history cache coherent DMA support on arm but I
> think some of the above can be changed. As an example, on arm64
> __dma_alloc() allocates from CMA independent of whether the device is
> coherent or not. Also __get_dma_pgprot() returns cacheable attributes
> for coherent devices, which in turn allows cacheable user mapping of
> such buffers. You don't really need to implement additional functions,
> just tweaks to the existing ones.
>
> Patches welcome ;)
>
> --
> Catalin

Thanks for the answer. I do agree with you on that: I'll take a look
at arm64 code and I'll be glad to contribute with patches as soon as
possible.

Anyway I'd like to focus on a different aspect: I think that this
solution can manage cache coherent DMA, so devices which guarantees
the coherency using cache snooping mechanism. However how can I manage
devices which needs contiguous memory and don't guarantee cache
coherency? If the device doesn't implement sg functionality, I can't
allocate buffers which is greater than 4MB because I can't use neither
dma_alloc_coherent() nor accessing directly to CMA (well, actually I
can use dma_alloc_coherent(), but it sounds a little bit confusing).

Do you think that dma_alloc_coherent() can be used as well with this
type of devices? Do you think that a new dma_alloc_contiguous()
function would help in this case?
Maybe my interpretation of dma_alloc_coherent() is not correct, and
the coherency can be managed using the dma_sync_single_for_* functions
and it doesn't require hardware mechanism.

Thank you.
Cheers
