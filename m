From: dianders@chromium.org (Doug Anderson)
Date: Mon, 19 Sep 2016 14:15:06 -0700
Subject: [PATCH] arm: dts: fix rk3066a based boards vdd_log voltage
 initialization
In-Reply-To: <20160919224352.3b84b6c0@bbrezillon>
References: <1474274639-27768-1-git-send-email-andy.yan@rock-chips.com>
 <1474274696-28090-1-git-send-email-andy.yan@rock-chips.com>
 <CAD=FV=VawAOWBF_PoXqSj3oiVgfF8SnCBp56p8F==XsaVLmMcg@mail.gmail.com>
 <2318029.f7g774Bk76@phil>
 <CAD=FV=UOXcUZyXRj++GkKksyFedGt59vQz8958nhhF9UM7rOuw@mail.gmail.com>
 <20160919191327.741a2b89@bbrezillon>
 <CAD=FV=Ufmvg1P8suOPQ53kpOD1pei4N2dOpKUCxZk001XKj_OA@mail.gmail.com>
 <20160919194844.0db7b307@bbrezillon>
 <CAD=FV=UyW5cXGGmq5xUzZ1aV5NzbBYGOz1gO9V1itrFU-PigAw@mail.gmail.com>
 <20160919200627.3ca1aae4@bbrezillon>
 <CAD=FV=U_BQez2eCqm7mX9kj0dcEsnBKiFWcLAhXXJD+yTZhACw@mail.gmail.com>
 <20160919224352.3b84b6c0@bbrezillon>
Message-ID: <CAD=FV=W=ZiaLu1=zcnDyUqvK6f=E-0AWH9URHE3cgAKWWa+aJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 19, 2016 at 1:43 PM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> On Mon, 19 Sep 2016 11:12:12 -0700
> Doug Anderson <dianders@chromium.org> wrote:
>
>> Hi,
>>
>> On Mon, Sep 19, 2016 at 11:06 AM, Boris Brezillon
>> <boris.brezillon@free-electrons.com> wrote:
>> > On Mon, 19 Sep 2016 10:52:51 -0700
>> > Doug Anderson <dianders@chromium.org> wrote:
>> >
>> >> Hi,
>> >>
>> >> On Mon, Sep 19, 2016 at 10:48 AM, Boris Brezillon
>> >> <boris.brezillon@free-electrons.com> wrote:
>> >> > The PWM chip has always claimed the pins and muxed them to the PWM IP.
>> >> > So, this means it's broken from the beginning, and my patch is only
>> >> > uncovering the problem (unless the pins stay configured as input until
>> >> > the PWM is enabled, which I'm not sure is the case).
>> >>
>> >> Such a solution is achievable with the pinctrl APIs pretty easily.
>> >> You might not be able to use the automatic "init" state but you can do
>> >> something similar and switch to an "active" state once the PWM is
>> >> actually turned on the first time.
>> >
>> > But is it really the case here (I don't see any code requesting a
>> > specific pinmux depending on the PWM state)?
>>
>> It is not happening right now as far as I know.  ...but that's a bug.
>>
>> > Anyway, we really need to handle this case, we should define the
>> > typical voltage when the PWM is disabled. Same as what you suggested
>> > with voltage-when-input, but with a different naming (since the concept
>> > of pinmux is PWM hardware/driver specific).
>> >
>> >         voltage-when-pwm-disabled = <...>;
>>
>> Voltage when disabled and voltage when input are two different states.
>> A disabled PWM will typically either drive high or low (depending on
>> where it was when you turned it off).  Not all "disabled" states will
>> mean that the pin is configured as an input.
>
> Okay, after reading again your first answer, I think I understand why
> you want to differentiate the when-disabled and when-input cases. You
> want to use the "init" and "default" pinctrl states. The "init" state
> (applied at probe time) would keep the PWM pin in gpio+input mode and
> the "default" state (applied when the PWM device is enabled for the
> first time) would mux the pin to the PWM device.
> Your solution requires that the pwm-regulator device knows in which
> state the pin attached to the PWM is, which IMO is breaking the
> layering we have right now: a PWM-regulator is assigned a PWM device
> which is assigned a pin and a pinmux config.
> Another solution would be to expose an additional information in the
> pwm_state: whether the PWM is in the INIT state (probed, but not yet
> configured by its user) or DEFAULT state (probed and already
> configured by its user). But again, by doing that we also expose
> internal PWM details to its user, which I'm not sure will help keep
> the PWM API simple.

One note is that probably using the "init" state would not be a good
idea because it would make assumptions about what state the firmware
left things.  Possibly a firmware update could cause a change from a
PWM being left as "input" to the PWM actually being initted.
...really we should be able to detect if the PWM was left on at
bootup.


> Actually, I had something slightly different in mind. I thought about
> having two new pinctrl states ("enabled" and "disabled"). The "enabled"
> state (pin muxed to the PWM device) would be applied each time the PWM
> is enabled, and "disabled" state (gpio+input mode) would be applied each
> time the PWM is disabled.

Adding "enabled" and "disabled" state is sane IMHO.  At the moment the
PWM regulator never actually puts things in "disabled" state, but I
suppose it could in the future.

> This way we can guarantee that even when the PWM is disabled, the
> PWM-driven regulator is configured to output a non-destructive voltage.
> Hence my suggestion to name the property 'voltage-when-pwm-disabled'.

That's fine with me, as long as the PWM starts up as "enabled" if the
pinctrl happened to be left initted by the BIOS.

-Doug
