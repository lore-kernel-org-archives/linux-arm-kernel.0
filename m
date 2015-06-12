From: lorenx4@gmail.com (Lorenzo Nava)
Date: Fri, 12 Jun 2015 08:34:55 +0200
Subject: [RFC PATCH v2] arm DMA: Fix allocation from CMA for coherent DMA
In-Reply-To: <20150611142537.GA29305@e104818-lin.cambridge.arm.com>
References: <1433351745-3646-1-git-send-email-lorenx4@gmail.com>
 <20150610162819.GD22844@e104818-lin.cambridge.arm.com>
 <CAE=W-e1FJ6j0=Nae0o7jcwFFbtUjogvLOWgL_D6J30Ztsb31-A@mail.gmail.com>
 <20150611142537.GA29305@e104818-lin.cambridge.arm.com>
Message-ID: <CAE=W-e2zXALU2qr9r-r_rtDWyDaiqT0KSmKOJWc2q1WWEPmFiw@mail.gmail.com>
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

Ok, sorry, now I've understood: __alloc_simple_buffer just doesn't
consider the attributes set in arm_coherent_dma_alloc() or
arm_dma_alloc() functions.
So, as you already correctly pointed out, I have to keep cacheability
attributes coherent even using the CMA.
I will update my patch and submit a new version.

Thank you.

Lorenzo
> --
> Catalin
