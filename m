From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 16 Nov 2016 12:34:18 +0100
Subject: [PATCH v5 1/2] drm: tilcdc: implement palette loading for rev1
In-Reply-To: <3fc032e5-cc23-ae7b-9f59-9c71c0a909b8@ti.com>
References: <1477923567-1610-1-git-send-email-bgolaszewski@baylibre.com>
 <1477923567-1610-2-git-send-email-bgolaszewski@baylibre.com>
 <3fc032e5-cc23-ae7b-9f59-9c71c0a909b8@ti.com>
Message-ID: <CAMpxmJUh8KypU_-HtGa+ieCpO46FBME8_VQCJvYkCjFhmuVWgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-10-31 17:05 GMT+01:00 Jyri Sarha <jsarha@ti.com>:
> On 10/31/16 16:19, Bartosz Golaszewski wrote:
>> Revision 1 of the IP doesn't work if we don't load the palette (even
>> if it's not used, which is the case for the RGB565 format).
>>
>> Add a function called from tilcdc_crtc_enable() which performs all
>> required actions if we're dealing with a rev1 chip.
>>
>
> There is only one thing I do not like about this patch. The palette
> loading is done so late that the frame buffer address are already placed
> into DMA base and ceiling registers, and we need to read them from the
> registers and restore them back after the palette loading.
>
> Could you try if the palette loading function works without trouble when
> called from tilcdc_pm_resume() before drm_atomic_helper_resume() call?
> If it does it would be cleaner in the sense that you could get rid off
> the old dma address restore code. You could reinit the completion always
> there right before the palette loading.
>
> If you can not get the above suggestion to work, then I can take this
> patch.
>

Hi Jyri,

the problem is that tilcdc_pm_resume() is not called when tilcdc is
initialized. We would have to have two calls in different places for
that to work.

>> +static void tilcdc_crtc_load_palette(struct drm_crtc *crtc)
>> +{
>> +     u32 dma_fb_base, dma_fb_ceiling, raster_ctl;
>> +     struct tilcdc_crtc *tilcdc_crtc;
>> +     struct drm_device *dev;
>> +     u16 *first_entry;
>> +
>> +     dev = crtc->dev;
>> +     tilcdc_crtc = to_tilcdc_crtc(crtc);
>> +     first_entry = tilcdc_crtc->palette_base;
>> +
>> +     *first_entry = TILCDC_REV1_PALETTE_FIRST_ENTRY;
>> +
>> +     dma_fb_base = tilcdc_read(dev, LCDC_DMA_FB_BASE_ADDR_0_REG);
>> +     dma_fb_ceiling = tilcdc_read(dev, LCDC_DMA_FB_CEILING_ADDR_0_REG);
>> +     raster_ctl = tilcdc_read(dev, LCDC_RASTER_CTRL_REG);
>> +
>> +     /* Tell the LCDC where the palette is located. */
>> +     tilcdc_write(dev, LCDC_DMA_FB_BASE_ADDR_0_REG,
>> +                  tilcdc_crtc->palette_dma_handle);
>> +     tilcdc_write(dev, LCDC_DMA_FB_CEILING_ADDR_0_REG,
>> +                  (u32)tilcdc_crtc->palette_dma_handle
>
> Just a nit pick, but I would put the plus sign to the end of the line
> above instead of the beginning of the line bellow. However,
> check_patch.pl does not complain about this so I guess I can accept it too.
>
>> +                             + TILCDC_REV1_PALETTE_SIZE - 1);
>> +

I'll fix that in v6.

Thanks,
Bartosz Golaszewski
