From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 5 Oct 2018 10:19:28 +0200
Subject: [PATCH] drm/meson: fix max mode_config height/width
In-Reply-To: <CAKMK7uE71OeOdDPb+5-cs9bByD-unYPxBV_R1t+4A0Nb4H6CAw@mail.gmail.com>
References: <1538642563-22465-1-git-send-email-narmstrong@baylibre.com>
 <20181004100958.GI31561@phenom.ffwll.local>
 <0ef7fa13-ce77-f8a5-f5f3-6568be3d6145@baylibre.com>
 <CAKMK7uHxiDF3z19cMBb0o2o4Ev0DFJkhMR7Ny6U2776Ry4oc=A@mail.gmail.com>
 <8e980de4-5a52-8f3d-fba2-734617e40d1b@baylibre.com>
 <CAKMK7uE71OeOdDPb+5-cs9bByD-unYPxBV_R1t+4A0Nb4H6CAw@mail.gmail.com>
Message-ID: <5dbd6337-7e08-f3f7-6d4a-d6bcaddfd3be@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2018 09:58, Daniel Vetter wrote:
> On Fri, Oct 5, 2018 at 9:39 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>

[...]

>> OK, won't this be enough ?
>> --- a/include/drm/drm_mode_config.h
>> +++ b/include/drm/drm_mode_config.h
>> @@ -333,6 +333,8 @@ struct drm_mode_config_funcs {
>>   * @min_height: minimum fb pixel height on this device
>>   * @max_width: maximum fb pixel width on this device
>>   * @max_height: maximum fb pixel height on this device
>> + * @max_fb_width: maximum fb buffer width if differs from max_width
>> + * @max_fb_height: maximum fb buffer height if differs from max_height
>>   * @funcs: core driver provided mode setting functions
>>   * @fb_base: base address of the framebuffer
>>   * @poll_enabled: track polling support for this device
>> @@ -508,6 +510,7 @@ struct drm_mode_config {
>>
>>         int min_width, min_height;
>>         int max_width, max_height;
>> +       int max_fb_width, max_fb_height;
>>         const struct drm_mode_config_funcs *funcs;
>>         resource_size_t fb_base;
>>
>> --- a/drivers/gpu/drm/drm_framebuffer.c
>> +++ b/drivers/gpu/drm/drm_framebuffer.c
>> @@ -283,14 +283,20 @@ drm_internal_framebuffer_create(struct drm_device *dev,
>>                 return ERR_PTR(-EINVAL);
>>         }
>>
>> -       if ((config->min_width > r->width) || (r->width > config->max_width)) {
>> +       if ((config->min_width > r->width) ||
>> +           (!config->max_fb_width && r->width > config->max_width) ||
>> +           (config->max_fb_width && r->width > config->max_fb_width)) {
>>                 DRM_DEBUG_KMS("bad framebuffer width %d, should be >= %d && <= %d\n",
>> -                         r->width, config->min_width, config->max_width);
>> +                         r->width, config->min_width, config->max_fb_width ?
>> +                         config->max_fb_width : config->max_width);
>>                 return ERR_PTR(-EINVAL);
>>         }
>> -       if ((config->min_height > r->height) || (r->height > config->max_height)) {
>> +       if ((config->min_height > r->height) ||
>> +           (!config->max_fb_height && r->height > config->max_height) ||
>> +           (config->max_fb_height && r->height > config->max_fb_height)) {
>>                 DRM_DEBUG_KMS("bad framebuffer height %d, should be >= %d && <= %d\n",
>> -                         r->height, config->min_height, config->max_height);
>> +                         r->height, config->min_height, config->max_fb_height ?
>> +                         config->max_fb_height : config->max_height);
>>                 return ERR_PTR(-EINVAL);
>>         }
>>
>> and in the driver :
>>
>> +       drm->mode_config.max_width = 4096;
>> +       drm->mode_config.max_height = 3840;
>> +       drm->mode_config.max_fb_width = 16384;
>> +       drm->mode_config.max_fb_height = 8192;
>>
>> With this I leave the mode filtering intact.
> 
> Not enough. See
> https://dri.freedesktop.org/docs/drm/gpu/drm-kms-helpers.html#c.drm_connector_helper_funcs
> and scroll down to mode_valid. You need to filter modes both in the
> detect paths, and the atomic_check paths.
> 
> Detect is explicitly filtered out, but atomic_check was only
> implicitly filtered, through the max fb size checks. Ok, you could
> light up a mode that's bigger than max fb, but in practice, no
> userspace ever did that. But with your code we're missing crucial
> validation now, and userspace could fall over that. What I think we
> need is to add mode filter against mode_config.max_width/height in
> drm_atomic_helper_check_modeset(). Probably best to stuff that into
> the mode_valid() function.

Ok I understood now, thanks for pointer, I'll try to add this.

Neil

> 
> Cheers, Daniel
>>
>> Neil
>>
>>
>>> -Daniel
>>>
>>>>
>>>> Neil
>>>>
>>>>>
>>>>> Bunch of igt to make sure we're not missing anything would be sweet on
>>>>> top, e.g. e.g. trying to set a mode over the limit and making sure it
>>>>> fails.
>>>>>
>>>>> Cheers, Daniel
>>>>>
>>>>>> ---
>>>>>>  drivers/gpu/drm/meson/meson_drv.c | 4 ++--
>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
>>>>>> index d344312..2e29968 100644
>>>>>> --- a/drivers/gpu/drm/meson/meson_drv.c
>>>>>> +++ b/drivers/gpu/drm/meson/meson_drv.c
>>>>>> @@ -243,8 +243,8 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>>>>>>              goto free_drm;
>>>>>>
>>>>>>      drm_mode_config_init(drm);
>>>>>> -    drm->mode_config.max_width = 3840;
>>>>>> -    drm->mode_config.max_height = 2160;
>>>>>> +    drm->mode_config.max_width = 16384;
>>>>>> +    drm->mode_config.max_height = 8192;
>>>>>>      drm->mode_config.funcs = &meson_mode_config_funcs;
>>>>>>
>>>>>>      /* Hardware Initialization */
>>>>>> --
>>>>>> 2.7.4
>>>>>>
>>>>>> _______________________________________________
>>>>>> dri-devel mailing list
>>>>>> dri-devel at lists.freedesktop.org
>>>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>>>
>>>>
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel at lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>
>>>
>>>
>>
> 
> 
