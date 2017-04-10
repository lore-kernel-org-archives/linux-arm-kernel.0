From: architt@codeaurora.org (Archit Taneja)
Date: Mon, 10 Apr 2017 16:24:10 +0530
Subject: [PATCH] drm: dw-hdmi: Implement the mode_fixup drm helper
In-Reply-To: <20170407183307.etouyzkwr6yzchan@phenom.ffwll.local>
References: <20170407121743.4142-1-romain.perier@collabora.com>
 <20170407183307.etouyzkwr6yzchan@phenom.ffwll.local>
Message-ID: <24a858d4-fba4-3218-dffd-8185a070fd9d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/08/2017 12:03 AM, Daniel Vetter wrote:
> On Fri, Apr 07, 2017 at 02:17:43PM +0200, Romain Perier wrote:
>> This helper is supposed to validate or reject the modeline before it
>> applied by the mode setting. Currently this function has been dropped,
>> it was previously set to a dummy function that always returned true. For
>> both cases, this means that userspace can ask for a bad modeline that
>> will be always accepted.
>>
>> On some platforms, like Rockchip, the drm dw_hdmi-rockchip variant driver
>> already implements the atomic_check drm helper, so mode_fixup cannot be
>> handled and implemented there (as drm_atomic_helper relies on either
>> atomic_check or mode_fixup).
>>
>> This commit implements this helper. It only checks that this mode is
>> correct from the connector point of view
>>
>> Signed-off-by: Romain Perier <romain.perier@collabora.com>	
>
> Yup this is how it's supposed to be done, check bridge limits in the
> bridge's mode_fixup hook.
>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

queued to drm-misc-next-fixes (so that it makes it into 4.12).

Thanks,
Archit

>> ---
>>  drivers/gpu/drm/bridge/dw-hdmi.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/dw-hdmi.c b/drivers/gpu/drm/bridge/dw-hdmi.c
>> index 22211ff..3bd0807 100644
>> --- a/drivers/gpu/drm/bridge/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/dw-hdmi.c
>> @@ -1740,6 +1740,21 @@ static int dw_hdmi_bridge_attach(struct drm_bridge *bridge)
>>  	return 0;
>>  }
>>
>> +
>> +static bool dw_hdmi_bridge_mode_fixup(struct drm_bridge *bridge,
>> +				      const struct drm_display_mode *orig_mode,
>> +				      struct drm_display_mode *mode)
>> +{
>> +	struct dw_hdmi *hdmi = bridge->driver_private;
>> +	struct drm_connector *connector = &hdmi->connector;
>> +	enum drm_mode_status status;
>> +
>> +	status = dw_hdmi_connector_mode_valid(connector, mode);
>> +	if (status != MODE_OK)
>> +		return false;
>> +	return true;
>> +}
>> +
>>  static void dw_hdmi_bridge_mode_set(struct drm_bridge *bridge,
>>  				    struct drm_display_mode *orig_mode,
>>  				    struct drm_display_mode *mode)
>> @@ -1781,6 +1796,7 @@ static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
>>  	.enable = dw_hdmi_bridge_enable,
>>  	.disable = dw_hdmi_bridge_disable,
>>  	.mode_set = dw_hdmi_bridge_mode_set,
>> +	.mode_fixup = dw_hdmi_bridge_mode_fixup,
>>  };
>>
>>  static irqreturn_t dw_hdmi_i2c_irq(struct dw_hdmi *hdmi)
>> --
>> 2.9.3
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel at lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
