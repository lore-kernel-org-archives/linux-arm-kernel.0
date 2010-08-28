From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sat, 28 Aug 2010 19:58:11 +0200
Subject: [PATCH] arm: fix pci_set_consistent_dma_mask for dmabounce devices
In-Reply-To: <20100819174426O.fujita.tomonori@lab.ntt.co.jp> (FUJITA
	Tomonori's message of "Thu, 19 Aug 2010 17:51:48 +0900")
References: <20100819174426O.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <m3sk1yzkjw.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

What's the outcome of the following?

Russell, are you going to apply it as is, or is a better (short-term)
fix being made?

FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> writes:

> This fixes the regression of the
> 6fee48cd330c68332f9712bc968d934a1a84a32a commit.
>
> After the above commit, pci_set_consistent_dma_mask doesn't work for
> dmabounce devices. It converts ARM to use the generic implementation
> of pci_set_consistent_dma_mask.
>
> The root cause that ARM's CONFIG_DMABOUNCE uses dev->coherent_dma_mask
> for the dma mask of a device _AND_ a bus. dev->coherent_dma_mask is
> supposed to represent the dma mask of a device.
>
> The proper solution is that device and bus has the own dma mask
> respectively (POWERPC does the similar). But the fix must go to stable
> trees so this simple (and hacky a bit) patch works better for now.
>
> For further information: http://lkml.org/lkml/2010/8/10/272
>
> Reported-by: Krzysztof Halasa <khc@pm.waw.pl>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Tested-by: Krzysztof Halasa <khc@pm.waw.pl>
> Cc: stable at kernel.org
> ---
>  arch/arm/mm/dma-mapping.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index c704eed..2a3fc2e 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -77,6 +77,11 @@ static struct page *__dma_alloc_buffer(struct device *dev, size_t size, gfp_t gf
>  	if (mask < 0xffffffffULL)
>  		gfp |= GFP_DMA;
>  
> +#ifdef CONFIG_DMABOUNCE
> +	if (dev->archdata.dmabounce)
> +		gfp |= GFP_DMA;
> +#endif
> +
>  	page = alloc_pages(gfp, order);
>  	if (!page)
>  		return NULL;

-- 
Krzysztof Halasa
