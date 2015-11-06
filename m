From: o.schinagl@ultimaker.com (Olliver Schinagl)
Date: Fri, 06 Nov 2015 17:18:32 +0100
Subject: [PATCH 08/10] pwm: core: add pulse feature to the PWM framework
In-Reply-To: <20151106160547.GF8418@ulmo>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
 <1445895161-2317-9-git-send-email-o.schinagl@ultimaker.com>
 <20151106151816.GD8418@ulmo> <563CCB6E.2090206@ultimaker.com>
 <20151106160547.GF8418@ulmo>
Message-ID: <563CD2D8.8060805@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Thierry,

On 06-11-15 17:05, Thierry Reding wrote:
> On Fri, Nov 06, 2015 at 04:46:54PM +0100, Olliver Schinagl wrote:
>> Hey Thierry,
>>
>> On 06-11-15 16:18, Thierry Reding wrote:
>>> On Mon, Oct 26, 2015 at 10:32:39PM +0100, Olliver Schinagl wrote:
>>>> From: Olliver Schinagl <oliver@schinagl.nl>
>>>>
>>>> Some hardware PWM's have the possibility to only send out one (or more)
>>>> pulses. This can be quite a useful feature in case one wants or needs
>>>> only a single pulse, but at the exact width.
>>>>
>>>> Additionally, if multiple pulses are possible, outputting a fixed amount
>>>> of pulses can be useful for various timing specific purposes.
>>> I see how theoretically this would be nice to have. But I'm reluctant to
>>> merge this feature if there aren't any users. What drivers in the kernel
>>> would want to use this feature? Are there new drivers being worked on
>>> that will need this?
>> I should have brought this up as to why I added this, I'm working on a
>> stepper driver framework (inspired by the pwm framework actually) and
>> rotating moters by x degree's you do by sending pulses, using controlled
>> pulses (timing wise) you can precisely move stepper motors. Yes we can do
>> this reasonably accurate in software, but doing it in hardware is so much
>> nicer.
> So is this going to be a kernel framework for stepper motors? If you say
> you rotate the motors by sending pulses, doesn't that mean that the PWM
> framework with pulse support would be enough? Or are there dedicated
> stepper chips that you plan to support, with PWM + pulses being the
> fallback for when you don't have one of those chips?
Well I'll have to investigate more into what other chips do, but 
generally speaking from what I know so far, that often you supply a 
stepper driver chip a variable voltage (via a regular pwm) to setup the 
current control, you have gpio's for direction, enable etc, and you 
'pulse' for each step you want the motor to take. There are of course 
some chips that have more logic, that work via i2c and spi interfaces.
>
>>>> * pwm_pulse_done()	an internal function for drivers to call when
>>>> 			they have completed their pre-configured number
>>>> 			of pulses
>>>> * pwm_is_pulsing()	tells the callers if the pwm is busy pulsing,
>>>> 			yielding a little more information than just
>>>> 			pwm_is_enabled()
>>> Similarily, I'd think that once the PWM is done executing the series of
>>> pulses that it was configured for it would be automatically disabled. A
>>> consumer could then simply use pwm_is_enabled() and drivers could call
>>> pwm_disable() on their PWM to mark them as disabled when they're done
>>> pulsing.
>> I agree, pulseating can be dropped too as we know that a) the pulse flag is
>> set, b) we are enabled. But I'm not sure now if the flag is exported to
>> sysfs, in any case, sysfs should just check the pulseating flag?
> Can't you derive that information simply by looking at the enable and
> pulses attributes? If enable == 1 and pulses > 0 you know the PWM is
> pulsing. If enable == 1 and pulses == 0 you know it's in regular mode.
oh right, yes you can :)

olliver
>
> Thierry

-- 
Met vriendelijke groeten, Kind regards, ??????

Olliver Schinagl
Software Engineer
Research & Development
Ultimaker B.V.
