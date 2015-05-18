From: lorenx4@gmail.com (Lorenzo Nava)
Date: Mon, 18 May 2015 22:56:06 +0200
Subject: [RFC] arm: DMA-API contiguous cacheable memory
Message-ID: <CAE=W-e24oDH5RZfPftRg_xYBiG+b9Sj09vpyay9EwqOo9cVX1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

it's been a while since I've started working with DMA on ARM processor
for a smart camera project. Typically the requirements is to have a
large memory area which can be accessed by both DMA and user. I've
already noticed that many people wonder about which would be the best
way to have data received from DMA mapped in user space and, more
important, mapped in a cacheable area of memory. Having a memory
mapped region which is cacheable is very important if the user must
access the data and make some sort of processing on that.
My question is: why don't we introduce a function in the DMA-API
interface for ARM processors which allows to allocate a contiguous and
cacheable area of memory (> 4MB)?
This new function can take advantage of the CMA mechanism as
dma_alloc_coherent() function does, but using different PTE attribute
for the allocated pages. Basically making a function similar to
arm_dma_alloc() and set the attributes differently would do the trick:

pgprot_t prot = __pgprot_modify(prot, L_PTE_MT_MASK,
        L_PTE_MT_WRITEALLOC | L_PTE_XN)

Of course this is very important for ARM processors as the pages
attributes must be coherent among different addressing of the same
physical memory, so this modification should eventually affect only
contiguous cacheable memory areas.

This will also make an improvement in the V4L2 interface which, for
buffers which is larger then 4MB, is forced to use non-cacheable
memory at the moment (with vb2_dma_contig_memops). The performance are
very poor if users deal with non cacheable memory while performing
image processing.

Any comment will be very appreciated.
Thanks.
Cheers.
