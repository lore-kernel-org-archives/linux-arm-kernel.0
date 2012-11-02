From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sat, 3 Nov 2012 00:29:24 +0300
Subject: [PATCH 2/5] ARM: PXA: Zipit Z2: Add USB host and device support
In-Reply-To: <CAN1soZyAuo4UUze9yWKTOqwJ0TC4cf+uywWo1Ypbrcq0+zez0g@mail.gmail.com>
References: <1351438555-4668-1-git-send-email-anarsoul@gmail.com>
 <1351438555-4668-2-git-send-email-anarsoul@gmail.com>
 <201210282259.46491.marex@denx.de>
 <CA+E=qVftf+A=U5CEvkFia4LMYgeU6iF5WpKPS3FVkf1d3rABFQ@mail.gmail.com>
 <CACTFLAOwUsWbqK-R1OLNfNTnkp7Mo3hFwu78dFKT8i8goTgdKw@mail.gmail.com>
 <CA+E=qVeup8QzqAiURzEfG8a2vp_rBJ-by8FORLEzSCfkxiyjtQ@mail.gmail.com>
 <508E4F7F.7010607@gmail.com>
 <CA+E=qVcnacT8L5GkqTxdowKt2KkoEWMhd3+XBk6nKsEEDtWecg@mail.gmail.com>
 <508E5DFB.3060002@gmail.com>
 <CA+E=qVcRM834_JFZskL7DEJQ10YsYexCeY3CE67fjJk4_WJLUw@mail.gmail.com>
 <508E61E7.7090502@gmail.com>
 <CA+E=qVcJ=WLJwS49zgb_=6or7Me3LLGQtBbfzBtS-p+U6Tw-pQ@mail.gmail.com>
 <508E651A.5070009@gmail.com>
 <CA+E=qVchrOXAL+cPD0-bZKSAjgyjoEFEqajva+SPtJBPOVGE=w@mail.gmail.com>
 <509032F6.1050301@gmail.com>
 <CAN1soZyAuo4UUze9yWKTOqwJ0TC4cf+uywWo1Ypbrcq0+zez0g@mail.gmail.com>
Message-ID: <CA+E=qVfi8Ko4SDDi92jRLjQ4bKtqHkhq4N7QtbiU1k7bPbWjig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 6:31 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Wed, Oct 31, 2012 at 4:05 AM, Daniel Mack <zonque@gmail.com> wrote:
>>
>> On 30.10.2012 21:01, Vasily Khoruzhick wrote:
>> > On Mon, Oct 29, 2012 at 2:14 PM, Daniel Mack <zonque@gmail.com> wrote:
>> >> On 29.10.2012 12:12, Vasily Khoruzhick wrote:
>> >>> On Mon, Oct 29, 2012 at 2:00 PM, Daniel Mack <zonque@gmail.com> wrote:
>> >>>
>> >>>>> Well, there's an issue - Z2 does not preserve memory contents in deep sleep
>> >>>>> (but it does in sleep), so userspace can't be fixed here unfortunatelly.
>> >>>>> There's no another possibility to turn Z2 off, and plain sleep is too
>> >>>>> power hungry.
>> >>>>> So the only way to keep Z2 in low-power mode is fake power off, which just puts
>> >>>>> Z2 in deep sleep.
>> >>>>
>> >>>> Why can't the userspace trigger a deep sleep then instead of powering
>> >>>> off? Which details do I lack?
>> >>>
>> >>> How? echo mem >/sys/power/state puts system into non-deep sleep. Anyway, kernel
>> >>> is not ready for fake power off instead of suspend (we can't resume
>> >>> from deep sleep,
>> >>> memory content is not preserved), so there can be some data loss.
>> >>> Adding some sysfs file to control sleep type does not look like a good
>> >>> idea to me.
>> >>>
>> >>> Btw, how other DT-capable boards handle power off?
>> >>
>> >> No idea. I never actually used that kind of power state.
>> >
>> > Hi Daniel,
>> >
>> > One more question: what should I use instead of pxa2xx_mfp_config in
>> > DT board to configure pin modes?
>>
>> Haojian was working on the PXA pinctrl drivers, but I don't know how far
>> that is yet.
>>
>> If that's not yet there, have a look at the pinctrl-single driver. It's
>> admittedly not as nice to use as the constants in the board file as DT
>> lacks defines for numerical constants, but's at least a workaround.
>>
>> On a more general note, it's arguable whether this kind of setup should
>> be done in the bootloader after all.
>>
>>
>> Daniel
>>
>
> I prefer to use pinctrl-single driver instead. I'm updating mmp
> pinctrol driver to
> pinctrl-single driver framework. You can find them in mailist. I'm submitting
> a third round in these days.
>
> Regards
> Haojian

OK, one more question:

On PXA2xx GPIO and PINMUX are not separate blocks. Each pin can be
either input or output and have 4 modes (gpio + 3 alternate functions)
== 8 states , so we have: gpio in, gpio out, 3 alt in, 3 alt out.
To control pin mode one should write to GPDR (direction register) and
GAFR (alternate function register). pxa-gpio driver controls both of
those registers, so does pxa2xx-mfp.

I'm not sure what to do in this case. Should I move code controlling
GPDR and GAFR into some pinctrl-pxa2xx driver, and modify pxa-gpio
driver to use it?

Regards
Vasily
