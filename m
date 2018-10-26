From: Claudiu.Beznea@microchip.com (Claudiu.Beznea at microchip.com)
Date: Fri, 26 Oct 2018 10:44:43 +0000
Subject: [RESEND PATCH v5 0/9] extend PWM framework to support PWM modes
In-Reply-To: <20181022082910.uw6i64h3w7jwxyx5@pengutronix.de>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <20181022082910.uw6i64h3w7jwxyx5@pengutronix.de>
Message-ID: <f19251eb-80e1-aea1-2d8a-971fe53242d0@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Thank you for your inputs and sorry for the late response. Please see my
answers inline.

On 22.10.2018 11:29, Uwe Kleine-K?nig wrote:
> Hello Claudiu,
> 
> On Tue, Aug 28, 2018 at 04:01:17PM +0300, Claudiu Beznea wrote:
>> Please give feedback on these patches which extends the PWM framework in
>> order to support multiple PWM modes of operations. This series is a rework
>> of [1] and [2].
>>
>> The current patch series add the following PWM modes:
>> - PWM mode normal
>> - PWM mode complementary
>> - PWM mode push-pull
>>
>> Normal mode - for PWM channels with one output; output waveforms looks like
>> this:
>>              __    __    __    __
>>     PWM   __|  |__|  |__|  |__|  |__
>>             <--T-->
>>
>>     Where T is the signal period
> 
> In my discussion about some suggested changes to the PWM framework I
> used slightly different way to show the wave-forms in ASCII which are
> IMHO slightly better. 

It is true that the slope version is more like in real world but, on the
other hand, the datasheets and documentations mostly uses the digital
waveform formats (with no slopes) with regards to, at least PWM.

> Also I think it is valuable to not use a 50% duty
> cycle in the examples to remove some ambiguity.

Ok, sure, I will use a 1/3 duty cycle on next version.

> 
> With a duty cycle of 1/3 the normal mode looks as follows in "my" way:
> 
>           __       __       __
>  PWM   __/  \_____/  \_____/  \_____/
>          ^        ^        ^        ^
> 
> The carets mark always the start of a period. And note the rising and
> falling edges are already part of the active and inactive phases
> respectively which matches reality.

Ok, I'll use the carets on next version.

>  
>> Since PWMs with more than one output per channel could be used as one
>> output PWM the normal mode is the default mode for all PWMs (if not
>> specified otherwise).
>>
>> Complementary mode - for PWM channels with two outputs; output waveforms
>> for a PWM channel in complementary mode looks line this:
>>              __    __    __    __
>>     PWMH1 __|  |__|  |__|  |__|  |__
>>           __    __    __    __    __
>>     PWML1   |__|  |__|  |__|  |__|
>>             <--T-->
>>
>>     Where T is the signal period.
> 
> So this translates to (I think):
> 
>            __       __       __       __       __
>  PWMH   __/  \_____/  \_____/  \_____/  \_____/  \_____/
>         __    _____    _____    _____    _____    _____
>  PWML     \__/     \__/     \__/     \__/     \__/     \
>           ^        ^        ^        ^        ^        ^
> 
> That is PWML always pulls in the opposite direction of PWMH. Maybe we
> could come up with better terms than PWMH and PWML (which might be
> specific for the Atmel implementation?).

Yes, this is Atmel implementation naming.

> Maybe "normal" and
> "complement"?

I will think about it try to come with new naming. Normal and Complement
may be confusing for users with regards to PWM modes.

> 
>> Push-pull mode - for PWM channels with two outputs; output waveforms for a
>> PWM channel in push-pull mode with normal polarity looks like this:
>>             __          __
>>     PWMH __|  |________|  |________
>>                   __          __
>>     PWML ________|  |________|  |__
>>            <--T-->
> 
> That again with the alternative display method and duty cycle 1/3:
> 
>            __                __                __
>  PWMA   __/  \______________/  \______________/  \______
>                     __                __
>  PWMB   ___________/  \______________/  \______________/
>           ^        ^        ^        ^        ^        ^
Ok.

> 
> That is PWMA and PWMB are active only every 2nd period taking alternate
> turns, right?

Yes.

> 
> 
>>     If polarity is inversed:
>>          __    ________    ________
>>     PWMH   |__|        |__|
>>          ________    ________    __
>>     PWML         |__|        |__|
>>            <--T-->
> 
> That's again with duty cycle 1/3:
> 
>         __    ______________    ______________    ______
>  PWMA     \__/              \__/              \__/
>         ___________    ______________    ______________
>  PWMB              \__/              \__/              \
>           ^        ^        ^        ^        ^        ^
> 

Ok.

> Given that the start of period isn't externally visible this is
> equivalent to using a duty cycle 2/3 and not inverting which results in:
> 
>         __    ______________    ______________    ______
>  PWMA     \__/              \__/              \__/
>         ___________    ______________    ______________
>  PWMB              \__/              \__/              \
>              ^        ^        ^        ^        ^
> 
> I would really like if a more detailed description of the modes would be
> created as part of this series.

Sure, I will try to document it better.

> Currently there are a few implied
> properties hidden in the PWM API (unrelated to this series) which I try
> to resolve together with Thierry. Getting this documented right from the
> start would be great here.

Could you tell me if you want something specific to be touch as part of
documentation process for these PWM modes?

