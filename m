From: lorenx4@gmail.com (Lorenzo Nava)
Date: Thu, 11 Jun 2015 23:42:44 +0200
Subject: [RFC PATCH v2] arm DMA: Fix allocation from CMA for coherent DMA
In-Reply-To: <20150611142537.GA29305@e104818-lin.cambridge.arm.com>
References: <1433351745-3646-1-git-send-email-lorenx4@gmail.com>
 <20150610162819.GD22844@e104818-lin.cambridge.arm.com>
 <CAE=W-e1FJ6j0=Nae0o7jcwFFbtUjogvLOWgL_D6J30Ztsb31-A@mail.gmail.com>
 <20150611142537.GA29305@e104818-lin.cambridge.arm.com>
Message-ID: <CAE=W-e3sy6HBdkRv15_c=xMZgybyTWLooVkd4KNKPMqyA-ityw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 4:26 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Wed, Jun 10, 2015 at 09:34:43PM +0200, Lorenzo Nava wrote:
>> On Wed, Jun 10, 2015 at 6:28 PM, Catalin Marinas
>> <catalin.marinas@arm.com> wrote:
>> > On Wed, Jun 03, 2015 at 07:15:45PM +0200, Lorenzo Nava wrote:
>> > > This patch allows the use of CMA for DMA coherent memory allocation.
>> > > At the moment if the input parameter "is_coherent" is set to true
>> > > the allocation is not made using the CMA, which I think is not the
>> > > desired behaviour.
>> > >
>> > > Signed-off-by: Lorenzo Nava <lorenx4@xxxxxxxx>
> [...]
>> > So while you allow __alloc_from_contiguous() to be called when
>> > is_coherent, the memory returned is still non-cacheable. The reason is
>> > that the "prot" argument passed to __dma_alloc() in
>> > arm_coherent_dma_alloc() is pgprot_dmacoherent(PAGE_KERNEL) which means
>> > Normal NonCacheable memory. The mmap seems to create a cacheable mapping
>> > as vma->vm_page_prot is not passed through __get_dma_pgprot().
> [...]
>> Well the final scope of this patch is just to fix what in my opinion
>> is an incorrect behaviour: the lack of use of CMA when the flag
>> "is_coherent" is set.
>
> But you still have to fix it properly: "is_coherent" means cacheable
> memory which you don't get with your patch.
>
>> Of course it still exists the problem of modify the attribute to make
>> the memory cacheable, but it is something I would like to do in a
>> second step (the patch you posted is of course a good starting point).
>
> So between the first and the second step, you basically break
> dma_alloc_coherent() by moving the allocation from
> __alloc_simple_buffer() (returning cacheable memory) to
> __alloc_from_contiguous() which changes the memory attributes to
> whatever __get_dma_pgprot() returned (currently Normal Non-cacheable).
>

Maybe I'm losing something.
What I see is that dma_alloc_coherent() calls dma_alloc_attrs() with
attrs set to NULL.
Depending on DMA coherent settings the function
arm_coherent_dma_alloc() or arm_dma_alloc() is called. Functions has
similar behaviour and set prot according to __get_dma_pgprot() which
uses the pgprot_dmacoherent() attributes (in both cases), which
defines the memory bufferable and _non_ cacheable. So the memory has
the same attribute even if __alloc_simple_buffer() is used.
What I see is that only using the dma_alloc_writecombine() function
you can get cacheable memory attributes.

>> I think that the current implementation maps memory keeping non
>> cacheable attributes enable, because the 'attrs' parameter passed to
>> arm_dma_mmap() has no WRITE_COMBINE attribute set (according to
>> dma_mmap_coherent() in include/asm-generic/dma-mapping-common.h).
>
> At least on ARMv7, WRITE_COMBINE and Normal Non-cacheable are the same.

Yes, but the function __get_dma_pgprot() uses different flags
depending on attribute DMA_ATTR_WRITE_COMBINE: if defined the memory
is marked as cacheable.

>
>> I also notice this patch that is pending "[PATCH v3]
>> arm/mm/dma-mapping.c: Add arm_coherent_dma_mmap": it modifies the
>> mapping of memory for coherent DMA. I want to understand if the merge
>> of this patch requires any other modification to guarantee that
>> coherent memory is allocated with cacheable attributes.
>
> I think this patch will go in, it is already in linux-next.
>

Ok, thanks. Anyway I think it shouldn't affect the allocation stuffs.

Lorenzo

> --
> Catalin
