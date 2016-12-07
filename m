From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 7 Dec 2016 16:42:22 +0000
Subject: [PATCH] drm: hdlcd: Work properly in big-endian mode
In-Reply-To: <20161207155714.ldmshptddwvhsdop@phenom.ffwll.local>
References: <f484518775c0bf063ae0a6f1e6c11bb404a7acc9.1481124156.git.robin.murphy@arm.com>
 <20161207155714.ldmshptddwvhsdop@phenom.ffwll.local>
Message-ID: <548dc9d9-4d21-7f93-cc92-5bc3234f1b8f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/16 15:57, Daniel Vetter wrote:
> On Wed, Dec 07, 2016 at 03:31:40PM +0000, Robin Murphy wrote:
>> Under a big-endian kernel, colours on the framebuffer all come out a
>> delightful shade of wrong, since we fail to take the reversed byte
>> order into account. Fortunately, the HDLCD has a control bit to make it
>> automatically byteswap big-endian data; let's use it as appropriate.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> fourcc codes (and the drm fourcc codes) are supposed to be little-endian.
> All of them. So either we fix up the drivers and userspace to set that
> flag correctly (which would mean hdlcd should expose twice as many
> formats, each one with the little and big endian mode).

AFAICS, SIMPLEFB_FORMATS *is* supposed to be explicitly little-endian
modes. I see that DRM_FORMAT_BIG_ENDIAN exists, but nothing in-tree ever
sets it :/

My vague (and probably wrong) assumption was that the HDLCD is still
expecting little-endian data, but the the CPU is writing framebuffer
data as host-endian words, hence what the HDLCD thinks is xRGB is
actually RGBx under a big-endian kernel - It's certainly consistent
between kernel (fbcon) and userspace (fb-test[1]): white is yellow, blue
is black, green is red and red is green. I don't know how to test
"proper" DRM (I've failed to get X to work with the Arch Linux ARM
distro I have on there at the moment).

Once again I'm somewhat out of my depth here - I just found a thing that
seemed appropriate and visibly resolved the immediate problem :)
By comparison, the same use-cases (fbcon and fb-test) under the same
big-endian kernel do *not* show the same problem with nouveau driving a
PCIe 7600GT card, which led me to believe it was HDLCD-specific.

Robin.

[1]:https://github.com/prpplague/fb-test-app

> Or we nuke the big endian flag from drm fourcc. Adding AMD folks who afaik
> are the only other ones who ever cared about big endian in drm.
> -Daniel
> 
>> ---
>>  drivers/gpu/drm/arm/hdlcd_crtc.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
>> index 28341b32067f..eceb7bed5dd0 100644
>> --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
>> +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
>> @@ -63,6 +63,7 @@ static int hdlcd_set_pxl_fmt(struct drm_crtc *crtc)
>>  	uint32_t pixel_format;
>>  	struct simplefb_format *format = NULL;
>>  	int i;
>> +	u32 reg;
>>  
>>  	pixel_format = crtc->primary->state->fb->pixel_format;
>>  
>> @@ -76,7 +77,11 @@ static int hdlcd_set_pxl_fmt(struct drm_crtc *crtc)
>>  
>>  	/* HDLCD uses 'bytes per pixel', zero means 1 byte */
>>  	btpp = (format->bits_per_pixel + 7) / 8;
>> -	hdlcd_write(hdlcd, HDLCD_REG_PIXEL_FORMAT, (btpp - 1) << 3);
>> +	reg = (btpp - 1) << 3;
>> +#ifdef __BIG_ENDIAN
>> +	reg |= HDLCD_PIXEL_FMT_BIG_ENDIAN;
>> +#endif
>> +	hdlcd_write(hdlcd, HDLCD_REG_PIXEL_FORMAT, reg);
>>  
>>  	/*
>>  	 * The format of the HDLCD_REG_<color>_SELECT register is:
>> -- 
>> 2.10.2.dirty
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel at lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
