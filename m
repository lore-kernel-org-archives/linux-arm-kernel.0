From: yuvaraj.lkml@gmail.com (Yuvaraj Cd)
Date: Wed, 13 Aug 2014 11:52:38 +0530
Subject: io-domain voltages as regulators?
In-Reply-To: <CAD=FV=Vewr5QkNEiBEOXA=FdKHKzg0ag5+Cf4KXuXWjcshSq_g@mail.gmail.com>
References: <3923586.SsVg941346@diego>
 <CACRpkdaJS0PUDLaCnrhtiuXPf4ccx51uNTqYWVWm47mhOhGEbA@mail.gmail.com>
 <CAPDyKFpiHf+urR85iJPqAXxREO+yPrDMcXM4K+BJqq=ur3DZtA@mail.gmail.com>
 <CAD=FV=Vewr5QkNEiBEOXA=FdKHKzg0ag5+Cf4KXuXWjcshSq_g@mail.gmail.com>
Message-ID: <CA+NduCCi20Xaq08X71Hc+Ma=jFigd_mAkFPopG0LwOjEoAt_7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 12, 2014 at 8:43 PM, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Mon, Aug 11, 2014 at 5:46 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 11 August 2014 09:44, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> On Mon, Aug 4, 2014 at 12:18 AM, Heiko St?bner <heiko@sntech.de> wrote:
>>>
>>> [Adding Ulf Hansson to this discussion...]
>>>
>>>> Hi Mark, Linus,
>>>>
>>>> I'd like to clarify what the appropriate way to handle pin output voltages is.
>>>> On the Rockchip SoCs the voltage for some groups of pins can be set between
>>>> 3.3V and 1.8V ... like the MMC/SD pins who need this to support UHS mode
>>>> cards.
>>>
>>> This is called "vqmmc" in the mmc/sd subsystem.
>>>
>>> grep for mmc_set_signal_voltage() in drivers/mmc/core/*
>>>
>>> In drivers/mmc/core/core.c, you find:
>>>
>>>  mmc->supply.vqmmc = devm_regulator_get_optional(dev, "vqmmc");
>>>
>>> Which gets the regulator to set the signal voltage, if such
>>> a regulator is specified for the host.
>>>
>>> Very simple and straight-forward, and handled by the MMC core.
>>>
>>>> In [0] when talking about something different, Linus Walleij described a
>>>> similar case as
>>>>
>>>> "I think we need to have a discussion with Mark Brown on how to
>>>> handle this.
>>>> We have previously had the case of MMC/SD level-shifters, where
>>>> a certain setting gives a certain level of signals out, and another setting
>>>> gives another level. Like two discrete levels.
>>>> So we modeled that as a regulator provider inside the pin control
>>>> driver eventually, see sh-pfc/pfc-sh73a0.c"
>>>>
>>>> As this sound like exactly the thing I'm trying to solve, is handling this via
>>>> a regulator the correct general way?
>>>
>>> Ithinkso.
>>
>> Just to confirm, I fully agree with the above said.
>>
>> You may also find a good example in the mmci host driver for how to
>> make use of the vqmmc regulator.
>
> Yuvaraj also submitted patches for dw_mmc:
>
> 4401241 New          [1/3] mmc: dw_mmc: use mmc_regulator_get_supply
> to handle regulators
> 4401261 New          [2/3] mmc: dw_mmc: Dont cut off vqmmc and vmmc
> 4401281 New          [3/3] mmc: dw_mmc: Support voltage changes
>
> He seems to have dropped these patches on the floor and I had review
> feedback on them, but I think they're in the right direction.
I have not dropped these patches.I am trying out  [3/3] mmc: dw_mmc:
Support voltage changes without extra state machine as Seungwon Jeon
suggested.
I will post the next version soon.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
