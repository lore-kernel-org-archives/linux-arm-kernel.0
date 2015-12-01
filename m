From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 01 Dec 2015 16:07:02 +0800
Subject: [RFC PATCH 8/9] drm: bridge/dw_hdmi: Covert to support atomic API
In-Reply-To: <20151201072128.GF17050@phenom.ffwll.local>
References: <1448940391-23333-1-git-send-email-mark.yao@rock-chips.com>
 <1448940953-23604-1-git-send-email-mark.yao@rock-chips.com>
 <20151201072128.GF17050@phenom.ffwll.local>
Message-ID: <565D5526.7030009@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?12?01? 15:21, Daniel Vetter wrote:
> On Tue, Dec 01, 2015 at 11:35:53AM +0800, Mark Yao wrote:
>> Fill atomic needed funcs with default atomic helper library.
>>
>> Rockchip use dw_hdmi, and drm/rockchip will covert to atomic api,
>> we need dw_hdmi support atomic funcs.
>>
>> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> Aren't there drivers around which use dw_hdmi and which are still not yet
> atomic? This would break them. I think we neeed two connector_func tables
> and dw_hdmi needs to check for DRIVER_ATOMIC at runtime and pick the right
> version.

Right, another drm driver use dw_hdmi is imx, not yet atomic, this would 
break it.
as you said, I would resend a patch to check DRIVER_ATOMIC at runtime.

Thanks
-Mark

>
> The larger problem here is that "who should register the drm_connector" is
> a bit an unsolved problem, since both the bridge and the driver should be
> able to customize/adjust the drm_connector at the end of a bridge chain.
> This here is just another example of this problem.
> -Daniel
>
>> ---
>>   drivers/gpu/drm/bridge/dw_hdmi.c |    6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
>> index 56de9f1..587065a 100644
>> --- a/drivers/gpu/drm/bridge/dw_hdmi.c
>> +++ b/drivers/gpu/drm/bridge/dw_hdmi.c
>> @@ -22,6 +22,7 @@
>>   
>>   #include <drm/drm_of.h>
>>   #include <drm/drmP.h>
>> +#include <drm/drm_atomic_helper.h>
>>   #include <drm/drm_crtc_helper.h>
>>   #include <drm/drm_edid.h>
>>   #include <drm/drm_encoder_slave.h>
>> @@ -1515,11 +1516,14 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
>>   }
>>   
>>   static struct drm_connector_funcs dw_hdmi_connector_funcs = {
>> -	.dpms = drm_helper_connector_dpms,
>> +	.dpms = drm_atomic_helper_connector_dpms,
>>   	.fill_modes = drm_helper_probe_single_connector_modes,
>>   	.detect = dw_hdmi_connector_detect,
>>   	.destroy = dw_hdmi_connector_destroy,
>>   	.force = dw_hdmi_connector_force,
>> +	.reset = drm_atomic_helper_connector_reset,
>> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>>   };
>>   
>>   static struct drm_connector_helper_funcs dw_hdmi_connector_helper_funcs = {
>> -- 
>> 1.7.9.5
>>
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel at lists.freedesktop.org
>> http://lists.freedesktop.org/mailman/listinfo/dri-devel