> 
> I didn't look in detail into the driver implementation, but from the
> PWMs implemented in the STM32F4 family I would have chosen a different
> model which makes me wonder if we should stick to a more general way to
> describe two outputs from a single PWM channel.
> 
> I would use four values with nanosecond resolution to describe these:
> 
>   .period
>   .duty_cycle
>   .alt_duty_cycle
>   .alt_offset
> 
> period and duty_cycle is as before for the primary output and then the
> alt_* values describe offset and duty cycle of the secondary output.
> 
> What you called "normal mode" would then be specified using
> 
>   .period = $period
>   .duty_cycle = $duty_cycle
>   .alt_duty_cycle = 0
>   .alt_offset = dontcare
> 
> Your "push pull mode" would be:
> 
>   .period = 2 * $period
>   .duty_cycle = $duty_cycle
>   .alt_duty_cycle = $duty_cycle
>   .alt_offset = $period
> 
> and complementary mode would be specified using:
> 
>   .period = $period
>   .duty_cycle = $duty_cycle
>   .alt_duty_cycle = $period - $duty_cycle
>   .alt_offset = $duty_cycle
> 

On Atmel PWM controller the push-pull mode is hardware generated based on
period and duty cycles that are setup for only one channel. The hardware
will take care of the synchronization b/w the outputs so that the push-pull
characteristic to be generated.

Having different configuration for every output part of the push-pull
waveform will allow users to generate every kind of outputs. But for IPs
that are capable of push-pull or complementary modes the generation of the
2 outputs are done in hardware (true in case of Atmel PWM controller). In
case of STM32F4 as far as I can see from [1] "The advanced-control timers
(TIM1 and TIM8 ) can output two complementary signals and
manage the switching-off and the switching-on instants of the outputs."
Maybe, in this case, if there are 2 hardware blocks that could be synced to
work together, e.g. in complementary mode, the setting of these two timers
should be done in driver so that the hardware blocks to be configured
together, atomically, so that the complementary characteristics to be obtained.

>From my point of view it is better to implement in PWM core the concepts,
e.g. push-pull, complementary, even dead-time (I had something in my queue
for this) and the driver to do what it takes so that the IP to generate
implemented concepts. Mostly, the applications of PWM will use the PWM in
normal mode, push-pull, complementary or complementary with dead-time
insertion.

[1]
https://www.st.com/content/ccc/resource/technical/document/reference_manual/3d/6d/5a/66/b4/99/40/d4/DM00031020.pdf/files/DM00031020.pdf/jcr:content/translations/en.DM00031020.pdf


> With this abstraction stuff like "complementary output with dead-time
> insertion" (something like:
> 
>            __                __                __
>  PWMA   __/  \______________/  \______________/  \______
>                 __________        __________          __
>  PWMB   _______/          \______/          \______/
>           ^                 ^                 ^
> 
> ) could be modelled.

Same for this, my opinion is that we should implement generic things in
core and drivers should configure properly the IP so that it generates the
proper signals.

> 
>> The PWM working modes are per PWM channel registered as PWM's capabilities.
>> The driver registers itself to PWM core a get_caps() function, in
>> struct pwm_ops, that will be used by PWM core to retrieve PWM capabilities.
>> If this function is not registered in driver's probe, a default function
>> will be used to retrieve PWM capabilities. Currently, the default
>> capabilities includes only PWM normal mode.
> 
> In the i2c framework this is a function, too, and I wonder if simplicity
> is better served when this is just a flags member in the pwm_ops
> structure.

Thierry proposed this so that we could retrieve capabilities per PWM channel.

> 
>> PWM state has been updated to keep PWM mode. PWM mode could be configured
>> via sysfs or via DT. pwm_apply_state() will do the preliminary validation
>> for PWM mode to be applied.
>>
>> In sysfs, user could get PWM modes by reading mode file of PWM device:
>> root at sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# ls -l
>> total 0
>> -r--r--r-- 1 root root 4096 Oct  9 09:07 capture
>> lrwxrwxrwx 1 root root    0 Oct  9 09:07 device -> ../../pwmchip0
>> -rw-r--r-- 1 root root 4096 Oct  9 08:42 duty_cycle
>> -rw-r--r-- 1 root root 4096 Oct  9 08:44 enable
>> --w------- 1 root root 4096 Oct  9 09:07 export
>> -rw-r--r-- 1 root root 4096 Oct  9 08:43 mode
>> -r--r--r-- 1 root root 4096 Oct  9 09:07 npwm
>> -rw-r--r-- 1 root root 4096 Oct  9 08:42 period
>> -rw-r--r-- 1 root root 4096 Oct  9 08:44 polarity
>> drwxr-xr-x 2 root root    0 Oct  9 09:07 power
>> lrwxrwxrwx 1 root root    0 Oct  9 09:07 subsystem -> ../../../../../../../../class/pwm
>> -rw-r--r-- 1 root root 4096 Oct  9 08:42 uevent
>> --w------- 1 root root 4096 Oct  9 09:07 unexport
>> root at sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# cat mode
>> normal complementary [push-pull]
>>
>> The mode enclosed in bracket is the currently active mode.
>>
>> The mode could be set, via sysfs, by writing to mode file one of the modes
>> displayed at read:
>> root at sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# echo normal > mode
>> root at sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# cat mode
>> [normal] complementary push-pull 
> 
> Getting a simple user of this into the kernel would be beneficial, too.
> In my discussion with Thierry I'm faced with arguments like: You're
> simplifying stuff which might destroy a use-case for sysfs users. This
> is hard to argue against because it involves some guesswork to
> reconstruct or contradict such arguments.

Yep, currently only sysfs is using this. I will see what I can do about
this to also have an in kernel user (I'll have to check, at least, how
pwm-regulator is working with this).

Thank you,
Claudiu Beznea

> 
> Best regards
> Uwe
> 
