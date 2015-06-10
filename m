From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 10 Jun 2015 11:32:52 +0200
Subject: [PATCH 1/2] scatterlist: use sg_phys()
In-Reply-To: <20150609162710.21910.57295.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150609162659.21910.41681.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150609162710.21910.57295.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <20150610093252.GA20384@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 09, 2015 at 12:27:10PM -0400, Dan Williams wrote:
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 7e7583ddd607..9f6ff6671f01 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1502,7 +1502,7 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
>  		return -ENOMEM;
>  
>  	for (count = 0, s = sg; count < (size >> PAGE_SHIFT); s = sg_next(s)) {
> -		phys_addr_t phys = page_to_phys(sg_page(s));
> +		phys_addr_t phys = sg_phys(s) - s->offset;

So sg_phys() turns out to be 'page_to_phys(sg_page(s)) + s->offset',
which makes the above statement to:

	page_to_phys(sg_page(s)) + s->offset - s->offset;

The compiler will probably optimize that away, but it still doesn't look
like an improvement.

>  		unsigned int len = PAGE_ALIGN(s->offset + s->length);
>  
>  		if (!is_coherent &&
> diff --git a/arch/microblaze/kernel/dma.c b/arch/microblaze/kernel/dma.c
> index ed7ba8a11822..dcb3c594d626 100644
> --- a/arch/microblaze/kernel/dma.c
> +++ b/arch/microblaze/kernel/dma.c
> @@ -61,7 +61,7 @@ static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
>  	/* FIXME this part of code is untested */
>  	for_each_sg(sgl, sg, nents, i) {
>  		sg->dma_address = sg_phys(sg);
> -		__dma_sync(page_to_phys(sg_page(sg)) + sg->offset,
> +		__dma_sync(sg_phys(sg),
>  							sg->length, direction);

Here the replacement makes sense, but weird indendation. Could all be
moved to one line, I guess.

>  	}
>  
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 68d43beccb7e..9b9ada71e0d3 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1998,7 +1998,7 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
>  			sg_res = aligned_nrpages(sg->offset, sg->length);
>  			sg->dma_address = ((dma_addr_t)iov_pfn << VTD_PAGE_SHIFT) + sg->offset;
>  			sg->dma_length = sg->length;
> -			pteval = page_to_phys(sg_page(sg)) | prot;
> +			pteval = (sg_phys(sg) - sg->offset) | prot;

Here it doesn't make sense too. In general, please remove the cases
where you have to subtract sg->offset after the conversion.


	Joerg
