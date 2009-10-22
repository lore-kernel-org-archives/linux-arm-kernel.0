From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 22 Oct 2009 22:12:49 +0100
Subject: coherent memory should be ARMv6's Device Memory?
In-Reply-To: <ede8cc2f231dda80cc85839cb94ec565.squirrel@www.codeaurora.org>
References: <ede8cc2f231dda80cc85839cb94ec565.squirrel@www.codeaurora.org>
Message-ID: <1256245969.5076.9.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-10-21 at 12:50 -0700, adharmap at codeaurora.org wrote:
> The current implementation of __dma_alloc  on ARMv7 based cpu returns
> Strongly Ordered Memory. On my uniprocessor  hardware the strongly ordered
> memory causes the reads after a DMA_FROM_DEVICE transfer to be slow. I
> think __dma_alloc returns StronglyOrdered memory on all v6 and v7 variants
> where arch_is_coherent is false.
> 
> In my opinion, coherent memory should be changed from Strongly Ordered
> Memory to device memory for the following reasons
[...]
> I am thinking of changing the pgprot_uncached to pgprot_device  in
> dma_alloc_coherent in dma-mapping.c.

If we want to be safe on ARMv7, we should actually change it to
pgprot_writecombine() which creates Norman uncached memory. According to
the ARM ARM (and hardware that we may see in the future), it is
Unpredictable to have two aliases to the same physical location using
different memory types (i.e. Normal vs SO or Device). With some
restriction, the hardware can cope with multiple Normal memory mappings
with different cacheability attributes (cached vs uncached). Drivers
would also need to use a barrier.

-- 
Catalin
