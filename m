From: jsarha@ti.com (Jyri Sarha)
Date: Thu, 1 Sep 2016 10:18:57 +0300
Subject: [PATCH v3 2/8] drm/tilcdc: Write DMA base and ceiling address
 with single instruction
In-Reply-To: <0f92d770-3a76-1495-cef2-a5f2230b4a07@ti.com>
References: <cover.1472634657.git.jsarha@ti.com>
 <82b100a090a929ac30d1d47687cb5726b93a929e.1472634657.git.jsarha@ti.com>
 <0f92d770-3a76-1495-cef2-a5f2230b4a07@ti.com>
Message-ID: <060f2616-602a-6e23-ba58-e097af622b7d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/16 10:13, Tomi Valkeinen wrote:
> On 31/08/16 16:14, Jyri Sarha wrote:
>> Write DMA base and ceiling address with a single instruction, if
>> available. This should make it more unlikely that LCDC would fetch the
>> DMA addresses in the middle of an update. Having bad combination of
>> addresses in dma base and ceiling (e.g base > ceiling) can cause
>> unpredictaple behavior in LCDC.
>>
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> ---
>>  drivers/gpu/drm/tilcdc/tilcdc_crtc.c |  9 +++++++--
>>  drivers/gpu/drm/tilcdc/tilcdc_regs.h | 14 ++++++++++++++
>>  2 files changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
>> index 6350f2a..41ec5b3 100644
>> --- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
>> +++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
>> @@ -70,6 +70,7 @@ static void set_scanout(struct drm_crtc *crtc, struct drm_framebuffer *fb)
>>  	struct drm_gem_cma_object *gem;
>>  	unsigned int depth, bpp;
>>  	dma_addr_t start, end;
>> +	u64 dma_base_and_ceiling;
>>  
>>  	drm_fb_get_bpp_depth(fb->pixel_format, &depth, &bpp);
>>  	gem = drm_fb_cma_get_gem_obj(fb, 0);
>> @@ -80,8 +81,12 @@ static void set_scanout(struct drm_crtc *crtc, struct drm_framebuffer *fb)
>>  
>>  	end = start + (crtc->mode.vdisplay * fb->pitches[0]);
>>  
>> -	tilcdc_write(dev, LCDC_DMA_FB_BASE_ADDR_0_REG, start);
>> -	tilcdc_write(dev, LCDC_DMA_FB_CEILING_ADDR_0_REG, end - 1);
>> +	/* Write DMA base and ceiling address with a single insruction,
>> +	 * if available. This should make it more unlikely that LCDC would
>> +	 * fetch the DMA addresses in the middle of an update.
>> +	 */
> 
> I think it would be good to have the register names mentioned in the
> above comment. Otherwise I can imagine grepping for CEILING_ADDR, and
> not finding it set anywhere in the driver...
> 

Ok, I'll do one more quick round for this patch. I also move the comment
before 64-bit assignment in tilcdc_write64() after the __iowmb();.

BR,
Jyri
