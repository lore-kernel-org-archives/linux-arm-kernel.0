From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Mon, 05 Mar 2018 15:01:24 +0800
Subject: [PATCH v9 5/5] drm/bridge/synopsys: dw-hdmi: Add missing bridge
 detach
In-Reply-To: <5A99EA37.6070006@rock-chips.com>
References: <20180302175757.28192-1-enric.balletbo@collabora.com>
 <20180302175757.28192-6-enric.balletbo@collabora.com>
 <2714218.VptbnhJPkd@avalon> <5A99EA37.6070006@rock-chips.com>
Message-ID: <5A9CEB44.40207@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

sorry, you're right, this patch should not be needed.

the connector should be cleanup by 
drm_mode_config_cleanup->drm_connector_put.

i did that in analogix_dp is to avoid a use-after-free issue not 
kmemleak, because the connector was allocated/freed in analogix_dp's 
bind/unbind.

but i found a kmemleak issue(dma_mask not freed) in dw-hdmi when testing 
that, will send patch soon.

On 03/03/2018 08:20 AM, JeffyChen wrote:
> Hi Laurent,
>
> On 03/03/2018 05:49 AM, Laurent Pinchart wrote:
>> Hi Enric,
>>
>> Thank you for the patch.
>>
>> On Friday, 2 March 2018 19:57:57 EET Enric Balletbo i Serra wrote:
>>> From: Jeffy Chen <jeffy.chen@rock-chips.com>
>>>
>>> We inited connector in attach(), so need a detach() to cleanup.
>>
>> Do we ? The dw-hdmi driver already sets drm_connector_cleanup() as the
>> connector .destroy() handler, and the .destroy() operation is called
>> by the
>> DRM core. None of the other bridge drivers call drm_connector_cleanup()
>> directly.
>
> hmmm, checking the code, there are also lots of drivers do the
> cleanup(drm_connector_cleanup or funcs->destroy):
> drm# grep -r "connector.*funcs->destroy" .
> ./rockchip/inno_hdmi.c: hdmi->connector.funcs->destroy(&hdmi->connector);
> ./rockchip/cdn-dp-core.c:       connector->funcs->destroy(connector);
> ./bridge/analogix/analogix_dp_core.c:
> dp->connector.funcs->destroy(&dp->connector);
> ./msm/hdmi/hdmi.c: hdmi->connector->funcs->destroy(hdmi->connector);
> ./msm/dsi/dsi.c: msm_dsi->connector->funcs->destroy(msm_dsi->connector);
> ./msm/edp/edp.c: edp->connector->funcs->destroy(edp->connector);
> ./zte/zx_hdmi.c:        hdmi->connector.funcs->destroy(&hdmi->connector);
> ./drm_connector.c:      connector->funcs->destroy(connector);
> ./drm_connector.c:              connector->funcs->destroy(connector);
> ./nouveau/dispnv04/disp.c: connector->funcs->destroy(connector);
> ./nouveau/nv50_display.c: mstc->connector.funcs->destroy(&mstc->connector);
> ./nouveau/nv50_display.c: connector->funcs->destroy(connector);
>
>
>
> when i debug analogix_dp bind/unbind, i found that we need to cleanup
> the connector(reported by kmemleak). so i added it to
> ./bridge/analogix/analogix_dp_core.c...after that i saw dw-hdmi missing
> that too(by checking the code), so make this patch.
>
> but i didn't really tested it on devices using dw-hdmi, so i'm not very
> sure the dw-hdmi(maybe also other bridges) is the same with analogix_dp.
>
> i can try to find a chromebook veyron to check it next week :)
>
> but even there's a leak, i'm still not very sure about:
> should the caller of drm_connector_init cleanup it
> or the caller of drm_bridge_attach should do it(for example
> analogix_dp_bind/analogix_dp_unbind)
> or should the DRM core take care of that?
>
>>
>>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>>> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> ---
