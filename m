From: will.deacon@arm.com (Will Deacon)
Date: Mon, 2 Feb 2015 10:20:49 +0000
Subject: [PATCH] iommu: arm-smmu: avoid build warning
In-Reply-To: <1754709.y30A9Ie4hF@wuerfel>
References: <1754709.y30A9Ie4hF@wuerfel>
Message-ID: <20150202102048.GB30699@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 09:55:55PM +0000, Arnd Bergmann wrote:
> ARM allmodconfig gained a new warning when dma_addr_t is 32-bit wide:
> 
> drivers/iommu/arm-smmu.c: In function 'arm_smmu_iova_to_phys_hard':
> drivers/iommu/arm-smmu.c:1255:3: warning: right shift count >= width of type
> 
> This changes the calculation so that the effective type is always
> 64-bit.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 859a732e4f713 ("iommu/arm-smmu: add support for iova_to_phys through ATS1PR")
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 1d6d43bb3395..fc13dd56953e 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1252,7 +1252,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
>  	} else {
>  		u32 reg = iova & ~0xfff;
>  		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
> -		reg = (iova & ~0xfff) >> 32;
> +		reg = ((u64)iova & ~0xfff) >> 32;
>  		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_HI);
>  	}

Thanks, Arnd.

Acked-by: Will Deacon <will.deacon@arm.com>

Joerg, could you pick this one up directly please? I don't have any other
ARM SMMU fixes queued at the moment.

Will
