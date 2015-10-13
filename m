From: info@lategoodbye.de (Stefan Wahren)
Date: Tue, 13 Oct 2015 20:50:30 +0200
Subject: [PATCH v3 3/7] drm/vc4: Add KMS support for Raspberry Pi.
In-Reply-To: <87io6a3a34.fsf@eliezer.anholt.net>
References: <1444426068-15817-1-git-send-email-eric@anholt.net>
 <1444426068-15817-4-git-send-email-eric@anholt.net>
 <561A6BE4.9080409@lategoodbye.de> <87io6a3a34.fsf@eliezer.anholt.net>
Message-ID: <561D5276.40906@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 13.10.2015 um 20:19 schrieb Eric Anholt:
> Stefan Wahren <info@lategoodbye.de> writes:
>
>>> diff --git a/drivers/gpu/drm/vc4/Kconfig b/drivers/gpu/drm/vc4/Kconfig
>>> new file mode 100644
>>> index 0000000..e810ef7
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/vc4/Kconfig
>>> @@ -0,0 +1,13 @@
>>> +config DRM_VC4
>>> +	tristate "Broadcom VC4 Graphics"
>>> +	depends on ARCH_BCM2835
>>
>> depends on (ARCH_BCM2835 || COMPILE_TEST) ?
>
> Done.

Sorry for the bad suggestion. The parentheses should be necessary.

>
>>> +	depends on DRM
>>> +	select DRM_KMS_HELPER
>>> +	select DRM_KMS_CMA_HELPER
>>> +	help
>>> +	  Choose this option if you have a system that has a Broadcom
>>> +	  VC4 GPU, such as the Raspberry Pi or other BCM2708/BCM2835.
>>> +
>>> +	  This driver requires that "avoid_warnings=2" be present in
>>> +	  the config.txt for the firmware, to keep it from smashing
>>> +	  our display setup.
>>> + [...]
>>> +static void vc4_crtc_disable(struct drm_crtc *crtc)
>>> +{
>>> +	struct drm_device *dev = crtc->dev;
>>> +	struct vc4_dev *vc4 = to_vc4_dev(dev);
>>> +	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
>>> +	u32 chan = vc4_crtc->channel;
>>> +
>>> +	require_hvs_enabled(dev);
>>> +
>>> +	CRTC_WRITE(PV_V_CONTROL,
>>> +		   CRTC_READ(PV_V_CONTROL) & ~PV_VCONTROL_VIDEN);
>>> +	while (CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN)
>>> +		cpu_relax();
>>> +
>>> +	/* Without a wait here, we end up with a black screen. */
>>> +	msleep(30);
>>
>> This looks a little bit strange. First we do a busy loop without any
>> timeout and then a fixed msleep without reason for the exact duration.
>>
>> Sorry for the possibly dumb questions:
>>
>> Is it safe to read PV_V_CONTROL exactly after writing to them? No
>> sleeping required?
>
> Correct.  We're waiting for the value to land, so you just read until it
> does.

The reason for my question was the possibility that writing to 
PV_V_CONTROL could take some time and reading directly after writing 
could return the old value. In such a case the busy loop has no effect.

But if it is not the case here everything is fine :-)

>
> I've pulled in a later change for doing waits with timouts.
>
>> How did you come to the 30 milli seconds?
>
> a bit more than a frame.  The comment was there to document why the
> sleep was there.  It looks like in retesting now that it's not required.

Sounds better

Regards
Stefan
