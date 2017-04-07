From: daniel.vetter@ffwll.ch (Daniel Vetter)
Date: Fri, 7 Apr 2017 20:31:28 +0200
Subject: [PATCH] drm: dw-hdmi: Implement the mode_fixup drm helper
In-Reply-To: <bdb7e77a-9f0f-fcb4-e5d2-1968d499070d@codeaurora.org>
References: <20170407121743.4142-1-romain.perier@collabora.com>
 <bdb7e77a-9f0f-fcb4-e5d2-1968d499070d@codeaurora.org>
Message-ID: <CAKMK7uH4SN7ayrgPeh=y_nSquBmtA=wWcF8hmPSdqha-vKZV_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 7, 2017 at 7:15 PM, Archit Taneja <architt@codeaurora.org> wrote:
> On 4/7/2017 5:47 PM, Romain Perier wrote:
>>
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
>
>
> We do have a atomic_check op in drm_connector_helper_funcs. I've
> rarely seen it being used, but it could be used to validate
> the mode w.r.t the connector, rather than checking it in the
> bridge's mode_fixup op.
>
> Daniel,
>
> Is it okay to use the connector's atomic_check to validate a mode.
> (by peeping into the new_crtc_state->mode?)

This new atomic_check is super-new, and only for validating properties
on the connector, before stuff like the routing or crtc is all set up.
So no, can't be used for that. mode_fixup on the bridge is indeed the
right place for limiting output specific stuff. Yes this is all a bit
awkward, but thus far no one volunteered to improve the helpers after
I explained the full nastiness of the situation ... I think we should
have some helpers that implement the mode_valid helper in terms of the
mode_fixup/atomic_check functions, but that's a bit tricky to get
right :(
-Daniel

>
> Thanks,
> Archit
>
>
>>
>> Signed-off-by: Romain Perier <romain.perier@collabora.com>
>> ---
>>  drivers/gpu/drm/bridge/dw-hdmi.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/dw-hdmi.c
>> b/drivers/gpu/drm/bridge/dw-hdmi.c
>> index 22211ff..3bd0807 100644
>> --- a/drivers/gpu/drm/bridge/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/dw-hdmi.c
>> @@ -1740,6 +1740,21 @@ static int dw_hdmi_bridge_attach(struct drm_bridge
>> *bridge)
>>         return 0;
>>  }
>>
>> +
>> +static bool dw_hdmi_bridge_mode_fixup(struct drm_bridge *bridge,
>> +                                     const struct drm_display_mode
>> *orig_mode,
>> +                                     struct drm_display_mode *mode)
>> +{
>> +       struct dw_hdmi *hdmi = bridge->driver_private;
>> +       struct drm_connector *connector = &hdmi->connector;
>> +       enum drm_mode_status status;
>> +
>> +       status = dw_hdmi_connector_mode_valid(connector, mode);
>> +       if (status != MODE_OK)
>> +               return false;
>> +       return true;
>> +}
>> +
>>  static void dw_hdmi_bridge_mode_set(struct drm_bridge *bridge,
>>                                     struct drm_display_mode *orig_mode,
>>                                     struct drm_display_mode *mode)
>> @@ -1781,6 +1796,7 @@ static const struct drm_bridge_funcs
>> dw_hdmi_bridge_funcs = {
>>         .enable = dw_hdmi_bridge_enable,
>>         .disable = dw_hdmi_bridge_disable,
>>         .mode_set = dw_hdmi_bridge_mode_set,
>> +       .mode_fixup = dw_hdmi_bridge_mode_fixup,
>>  };
>>
>>  static irqreturn_t dw_hdmi_i2c_irq(struct dw_hdmi *hdmi)
>>
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
