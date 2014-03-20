From: tim.kryger@linaro.org (Tim Kryger)
Date: Thu, 20 Mar 2014 10:12:51 -0700
Subject: [PATCH v3 2/5] pwm: kona: Introduce Kona PWM controller support
In-Reply-To: <20140320155732.GB25092@ulmo>
References: <1394655346-30048-1-git-send-email-tim.kryger@linaro.org>
 <1394655346-30048-3-git-send-email-tim.kryger@linaro.org>
 <20140318215231.GH5917@mithrandir>
 <CAAYSxhri0evgrbCPew6-MTXVmpzm7Oa6TpmJTSGZpTcV=876HQ@mail.gmail.com>
 <20140320155732.GB25092@ulmo>
Message-ID: <CAAYSxhrMxjFNr-z1qQQRK88B2_GcWo_5MhQrwsht=zRWpp4SQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 8:57 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Tue, Mar 18, 2014 at 04:47:36PM -0700, Tim Kryger wrote:

> Perhaps the comment for enum pwm_polarity in include/linux/pwm.h makes
> this more obvious. What you do here is invert the duty cycle, rather
> than the polarity. While it is true that the result is the same for
> things like LEDs or backlight (because the signal power remains the
> same), but there's a slight difference to what the PWM signal looks
> like.

Thanks, I missed that comment before.

>> Does polarity influence the output while a PWM is disabled?
>
> Yes, there is apparently hardware where the polarity causes the PWM pin
> to be 1 when the PWM is disabled. But that's really a separate issue.

Do you have a preference on how this should be handled?


> Things are starting to get confusing here. Looking at the register
> definitions, there's PWM_CONTROL_ENABLE_SHIFT(chan), which I suspect
> controls whether or not a channel is enabled (if that's not the case
> then please add a comment that explains what it does).

I've tried to do this but the unfortunate name for these bits and
their nuanced behavior makes it difficult.

>
> But a little further up you said that the hardware does only support a
> configure operation and not an enable/disable.

If you define disabled as zero duty output, then this is true.

When the smooth bit is off and the "enable" bit is off output is 100% duty.

>
> The comment above further confuses me. What I read from it is that you
> can in fact disable a channel by clearing the "enable" bit in the
> control register. But the reason why you don't do it that way is because
> that change won't take effect until "settings start to take effect". So
> in order to disable the PWM immediately you resort to writing a 0 duty
> cycle.

Sorry if my comments were confusing.  New settings are only applied on
a rising edge of the "enable" bit.  You should think of it more as a
trigger bit than an enable.

>
> Perhaps I misunderstood, in which case it might be good to revise that
> comment to be more explicit or accurate.

Perhaps it would be clearest to deviate from the hw docs and rename
PWM_CONTROL_ENABLE_SHIFT to PWM_CONTROL_TRIGGER_SHIFT to more closely
match its function.  What do you think of the following?

/*
* New duty and period settings are only reflected in the PWM output
* after a rising edge of the trigger bit.  After a rising edge, if the
* smooth bit is set, the settings are also delayed until the current
* period has completed. Furthermore, if the smooth bit is set, the PWM
* continues to output a waveform based on the old settings during the
* time that the trigger bit is low.  Otherwise the output is a constant
* high signal while the trigger bit is low.
*/
