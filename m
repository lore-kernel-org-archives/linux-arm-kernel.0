From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 24 Sep 2012 10:52:42 +0100
Subject: Mismatched aliases with DMA mappings?
In-Reply-To: <CAH9JG2XskuxgPwHwF+3SiaMWQhFMf0x3V=d=33cV1oKuppE8PA@mail.gmail.com>
References: <20120921152127.GA2106@linaro.org>
 <CAH9JG2XskuxgPwHwF+3SiaMWQhFMf0x3V=d=33cV1oKuppE8PA@mail.gmail.com>
Message-ID: <20120924095242.GA2122@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 22, 2012 at 02:22:07PM +0900, Kyungmin Park wrote:
> Hi Dave,
> 
> Marek is on vacation and will back 24 Sep. he will explain it in detail.

Hi, thanks for your reply

> I just show how CMA addresses mismatched aliases codes.
> 
> In reserve function, it declares the require memory size with base
> address. At that time it calles 'dma_contiguous_early_fixup()'. it
> just registered address and size.
> 
> void __init dma_contiguous_early_fixup(phys_addr_t base, unsigned long size)
> {
>         dma_mmu_remap[dma_mmu_remap_num].base = base;
>         dma_mmu_remap[dma_mmu_remap_num].size = size;
>         dma_mmu_remap_num++;
> }
> 
> These registerd base and size will be remap at dma_contiguous_remap
> function at paging_init.
> 
> void __init dma_contiguous_remap(void)
> {
>         int i;
>         for (i = 0; i < dma_mmu_remap_num; i++) {
>                 phys_addr_t start = dma_mmu_remap[i].base;
>                 phys_addr_t end = start + dma_mmu_remap[i].size;
>                 struct map_desc map;
>                 unsigned long addr;
> 
>                 if (end > arm_lowmem_limit)
>                         end = arm_lowmem_limit;
>                 if (start >= end)
>                         continue;
> 
>                 map.pfn = __phys_to_pfn(start);
>                 map.virtual = __phys_to_virt(start);
>                 map.length = end - start;
>                 map.type = MT_MEMORY_DMA_READY;
> 
>                 /*
>                  * Clear previous low-memory mapping
>                  */
>                 for (addr = __phys_to_virt(start); addr < __phys_to_virt(end);
>                      addr += PMD_SIZE)
>                         pmd_clear(pmd_off_k(addr));
> 
>                 iotable_init(&map, 1);
>         }
> }

OK, so it looks like this is done early and can't happen after the
kernel has booted (?)

Do you know whether the linear alias for DMA memory is removed when
not using CMA?

Cheers
---Dave

> 
> Thank you,
> Kyungmin Park
> 
> On 9/22/12, Dave Martin <dave.martin@linaro.org> wrote:
> > Hi Marek,
> >
> > I've been trying to understand whether (and if so, how) and DMA buffer
> > allocation code in dma-mapping.c avoids mismatched alises in the kernel
> > linear map.
> >
> >
> > I need a way of getting some uncached memory for communicating with
> > temporarily noncoherent CPUs during CPU bringup/teardown.  Although
> > the DMA API does not seem quite the right solution for this, nothing
> > else currently feels like quite the right solution either.  Approaches
> > based on memblock_steal() and on using cacheable memory with explicit
> > flushing both have problems, and reserving specific physical memory
> > via DT seems ugly, because we really don't care where the memory is.
> >
> > What is needed is something like an ioremap of anonymous memory with
> > specific attributes, using largely the same infrastructure as the DMA
> > API, but eliminating a mismatched alias of the allocated memory in the
> > kernel linear mapping is likely to be important.
> >
> > Can you explain how the DMA mapping code eliminates mismatched aliases?
> > I can see the attributes of new mappings being set, but currently I
> > don't see how the linear map gets modified.
> >
> > Cheers
> > ---Dave
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
