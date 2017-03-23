From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 23 Mar 2017 10:04:59 +0100
Subject: [PATCH 10/41] drm/bridge: analogix_dp: Don't change psr while
 bridge is disabled
In-Reply-To: <20170322151930.GQ19389@art_vandelay>
References: <20170310043305.17216-1-seanpaul@chromium.org>
 <CGME20170310044738epcas5p254ae086c7ed81ec88e4ba3211f86c014@epcas5p2.samsung.com>
 <20170310043305.17216-11-seanpaul@chromium.org>
 <e7b7ef5b-7935-a74c-c046-27c56ae16774@samsung.com>
 <20170321195818.GE19389@art_vandelay>
 <5279d215-4a19-73c0-0a77-9c8580fa36c0@samsung.com>
 <20170322151930.GQ19389@art_vandelay>
Message-ID: <d45caf3e-8243-8edc-923c-4b955299518b@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.03.2017 16:19, Sean Paul wrote:
> On Wed, Mar 22, 2017 at 09:36:34AM +0100, Andrzej Hajda wrote:
>> On 21.03.2017 20:58, Sean Paul wrote:
>>> On Thu, Mar 16, 2017 at 02:40:21PM +0100, Andrzej Hajda wrote:
>>>> On 10.03.2017 05:32, Sean Paul wrote:
>>>>> From: zain wang <wzz@rock-chips.com>
>>>>>
>>>>> There is a race between AUX CH bring-up and enabling bridge which will
>>>>> cause link training to fail. To avoid hitting it, don't change psr state
>>>>> while enabling the bridge.
>>>>>
>>>>> Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>>>> Cc: Sean Paul <seanpaul@chromium.org>
>>>>> Signed-off-by: zain wang <wzz@rock-chips.com>
>>>>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>>>>> [seanpaul fixed up the commit message a bit and renamed *_supported to *_enabled]
>>>>> Signed-off-by: Sean Paul <seanpaul@chromium.org>
>>>> Hmm, beside resetting psr_enable in analogix_dp_bridge_disable I do not
>>>> see functional change, or am I blind?
>>> The patch also adds a check of psr_enable in analogix_dp_commit. This will avoid
>>> trying to enable psr when the bridge is disabled (that's why psr_enable is
>>> reset).
>> Copy/paste from analogix_dp_commit chunk below:
>>
>> -	dp->psr_support = analogix_dp_detect_sink_psr(dp);
>> -	if (dp->psr_support)
>> +	dp->psr_enable = analogix_dp_detect_sink_psr(dp);
>> +	if (dp->psr_enable)
>>  		analogix_dp_enable_sink_psr(dp);
>>
>>
>> What is added here?
> I guess this is what I get for skimming, apologies. I'll hopefully do a better
> job explaining below.
>
>
>> Regards
>> Andrzej
>>
>>> Sean
>>>
>>>> Regards
>>>> Andrzej
>>>>
>>>>> ---
>>>>>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 15 ++++++++-------
>>>>>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  2 +-
>>>>>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  2 +-
>>>>>  include/drm/bridge/analogix_dp.h                   |  2 +-
>>>>>  4 files changed, 11 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>>>>> index 8a8f05fe9da3..64d94a34874d 100644
>>>>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>>>>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>>>>> @@ -98,20 +98,20 @@ static int analogix_dp_detect_hpd(struct analogix_dp_device *dp)
>>>>>  	return 0;
>>>>>  }
>>>>>  
>>>>> -int analogix_dp_psr_supported(struct device *dev)
>>>>> +int analogix_dp_psr_enabled(struct device *dev)
>>>>>  {
>>>>>  	struct analogix_dp_device *dp = dev_get_drvdata(dev);
>>>>>  
>>>>> -	return dp->psr_support;
>>>>> +	return dp->psr_enable;
>>>>>  }
>>>>> -EXPORT_SYMBOL_GPL(analogix_dp_psr_supported);
>>>>> +EXPORT_SYMBOL_GPL(analogix_dp_psr_enabled);
>>>>>  
>>>>>  int analogix_dp_enable_psr(struct device *dev)
>>>>>  {
>>>>>  	struct analogix_dp_device *dp = dev_get_drvdata(dev);
>>>>>  	struct edp_vsc_psr psr_vsc;
>>>>>  
>>>>> -	if (!dp->psr_support)
>>>>> +	if (!dp->psr_enable)
> This gates enabling psr on the panel. Previously it was put in place to avoid
> trying to enable psr on devices which did not support it.
>
>>>>>  		return 0;
>>>>>  
>>>>>  	/* Prepare VSC packet as per EDP 1.4 spec, Table 6.9 */
>>>>> @@ -134,7 +134,7 @@ int analogix_dp_disable_psr(struct device *dev)
>>>>>  	struct edp_vsc_psr psr_vsc;
>>>>>  	int ret;
>>>>>  
>>>>> -	if (!dp->psr_support)
>>>>> +	if (!dp->psr_enable)
>>>>>  		return 0;
>>>>>  
>>>>>  	/* Prepare VSC packet as per EDP 1.4 spec, Table 6.9 */
>>>>> @@ -878,8 +878,8 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
>>>>>  	/* Enable video */
>>>>>  	analogix_dp_start_video(dp);
>>>>>  
>>>>> -	dp->psr_support = analogix_dp_detect_sink_psr(dp);
>>>>> -	if (dp->psr_support)
>>>>> +	dp->psr_enable = analogix_dp_detect_si1]nk_psr(dp);
>>>>> +	if (dp->psr_enable)
> This probes the hardware to see if psr is supported. If it is, psr_enable will
> transition to true. Before this patch, psr_support/psr_enable would be flipped
> true on the first modeset and stay that way forever, even when the panel was
> turned off.

