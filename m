From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 28 Sep 2018 17:13:18 +0100
Subject: [PATCH] drm/exynos: Use selected dma_dev default iommu domain
 instead of a fake one
In-Reply-To: <20180928160923.12311-1-m.szyprowski@samsung.com>
References: <a9eb4b79-1fb8-eec7-0566-966f84022d7b@arm.com>
 <CGME20180928160945eucas1p17ff77fe34854548719880638ecb9c54d@eucas1p1.samsung.com>
 <20180928160923.12311-1-m.szyprowski@samsung.com>
Message-ID: <cc33ebeb-e579-e9b6-da86-b9b97a6c39c5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-09-28 5:09 PM, Marek Szyprowski wrote:
> Instead of allocating a fake IOMMU domain for all Exynos DRM components,
> simply reuse the default IOMMU domain of the already selected DMA device.
> This allows some design changes in IOMMU framework without breaking IOMMU
> support in Exynos DRM.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> Inki:
> If possible, please consider this patch as a fix for v4.19-rc, this will
> help doing a rework in IOMMU and DMA-IOMMU frameworks in v4.20 without
> breaking Exynos DRM. It worked for current IOMMU code, but such usage is
> considered as a hack.
> ---
>   drivers/gpu/drm/exynos/exynos_drm_iommu.h | 34 ++++-------------------
>   1 file changed, 6 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_iommu.h b/drivers/gpu/drm/exynos/exynos_drm_iommu.h
> index 87f6b5672e11..797d9ee5f15a 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_iommu.h
> +++ b/drivers/gpu/drm/exynos/exynos_drm_iommu.h
> @@ -55,37 +55,12 @@ static inline void __exynos_iommu_detach(struct exynos_drm_private *priv,
>   static inline int __exynos_iommu_create_mapping(struct exynos_drm_private *priv,
>   					unsigned long start, unsigned long size)
>   {
> -	struct iommu_domain *domain;
> -	int ret;
> -
> -	domain = iommu_domain_alloc(priv->dma_dev->bus);
> -	if (!domain)
> -		return -ENOMEM;
> -
> -	ret = iommu_get_dma_cookie(domain);
> -	if (ret)
> -		goto free_domain;
> -
> -	ret = iommu_dma_init_domain(domain, start, size, NULL);
> -	if (ret)
> -		goto put_cookie;
> -
> -	priv->mapping = domain;
> +	priv->mapping = iommu_get_domain_for_dev(priv->dma_dev);
>   	return 0;
> -
> -put_cookie:
> -	iommu_put_dma_cookie(domain);
> -free_domain:
> -	iommu_domain_free(domain);
> -	return ret;
>   }
>   
>   static inline void __exynos_iommu_release_mapping(struct exynos_drm_private *priv)
>   {
> -	struct iommu_domain *domain = priv->mapping;
> -
> -	iommu_put_dma_cookie(domain);
> -	iommu_domain_free(domain);
>   	priv->mapping = NULL;
>   }
>   
> @@ -94,7 +69,9 @@ static inline int __exynos_iommu_attach(struct exynos_drm_private *priv,
>   {
>   	struct iommu_domain *domain = priv->mapping;
>   
> -	return iommu_attach_device(domain, dev);
> +	if (dev != priv->dma_dev)
> +		return iommu_attach_device(domain, dev);
> +	return 0;
>   }
>   
>   static inline void __exynos_iommu_detach(struct exynos_drm_private *priv,
> @@ -102,7 +79,8 @@ static inline void __exynos_iommu_detach(struct exynos_drm_private *priv,
>   {
>   	struct iommu_domain *domain = priv->mapping;
>   
> -	iommu_detach_device(domain, dev);
> +	if (dev != priv->dma_dev)
> +		iommu_detach_device(domain, dev);
>   }
>   #else
>   #error Unsupported architecture and IOMMU/DMA-mapping glue code
> 
