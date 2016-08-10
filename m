From: inki.dae@samsung.com (Inki Dae)
Date: Thu, 11 Aug 2016 07:59:57 +0900
Subject: [PATCH] exynos-drm: Fix display manager failing to start without
 IOMMU problem
In-Reply-To: <1470850251-9150-1-git-send-email-shuahkh@osg.samsung.com>
References: <CGME20160810214111epcas1p4dd2a581353b550a1992fc7695e846da7@epcas1p4.samsung.com>
 <1470850251-9150-1-git-send-email-shuahkh@osg.samsung.com>
Message-ID: <57ABB1ED.1080301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shuah,

2016? 08? 11? 02:30? Shuah Khan ?(?) ? ?:
> Fix exynos_drm_gem_create_ioctl() attempts to allocate non-contiguous GEM
> memory without IOMMU. In this case, there is no point in attempting to

DRM gem can be used for Non-DRM drivers such as GPU, V4L2 based Multimedia device and other DMA devices.
Even though IOMMU support is disabled, other framework based DMA drivers can use IOMMU - i.e., GPU driver -
and they can use non-contiguous GEM buffer through UMM. (DMABUF) 

So GEM allocation type is not dependent on IOMMU.

Thanks,
Inki Dae

> allocate non-contiguous memory, only to return error during the next step
> from exynos_drm_framebuffer_init() which leads to display manager failing
> to start.
> 
> Check if non-contiguous GEM memory is requested without IOMMU. If so,
> allocate contiguous GEM memory to help display manager start.
> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_gem.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> index 4c4cb0e..4719116 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> @@ -266,6 +266,20 @@ int exynos_drm_gem_create_ioctl(struct drm_device *dev, void *data,
>  	struct exynos_drm_gem *exynos_gem;
>  	int ret;
>  
> +	/*
> +	 * Check if non-contiguous GEM memory is requested without IOMMU.
> +	 * If so, allocate contiguous GEM memory.
> +	 *
> +	 * There is no point in attempting to allocate non-contiguous memory,
> +	 * only to return error from exynos_drm_framebuffer_init() which leads
> +	 * to display manager failing to start.
> +	*/
> +	if (!is_drm_iommu_supported(dev) &&
> +	    (args->flags & EXYNOS_BO_NONCONTIG)) {
> +		args->flags &= ~EXYNOS_BO_NONCONTIG;
> +		args->flags |= EXYNOS_BO_CONTIG;
> +	}
> +
>  	exynos_gem = exynos_drm_gem_create(dev, args->flags, args->size);
>  	if (IS_ERR(exynos_gem))
>  		return PTR_ERR(exynos_gem);
> 
