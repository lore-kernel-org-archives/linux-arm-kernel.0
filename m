From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Oct 2017 11:09:11 +0800
Subject: [PATCH v3 12/12] ARM: dtsi: axp81x: set pinmux for GPIO0/1 when
 used as LDOs
In-Reply-To: <8be22e47-8071-be4c-0bd4-38fa51cbe3ff@free-electrons.com>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
 <20171002120854.5212-13-quentin.schulz@free-electrons.com>
 <CACRpkdZYcSuhvn0b0qa0k1PQHoyXjNyjoyhR2sPme_t1pF12Dg@mail.gmail.com>
 <20171003144737.rhgtp3uwckhvoqdw@flea>
 <CAGb2v64=XL34x7iGJcEmmVnmzkA5wmyZJd-g827bY=kdHcZOMA@mail.gmail.com>
 <8be22e47-8071-be4c-0bd4-38fa51cbe3ff@free-electrons.com>
Message-ID: <CAGb2v65-_MjUsfTHMoyzvczs_280p7NXEsStSaoR6wnvTCq5+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 4, 2017 at 3:35 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> Hi Chen-Yu, Linus,
>
> On 03/10/2017 17:08, Chen-Yu Tsai wrote:
>> On Tue, Oct 3, 2017 at 10:47 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>>> Hi Linus,
>>>
>>> On Tue, Oct 03, 2017 at 09:27:17AM +0000, Linus Walleij wrote:
>>>> On Mon, Oct 2, 2017 at 2:08 PM, Quentin Schulz
>>>> <quentin.schulz@free-electrons.com> wrote:
>>>>
>>>>> On AXP813/818, GPIO0 and GPIO1 can be used as LDO as (respectively)
>>>>> ldo_io0 and ldo_io1.
>>>> (...)
>>>>> +               gpio0_ldo: gpio0_ldo {
>>>>> +                       pins = "GPIO0";
>>>>> +                       function = "ldo";
>>>>> +               };
>>>> (...)
>>>>> +                       pinctrl-names = "default";
>>>>> +                       pinctrl-0 = <&gpio0_ldo>;
>>>>>                         /* Disable by default to avoid conflicts with GPIO */
>>>>>                         status = "disabled";
>>>>
>>>> So this is still by default disabled, but you make the default
>>>> mode something called "ldo".
>>>>
>>>> And I think that is to be understood as a low-dropout regulator?
>>>>
>>>> So is the idea that this should be represented as a regulator
>>>> in the end?
>>>>
>>>> Then I think the state name should not be "default" rather
>>>> something like "regulator" and "default" should be the GPIO
>>>> mode, as I guess something like that exists.
>>>>
>>>> Activating a regulator using pin control "default" mode is
>>>> not very pretty. It would probably be unintuitive and end
>>>> up wasting power because people will get confused about
>>>> what is going on.
>>>
>>> That's not really it. The PMIC has pins that can be muxed either to
>>> (regular) GPIOs, an ADC or to an LDO regulator.
>>>
>>> This is just muxing, the regulator will be enabled and disabled
>>> separately through another register. If it wasn't the case, it would
>>> indeed be very messy.
>>
>> No. Actually they are controlled in the same register, so it is
>> very messy. The muxing options are:
>>
>>     - 0: drive low
>>     - 1: drive high
>>     - 2: input with interrupt triggering
>>     - 3: LDO on
>>     - 4: LDO off
>>     - 5~7: floating (or ADC)
>>
>
> Just to be a little more precise,
>      - 0: drive low
>      - 1: drive high
>      - 2: input with interrupt triggering
>      - 3: LDO on
>      - 4: LDO off
>      - 5~7: floating (or ADC)
>
> for AXP813, and
>      - 0: drive low
>      - 1: drive high
>      - 2: input with interrupt triggering
>      - 3: LDO on
>      - 4: ADC
>      - 5~7: floating
>
> for AXP209.
>
> So I think what you suggested Linus is not really relevant here as the
> regulator framework will take care of disabling the regulator when
> needed (for AXP813 via the ldo_off "muxing" selected by the regulator
> framework).

Linus is suggesting that we use (switching between) pinctrl states to
control the regulator, as opposed to overriding the register value
directly. That would be nice, as both subsystems would have the same
idea of what's actually happening in the hardware.

As Linus mentioned, having the LDO on or off as the default pinctrl state
is not pretty. It also means as soon as the device is brought up, the
regulator state gets overridden. That would not work well for regulators
that have/want the "always-on" or "boot-on" properties.

> However, there is no LDO off bit for AXP209 and the LDO can't be set to
> 0V in any other register. What's done now in the regulator driver for
> AXP209 is to select the floating "muxing" for the pin when wanting to
> disable the regulator. So I guess that's a way to handle it. Should we
> do it another way?

I can't think of one. :)

You could have an actual pinmux option for "floating". If there's no
"LDO off" state, the regulator driver could use the "floating" state
instead.

ChenYu

> Thanks for raising the issue, I frankly haven't thought about that at all.
>
> I have to send a v4 to update the support for AXP813 (basically setting
> ADC muxing to 0x5 instead of 0x4, for AXP813) as I misread the muxing
> register description when adding support for it.
>
> Thanks,
> Quentin
> --
> Quentin Schulz, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
