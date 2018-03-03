From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Sat, 03 Mar 2018 08:20:07 +0800
Subject: [PATCH v9 5/5] drm/bridge/synopsys: dw-hdmi: Add missing bridge
 detach
In-Reply-To: <2714218.VptbnhJPkd@avalon>
References: <20180302175757.28192-1-enric.balletbo@collabora.com>
 <20180302175757.28192-6-enric.balletbo@collabora.com>
 <2714218.VptbnhJPkd@avalon>
Message-ID: <5A99EA37.6070006@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On 03/03/2018 05:49 AM, Laurent Pinchart wrote:
> Hi Enric,
>
> Thank you for the patch.
>
> On Friday, 2 March 2018 19:57:57 EET Enric Balletbo i Serra wrote:
>> From: Jeffy Chen <jeffy.chen@rock-chips.com>
>>
>> We inited connector in attach(), so need a detach() to cleanup.
>
> Do we ? The dw-hdmi driver already sets drm_connector_cleanup() as the
> connector .destroy() handler, and the .destroy() operation is called by the
> DRM core. None of the other bridge drivers call drm_connector_cleanup()
> directly.

hmmm, checking the code, there are also lots of drivers do the 
cleanup(drm_connector_cleanup or funcs->destroy):
drm# grep -r "connector.*funcs->destroy" .
./rockchip/inno_hdmi.c: hdmi->connector.funcs->destroy(&hdmi->connector);
./rockchip/cdn-dp-core.c:       connector->funcs->destroy(connector);
./bridge/analogix/analogix_dp_core.c: 
dp->connector.funcs->destroy(&dp->connector);
./msm/hdmi/hdmi.c: 
hdmi->connector->funcs->destroy(hdmi->connector);
./msm/dsi/dsi.c: 
msm_dsi->connector->funcs->destroy(msm_dsi->connector);
./msm/edp/edp.c: 
edp->connector->funcs->destroy(edp->connector);
./zte/zx_hdmi.c:        hdmi->connector.funcs->destroy(&hdmi->connector);
./drm_connector.c:      connector->funcs->destroy(connector);
./drm_connector.c:              connector->funcs->destroy(connector);
./nouveau/dispnv04/disp.c: 
connector->funcs->destroy(connector);
./nouveau/nv50_display.c: 
mstc->connector.funcs->destroy(&mstc->connector);
./nouveau/nv50_display.c: 
connector->funcs->destroy(connector);



when i debug analogix_dp bind/unbind, i found that we need to cleanup 
the connector(reported by kmemleak). so i added it to 
./bridge/analogix/analogix_dp_core.c...after that i saw dw-hdmi missing 
that too(by checking the code), so make this patch.

but i didn't really tested it on devices using dw-hdmi, so i'm not very 
sure the dw-hdmi(maybe also other bridges) is the same with analogix_dp.

i can try to find a chromebook veyron to check it next week :)

but even there's a leak, i'm still not very sure about:
should the caller of drm_connector_init cleanup it
or the caller of drm_bridge_attach should do it(for example 
analogix_dp_bind/analogix_dp_unbind)
or should the DRM core take care of that?

>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v9: None
>>
>>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
>> f9802399cc0d..5626922f95f9 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -1985,6 +1985,13 @@ static int dw_hdmi_bridge_attach(struct drm_bridge
>> *bridge) return 0;
>>   }
>>
>> +static void dw_hdmi_bridge_detach(struct drm_bridge *bridge)
>> +{
>> +	struct dw_hdmi *hdmi = bridge->driver_private;
>> +
>> +	drm_connector_cleanup(&hdmi->connector);
>> +}
>> +
>>   static enum drm_mode_status
>>   dw_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
>>   			  const struct drm_display_mode *mode)
>> @@ -2041,6 +2048,7 @@ static void dw_hdmi_bridge_enable(struct drm_bridge
>> *bridge)
>>
>>   static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
>>   	.attach = dw_hdmi_bridge_attach,
>> +	.detach = dw_hdmi_bridge_detach,
>>   	.enable = dw_hdmi_bridge_enable,
>>   	.disable = dw_hdmi_bridge_disable,
>>   	.mode_set = dw_hdmi_bridge_mode_set,
>
