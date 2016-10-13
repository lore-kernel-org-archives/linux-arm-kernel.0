From: mark.yao@rock-chips.com (Mark yao)
Date: Thu, 13 Oct 2016 09:56:50 +0800
Subject: Question: Re: [PATCH] drm/bridge: analogix: protect power when
 get_modes or detect
In-Reply-To: <CAOw6vbKe0d66O1MymP24UQ-M3EmdR+=pZVWmgZG9iVm5x1Arrg@mail.gmail.com>
References: <1476266442-29803-1-git-send-email-mark.yao@rock-chips.com>
 <57FE0EF5.7010207@rock-chips.com>
 <CAOw6vbKe0d66O1MymP24UQ-M3EmdR+=pZVWmgZG9iVm5x1Arrg@mail.gmail.com>
Message-ID: <57FEE9E2.20505@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?10?12? 22:51, Sean Paul wrote:
> On Wed, Oct 12, 2016 at 6:22 AM, Mark yao <mark.yao@rock-chips.com> wrote:
>> I'm not familiar with the analogix driver, maybe use a power reference count
>> would better then direct power on/off analogix_dp.
>>
>> Does anyone has the idea to protect detect and get_modes context?
>>
> I'm not sure a reference count is going to help here. The common
> pattern is to call detect() followed by get_modes() and then modeset.
> However, it's not guaranteed that any one of those functions will be
> called after the other. So, if you leave things on after detect or
> get_modes, you might be wasting power (or worse).
>
> I recently ran into this exact problem with a panel we're using. Check
> out "0b8b059a7: drm/bridge: analogix_dp: Ensure the panel is properly
> prepared/unprepared". Perhaps you can piggyback on that function to
> add your pm_runtime and plat_data callbacks (since using dpms_mode
> might be racey).
>
> Sean
Hi Sean

Thanks for your advice.

I re-test the detect and get_modes, only use pm_runtime_get/put also can 
fix my problem.
without plat_data callbacks can avoid race to dpms_mode.

I had send v2 patch,  you can review it.

Thanks.

>
>> I found many other connector driver also direct access register on detect or
>> get_modes, no problem for it?
>>
>> On 2016?10?12? 18:00, Mark Yao wrote:
>>
>> The drm callback ->detect and ->get_modes seems is not power safe,
>> they may be called when device is power off, do register access on
>> detect or get_modes will cause system die.
>>
>> Here is the path call ->detect before analogix_dp power on
>> [<ffffff800843babc>] analogix_dp_detect+0x44/0xdc
>> [<ffffff80083fd840>]
>> drm_helper_probe_single_connector_modes_merge_bits+0xe8/0x41c
>> [<ffffff80083fdb84>] drm_helper_probe_single_connector_modes+0x10/0x18
>> [<ffffff8008418d24>] drm_mode_getconnector+0xf4/0x304
>> [<ffffff800840cff0>] drm_ioctl+0x23c/0x390
>> [<ffffff80081a8adc>] do_vfs_ioctl+0x4b8/0x58c
>> [<ffffff80081a8c10>] SyS_ioctl+0x60/0x88
>>
>> Cc: Inki Dae <inki.dae@samsung.com>
>> Cc: Sean Paul <seanpaul@chromium.org>
>> Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
>> Cc: "Ville Syrj?l?" <ville.syrjala@linux.intel.com>
>>
>> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
>> ---
>>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 28
>> ++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> index efac8ab..09dece2 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> @@ -1062,6 +1062,13 @@ int analogix_dp_get_modes(struct drm_connector
>> *connector)
>>    return 0;
>>    }
>>
>> + if (dp->dpms_mode != DRM_MODE_DPMS_ON) {
>> + pm_runtime_get_sync(dp->dev);
>> +
>> + if (dp->plat_data->power_on)
>> + dp->plat_data->power_on(dp->plat_data);
>> + }
>> +
>>    if (analogix_dp_handle_edid(dp) == 0) {
>>    drm_mode_connector_update_edid_property(&dp->connector, edid);
>>    num_modes += drm_add_edid_modes(&dp->connector, edid);
>> @@ -1073,6 +1080,13 @@ int analogix_dp_get_modes(struct drm_connector
>> *connector)
>>    if (dp->plat_data->get_modes)
>>    num_modes += dp->plat_data->get_modes(dp->plat_data, connector);
>>
>> + if (dp->dpms_mode != DRM_MODE_DPMS_ON) {
>> + if (dp->plat_data->power_off)
>> + dp->plat_data->power_off(dp->plat_data);
>> +
>> + pm_runtime_put_sync(dp->dev);
>> + }
>> +
>>    ret = analogix_dp_prepare_panel(dp, false, false);
>>    if (ret)
>>    DRM_ERROR("Failed to unprepare panel (%d)\n", ret);
>> @@ -1106,9 +1120,23 @@ analogix_dp_detect(struct drm_connector *connector,
>> bool force)
>>    return connector_status_disconnected;
>>    }
>>
>> + if (dp->dpms_mode != DRM_MODE_DPMS_ON) {
>> + pm_runtime_get_sync(dp->dev);
>> +
>> + if (dp->plat_data->power_on)
>> + dp->plat_data->power_on(dp->plat_data);
>> + }
>> +
>>    if (!analogix_dp_detect_hpd(dp))
>>    status = connector_status_connected;
>>
>> + if (dp->dpms_mode != DRM_MODE_DPMS_ON) {
>> + if (dp->plat_data->power_off)
>> + dp->plat_data->power_off(dp->plat_data);
>> +
>> + pm_runtime_put_sync(dp->dev);
>> + }
>> +
>>    ret = analogix_dp_prepare_panel(dp, false, false);
>>    if (ret)
>>    DRM_ERROR("Failed to unprepare panel (%d)\n", ret);
>>
>>
>>
>> --
>> ?ark Yao
>
>


-- 
?ark Yao
