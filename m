From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 4 Oct 2018 17:04:25 +0200
Subject: [PATCH] drm/meson: fix max mode_config height/width
In-Reply-To: <20181004100958.GI31561@phenom.ffwll.local>
References: <1538642563-22465-1-git-send-email-narmstrong@baylibre.com>
 <20181004100958.GI31561@phenom.ffwll.local>
Message-ID: <0ef7fa13-ce77-f8a5-f5f3-6568be3d6145@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2018 12:09, Daniel Vetter wrote:
> On Thu, Oct 04, 2018 at 10:42:43AM +0200, Neil Armstrong wrote:
>> The mode_config max_width/max_height determines the maximum framebuffer
>> size the pixel reader can handle. But the values were set thinking they
>> were determining the maximum screen dimensions.
>>
>> This patch changes the values to the maximum height/width the CANVAS block
>> can handle rounded to some coherent values.
>>
>> Fixes: a41e82e6c457 ("drm/meson: Add support for components")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> It's both. Grep for all the callers of ->fill_modes and you'll see that
> this limit is also used to filter max screen sizes.
> 
> If you want to change this, then I think we need a new
> mode_config.fb_max_width/height, which if non-zero, would extend the limit
> for fbs.
> 
> There's also the problem that if you extend this for fbs, then there's no
> check anymore in the atomic_commit paths (or legacy modeset), so that
> needs to be addressed somehow too.

What about adding optionals mode_config.fb_max_width/height and update
drm_internal_framebuffer_create() to use these if non-0 or fallback
to the mode_config max_width/max_height.

Neil

> 
> Bunch of igt to make sure we're not missing anything would be sweet on
> top, e.g. e.g. trying to set a mode over the limit and making sure it
> fails.
> 
> Cheers, Daniel
> 
>> ---
>>  drivers/gpu/drm/meson/meson_drv.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
>> index d344312..2e29968 100644
>> --- a/drivers/gpu/drm/meson/meson_drv.c
>> +++ b/drivers/gpu/drm/meson/meson_drv.c
>> @@ -243,8 +243,8 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>>  		goto free_drm;
>>  
>>  	drm_mode_config_init(drm);
>> -	drm->mode_config.max_width = 3840;
>> -	drm->mode_config.max_height = 2160;
>> +	drm->mode_config.max_width = 16384;
>> +	drm->mode_config.max_height = 8192;
>>  	drm->mode_config.funcs = &meson_mode_config_funcs;
>>  
>>  	/* Hardware Initialization */
>> -- 
>> 2.7.4
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel at lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
