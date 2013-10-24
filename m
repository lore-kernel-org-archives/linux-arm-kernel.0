From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Oct 2013 10:04:23 +0100
Subject: [PATCH] ARM: dma-mapping: don't allow DMA mappings to be marked
 executable
In-Reply-To: <20131024070547.GA16735@n2100.arm.linux.org.uk>
References: <20131024070547.GA16735@n2100.arm.linux.org.uk>
Message-ID: <1382605463.7602.5.camel@mbp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, 2013-10-24 at 08:05 +0100, Russell King - ARM Linux wrote:
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -688,7 +688,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>  void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>  		    gfp_t gfp, struct dma_attrs *attrs)
>  {
> -	pgprot_t prot = __get_dma_pgprot(attrs, pgprot_kernel);
> +	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);

I think we lose the shareability attribute we add to pgprot_kernel when
SMP. So this creates a mismatched aliases and could have implications on
the barrier use (though I think we use the full system DSB in most cases
related to DMA). But architecturally I would feel better if we have the
same shareability domain.

-- 
Catalin
