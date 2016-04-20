From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 20 Apr 2016 18:19:58 +0100
Subject: [PATCH v7 08/10] iommu/dma-reserved_iommu:
 iommu_msi_mapping_desc_to_domain
In-Reply-To: <1461084994-2355-9-git-send-email-eric.auger@linaro.org>
References: <1461084994-2355-1-git-send-email-eric.auger@linaro.org>
 <1461084994-2355-9-git-send-email-eric.auger@linaro.org>
Message-ID: <5717BA3E.8050901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/04/16 17:56, Eric Auger wrote:
> This function checks whether
> - the device emitting the MSI belongs to a non default iommu domain
> - the iommu domain requires the MSI address to be mapped.
>
> If those conditions are met, the function returns the iommu domain
> to be used for mapping the MSI doorbell; else it returns NULL.
>
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> ---
>   drivers/iommu/dma-reserved-iommu.c | 19 +++++++++++++++++++
>   include/linux/dma-reserved-iommu.h | 18 ++++++++++++++++++
>   2 files changed, 37 insertions(+)
>
> diff --git a/drivers/iommu/dma-reserved-iommu.c b/drivers/iommu/dma-reserved-iommu.c
> index 2522235..907a17f 100644
> --- a/drivers/iommu/dma-reserved-iommu.c
> +++ b/drivers/iommu/dma-reserved-iommu.c
> @@ -17,6 +17,7 @@
>
>   #include <linux/iommu.h>
>   #include <linux/iova.h>
> +#include <linux/msi.h>
>
>   struct reserved_iova_domain {
>   	struct iova_domain *iovad;
> @@ -332,3 +333,21 @@ unlock:
>   }
>   EXPORT_SYMBOL_GPL(iommu_put_reserved_iova);
>
> +struct iommu_domain *iommu_msi_mapping_desc_to_domain(struct msi_desc *desc)
> +{
> +	struct device *dev;
> +	struct iommu_domain *d;
> +
> +	dev = msi_desc_to_dev(desc);
> +
> +	d = iommu_get_domain_for_dev(dev);
> +
> +	if (!d || (d->type == IOMMU_DOMAIN_DMA))
> +		return NULL;
> +
> +	if (iommu_domain_get_attr(d, DOMAIN_ATTR_MSI_MAPPING, NULL))
> +		return NULL;

Yeah, I don't see why we couldn't just use

if (domain->ops->capable(IOMMU_CAP_INTR_REMAP))
	return NULL

there instead.

> +
> +	return d;
> +}
> +EXPORT_SYMBOL_GPL(iommu_msi_mapping_desc_to_domain);
> diff --git a/include/linux/dma-reserved-iommu.h b/include/linux/dma-reserved-iommu.h
> index 8722131..8373929 100644
> --- a/include/linux/dma-reserved-iommu.h
> +++ b/include/linux/dma-reserved-iommu.h
> @@ -19,6 +19,7 @@
>   #include <linux/kernel.h>
>
>   struct iommu_domain;
> +struct msi_desc;
>
>   #ifdef CONFIG_IOMMU_DMA_RESERVED
>
> @@ -70,6 +71,17 @@ int iommu_get_reserved_iova(struct iommu_domain *domain,
>    * if the binding ref count is null, destroy the reserved mapping
>    */
>   void iommu_put_reserved_iova(struct iommu_domain *domain, phys_addr_t addr);
> +
> +/**
> + * iommu_msi_mapping_desc_to_domain: in case the MSI originates from a device
> + * upstream to an IOMMU and this IOMMU translates the MSI transaction,
> + * this function returns the iommu domain the MSI doorbell address must be
> + * mapped in. Else it returns NULL.
> + *
> + * @desc: msi desc handle
> + */
> +struct iommu_domain *iommu_msi_mapping_desc_to_domain(struct msi_desc *desc);
> +
>   #else
>
>   static inline int
> @@ -93,5 +105,11 @@ static inline int iommu_get_reserved_iova(struct iommu_domain *domain,
>   static inline void iommu_put_reserved_iova(struct iommu_domain *domain,
>   					   phys_addr_t addr) {}
>
> +static inline struct iommu_domain *
> +iommu_msi_mapping_desc_to_domain(struct msi_desc *desc)
> +{
> +	return NULL;
> +}
> +
>   #endif	/* CONFIG_IOMMU_DMA_RESERVED */
>   #endif	/* __DMA_RESERVED_IOMMU_H */
>
