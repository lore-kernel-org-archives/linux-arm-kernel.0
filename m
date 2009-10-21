From: adharmap@codeaurora.org (adharmap at codeaurora.org)
Date: Wed, 21 Oct 2009 12:50:08 -0700 (PDT)
Subject: coherent memory should be ARMv6's Device Memory?
Message-ID: <ede8cc2f231dda80cc85839cb94ec565.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current implementation of __dma_alloc  on ARMv7 based cpu returns
Strongly Ordered Memory. On my uniprocessor  hardware the strongly ordered
memory causes the reads after a DMA_FROM_DEVICE transfer to be slow. I
think __dma_alloc returns StronglyOrdered memory on all v6 and v7 variants
where arch_is_coherent is false.

In my opinion, coherent memory should be changed from Strongly Ordered
Memory to device memory for the following reasons
1. Device and Strongly Ordered are both non-cacheable and hence shareable
and coherent.
2. There are no speculative fetches from Device and StronglyOrdered
3. The Program order is guaranteed for access to Device and Strongly Order
memory
4. Device accesses don?t insert a "dmb" after each accesses and hence are
faster

I am thinking of changing the pgprot_uncached to pgprot_device  in
dma_alloc_coherent in dma-mapping.c.

Abhijeet
