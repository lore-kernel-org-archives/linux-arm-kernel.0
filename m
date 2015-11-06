From: o.schinagl@ultimaker.com (Olliver Schinagl)
Date: Fri, 06 Nov 2015 16:46:54 +0100
Subject: [PATCH 08/10] pwm: core: add pulse feature to the PWM framework
In-Reply-To: <20151106151816.GD8418@ulmo>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
 <1445895161-2317-9-git-send-email-o.schinagl@ultimaker.com>
 <20151106151816.GD8418@ulmo>
Message-ID: <563CCB6E.2090206@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Thierry,

On 06-11-15 16:18, Thierry Reding wrote:
> On Mon, Oct 26, 2015 at 10:32:39PM +0100, Olliver Schinagl wrote:
>> From: Olliver Schinagl <oliver@schinagl.nl>
>>
>> Some hardware PWM's have the possibility to only send out one (or more)
>> pulses. This can be quite a useful feature in case one wants or needs
>> only a single pulse, but at the exact width.
>>
>> Additionally, if multiple pulses are possible, outputting a fixed amount
>> of pulses can be useful for various timing specific purposes.
> I see how theoretically this would be nice to have. But I'm reluctant to
> merge this feature if there aren't any users. What drivers in the kernel
> would want to use this feature? Are there new drivers being worked on
> that will need this?
I should have brought this up as to why I added this, I'm working on a 
stepper driver framework (inspired by the pwm framework actually) and 
rotating moters by x degree's you do by sending pulses, using controlled 
pulses (timing wise) you can precisely move stepper motors. Yes we can 
do this reasonably accurate in software, but doing it in hardware is so 
much nicer.
>
>> A few new functions have been expanded or added for this new behavior.
>>
>> * pwm_config()	now takes an additional parameter to setup the number of
>> 		pulses to output. The driver may force this to 0 or 1
>> 		for if example if this feature is not or only partially
>> 		supported
> This is problematic because you need to atomically update all drivers
> and users (the kbuild robot already told you that you didn't do this).
> To make things easier I suggest you wait with this change until the
> atomic PWM patches have been merged, at which point it should become a
> lot easier to deal with this kind of extension.
yes, I think i mentioned this in the cover letter, I wanted to get your 
input whilst waiting for Boris's patches. So I deffinatly want to 
combine it then, just getting some head work started :)
>
>> * pwm_[sg]et_pulse_count()	get or set the number of pulses the pwm
>> 				framework is configured for
>> * pwm_get_pulse_count_max()	get the maximum number of pulses the pwm
>> 				driver supports
>> * pwm_pulse()		Tell the PWM to emit a pre-configured number of pulses
> Isn't this essentially the same as pwm_enable()? I'd think that if the
> PWM is configured to output pulses, then pwm_enable() would simply do
> what it's been configured to do (emit the pulses). Why the need for an
> additional function?
pwm_pulse() should be dropped, I think I accidentally left that in the 
documentation, sorry.
>
>> * pwm_pulse_done()	an internal function for drivers to call when
>> 			they have completed their pre-configured number
>> 			of pulses
>> * pwm_is_pulsing()	tells the callers if the pwm is busy pulsing,
>> 			yielding a little more information than just
>> 			pwm_is_enabled()
> Similarily, I'd think that once the PWM is done executing the series of
> pulses that it was configured for it would be automatically disabled. A
> consumer could then simply use pwm_is_enabled() and drivers could call
> pwm_disable() on their PWM to mark them as disabled when they're done
> pulsing.
I agree, pulseating can be dropped too as we know that a) the pulse flag 
is set, b) we are enabled. But I'm not sure now if the flag is exported 
to sysfs, in any case, sysfs should just check the pulseating flag?
>
>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
>> ---
>>   drivers/pwm/core.c      | 30 +++++++++++++++++++----
>>   drivers/pwm/pwm-gpio.c  |  3 ++-
>>   drivers/pwm/pwm-sun4i.c |  3 ++-
>>   drivers/pwm/sysfs.c     | 58 ++++++++++++++++++++++++++++++++++++++++++--
>>   include/linux/pwm.h     | 64 ++++++++++++++++++++++++++++++++++++++++++++++---
>>   5 files changed, 147 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>> index 3f9df3e..e2c1c0a 100644
>> --- a/drivers/pwm/core.c
>> +++ b/drivers/pwm/core.c
>> @@ -432,22 +432,29 @@ EXPORT_SYMBOL_GPL(pwm_free);
>>    * @pwm: PWM device
>>    * @duty_ns: "on" time (in nanoseconds)
>>    * @period_ns: duration (in nanoseconds) of one cycle
>> + * @pulse_count: number of pulses (periods) to output on pwm_pulse
>>    *
>>    * Returns: 0 on success or a negative error code on failure.
>>    */
>> -int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
>> +int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns,
>> +	       unsigned int pulse_count)
> Like I said, this is problematic because every driver and every consumer
> now needs to be aware of pulsing. Once the PWM atomic patches are merged
> this will become easier to do because the pulse configuration would be a
> part of the atomic state, and hence can be conveniently ignored by users
> and driver alike.
I agree :) I'll take your initial comments and work with those so far in 
cleaning stuff up. Feel free to get back to me about the validity of the 
pwm_pulse for steppers generally
> Thierry

-- 
Met vriendelijke groeten, Kind regards, ??????

Olliver Schinagl
Software Engineer
Research & Development
Ultimaker B.V.
