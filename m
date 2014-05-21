From: ritesh.harjani@gmail.com (Ritesh Harjani)
Date: Wed, 21 May 2014 15:07:27 +0530
Subject: Cache maintenance in arm_iommu_alloc_attrs for iommu_coherent_ops
In-Reply-To: <CAD15agav14RUb473+iCm24HM9eQfWYG8ytZOfpzm5j0e3EX3WQ@mail.gmail.com>
References: <CAD15agav14RUb473+iCm24HM9eQfWYG8ytZOfpzm5j0e3EX3WQ@mail.gmail.com>
Message-ID: <CAD15agY8bBQZgcVqJjM2W8x5qHs5ozs-nVa1QJuzmiqHW2wFOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

++

Also,

arm_iommu_mmap_attrs function for iommu_coherent_ops(and also for
noncoherent iommu_ops) calls for __get_dma_pgprot.

 628 static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs,
pgprot_t prot)
 629 {
 630         prot = dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs) ?
 631                             pgprot_writecombine(prot) :
 632                             pgprot_dmacoherent(prot);
 633         return prot;
 634 }

Now if someone calls for dma_mmap_coherent, then we should not be
changing the memory to be uncached always to make it coherent right
(from functino __get_dma_pgprot above) ??
It should be based on dma_map_ops, and if it is iommu_coherent_ops,
then we should not change the memory to be uncached ??

Please let me know the correct answer on these two questions
(including in previous mail).


Thanks
Ritesh




On Wed, May 21, 2014 at 2:22 PM, Ritesh Harjani
<ritesh.harjani@gmail.com> wrote:
> Hi All,
>
> There is this path in arm dma-mapping.c with respect to iommu coherent
> buffer allocation:
>
> 1. arm_iommu_alloc_attrs
>        -> __iommu_alloc_buffer
>                  -> __dma_clear_buffer
>
>
> __dma_clear_buffer zeros out the allocated pages but also flushes the
> cpu and the outer cache for coherent iommu ops.
>
> I think the above operation for coherent iommu ops should not include
> cache flush operation right ??
> Or I am missing something here ? Whether this is put intentional or
> its a mistake we can correct ?
>
>
> Thanks
> Ritesh
