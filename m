From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 30 Sep 2015 17:39:23 +0800
Subject: [PATCH v5 05/17] drm: bridge: analogix/dp: dynamic parse sync_pol
 & interlace & dynamic_range
In-Reply-To: <560B9CAA.9080109@samsung.com>
References: <1442906428-2609-1-git-send-email-ykk@rock-chips.com>
 <1442907477-3283-1-git-send-email-ykk@rock-chips.com>
 <560B73D4.30109@samsung.com> <560B8CF1.7050102@rock-chips.com>
 <560B9075.1000304@samsung.com> <560B9B33.2060409@rock-chips.com>
 <560B9CAA.9080109@samsung.com>
Message-ID: <560BADCB.9020502@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 09/30/2015 04:26 PM, Krzysztof Kozlowski wrote:
> On 30.09.2015 17:20, Yakir Yang wrote:
>> Hi Krzysztof,
>>
>> On 09/30/2015 03:34 PM, Krzysztof Kozlowski wrote:
>>> On 30.09.2015 16:19, Yakir Yang wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On 09/30/2015 01:32 PM, Krzysztof Kozlowski wrote:
>>>>> On 22.09.2015 16:37, Yakir Yang wrote:
>>>>>> Both hsync/vsync polarity and interlace mode can be parsed from
>>>>>> drm display mode, and dynamic_range and ycbcr_coeff can be judge
>>>>>> by the video code.
>>>>>>
>>>>>> But presumably Exynos still relies on the DT properties, so take
>>>>>> good use of mode_fixup() in to achieve the compatibility hacks.
>>>>>>
>>>>>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>>>>>> ---
>>>>>> Changes in v5:
>>>>>> - Switch video timing type to "u32", so driver could use "of_property_read_u32"
>>>>>>    to get the backword timing values.
>>>>> Okay
>>>>>
>>>>>> Krzysztof suggest me that driver could use
>>>>>>    the "of_property_read_bool" to get backword timing values, but that interfacs
>>>>>>    would modify the original drm_display_mode timing directly (whether those
>>>>>>    properties exists or not).
>>>>> Hmm, I don't understand. You have a:
>>>>> 	struct video_info {
>>>>> 		bool h_sync_polarity;
>>>>> 		bool v_sync_polarity;
>>>>> 		bool interlaced;
>>>>> 	};
>>>>>
>>>>> so what is wrong with:
>>>>> 	dp_video_config->h_sync_polarity =
>>>>> 		of_property_read_bool(dp_node, "hsync-active-high");
>>>>>
>>>>> Is it exactly the same binding as previously?
>>>> Yes, it is the same binding as previously. But just a note that we already
>>>> mark those DT binding as deprecated.
>>>>
>>>> +-interlaced:            deprecated prop that can parsed frm drm_display_mode.
>>>> +-vsync-active-high:     deprecated prop that can parsed frm drm_display_mode.
>>>> +-hsync-active-high:     deprecated prop that can parsed frm drm_display_mode.
>>>>
>>>>
>>>> For now those values should come from "struct drm_display_mode",
>>>> and we already parsed them out from "drm_display_mode" before
>>>> driver provide the backward compatibility.
>>>>
>>>> Let's used the "hsync-active-high" example:
>>>>      As for now the code would like:
>>>>      static void analogix_dp_bridge_mode_set(...)
>>>>      {
>>>>          // Parsed timing value from "drm_display_mode"
>>>>          video->h_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_NHSYNC);
>>>>
>>>>          // Try to detect the deprecated property, providing
>>>>          // the backward compatibility
>>>>          of_property_read_u32(dp_node, "hsync-active-high",
>>>>                                   &video->h_sync_polarity);
>>>>
>>>>          /*
>>>>           * In this case, if "hsync-active-high" property haven't been
>>>>           * found, then the video timing "h_sync_polarity" would  keep
>>>>           * no change, keeping the parsed value from "drm_display_mode"
>>>>           */
>>>>      }
>>>>
>>>>      But if keep the "of_property_read_bool", then code would like:
>>>>      static void analogix_dp_bridge_mode_set(...)
>>>>      {
>>>>          // Parsed timing value from "drm_display_mode"
>>>>          video->h_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_NHSYNC);
>>>>
>>>>          // Try to detect the deprecated property, providing
>>>>          // the backward compatibility
>>>>          video->h_sync_polarity =
>>>>                      of_property_read_bool(dp_node, "hsync-active-high");
>>>>     
>>>>
>>>>          /*
>>>>           * In this case, if "hsync-active-high" property haven't been
>>>>           * found, then the video timing "h_sync_polarity" would just
>>>>           * modify to "false". That is the place we don't want, cause
>>>>           * it would always modify the timing value parsed from
>>>>           * "drm_display_mode"
>>>>           */
>>>>      }
>>>>
>>> OK, I see the point of overwriting values from drm_display_mode. However
>>> I think you changed the binding. I believe the of_property_read_u32()
>>> will behave differently for such DTS:
>>>
>>> exynos_dp {
>>> 	...
>>> 	hsync-active-high;
>>> }
>>>
>>> It will return -EOVERFLOW which means it would be broken now...
>> Whoops, thanks for your remind, after try that, I do see over flow error.
>> static void *of_find_property_value_of_size(const struct device_node *np,
>>                          const char *propname, u32 len)
>> {
>>          ....
>>          if (len > prop->length)
>>                  return ERR_PTR(-EOVERFLOW);
>>          ...
>> }
>>
>> So I though code should be:
>>      if (of_property_read_bool(dp_node, "hsync-active-high"))
>>          video->h_sync_polarity = true;
> Looks good.
>
>> And we can't provide full backward compatibility for this property, cause
>> the previous exynos_dp driver would set this timing value to "false" when
>> property not defined, but analogix_dp driver keep this timing value
>> corresponding to "drm_display_mode" when property not found.
> Indeed, the behaviour changes. I don't know if this is important issue...

Hmm... as I know the timing polarity would influence something like:
     - CTS test
     - HDCP function

But I though it's more likely that driver would made those functions 
failed if
hard code the timing polarity.

And I think it would be better to get timing polarity from 
"drm_display_mode".
Caused the analogix_dp driver have called the drm_add_edid_modes() that
function would parse the EDID "detailed timing" block which contained the
correct timing message that panel request.

Besides I see the exynos_fmid driver already setup the timing polarity from
"drm_display_mode", and there is no doubt that exynos dp should set the
same polarity with fmid driver (I guess, just notice that fmid is a kind 
of CTRC
driver).

That's to say parsing timing polarity dynamically would give more chances to
make those functions works.

Thanks,
- Yakir

> Best regards,
> Krzysztof
>
>
>
>
"
