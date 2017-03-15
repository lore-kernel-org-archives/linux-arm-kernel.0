From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Wed, 15 Mar 2017 21:11:58 +0100
Subject: [PATCH 1/2] pinctrl: meson: gxl: add the missing PWM pin
 definitions
In-Reply-To: <m237ee8id8.fsf@baylibre.com>
References: <20170304212318.27076-1-martin.blumenstingl@googlemail.com>
 <20170304212318.27076-2-martin.blumenstingl@googlemail.com>
 <1488811357.2420.18.camel@baylibre.com>
 <CAFBinCDty8v80tLxHJPR+SHv32LX834dPJUruRNqr6angx3OOQ@mail.gmail.com>
 <CACRpkdbGfGUhnAQz=9xeFnD2hF6m_xXacu8mZiwte-OCSDMo9w@mail.gmail.com>
 <b7430d5f-96a7-2445-1c2a-ccc299bfdda2@baylibre.com>
 <m237ee8id8.fsf@baylibre.com>
Message-ID: <CAFBinCCCgbSvh8B81nXP6D11d5WZZ+71jDgvsjYDsWTb=V78Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 8:12 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Neil Armstrong <narmstrong@baylibre.com> writes:
>
>> On 03/14/2017 04:42 PM, Linus Walleij wrote:
>>> On Thu, Mar 9, 2017 at 8:47 PM, Martin Blumenstingl
>>> <martin.blumenstingl@googlemail.com> wrote:
>>>> On Mon, Mar 6, 2017 at 3:42 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
>>>>> On Sat, 2017-03-04 at 22:23 +0100, Martin Blumenstingl wrote:
>>>
>>>>>> +     FUNCTION(pwm_f_clk),
>>>>>> +     FUNCTION(pwm_f_x),
>>>>>
>>>>> I wonder if having function named "pwm_f_clk" really makes sense ?
>>>>> Shouldn't it be just "pwm_f" ? This is real function, isn't it ?
>>>>> The actual pin used will be provided in the dt. Here, I suppose we
>>>>> could have this:
>>>>>
>>>>> +static const char * const pwm_f_groups[] = {
>>>>> +       "pwm_f_x", "pwm_f_clk",
>>>>> +};
>>>>>
>>>>> Has far as I can see, on meson arch, the function does not carry much
>>>>> information anyway, except for prints.
>>>>>
>>>>> To be clear, I'm not questioning this change in particular. It looks
>>>>> good, and follows what has been done in the past on meson. I know we
>>>>> have been this a lot already, but I'm questioning whether we should
>>>>> continue to do so ?
>>>>>
>>>>> I asking because I also have a lot case like this coming up on audio
>>>>> for gxl and gxbb, where the same function can use different pins.
>>>>
>>>> could you please look into Jerome's question?
>>>> personally I'm fine with either way, and changing my patch would be
>>>> quite trivial. but I'd like to know what's "the way to go" before
>>>> changing anything (and reverting that afterwards again).
>>>
>>> I don't understand the question really.
>>>
>>> I am not an expert on this system, if the people working with it
>>> cannot tell a function from a group I don't know who can... certainly
>>> not me.
>>>
>>> What I can say is that pincontrol combines functions and groups to
>>> states using a mapping. The functions should be something you poke
>>> into a register, the groups are looser defined but may also be a
>>> character of the hardware, but more usual a character of the
>>> intended electronic usecase. Groups contain 1..n pins and can
>>> be combined with some applicable functions.
>>>
>>> Please re-read Documentation/pinctrl.txt very closely if anything is
>>> unclear, I really put a lot of hours into getting that right. Especially
>>> reexamine "Pinmux conventions".
>>
>> The point pushed by Jerome was purely cosmetic since the groups in the meson
>> pinctrl driver are purely cosmetic, since only the GPIO group is handled,
>> other groups are all handled the same.
>
> handled the same... as what?
>
>> This is because I pushed all the PWM pins in a separate group, but functionnaly
>> the internal signal (i.e. PWM F) is the same for multiple pins and should be
>> a single "PWM F" group instead of multiple ones.
>>
>> My advice is to leave the PWM groups as is,
>
> Do you mean as we have in mainline today?  or as is proposed in $SUBJECT patch?
>
>> and push new pins/functions/groups
>> grouped with the internal signal name if split on multiple pins.
>
> Can somone do a quick patch for PWM_F for example, also showing how this
> will look in the DT if someone wants to switch between the PWM_F on GPIOX
> or GPIOCLK?
it would look like this (node name, label and group stay the same,
function does not contain the _x/_clk suffix anymore):
pwm_f_clk_pins: pwm_f_clk {
    mux {
        groups = "pwm_f_clk";
        function = "pwm_f";
    };
};

pwm_f_x_pins: pwm_f_x {
    mux {
        groups = "pwm_f_x";
        function = "pwm_f";
    };
};

> We shouldalso verify that the driver is detecting/removing conflicts
> properly when something else is already using that pin (e.g. SDIO_IRQ
> shares pin GPIOX_7 with PWM_F)
if the same pin is assigned to two devices then the pinctrl subsystem
will throw an error (we don't have to take care of this, it's how I
discovered as GPIOAO_1 was used by uart_rx_ao_a and uart_rx_ao_b).
however, I have not tested yet what happens if the same function is
assigned to multiple pins (let's say you pass both, pwm_f_clk_pins and
pwm_f_x_pins to the pwm_ef node - will this result in the PWM output
being routed to *both* pins or just one pin?). if the same function
cannot be used by two pins simultaneously then we should probably use
function "pwm_f" instead of "pwm_f_x" (just an example) so we can
detect these "conflicts".


Regards,
Martin


[0] https://github.com/torvalds/linux/commit/b27e36482c02a94194fec71fb29696f4c8e9241c
