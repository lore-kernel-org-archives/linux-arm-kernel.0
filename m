From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 04 Feb 2015 11:20:19 +0100
Subject: [PATCH v2 1/2] drm/exynos: fix DMA_ATTR_NO_KERNEL_MAPPING usage
In-Reply-To: <1423041800-27859-2-git-send-email-carlo@caione.org>
References: <1423041800-27859-1-git-send-email-carlo@caione.org>
 <1423041800-27859-2-git-send-email-carlo@caione.org>
Message-ID: <54D1F263.4000006@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-02-04 10:23, Carlo Caione wrote:
> The Exynos DRM driver doesn't follow the correct API when dealing with
> dma_{alloc, mmap, free}_attrs functions and the
> DMA_ATTR_NO_KERNEL_MAPPING attribute.
>
> When a IOMMU is not available and the DMA_ATTR_NO_KERNEL_MAPPING is
> used, the driver should use the pointer returned by dma_alloc_attr() as
> a cookie.
>
> The Exynos DRM driver directly uses the non-requested virtual kernel
> address returned by the DMA mapping subsystem. This just works now
> because the non-IOMMU codepath doesn't obey DMA_ATTR_NO_KERNEL_MAPPING
> but we need to fix it before fixing the DMA layer.
>
> Signed-off-by: Carlo Caione <carlo@caione.org>
> Acked-by: Joonyoung Shim <jy0922.shim@samsung.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   drivers/gpu/drm/exynos/exynos_drm_buf.c   |  6 +++---
>   drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 29 +++++++++--------------------
>   drivers/gpu/drm/exynos/exynos_drm_gem.h   |  2 ++
>   3 files changed, 14 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_buf.c b/drivers/gpu/drm/exynos/exynos_drm_buf.c
> index 9c80884..24994ba 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_buf.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_buf.c
> @@ -63,11 +63,11 @@ static int lowlevel_buffer_allocate(struct drm_device *dev,
>   			return -ENOMEM;
>   		}
>   
> -		buf->kvaddr = (void __iomem *)dma_alloc_attrs(dev->dev,
> +		buf->cookie = dma_alloc_attrs(dev->dev,
>   					buf->size,
>   					&buf->dma_addr, GFP_KERNEL,
>   					&buf->dma_attrs);
> -		if (!buf->kvaddr) {
> +		if (!buf->cookie) {
>   			DRM_ERROR("failed to allocate buffer.\n");
>   			ret = -ENOMEM;
>   			goto err_free;
> @@ -132,7 +132,7 @@ static void lowlevel_buffer_deallocate(struct drm_device *dev,
>   	buf->sgt = NULL;
>   
>   	if (!is_drm_iommu_supported(dev)) {
> -		dma_free_attrs(dev->dev, buf->size, buf->kvaddr,
> +		dma_free_attrs(dev->dev, buf->size, buf->cookie,
>   				(dma_addr_t)buf->dma_addr, &buf->dma_attrs);
>   		drm_free_large(buf->pages);
>   	} else
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> index e12ea90..84f8dfe 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> @@ -79,9 +79,9 @@ static int exynos_drm_fbdev_update(struct drm_fb_helper *helper,
>   				     struct drm_framebuffer *fb)
>   {
>   	struct fb_info *fbi = helper->fbdev;
> -	struct drm_device *dev = helper->dev;
>   	struct exynos_drm_gem_buf *buffer;
>   	unsigned int size = fb->width * fb->height * (fb->bits_per_pixel >> 3);
> +	unsigned int nr_pages;
>   	unsigned long offset;
>   
>   	drm_fb_helper_fill_fix(fbi, fb->pitches[0], fb->depth);
> @@ -94,25 +94,14 @@ static int exynos_drm_fbdev_update(struct drm_fb_helper *helper,
>   		return -EFAULT;
>   	}
>   
> -	/* map pages with kernel virtual space. */
> +	nr_pages = buffer->size >> PAGE_SHIFT;
> +
> +	buffer->kvaddr = (void __iomem *) vmap(buffer->pages,
> +			nr_pages, VM_MAP,
> +			pgprot_writecombine(PAGE_KERNEL));
>   	if (!buffer->kvaddr) {
> -		if (is_drm_iommu_supported(dev)) {
> -			unsigned int nr_pages = buffer->size >> PAGE_SHIFT;
> -
> -			buffer->kvaddr = (void __iomem *) vmap(buffer->pages,
> -					nr_pages, VM_MAP,
> -					pgprot_writecombine(PAGE_KERNEL));
> -		} else {
> -			phys_addr_t dma_addr = buffer->dma_addr;
> -			if (dma_addr)
> -				buffer->kvaddr = (void __iomem *)phys_to_virt(dma_addr);
> -			else
> -				buffer->kvaddr = (void __iomem *)NULL;
> -		}
> -		if (!buffer->kvaddr) {
> -			DRM_ERROR("failed to map pages to kernel space.\n");
> -			return -EIO;
> -		}
> +		DRM_ERROR("failed to map pages to kernel space.\n");
> +		return -EIO;
>   	}
>   
>   	/* buffer count to framebuffer always is 1 at booting time. */
> @@ -313,7 +302,7 @@ static void exynos_drm_fbdev_destroy(struct drm_device *dev,
>   	struct exynos_drm_gem_obj *exynos_gem_obj = exynos_fbd->exynos_gem_obj;
>   	struct drm_framebuffer *fb;
>   
> -	if (is_drm_iommu_supported(dev) && exynos_gem_obj->buffer->kvaddr)
> +	if (exynos_gem_obj->buffer->kvaddr)
>   		vunmap(exynos_gem_obj->buffer->kvaddr);
>   
>   	/* release drm framebuffer and real buffer */
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.h b/drivers/gpu/drm/exynos/exynos_drm_gem.h
> index ec58fe9..308173c 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_gem.h
> +++ b/drivers/gpu/drm/exynos/exynos_drm_gem.h
> @@ -22,6 +22,7 @@
>   /*
>    * exynos drm gem buffer structure.
>    *
> + * @cookie: cookie returned by dma_alloc_attrs
>    * @kvaddr: kernel virtual address to allocated memory region.
>    * *userptr: user space address.
>    * @dma_addr: bus address(accessed by dma) to allocated memory region.
> @@ -35,6 +36,7 @@
>    *	VM_PFNMAP or not.
>    */
>   struct exynos_drm_gem_buf {
> +	void 			*cookie;
>   	void __iomem		*kvaddr;
>   	unsigned long		userptr;
>   	dma_addr_t		dma_addr;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
