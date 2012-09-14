From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Sep 2012 10:23:40 +0100
Subject: Alignment problems: arm_memblock_steal() +
 dma_declare_coherent_memory()
In-Reply-To: <CACKLOr1_KqsKovcpV06_nAzVKRGAf3z17S-XfNBw8d3BbTshZg@mail.gmail.com>
References: <CACKLOr1_KqsKovcpV06_nAzVKRGAf3z17S-XfNBw8d3BbTshZg@mail.gmail.com>
Message-ID: <20120914092340.GB12245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 10:49:27AM +0200, javier Martin wrote:
> Hello,
> we use arm_memblock_steal() + dma_declare_coherent_memory() in order
> to reserve son contiguous video memory in our platform:
> http://git.linuxtv.org/media_tree.git/blob/refs/heads/staging/for_v3.7:/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
> 
> We've noticed that some restrictive alignment constraints are being
> applied. For example, for coda driver, the following allocations are
> made:
> 
> coda coda-imx27.0: dma_alloc_from_coherent: try to allocate 557056
> bytes, out of 8388608 (vaddr = 0xc6000000) PAGE_SHIFT = 0xc
> coda coda-imx27.0: dma_alloc_from_coherent: try to allocate 65536
> bytes, out of 8388608 (vaddr = 0xc6100000) PAGE_SHIFT = 0xc
> coda coda-imx27.0: dma_alloc_from_coherent: try to allocate 10240
> bytes, out of 8388608 (vaddr = 0xc6110000) PAGE_SHIFT = 0xc
> coda coda-imx27.0: dma_alloc_from_coherent: try to allocate 622080
> bytes, out of 8388608 (vaddr = 0xc6200000) PAGE_SHIFT = 0xc
> coda coda-imx27.0: dma_alloc_from_coherent: try to allocate 622080
> bytes, out of 8388608 (vaddr = 0xc6300000) PAGE_SHIFT = 0xc
> coda coda-imx27.0: dma_alloc_from_coherent: try to allocate 622080
> bytes, out of 8388608 (vaddr = 0xc6400000) PAGE_SHIFT = 0xc
> coda coda-imx27.0: dma_alloc_from_coherent: try to allocate 589824
> bytes, out of 8388608 (vaddr = 0xc6500000) PAGE_SHIFT = 0xc
> coda coda-imx27.0: dma_alloc_from_coherent: try to allocate 589824
> bytes, out of 8388608 (vaddr = 0xc6600000) PAGE_SHIFT = 0xc
> coda coda-imx27.0: dma_alloc_from_coherent: try to allocate 622080
> bytes, out of 8388608 (vaddr = 0xc6700000) PAGE_SHIFT = 0xc
> 
> If we take a look at the size of each allocation and the different
> vaddr values we find that the alignment is 0x100000 = 1MB for values
> like 622080 byte size. Why is that?

Have you thought about get_order() on the allocation size, and what the
resulting order will be?  I'm sure if you could come up with a better
allocation algorithm for this which doesn't lead to too much fragmentation
(or convert it to use the pool infrastructure)...

BTW, your question has nothing to do with arm_memblock_steal().
