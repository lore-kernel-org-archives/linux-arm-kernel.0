From: lorenx4@gmail.com (Lorenzo Nava)
Date: Tue, 30 Jun 2015 13:40:40 +0200
Subject: [PATCH v4] arm DMA: Fix allocation from CMA for coherent DMA
In-Reply-To: <20150630110521.GA7445@e104818-lin.cambridge.arm.com>
References: <1435597845-19811-1-git-send-email-lorenx4@gmail.com>
 <20150630110521.GA7445@e104818-lin.cambridge.arm.com>
Message-ID: <CAE=W-e3GSo67T5f7UsmdESAp9nhttFVJMnRFdJ+uKAOrxTNf0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 30, 2015 at 1:05 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Mon, Jun 29, 2015 at 07:10:45PM +0200, Lorenzo Nava wrote:
> > This patch allows the use of CMA for DMA coherent memory allocation.
> > At the moment if the input parameter "is_coherent" is set to true
> > the allocation is not made using the CMA, which I think is not the
> > desired behaviour.
> >
> > Signed-off-by: Lorenzo Nava <lorenx4@xxxxxxxx>
>
> It's nice to have a proper email address here.

oops, sorry I thought it was made to avoid spam. This is an easy fix :-)

>
> > @@ -680,9 +684,14 @@ void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> >  static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
> >       dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
> >  {
> > -     pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
> > +     pgprot_t prot;
> >       void *memory;
> >
> > +     if (attrs == NULL)
> > +              prot  = PAGE_KERNEL;
> > +     else
> > +              prot  = __get_dma_pgprot(attrs, PAGE_KERNEL);
> > +
> >       if (dma_alloc_from_coherent(dev, size, handle, &memory))
> >               return memory;
>
> We have a slight inconsistency with commit 55af8a91640d (ARM: 8387/1:
> arm/mm/dma-mapping.c: Add arm_coherent_dma_mmap) where the attrs are not
> honoured for the coherent ops. That is, DMA_ATTRS_WRITE_COMBINE
> doesn't have any effect for mmap but with your patch it still has an
> effect on alloc.
>
> I think we could just ignore it, the WRITE_COMBINE attr is a hint that
> the arch may or may not implement and I haven't seen it used with
> coherent mappings. So in this case just pass PAGE_KERNEL to
> __dma_alloc() directly without calling __get_dma_pgprot().
>
> (it also looks like commit 55af8a91640d left an unused attrs argument
> for __arm_dma_mmap that can be removed as well)
>

Right: ok I just pass PAGE_KERNEL to the alloc function, so we are
coherent with the mmap.

> Apart from the above, you can add:
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.
