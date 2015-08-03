From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 3 Aug 2015 21:23:14 +0300
Subject: [PATCH 13/13] iommu/arm-smmu: Treat unknown OAS as 48-bit
In-Reply-To: <1438608355-7335-14-git-send-email-will.deacon@arm.com>
References: <1438608355-7335-1-git-send-email-will.deacon@arm.com>
 <1438608355-7335-14-git-send-email-will.deacon@arm.com>
Message-ID: <55BFB192.1040505@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/03/2015 04:25 PM, Will Deacon wrote:

> A late change to the SMMUv3 architecture ensures that the OAS field
> will be monotonically increasing, so we can assume that an unknown OAS
> is at least 48-bit and use that, rather than fail the device probe.

> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>   drivers/iommu/arm-smmu-v3.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 15fb669282b4..a435e706226a 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2528,12 +2528,11 @@ static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
>   	case IDR5_OAS_44_BIT:
>   		smmu->oas = 44;
>   		break;
> +	default:
> +		dev_info(smmu->dev,
> +			"unknown output address size. Truncating to 48-bit\n");

    Please add a comment like /* FALLTHRU */ here.

>   	case IDR5_OAS_48_BIT:
>   		smmu->oas = 48;
> -		break;
> -	default:
> -		dev_err(smmu->dev, "unknown output address size!\n");
> -		return -ENXIO;
>   	}
>
>   	/* Set the DMA mask for our table walker */

MBR, Sergei