But here and above we have still only renaming, no functional change.


>
>>>>>  		analogix_dp_enable_sink_psr(dp);
>>>>>  }
>>>>>  
>>>>> @@ -1120,6 +1120,7 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
>>>>>  	if (ret)
>>>>>  		DRM_ERROR("failed to setup the panel ret = %d\n", ret);
>>>>>  
>>>>> +	dp->psr_enable = false;
> By setting psr_enable to false here, the driver ensures that any subsequent calls
> to analogix_dp_enable_psr() will return early and will not attempt to change
> hardware (that would fail). Once the panel is re-enabled, psr_enable will return
> to true if the hardware supports it.
>
> This is why the variable was renamed from psr_support to psr_enable. It no
> longer just tracks whether psr is supported, but rather that it is supported and
> eligible to be enabled.

OK so the patch does actually two things:
- renaming psr_support* -> psr_enable*
- reset psr_enable on bridge disable.

Renaming obscures the patch and hides functional change, so please say
about real change in description.
And regarding description, it does not seem adequate to the patch, do we
really have race here? Or as subject says we prevent touching psr on
disabled bridge.

Regards
Andrzej



>
> Sean
>
>
>>>>>  	dp->dpms_mode = DRM_MODE_DPMS_OFF;
>>>>>  }
>>>>>  
>>>>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
>>>>> index b039b28d8fcc..e135a42cb19e 100644
>>>>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
>>>>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
>>>>> @@ -170,7 +170,7 @@ struct analogix_dp_device {
>>>>>  	int			dpms_mode;
>>>>>  	int			hpd_gpio;
>>>>>  	bool                    force_hpd;
>>>>> -	bool			psr_support;
>>>>> +	bool			psr_enable;
>>>>>  
>>>>>  	struct mutex		panel_lock;
>>>>>  	bool			panel_is_modeset;
>>>>> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
>>>>> index 64e7e2c0bc58..f44756029478 100644
>>>>> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
>>>>> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
>>>>> @@ -83,7 +83,7 @@ static void analogix_dp_psr_set(struct drm_encoder *encoder, bool enabled)
>>>>>  	int vact_end;
>>>>>  	int ret;
>>>>>  
>>>>> -	if (!analogix_dp_psr_supported(dp->dev))
>>>>> +	if (!analogix_dp_psr_enabled(dp->dev))
>>>>>  		return;
>>>>>  
>>>>>  	dev_dbg(dp->dev, "%s PSR...\n", enabled ? "enable" : "disable");
>>>>> diff --git a/include/drm/bridge/analogix_dp.h b/include/drm/bridge/analogix_dp.h
>>>>> index c99d6eaef1ac..4fc0165ed3f5 100644
>>>>> --- a/include/drm/bridge/analogix_dp.h
>>>>> +++ b/include/drm/bridge/analogix_dp.h
>>>>> @@ -38,7 +38,7 @@ struct analogix_dp_plat_data {
>>>>>  			 struct drm_connector *);
>>>>>  };
>>>>>  
>>>>> -int analogix_dp_psr_supported(struct device *dev);
>>>>> +int analogix_dp_psr_enabled(struct device *dev);
>>>>>  int analogix_dp_enable_psr(struct device *dev);
>>>>>  int analogix_dp_disable_psr(struct device *dev);
>>>>>  
