From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Oct 2013 11:14:09 +0100
Subject: [PATCH] ARM: dma-mapping: don't allow DMA mappings to be	marked
 executable
In-Reply-To: <20131024093339.GF16735@n2100.arm.linux.org.uk>
References: <20131024070547.GA16735@n2100.arm.linux.org.uk>
 <1382605463.7602.5.camel@mbp>
 <20131024093339.GF16735@n2100.arm.linux.org.uk>
Message-ID: <1382609649.7602.26.camel@mbp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-10-24 at 10:33 +0100, Russell King - ARM Linux wrote:
> On Thu, Oct 24, 2013 at 10:04:23AM +0100, Catalin Marinas wrote:
> > On Thu, 2013-10-24 at 08:05 +0100, Russell King - ARM Linux wrote:
> > > --- a/arch/arm/mm/dma-mapping.c
> > > +++ b/arch/arm/mm/dma-mapping.c
> > > @@ -688,7 +688,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> > >  void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> > >  		    gfp_t gfp, struct dma_attrs *attrs)
> > >  {
> > > -	pgprot_t prot = __get_dma_pgprot(attrs, pgprot_kernel);
> > > +	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
> > 
> > I think we lose the shareability attribute we add to pgprot_kernel when
> > SMP. So this creates a mismatched aliases and could have implications on
> > the barrier use (though I think we use the full system DSB in most cases
> > related to DMA). But architecturally I would feel better if we have the
> > same shareability domain.
> 
> We don't.
> 
> #define _MOD_PROT(p, b) __pgprot(pgprot_val(p) | (b))
> 
> #define PAGE_KERNEL             _MOD_PROT(pgprot_kernel, L_PTE_XN)
> #define PAGE_KERNEL_EXEC        pgprot_kernel
> 
> PAGE_KERNEL is used in generic code to setup kernel mappings by things
> like vmalloc() etc.

Ah, yes, it works correctly then.

-- 
Catalin
