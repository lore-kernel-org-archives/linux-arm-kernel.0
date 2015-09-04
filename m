From: robherring2@gmail.com (Rob Herring)
Date: Fri, 4 Sep 2015 16:06:02 -0500
Subject: [PATCH v4 03/16] drm: bridge: analogix/dp: split exynos dp driver
 to bridge dir
In-Reply-To: <2618155.E00Pak1qvi@phil>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1441086598-24995-1-git-send-email-ykk@rock-chips.com>
 <2618155.E00Pak1qvi@phil>
Message-ID: <CAL_JsqLvOOF0Wk=E1kz0rWXg0+6ay0=4OTbCpjdGCfL7_qFN8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 1, 2015 at 3:46 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Am Dienstag, 1. September 2015, 13:49:58 schrieb Yakir Yang:
>> Split the dp core driver from exynos directory to bridge
>> directory, and rename the core driver to analogix_dp_*,
>> leave the platform code to analogix_dp-exynos.
>>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>
> [...]
>
>> diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c
>> b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c similarity index 50%
>> rename from drivers/gpu/drm/exynos/exynos_dp_core.c
>> rename to drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> index bed0252..7d62f22 100644
>> --- a/drivers/gpu/drm/exynos/exynos_dp_core.c
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>
> [...]
>
>>       connector->polled = DRM_CONNECTOR_POLL_HPD;
>>
>>       ret = drm_connector_init(dp->drm_dev, connector,
>> -                              &exynos_dp_connector_funcs,
>> +                              &analogix_dp_connector_funcs,
>>                                DRM_MODE_CONNECTOR_eDP);
>>       if (ret) {
>>               DRM_ERROR("Failed to initialize connector with drm\n");
>>               return ret;
>>       }
>>
>> -     drm_connector_helper_add(connector, &exynos_dp_connector_helper_funcs);
>> +     drm_connector_helper_add(connector,
>> +                              &analogix_dp_connector_helper_funcs);
>>       drm_connector_register(connector);
>
> this should only run on exynos, as we're doing all our connector registration
> in the core driver after all components are bound, so I guess something like
> the following is needed:
>
>        if (dp->plat_data && dp->plat_data->dev_type == EXYNOS_DP)
>                drm_connector_register(connector);

Yuck!

Surely there is a better way. From what I've seen of DRM, I have no
doubt this is needed, but really a better solution is needed. Surely
there can be a more generic way for the driver to determine if it
should handle the connector or not. This seems like a common problem
including one I have seen. What I'm working on has onchip DSI encoder
-> ADV7533 -> HDMI. The DSI encoder can also have a direct attached
panel. So I have to check for a bridge in the encoder driver and only
register the connector for the panel if a bridge is not attached.

Rob
