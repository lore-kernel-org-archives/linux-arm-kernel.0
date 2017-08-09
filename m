From: noralf@tronnes.org (=?UTF-8?Q?Noralf_Tr=c3=b8nnes?=)
Date: Wed, 9 Aug 2017 17:56:53 +0200
Subject: [PATCH v4 1/5] drm/tinydrm: Generalize tinydrm_xrgb8888_to_gray8()
In-Reply-To: <1502127581-10517-2-git-send-email-david@lechnology.com>
References: <1502127581-10517-1-git-send-email-david@lechnology.com>
 <1502127581-10517-2-git-send-email-david@lechnology.com>
Message-ID: <0972c604-36f8-ed60-bea8-2ed82f79645a@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 07.08.2017 19.39, skrev David Lechner:
> This adds parameters for vaddr and clip to tinydrm_xrgb8888_to_gray8() to
> make it more generic.
>
> dma_buf_{begin,end}_cpu_access() are moved out to the repaper driver.
>
> Return type is change to void to simplify error handling by callers.
>
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

Thanks for doing this, applied to drm-misc.

Noralf.

> v4 changes:
> * Change return type to void.
>
>
>   drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c | 42 +++++++++-----------------
>   drivers/gpu/drm/tinydrm/repaper.c              | 28 +++++++++++++++--
>   include/drm/tinydrm/tinydrm-helpers.h          |  3 +-
>   3 files changed, 41 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c b/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
> index 75808bb..bd6cce0 100644
> --- a/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
> +++ b/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
> @@ -185,7 +185,9 @@ EXPORT_SYMBOL(tinydrm_xrgb8888_to_rgb565);
>   /**
>    * tinydrm_xrgb8888_to_gray8 - Convert XRGB8888 to grayscale
>    * @dst: 8-bit grayscale destination buffer
> + * @vaddr: XRGB8888 source buffer
>    * @fb: DRM framebuffer
> + * @clip: Clip rectangle area to copy
>    *
>    * Drm doesn't have native monochrome or grayscale support.
>    * Such drivers can announce the commonly supported XR24 format to userspace
> @@ -195,41 +197,31 @@ EXPORT_SYMBOL(tinydrm_xrgb8888_to_rgb565);
>    * where 1 means foreground color and 0 background color.
>    *
>    * ITU BT.601 is used for the RGB -> luma (brightness) conversion.
> - *
> - * Returns:
> - * Zero on success, negative error code on failure.
>    */
> -int tinydrm_xrgb8888_to_gray8(u8 *dst, struct drm_framebuffer *fb)
> +void tinydrm_xrgb8888_to_gray8(u8 *dst, void *vaddr, struct drm_framebuffer *fb,
> +			       struct drm_clip_rect *clip)
>   {
> -	struct drm_gem_cma_object *cma_obj = drm_fb_cma_get_gem_obj(fb, 0);
> -	struct dma_buf_attachment *import_attach = cma_obj->base.import_attach;
> -	unsigned int x, y, pitch = fb->pitches[0];
> -	int ret = 0;
> +	unsigned int len = (clip->x2 - clip->x1) * sizeof(u32);
> +	unsigned int x, y;
>   	void *buf;
>   	u32 *src;
>   
>   	if (WARN_ON(fb->format->format != DRM_FORMAT_XRGB8888))
> -		return -EINVAL;
> +		return;
>   	/*
>   	 * The cma memory is write-combined so reads are uncached.
>   	 * Speed up by fetching one line at a time.
>   	 */
> -	buf = kmalloc(pitch, GFP_KERNEL);
> +	buf = kmalloc(len, GFP_KERNEL);
>   	if (!buf)
> -		return -ENOMEM;
> -
> -	if (import_attach) {
> -		ret = dma_buf_begin_cpu_access(import_attach->dmabuf,
> -					       DMA_FROM_DEVICE);
> -		if (ret)
> -			goto err_free;
> -	}
> +		return;
>   
> -	for (y = 0; y < fb->height; y++) {
> -		src = cma_obj->vaddr + (y * pitch);
> -		memcpy(buf, src, pitch);
> +	for (y = clip->y1; y < clip->y2; y++) {
> +		src = vaddr + (y * fb->pitches[0]);
> +		src += clip->x1;
> +		memcpy(buf, src, len);
>   		src = buf;
> -		for (x = 0; x < fb->width; x++) {
> +		for (x = clip->x1; x < clip->x2; x++) {
>   			u8 r = (*src & 0x00ff0000) >> 16;
>   			u8 g = (*src & 0x0000ff00) >> 8;
>   			u8 b =  *src & 0x000000ff;
> @@ -240,13 +232,7 @@ int tinydrm_xrgb8888_to_gray8(u8 *dst, struct drm_framebuffer *fb)
>   		}
>   	}
>   
> -	if (import_attach)
> -		ret = dma_buf_end_cpu_access(import_attach->dmabuf,
> -					     DMA_FROM_DEVICE);
> -err_free:
>   	kfree(buf);
> -
> -	return ret;
>   }
>   EXPORT_SYMBOL(tinydrm_xrgb8888_to_gray8);
>   
> diff --git a/drivers/gpu/drm/tinydrm/repaper.c b/drivers/gpu/drm/tinydrm/repaper.c
> index 3343d3f..30dc97b 100644
> --- a/drivers/gpu/drm/tinydrm/repaper.c
> +++ b/drivers/gpu/drm/tinydrm/repaper.c
> @@ -18,6 +18,7 @@
>    */
>   
>   #include <linux/delay.h>
> +#include <linux/dma-buf.h>
>   #include <linux/gpio/consumer.h>
>   #include <linux/module.h>
>   #include <linux/of_device.h>
> @@ -525,11 +526,20 @@ static int repaper_fb_dirty(struct drm_framebuffer *fb,
>   			    struct drm_clip_rect *clips,
>   			    unsigned int num_clips)
>   {
> +	struct drm_gem_cma_object *cma_obj = drm_fb_cma_get_gem_obj(fb, 0);
> +	struct dma_buf_attachment *import_attach = cma_obj->base.import_attach;
>   	struct tinydrm_device *tdev = fb->dev->dev_private;
>   	struct repaper_epd *epd = epd_from_tinydrm(tdev);
> +	struct drm_clip_rect clip;
>   	u8 *buf = NULL;
>   	int ret = 0;
>   
> +	/* repaper can't do partial updates */
> +	clip.x1 = 0;
> +	clip.x2 = fb->width;
> +	clip.y1 = 0;
> +	clip.y2 = fb->height;
> +
>   	mutex_lock(&tdev->dirty_lock);
>   
>   	if (!epd->enabled)
> @@ -550,9 +560,21 @@ static int repaper_fb_dirty(struct drm_framebuffer *fb,
>   		goto out_unlock;
>   	}
>   
> -	ret = tinydrm_xrgb8888_to_gray8(buf, fb);
> -	if (ret)
> -		goto out_unlock;
> +	if (import_attach) {
> +		ret = dma_buf_begin_cpu_access(import_attach->dmabuf,
> +					       DMA_FROM_DEVICE);
> +		if (ret)
> +			goto out_unlock;
> +	}
> +
> +	tinydrm_xrgb8888_to_gray8(buf, cma_obj->vaddr, fb, &clip);
> +
> +	if (import_attach) {
> +		ret = dma_buf_end_cpu_access(import_attach->dmabuf,
> +					     DMA_FROM_DEVICE);
> +		if (ret)
> +			goto out_unlock;
> +	}
>   
>   	repaper_gray8_to_mono_reversed(buf, fb->width, fb->height);
>   
> diff --git a/include/drm/tinydrm/tinydrm-helpers.h b/include/drm/tinydrm/tinydrm-helpers.h
> index a6c387f..d554ded 100644
> --- a/include/drm/tinydrm/tinydrm-helpers.h
> +++ b/include/drm/tinydrm/tinydrm-helpers.h
> @@ -43,7 +43,8 @@ void tinydrm_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
>   void tinydrm_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
>   				struct drm_framebuffer *fb,
>   				struct drm_clip_rect *clip, bool swap);
> -int tinydrm_xrgb8888_to_gray8(u8 *dst, struct drm_framebuffer *fb);
> +void tinydrm_xrgb8888_to_gray8(u8 *dst, void *vaddr, struct drm_framebuffer *fb,
> +			       struct drm_clip_rect *clip);
>   
>   struct backlight_device *tinydrm_of_find_backlight(struct device *dev);
>   int tinydrm_enable_backlight(struct backlight_device *backlight);
