From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 19 Jul 2017 11:59:37 +0100
Subject: [PATCH 2/5] iommu/arm-smmu: add IOMMU_CAP_BYPASS to the ARM SMMU
 driver
In-Reply-To: <1500456838-18405-3-git-send-email-anup.patel@broadcom.com>
References: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
 <1500456838-18405-3-git-send-email-anup.patel@broadcom.com>
Message-ID: <71d21ee4-6112-0ec9-9074-b2a00f5c207c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/07/17 10:33, Anup Patel wrote:
> The ARM SMMUv1 and SMMUv2 support bypassing transactions for
> which domain is not configured. The patch adds corresponding
> IOMMU capability to advertise this fact.
> 
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> ---
>  drivers/iommu/arm-smmu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index bc89b4d..08a9020 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1483,6 +1483,8 @@ static bool arm_smmu_capable(enum iommu_cap cap)
>  		return true;
>  	case IOMMU_CAP_NOEXEC:
>  		return true;
> +	case IOMMU_CAP_BYPASS:
> +		return true;

Except when it isn't, of course.

Beware that what we'd like to do in the long term is flip the polarity
of disable_bypass, because there isn't generally a good reason for
Non-Secure DMA to be happening behind Linux's back.

Robin.

>  	default:
>  		return false;
>  	}
> 
