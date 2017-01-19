From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 19 Jan 2017 19:00:25 +0000
Subject: [PATCH 4/5] arm64: dma-mapping: Only swizzle DMA ops for
 IOMMU_DOMAIN_DMA
In-Reply-To: <1484849955-1871-5-git-send-email-will.deacon@arm.com>
References: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
 <1484849955-1871-5-git-send-email-will.deacon@arm.com>
Message-ID: <91cf771f-af55-f66f-ea24-9582fc83f03a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/01/17 18:19, Will Deacon wrote:
> The arm64 DMA-mapping implementation sets the DMA ops to the IOMMU DMA
> ops if we detect that an IOMMU is present for the master and the DMA
> ranges are valid.
> 
> In the case when the IOMMU domain for the device is not of type
> IOMMU_DOMAIN_DMA, then we have no business swizzling the ops, since
> we're not in control of the underlying address space. This patch leaves
> the DMA ops alone for masters attached to non-DMA IOMMU domains.

In fact, I don't think there would be any harm in taking this one
through arm64 straight away. The DMA ops can't be expected to work
successfully on any old domain, so it's a reasonable sanity check
regardless.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/mm/dma-mapping.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index e04082700bb1..5d3c6ad621e8 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -831,14 +831,21 @@ static bool do_iommu_attach(struct device *dev, const struct iommu_ops *ops,
>  	 * then the IOMMU core will have already configured a group for this
>  	 * device, and allocated the default domain for that group.
>  	 */
> -	if (!domain || iommu_dma_init_domain(domain, dma_base, size, dev)) {
> -		pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
> -			dev_name(dev));
> -		return false;
> +	if (!domain)
> +		goto out_err;
> +
> +	if (domain->type == IOMMU_DOMAIN_DMA) {
> +		if (iommu_dma_init_domain(domain, dma_base, size, dev))
> +			goto out_err;
> +
> +		dev->archdata.dma_ops = &iommu_dma_ops;
>  	}
>  
> -	dev->archdata.dma_ops = &iommu_dma_ops;
>  	return true;
> +out_err:
> +	pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
> +		 dev_name(dev));
> +	return false;
>  }
>  
>  static void queue_iommu_attach(struct device *dev, const struct iommu_ops *ops,
> 
