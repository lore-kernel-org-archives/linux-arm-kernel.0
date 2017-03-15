From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 15 Mar 2017 12:12:03 -0700
Subject: [PATCH 1/2] pinctrl: meson: gxl: add the missing PWM pin
 definitions
In-Reply-To: <b7430d5f-96a7-2445-1c2a-ccc299bfdda2@baylibre.com> (Neil
 Armstrong's message of "Wed, 15 Mar 2017 10:59:06 +0100")
References: <20170304212318.27076-1-martin.blumenstingl@googlemail.com>
 <20170304212318.27076-2-martin.blumenstingl@googlemail.com>
 <1488811357.2420.18.camel@baylibre.com>
 <CAFBinCDty8v80tLxHJPR+SHv32LX834dPJUruRNqr6angx3OOQ@mail.gmail.com>
 <CACRpkdbGfGUhnAQz=9xeFnD2hF6m_xXacu8mZiwte-OCSDMo9w@mail.gmail.com>
 <b7430d5f-96a7-2445-1c2a-ccc299bfdda2@baylibre.com>
Message-ID: <m237ee8id8.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 03/14/2017 04:42 PM, Linus Walleij wrote:
>> On Thu, Mar 9, 2017 at 8:47 PM, Martin Blumenstingl
>> <martin.blumenstingl@googlemail.com> wrote:
>>> On Mon, Mar 6, 2017 at 3:42 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
>>>> On Sat, 2017-03-04 at 22:23 +0100, Martin Blumenstingl wrote:
>> 
>>>>> +     FUNCTION(pwm_f_clk),
>>>>> +     FUNCTION(pwm_f_x),
>>>>
>>>> I wonder if having function named "pwm_f_clk" really makes sense ?
>>>> Shouldn't it be just "pwm_f" ? This is real function, isn't it ?
>>>> The actual pin used will be provided in the dt. Here, I suppose we
>>>> could have this:
>>>>
>>>> +static const char * const pwm_f_groups[] = {
>>>> +       "pwm_f_x", "pwm_f_clk",
>>>> +};
>>>>
>>>> Has far as I can see, on meson arch, the function does not carry much
>>>> information anyway, except for prints.
>>>>
>>>> To be clear, I'm not questioning this change in particular. It looks
>>>> good, and follows what has been done in the past on meson. I know we
>>>> have been this a lot already, but I'm questioning whether we should
>>>> continue to do so ?
>>>>
>>>> I asking because I also have a lot case like this coming up on audio
>>>> for gxl and gxbb, where the same function can use different pins.
>>>
>>> could you please look into Jerome's question?
>>> personally I'm fine with either way, and changing my patch would be
>>> quite trivial. but I'd like to know what's "the way to go" before
>>> changing anything (and reverting that afterwards again).
>> 
>> I don't understand the question really.
>> 
>> I am not an expert on this system, if the people working with it
>> cannot tell a function from a group I don't know who can... certainly
>> not me.
>> 
>> What I can say is that pincontrol combines functions and groups to
>> states using a mapping. The functions should be something you poke
>> into a register, the groups are looser defined but may also be a
>> character of the hardware, but more usual a character of the
>> intended electronic usecase. Groups contain 1..n pins and can
>> be combined with some applicable functions.
>> 
>> Please re-read Documentation/pinctrl.txt very closely if anything is
>> unclear, I really put a lot of hours into getting that right. Especially
>> reexamine "Pinmux conventions".
>
> The point pushed by Jerome was purely cosmetic since the groups in the meson
> pinctrl driver are purely cosmetic, since only the GPIO group is handled,
> other groups are all handled the same.

handled the same... as what?

> This is because I pushed all the PWM pins in a separate group, but functionnaly
> the internal signal (i.e. PWM F) is the same for multiple pins and should be
> a single "PWM F" group instead of multiple ones.
>
> My advice is to leave the PWM groups as is,

Do you mean as we have in mainline today?  or as is proposed in $SUBJECT patch?

> and push new pins/functions/groups
> grouped with the internal signal name if split on multiple pins.

Can somone do a quick patch for PWM_F for example, also showing how this
will look in the DT if someone wants to switch between the PWM_F on GPIOX
or GPIOCLK?

We shouldalso verify that the driver is detecting/removing conflicts
properly when something else is already using that pin (e.g. SDIO_IRQ
shares pin GPIOX_7 with PWM_F)

Kevin
