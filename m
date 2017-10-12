From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 12 Oct 2017 13:39:39 +0100
Subject: [PATCH] iommu: enable bypass transaction caching for ARM SMMU 500
In-Reply-To: <1507759719-16675-1-git-send-email-fkan@apm.com>
References: <1507759719-16675-1-git-send-email-fkan@apm.com>
Message-ID: <d0482cb9-7af4-2a52-dde2-8d9113a4721d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/17 23:08, Feng Kan wrote:
> The ARM SMMU identity mapping performance was poor compared with the
> DMA mode. It was found that enable caching would restore the performance
> back to normal. The S2CRB_TLBEN bit in the ACR register would allow for
> caching of the stream to context register bypass transaction information.

I know the hardware design and reasoning behind this feature, but I'm
still a little surprised that bypass can show a measurably higher
overhead than the full DMA mapping path in practice. MMU-500 is great :D

> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  drivers/iommu/arm-smmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 3bdb799..b5676a8 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -59,6 +59,7 @@
>  #define ARM_MMU500_ACTLR_CPRE		(1 << 1)
>  
>  #define ARM_MMU500_ACR_CACHE_LOCK	(1 << 26)
> +#define ARM_MMU500_ACR_S2CRB_TLBEN	(1 << 10)
>  #define ARM_MMU500_ACR_SMTNMB_TLBEN	(1 << 8)
>  
>  #define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
> @@ -1606,7 +1607,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  		 * Allow unmatched Stream IDs to allocate bypass
>  		 * TLB entries for reduced latency.
>  		 */
> -		reg |= ARM_MMU500_ACR_SMTNMB_TLBEN;
> +		reg |= ARM_MMU500_ACR_SMTNMB_TLBEN | ARM_MMU500_ACR_S2CRB_TLBEN;
>  		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_sACR);
>  	}
>  

Looks correct to me, and TLB usage by bypass domains should still be
equivalent to that of translation domains, so I don't think we should
see any deleterious effects overall:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
