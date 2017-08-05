From: noralf@tronnes.org (=?UTF-8?Q?Noralf_Tr=c3=b8nnes?=)
Date: Sat, 5 Aug 2017 21:54:33 +0200
Subject: [PATCH v3 4/6] drm/tinydrm: add support for LEGO MINDSTORMS EV3
 LCD
In-Reply-To: <d814508b-1225-b385-6a90-091487bee2b5@tronnes.org>
References: <1501799630-1650-1-git-send-email-david@lechnology.com>
 <1501799630-1650-5-git-send-email-david@lechnology.com>
 <d814508b-1225-b385-6a90-091487bee2b5@tronnes.org>
Message-ID: <20b8dda7-f569-614c-e628-20d22dada0bd@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 05.08.2017 20.19, skrev Noralf Tr?nnes:
>
> Den 04.08.2017 00.33, skrev David Lechner:
>> LEGO MINDSTORMS EV3 has an LCD with a ST7586 controller. This adds a new
>> module for the ST7586 controller with parameters for the LEGO MINDSTORMS
>> EV3 LCD display.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---

[...]

>> diff --git a/drivers/gpu/drm/tinydrm/st7586.c 
>> b/drivers/gpu/drm/tinydrm/st7586.c

[...]

>> +static void st7586_xrgb8888_to_gray332(u8 *dst, void *vaddr,
>
> Could you put a comment somewhere explaining what grey332 means, that 
> it's not
> a 332 pixel format that I first thought, but that you store 3x 2-bit 
> pixles in one byte.
>
>> +                       struct drm_framebuffer *fb,
>> +                       struct drm_clip_rect *clip)
>> +{
>> +    size_t len = (clip->x2 - clip->x1) * (clip->y2 - clip->y1);
>> +    unsigned int x, y;
>> +    u8 *src, *buf, val;
>> +
>> +    /* 3 pixels per byte, so grow clip to nearest multiple of 3 */
>> +    clip->x1 = clip->x1 / 3 * 3;
>
> Something wrong here: 3 * 3.
>
>> +    clip->x2 = (clip->x2 + 2) / 3 * 3;
>
> You can use DIV_ROUND_UP().
>

Now I see what you're doing, can you use roundup() and rounddown()?

>> +
>> +    buf = kmalloc(len, GFP_KERNEL);
>> +    if (!buf)
>> +        return;
>> +
>> +    tinydrm_xrgb8888_to_gray8(buf, vaddr, fb, clip);
>> +    src = buf;
>> +
>> +    for (y = clip->y1; y < clip->y2; y++) {
>> +        for (x = clip->x1; x < clip->x2; x += 3) {
>> +            val = *src++ & 0xc0;
>> +            if (val & 0xc0)
>> +                val |= 0x20;
>> +            val |= (*src++ & 0xc0) >> 3;
>> +            if (val & 0x18)
>> +                val |= 0x04;
>> +            val |= *src++ >> 6;
>> +            *dst++ = ~val;
>
> I don't understand how this pixel packing matches the one described in
> the datasheet. Why do you flip the bits at the end?
>
>> +        }
>> +    }
>> +
>> +    /* now adjust the clip so it applies to dst */
>> +    clip->x1 /= 3;
>> +    clip->x2 /= 3;

I don't like this, you are changing the clip into a buffer length.
Better do the calculation before you call mipi_dbi_command_buf().

>> +
>> +    kfree(buf);
>> +}
>> +
>> +static int st7586_buf_copy(void *dst, struct drm_framebuffer *fb,
>> +               struct drm_clip_rect *clip)
>> +{
>> +    struct drm_gem_cma_object *cma_obj = drm_fb_cma_get_gem_obj(fb, 0);
>> +    struct dma_buf_attachment *import_attach = 
>> cma_obj->base.import_attach;
>> +    struct drm_format_name_buf format_name;
>> +    void *src = cma_obj->vaddr;
>> +    int ret = 0;
>> +
>> +    if (import_attach) {
>> +        ret = dma_buf_begin_cpu_access(import_attach->dmabuf,
>> +                           DMA_FROM_DEVICE);
>> +        if (ret)
>> +            return ret;
>> +    }
>> +
>> +    switch (fb->format->format) {
>> +    case DRM_FORMAT_XRGB8888:
>> +        st7586_xrgb8888_to_gray332(dst, src, fb, clip);
>> +        break;

I assume you will be adding monochrome and greyscale formats here soon.
Maybe you should have a function st7586_grey8_pack() or something, and do:

switch (fb->format->format) {
         case DRM_FORMAT_XRGB8888:
                 buf = kmalloc();
                 tinydrm_xrgb8888_to_gray8(buf, src, fb, clip);
                 st7586_grey8_to_packed8(dst, buf, clip);
                 kfree();
                 break;

And then later add:

         case DRM_FORMAT_Y8:
                 st7586_grey8_to_packed8(dst, src,...);
                 break;
         case DRM_FORMAT_Y1:
                 st7586_mono_to_packed8(dst, src,...);
                 break;

Just a suggestion, feel free to do what you want.

A patch adding greyscale came today:
https://lists.freedesktop.org/archives/dri-devel/2017-August/149445.html

>> +    default:
>> +        dev_err_once(fb->dev->dev, "Format is not supported: %s\n",
>> +                 drm_get_format_name(fb->format->format,
>> +                         &format_name));
>> +        ret = -EINVAL;
>> +        break;
>
> You don't need this default, because you can only get the ones in 
> st7586_formats.
>
>> +    }
>> +
>> +    if (import_attach)
>> +        dma_buf_end_cpu_access(import_attach->dmabuf, DMA_FROM_DEVICE);
>
> ret = dma_buf_end_cpu_access(...)
>
>> +
>> +    return ret;
>> +}
>> +
>> +static int st7586_fb_dirty(struct drm_framebuffer *fb,
>> +               struct drm_file *file_priv, unsigned int flags,
>> +               unsigned int color, struct drm_clip_rect *clips,
>> +               unsigned int num_clips)
>> +{
>> +    struct tinydrm_device *tdev = fb->dev->dev_private;
>> +    struct mipi_dbi *mipi = mipi_dbi_from_tinydrm(tdev);
>> +    struct drm_clip_rect clip;
>> +    int ret = 0;
>> +
>> +    mutex_lock(&tdev->dirty_lock);
>> +
>> +    if (!mipi->enabled)
>> +        goto out_unlock;
>> +
>> +    /* fbdev can flush even when we're not interested */
>> +    if (tdev->pipe.plane.fb != fb)
>> +        goto out_unlock;
>> +
>> +    tinydrm_merge_clips(&clip, clips, num_clips, flags, fb->width,
>> +                fb->height);
>> +

I suggest you adjust the clip here since it applies to all formats:

     /* pixels are packed in threes */
     clip->x1 = rounddown(clip->x1, 3);
     clip->x2 = roundup(clip->x2, 3);

>> +    DRM_DEBUG("Flushing [FB:%d] x1=%u, x2=%u, y1=%u, y2=%u\n", 
>> fb->base.id,
>> +          clip.x1, clip.x2, clip.y1, clip.y2);
>> +
>> +    ret = st7586_buf_copy(mipi->tx_buf, fb, &clip);
>> +    if (ret)
>> +        goto out_unlock;
>> +
>> +    /* NB: st7586_buf_copy() modifies clip */
>> +
>> +    mipi_dbi_command(mipi, MIPI_DCS_SET_COLUMN_ADDRESS,
>> +             (clip.x1 >> 8) & 0xFF, clip.x1 & 0xFF,
>> +             (clip.x2 >> 8) & 0xFF, (clip.x2 - 1) & 0xFF);
>> +    mipi_dbi_command(mipi, MIPI_DCS_SET_PAGE_ADDRESS,
>> +             (clip.y1 >> 8) & 0xFF, clip.y1 & 0xFF,
>> +             (clip.y2 >> 8) & 0xFF, (clip.y2 - 1) & 0xFF);
>> +
>> +    ret = mipi_dbi_command_buf(mipi, MIPI_DCS_WRITE_MEMORY_START,
>> +                   (u8 *)mipi->tx_buf,
>> +                   (clip.x2 - clip.x1) * (clip.y2 - clip.y1));
>> +
>> +out_unlock:
>> +    mutex_unlock(&tdev->dirty_lock);
>> +
>> +    if (ret)
>> +        dev_err_once(fb->dev->dev, "Failed to update display %d\n",
>> +                 ret);
>> +
>> +    return ret;
>> +}
>> +
