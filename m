From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 17 Aug 2010 01:29:49 +0200
Subject: ARM: 2.6.3[45] PCI regression (IXP4xx and PXA?)
In-Reply-To: <20100814181306U.fujita.tomonori@lab.ntt.co.jp> (FUJITA
	Tomonori's message of "Sat, 14 Aug 2010 18:30:37 +0900")
References: <20100811072532.GA21511@n2100.arm.linux.org.uk>
	<20100813152224H.fujita.tomonori@lab.ntt.co.jp>
	<20100813215413.GA21607@n2100.arm.linux.org.uk>
	<20100814181306U.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <m3vd7agmqa.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> writes:

> A long solution would be having two dma_mask for a device and a
> bus. We also need something to represent a DMA-capable range instead
> of the dma mask.
>
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

This patch fixes the problem on my IXP425.
-- 
Krzysztof Halasa
