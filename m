From: noralf@tronnes.org (=?UTF-8?Q?Noralf_Tr=c3=b8nnes?=)
Date: Fri, 4 Aug 2017 15:20:21 +0200
Subject: [PATCH v3 2/6] drm/tinydrm: generalize tinydrm_xrgb8888_to_gray8()
In-Reply-To: <e53e6ff2-ae9b-a710-a9f4-410992c29a66@tronnes.org>
References: <1501799630-1650-1-git-send-email-david@lechnology.com>
 <1501799630-1650-3-git-send-email-david@lechnology.com>
 <e53e6ff2-ae9b-a710-a9f4-410992c29a66@tronnes.org>
Message-ID: <9713028d-ac77-40d6-fe62-9be2e9a5dd28@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 04.08.2017 09.27, skrev Noralf Tr?nnes:
>
> Den 04.08.2017 00.33, skrev David Lechner:
>> This adds parameters for vaddr and clip to 
>> tinydrm_xrgb8888_to_gray8() to
>> make it more generic.
>>
>> dma_buf_{begin,end}_cpu_access() are moved out to the repaper driver.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>   drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c | 35 
>> ++++++++++----------------
>>   drivers/gpu/drm/tinydrm/repaper.c              | 21 +++++++++++++++-
>>   include/drm/tinydrm/tinydrm-helpers.h          |  3 ++-
>>   3 files changed, 35 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c 
>> b/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
>> index 75808bb..5915ba8 100644
>> --- a/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
>> +++ b/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
>> @@ -185,7 +185,9 @@ EXPORT_SYMBOL(tinydrm_xrgb8888_to_rgb565);
>>   /**
>>    * tinydrm_xrgb8888_to_gray8 - Convert XRGB8888 to grayscale
>>    * @dst: 8-bit grayscale destination buffer
>> + * @vaddr: XRGB8888 source buffer
>>    * @fb: DRM framebuffer
>> + * @clip: Clip rectangle area to copy
>>    *
>>    * Drm doesn't have native monochrome or grayscale support.
>>    * Such drivers can announce the commonly supported XR24 format to 
>> userspace
>> @@ -199,12 +201,11 @@ EXPORT_SYMBOL(tinydrm_xrgb8888_to_rgb565);
>>    * Returns:
>>    * Zero on success, negative error code on failure.
>>    */
>> -int tinydrm_xrgb8888_to_gray8(u8 *dst, struct drm_framebuffer *fb)
>> +int tinydrm_xrgb8888_to_gray8(u8 *dst, void *vaddr, struct 
>> drm_framebuffer *fb,
>> +                  struct drm_clip_rect *clip)
>>   {
>> -    struct drm_gem_cma_object *cma_obj = drm_fb_cma_get_gem_obj(fb, 0);
>> -    struct dma_buf_attachment *import_attach = 
>> cma_obj->base.import_attach;
>> -    unsigned int x, y, pitch = fb->pitches[0];
>> -    int ret = 0;
>> +    unsigned int len = (clip->x2 - clip->x1) * sizeof(u32);
>> +    unsigned int x, y;
>>       void *buf;
>>       u32 *src;
>>   @@ -214,22 +215,16 @@ int tinydrm_xrgb8888_to_gray8(u8 *dst, struct 
>> drm_framebuffer *fb)
>>        * The cma memory is write-combined so reads are uncached.
>>        * Speed up by fetching one line at a time.
>>        */
>> -    buf = kmalloc(pitch, GFP_KERNEL);
>> +    buf = kmalloc(len, GFP_KERNEL);
>>       if (!buf)
>>           return -ENOMEM;
>>   -    if (import_attach) {
>> -        ret = dma_buf_begin_cpu_access(import_attach->dmabuf,
>> -                           DMA_FROM_DEVICE);
>> -        if (ret)
>> -            goto err_free;
>> -    }
>> -
>> -    for (y = 0; y < fb->height; y++) {
>> -        src = cma_obj->vaddr + (y * pitch);
>> -        memcpy(buf, src, pitch);
>> +    for (y = clip->y1; y < clip->y2; y++) {
>> +        src = vaddr + (y * fb->pitches[0]);
>> +        src += clip->x1;
>> +        memcpy(buf, src, len);
>>           src = buf;
>> -        for (x = 0; x < fb->width; x++) {
>> +        for (x = clip->x1; x < clip->x2; x++) {
>>               u8 r = (*src & 0x00ff0000) >> 16;
>>               u8 g = (*src & 0x0000ff00) >> 8;
>>               u8 b =  *src & 0x000000ff;
>> @@ -240,13 +235,9 @@ int tinydrm_xrgb8888_to_gray8(u8 *dst, struct 
>> drm_framebuffer *fb)
>>           }
>>       }
>>   -    if (import_attach)
>> -        ret = dma_buf_end_cpu_access(import_attach->dmabuf,
>> -                         DMA_FROM_DEVICE);
>> -err_free:
>>       kfree(buf);
>>   -    return ret;
>> +    return 0;
>>   }
>>   EXPORT_SYMBOL(tinydrm_xrgb8888_to_gray8);
>>   diff --git a/drivers/gpu/drm/tinydrm/repaper.c 
>> b/drivers/gpu/drm/tinydrm/repaper.c
>> index 3343d3f..d34cd9b 100644
>> --- a/drivers/gpu/drm/tinydrm/repaper.c
>> +++ b/drivers/gpu/drm/tinydrm/repaper.c
>> @@ -18,6 +18,7 @@
>>    */
>>     #include <linux/delay.h>
>> +#include <linux/dma-buf.h>
>>   #include <linux/gpio/consumer.h>
>>   #include <linux/module.h>
>>   #include <linux/of_device.h>
>> @@ -525,11 +526,20 @@ static int repaper_fb_dirty(struct 
>> drm_framebuffer *fb,
>>                   struct drm_clip_rect *clips,
>>                   unsigned int num_clips)
>>   {
>> +    struct drm_gem_cma_object *cma_obj = drm_fb_cma_get_gem_obj(fb, 0);
>> +    struct dma_buf_attachment *import_attach = 
>> cma_obj->base.import_attach;
>>       struct tinydrm_device *tdev = fb->dev->dev_private;
>>       struct repaper_epd *epd = epd_from_tinydrm(tdev);
>> +    struct drm_clip_rect clip;
>>       u8 *buf = NULL;
>>       int ret = 0;
>>   +    /* repaper can't do partial updates */
>> +    clip.x1 = 0;
>> +    clip.x2 = fb->width;
>> +    clip.y1 = 0;
>> +    clip.y2 = fb->height;
>> +
>>       mutex_lock(&tdev->dirty_lock);
>>         if (!epd->enabled)
>> @@ -550,7 +560,16 @@ static int repaper_fb_dirty(struct 
>> drm_framebuffer *fb,
>>           goto out_unlock;
>>       }
>>   -    ret = tinydrm_xrgb8888_to_gray8(buf, fb);
>> +    if (import_attach) {
>> +        ret = dma_buf_begin_cpu_access(import_attach->dmabuf,
>> +                           DMA_FROM_DEVICE);
>> +        if (ret)
>> +            goto out_unlock;
>> +    }
>> +
>> +    ret = tinydrm_xrgb8888_to_gray8(buf, cma_obj->vaddr, fb, &clip);
>> +    if (import_attach)
>> +        dma_buf_end_cpu_access(import_attach->dmabuf, DMA_FROM_DEVICE);
>
> I think we can make tinydrm_xrgb8888_to_gray8() return void like the
> other copy functions. We loose the error if the line buffer can't be
> allocated, but that's no big deal. If we can't allocate <4k of memory,
> then we have much bigger problems elsewhere.
> This simplifies returning an error from dma_buf_end_cpu_access().
> The error is propagated to userspace who called the dirty ioctl.
>
> When I have switched from cma to shmem buffers backing the framebuffer
> (ongoing work), we don't need the line buffer copy to speed up the
> uncached reads from write combined memory mappings. But we will
> probably need it on buffers imported with PRIME, since we don't know
> the memory mapping. At least I don't think we can find that out.
>

I realised that we can just do a slow copy, if we can't allocate a buffer.
I will sort that out in all the copy functions when we switch to shmem.
So please make tinydrm_xrgb8888_to_gray8() void.

> Noralf.
>
>>       if (ret)
>>           goto out_unlock;
>>   diff --git a/include/drm/tinydrm/tinydrm-helpers.h 
>> b/include/drm/tinydrm/tinydrm-helpers.h
>> index a6c387f..9e13ef5 100644
>> --- a/include/drm/tinydrm/tinydrm-helpers.h
>> +++ b/include/drm/tinydrm/tinydrm-helpers.h
>> @@ -43,7 +43,8 @@ void tinydrm_swab16(u16 *dst, void *vaddr, struct 
>> drm_framebuffer *fb,
>>   void tinydrm_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
>>                   struct drm_framebuffer *fb,
>>                   struct drm_clip_rect *clip, bool swap);
>> -int tinydrm_xrgb8888_to_gray8(u8 *dst, struct drm_framebuffer *fb);
>> +int tinydrm_xrgb8888_to_gray8(u8 *dst, void *vaddr, struct 
>> drm_framebuffer *fb,
>> +                  struct drm_clip_rect *clip);
>>     struct backlight_device *tinydrm_of_find_backlight(struct device 
>> *dev);
>>   int tinydrm_enable_backlight(struct backlight_device *backlight);
>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
