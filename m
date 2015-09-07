From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 07 Sep 2015 09:22:35 +0900
Subject: [PATCH v4 03/16] drm: bridge: analogix/dp: split exynos dp driver
 to bridge dir
In-Reply-To: <55EBF024.3070304@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1441086598-24995-1-git-send-email-ykk@rock-chips.com>
 <55E79B41.6010301@samsung.com> <55E7DAE1.6070308@rock-chips.com>
 <55E8E8BE.8010300@samsung.com> <55EBF024.3070304@rock-chips.com>
Message-ID: <55ECD8CB.7060408@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.09.2015 16:49, Yakir Yang wrote:
> Hi Krzysztof,
> 
> ? 09/04/2015 08:41 AM, Krzysztof Kozlowski ??:
>> On 03.09.2015 14:30, Yakir Yang wrote:
>>> Hi Krzysztof,
>>>
>>> ? 09/03/2015 08:58 AM, Krzysztof Kozlowski ??:
>>>> On 01.09.2015 14:49, Yakir Yang wrote:
>>>>> Split the dp core driver from exynos directory to bridge
>>>>> directory, and rename the core driver to analogix_dp_*,
>>>>> leave the platform code to analogix_dp-exynos.
>>>>>
>>>>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>>>>> ---
>>>>> Changes in v4:
>>>>> - Take Rob suggest, update "analogix,hpd-gpios" to "hpd-gpios" DT
>>>>> propery.
>>>>> - Take Jingoo suggest, rename "analogix_dp-exynos.c" file name to
>>>>> "exynos_dp.c"
>>>>> - Take Archit suggest, create a separate folder for analogix code in
>>>>> bridge/
>>>>>
>>>>> Changes in v3:
>>>>> - Take Thierry Reding suggest, move exynos's video_timing code
>>>>>     to analogix_dp-exynos platform driver, add get_modes method
>>>>>     to struct analogix_dp_plat_data.
>>>>> - Take Heiko suggest, rename some "samsung*" dts propery to
>>>>> "analogix*".
>>>>>
>>>>> Changes in v2:
>>>>> - Take Jingoo Han suggest, remove new copyright
>>>>> - Fix compiled failed dut to analogix_dp_device misspell
> 
> [.....]
> 
>>>>> -static int exynos_dp_bridge_attach(struct drm_bridge *bridge)
>>>>> +static int analogix_dp_bridge_attach(struct drm_bridge *bridge)
>>>>>    {
>>>>> -    struct exynos_dp_device *dp = bridge->driver_private;
>>>>> -    struct drm_encoder *encoder = &dp->encoder;
>>>>> +    struct analogix_dp_device *dp = bridge->driver_private;
>>>>> +    struct drm_encoder *encoder = dp->encoder;
>>>>>        struct drm_connector *connector = &dp->connector;
>>>>>        int ret;
>>>>>    -    /* Pre-empt DP connector creation if there's a bridge */
>>>>> -    if (dp->ptn_bridge) {
>>>>> -        ret = exynos_drm_attach_lcd_bridge(dp, encoder);
>>>>> -        if (!ret)
>>>>> -            return 0;
>>>>> +    if (!bridge->encoder) {
>>>>> +        DRM_ERROR("Parent encoder object not found");
>>>>> +        return -ENODEV;
>>>>>        }
>>>>>    +    encoder->bridge = bridge;
>>>>> +
>>>>>        connector->polled = DRM_CONNECTOR_POLL_HPD;
>>>>>          ret = drm_connector_init(dp->drm_dev, connector,
>>>>> -                 &exynos_dp_connector_funcs,
>>>>> +                 &analogix_dp_connector_funcs,
>>>>>                     DRM_MODE_CONNECTOR_eDP);
>>>>>        if (ret) {
>>>>>            DRM_ERROR("Failed to initialize connector with drm\n");
>>>>>            return ret;
>>>>>        }
>>>>>    -    drm_connector_helper_add(connector,
>>>>> &exynos_dp_connector_helper_funcs);
>>>>> +    drm_connector_helper_add(connector,
>>>>> +                 &analogix_dp_connector_helper_funcs);
>>>>>        drm_connector_register(connector);
>>>>>        drm_mode_connector_attach_encoder(connector, encoder);
>>>>>    -    if (dp->panel)
>>>>> -        ret = drm_panel_attach(dp->panel, &dp->connector);
>>>>> +    if (dp->plat_data && dp->plat_data->panel) {
>>>>> +        ret = drm_panel_attach(dp->plat_data->panel, &dp->connector);
>>>>> +        if (ret) {
>>>>> +            DRM_ERROR("Failed to attach panel\n");
>>>>> +            return ret;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    /*
>>>>> +     * This should be the end of attach function, caused
>>>>> +     * we should ensure dp bridge could attach first.
>>>>> +     */
>>>>> +     if (dp->plat_data && dp->plat_data->attach) {
>>>>> +         ret = dp->plat_data->attach(dp->plat_data, bridge);
>>>>> +         if (ret) {
>>>>> +             DRM_ERROR("Failed at platform attch func\n");
>>>> Two new error paths appeared here and above. Don't you have to
>>>> cleanup something? I don't know, just wondering...
>>> Hmm... I think both panel & platform_attch need ERROR remind when
>>> it failed. But if it still need clean, I though it should clean the
>>> platform attch
>>> error,
>>> this is not relate to DRM directly, just analogix driver logic, so
>>> code would like,
>>>
>>> -    if (dp->panel)
>>> -        ret = drm_panel_attach(dp->panel, &dp->connector);
>>> +    if (dp->plat_data && dp->plat_data->panel) {
>>> +        ret = drm_panel_attach(dp->plat_data->panel, &dp->connector);
>>> +        if (ret) {
>>> +            DRM_ERROR("Failed to attach panel\n");
>>> +            return ret;
>>> +        }
>>> +    }
>>>
>>> +    /*
>>> +     * This should be the end of attach function, caused
>>> +     * we should ensure dp bridge could attach first.
>>> +     */
>>> +     if (dp->plat_data && dp->plat_data->attach) {
>>> +         ret = dp->plat_data->attach(dp->plat_data, bridge);
>>>
>>>            return ret;
>> I am lost... the code looks the same. What did you change?
> 
> I just remove the DRM_ERROR after dp->plat_data->attach(),
> maybe I should paste the change that rebase on this patch,
> here are they,
> 
>     /*
>      * This should be the end of attach function, caused
>      * we should ensure dp bridge could attach first.
>      */
> -     if (dp->plat_data && dp->plat_data->attach) {
> +     if (dp->plat_data && dp->plat_data->attach)
>            ret = dp->plat_data->attach(dp->plat_data, bridge);
> -          if (ret) {
> -              DRM_ERROR("Failed at platform attch func\n");
> -              return ret;
> -          }
> -      }
> 
> -    return 0;
> +   return ret;
> 
> 
> If this haven't meet your comment, I maybe start to think that
> your comment  "Two new error paths appeared here and above"
> indicated that those two function is the same.
>     "dp->plat_data->attach(dp->plat_data, bridge); "
>     "drm_panel_attach(dp->plat_data->panel, &dp->connector); "

I wasn't talking about error message but rather about possible need of
clean up in error path. Previously there was only drm_panel_attach().
Now you have two of them (drm_panel_attach() and
dp->plat_data->attach()). If the second fails don't you have to clean up
before exit? I don't know, just asking.

Best regards,
Krzysztof
