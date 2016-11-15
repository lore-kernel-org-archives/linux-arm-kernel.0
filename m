From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 15 Nov 2016 12:49:09 +0100
Subject: [PATCH] iommu/dma: Stop getting dma_32bit_pfn wrong
In-Reply-To: <f9c96106e6253f7033be8dd975392f0edb12e603.1478889045.git.robin.murphy@arm.com>
References: <f9c96106e6253f7033be8dd975392f0edb12e603.1478889045.git.robin.murphy@arm.com>
Message-ID: <20161115114909.GC24857@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 06:30:45PM +0000, Robin Murphy wrote:
> iommu_dma_init_domain() was originally written under the misconception
> that dma_32bit_pfn represented some sort of size limit for IOVA domains.
> Since the truth is almost the exact opposite of that, rework the logic
> and comments to reflect its real purpose of optimising lookups when
> allocating from a subset of the available space.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index c5ab8667e6f2..ae045a14b530 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -139,6 +139,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>  {
>  	struct iova_domain *iovad = cookie_iovad(domain);
>  	unsigned long order, base_pfn, end_pfn;
> +	bool pci = dev && dev_is_pci(dev);
>  
>  	if (!iovad)
>  		return -ENODEV;
> @@ -161,19 +162,31 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>  		end_pfn = min_t(unsigned long, end_pfn,
>  				domain->geometry.aperture_end >> order);
>  	}
> +	/*
> +	 * PCI devices may have larger DMA masks, but still prefer allocating
> +	 * within a 32-bit mask to avoid DAC addressing. Such limitations don't
> +	 * apply to the typical platform device, so for those we may as well
> +	 * leave the cache limit at the top of the range they're likely to use.
> +	 */
> +	if (pci)
> +		end_pfn = min_t(unsigned long, end_pfn,
> +				DMA_BIT_MASK(32) >> order);

Question, does it actually hurt platform devices to follow the same
allocation strategy as pci devices? I mean, does it hurt enough to
special-case the code here?



	Joerg
