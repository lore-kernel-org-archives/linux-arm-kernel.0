From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 20 Apr 2016 13:47:10 +0100
Subject: [PATCH v7 01/10] iommu: Add DOMAIN_ATTR_MSI_MAPPING attribute
In-Reply-To: <1461084994-2355-2-git-send-email-eric.auger@linaro.org>
References: <1461084994-2355-1-git-send-email-eric.auger@linaro.org>
 <1461084994-2355-2-git-send-email-eric.auger@linaro.org>
Message-ID: <57177A4E.4090804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On 19/04/16 17:56, Eric Auger wrote:
> Introduce a new DOMAIN_ATTR_MSI_MAPPING domain attribute. If supported,
> this means the MSI addresses need to be mapped in the IOMMU.
>
> x86 IOMMUs typically don't expose the attribute since on x86, MSI write
> transaction addresses always are within the 1MB PA region [FEE0_0000h -
> FEF0_000h] window which directly targets the APIC configuration space and
> hence bypass the sMMU. On ARM and PowerPC however MSI transactions are
> conveyed through the IOMMU.

What's stopping us from simply inferring this from the domain's IOMMU 
not advertising interrupt remapping capabilities?

Robin.

> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@freescale.com>
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
>
> ---
>
> v4 -> v5:
> - introduce the user in the next patch
>
> RFC v1 -> v1:
> - the data field is not used
> - for this attribute domain_get_attr simply returns 0 if the MSI_MAPPING
>    capability if needed or <0 if not.
> - removed struct iommu_domain_msi_maps
> ---
>   include/linux/iommu.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 62a5eae..b3e8c5b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -113,6 +113,7 @@ enum iommu_attr {
>   	DOMAIN_ATTR_FSL_PAMU_ENABLE,
>   	DOMAIN_ATTR_FSL_PAMUV1,
>   	DOMAIN_ATTR_NESTING,	/* two stages of translation */
> +	DOMAIN_ATTR_MSI_MAPPING, /* Require MSIs mapping in iommu */
>   	DOMAIN_ATTR_MAX,
>   };
>
>
