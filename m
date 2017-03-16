From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 16 Mar 2017 14:54:03 +0100
Subject: [PATCH 1/2] pinctrl: meson: gxl: add the missing PWM pin
 definitions
In-Reply-To: <CAFBinCCCgbSvh8B81nXP6D11d5WZZ+71jDgvsjYDsWTb=V78Xg@mail.gmail.com>
References: <20170304212318.27076-1-martin.blumenstingl@googlemail.com>
 <20170304212318.27076-2-martin.blumenstingl@googlemail.com>
 <1488811357.2420.18.camel@baylibre.com>
 <CAFBinCDty8v80tLxHJPR+SHv32LX834dPJUruRNqr6angx3OOQ@mail.gmail.com>
 <CACRpkdbGfGUhnAQz=9xeFnD2hF6m_xXacu8mZiwte-OCSDMo9w@mail.gmail.com>
 <b7430d5f-96a7-2445-1c2a-ccc299bfdda2@baylibre.com>
 <m237ee8id8.fsf@baylibre.com>
 <CAFBinCCCgbSvh8B81nXP6D11d5WZZ+71jDgvsjYDsWTb=V78Xg@mail.gmail.com>
Message-ID: <c0dad3a3-bdd4-3563-0ca6-0ca9d5a4ce2f@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/15/2017 09:11 PM, Martin Blumenstingl wrote:
> On Wed, Mar 15, 2017 at 8:12 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>> Neil Armstrong <narmstrong@baylibre.com> writes:
>>
>>> On 03/14/2017 04:42 PM, Linus Walleij wrote:
>>>> On Thu, Mar 9, 2017 at 8:47 PM, Martin Blumenstingl
>>>> <martin.blumenstingl@googlemail.com> wrote:
>>>>> On Mon, Mar 6, 2017 at 3:42 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
>>>>>> On Sat, 2017-03-04 at 22:23 +0100, Martin Blumenstingl wrote:
>>>>
>>>>>>> +     FUNCTION(pwm_f_clk),
>>>>>>> +     FUNCTION(pwm_f_x),
>>>>>>
>>>>>> I wonder if having function named "pwm_f_clk" really makes sense ?
>>>>>> Shouldn't it be just "pwm_f" ? This is real function, isn't it ?
>>>>>> The actual pin used will be provided in the dt. Here, I suppose we
>>>>>> could have this:
>>>>>>
>>>>>> +static const char * const pwm_f_groups[] = {
>>>>>> +       "pwm_f_x", "pwm_f_clk",
>>>>>> +};
>>>>>>
>>>>>> Has far as I can see, on meson arch, the function does not carry much
>>>>>> information anyway, except for prints.
>>>>>>
>>>>>> To be clear, I'm not questioning this change in particular. It looks
>>>>>> good, and follows what has been done in the past on meson. I know we
>>>>>> have been this a lot already, but I'm questioning whether we should
>>>>>> continue to do so ?
>>>>>>
>>>>>> I asking because I also have a lot case like this coming up on audio
>>>>>> for gxl and gxbb, where the same function can use different pins.
>>>>>
>>>>> could you please look into Jerome's question?
>>>>> personally I'm fine with either way, and changing my patch would be
>>>>> quite trivial. but I'd like to know what's "the way to go" before
>>>>> changing anything (and reverting that afterwards again).
>>>>
>>>> I don't understand the question really.
>>>>
>>>> I am not an expert on this system, if the people working with it
>>>> cannot tell a function from a group I don't know who can... certainly
>>>> not me.
>>>>
>>>> What I can say is that pincontrol combines functions and groups to
>>>> states using a mapping. The functions should be something you poke
>>>> into a register, the groups are looser defined but may also be a
>>>> character of the hardware, but more usual a character of the
>>>> intended electronic usecase. Groups contain 1..n pins and can
>>>> be combined with some applicable functions.
>>>>
>>>> Please re-read Documentation/pinctrl.txt very closely if anything is
>>>> unclear, I really put a lot of hours into getting that right. Especially
>>>> reexamine "Pinmux conventions".
>>>
>>> The point pushed by Jerome was purely cosmetic since the groups in the meson
>>> pinctrl driver are purely cosmetic, since only the GPIO group is handled,
>>> other groups are all handled the same.
>>
>> handled the same... as what?
>>
>>> This is because I pushed all the PWM pins in a separate group, but functionnaly
>>> the internal signal (i.e. PWM F) is the same for multiple pins and should be
>>> a single "PWM F" group instead of multiple ones.
>>>
>>> My advice is to leave the PWM groups as is,
>>
>> Do you mean as we have in mainline today?  or as is proposed in $SUBJECT patch?
>>
>>> and push new pins/functions/groups
>>> grouped with the internal signal name if split on multiple pins.
>>
>> Can somone do a quick patch for PWM_F for example, also showing how this
>> will look in the DT if someone wants to switch between the PWM_F on GPIOX
>> or GPIOCLK?
> it would look like this (node name, label and group stay the same,
> function does not contain the _x/_clk suffix anymore):
> pwm_f_clk_pins: pwm_f_clk {
>     mux {
>         groups = "pwm_f_clk";
>         function = "pwm_f";
>     };
> };
> 
> pwm_f_x_pins: pwm_f_x {
>     mux {
>         groups = "pwm_f_x";
>         function = "pwm_f";
>     };
> };
> 
>> We shouldalso verify that the driver is detecting/removing conflicts
>> properly when something else is already using that pin (e.g. SDIO_IRQ
>> shares pin GPIOX_7 with PWM_F)
> if the same pin is assigned to two devices then the pinctrl subsystem
> will throw an error (we don't have to take care of this, it's how I
> discovered as GPIOAO_1 was used by uart_rx_ao_a and uart_rx_ao_b).
> however, I have not tested yet what happens if the same function is
> assigned to multiple pins (let's say you pass both, pwm_f_clk_pins and
> pwm_f_x_pins to the pwm_ef node - will this result in the PWM output
> being routed to *both* pins or just one pin?). if the same function
> cannot be used by two pins simultaneously then we should probably use
> function "pwm_f" instead of "pwm_f_x" (just an example) so we can
> detect these "conflicts".
> 
> 
> Regards,
> Martin
> 
> 
> [0] https://github.com/torvalds/linux/commit/b27e36482c02a94194fec71fb29696f4c8e9241c
> 

Let's resume :
In the mainline meson pinctrl driver, we have :
 - pins that represent the PAD name (GPIOX_3 or GPIODV_17)
 - groups that represent each physical "bit" we set in the control registers, each group can group 1 or multiple physical pins
For example, the "emmc_nand_d07" sets the mode of multiple pins.
 - functions are a purely logical set of groups

The only C function handling the "function" is :
static int meson_pmx_set_mux(func_num, group_num)
{
...
	struct meson_pmx_func *func = &pc->data->funcs[func_num];
...
	/* Function 0 (GPIO) doesn't need any additional setting */
	if (func_num)
		ret = regmap_update_bits(...);
...
}

So we could have only two big functions :
is_gpio
is_not_gpio

But now we group every logically similar "groups" into the same function, like :
static const char * const uart_a_groups[] = {
	"uart_tx_a", "uart_rx_a", "uart_cts_a", "uart_rts_a",
};

When I pushed the PWM pins, I did not knew how to handle the fact that the same signal
is on multiple physical pins, so I added multiple functions for each physical pin mode.

What jerome pointed is that instead of :
static const char * const pwm_a_x_groups[] = {
	"pwm_a_x",
};

static const char * const pwm_a_y_groups[] = {
	"pwm_a_y",
};

we could have single :
static const char * const pwm_a_groups[] = {
	"pwm_a_x", "pwm_a_y",
};

But we should also change the DT accordingly.

So we can see that from different perspective :
- from the "pin" perspective : they are different functions, so we leave like it's already mainline
- from the "signal" perspective : they are the same signal, so we should group
- both, so we set a function per groupable groups.

for example, on the GXL, we can have UART_AO_B TX&RX on multiple pins, so we can have either :
static const char * const uart_ao_b_groups[] = {
 	"uart_tx_ao_b", "uart_rx_ao_b", "uart_cts_ao_b", "uart_rts_ao_b",
	"uart_tx_ao_b_0", "uart_rx_ao_b_1",
};

or

static const char * const uart_ao_b_groups[] = {
 	"uart_tx_ao_b", "uart_rx_ao_b", "uart_cts_ao_b", "uart_rts_ao_b",
};

static const char * const uart_ao_b_0_1_groups[] = {
	"uart_tx_ao_b_0", "uart_rx_ao_b_1",
};

or

static const char * const uart_ao_b_groups[] = {
 	"uart_tx_ao_b", "uart_rx_ao_b", "uart_cts_ao_b", "uart_rts_ao_b",
};

static const char * const uart_ao_b_0_1_groups[] = {
 	"uart_tx_ao_b_0", "uart_rx_ao_b_1", "uart_cts_ao_b", "uart_rts_ao_b",
};

The three of these are correct.
The point Jerome asked was for solution 1, and it what I pushed
The solution 2 is how functions are today.

The third solution is less easy but still valid.

What I want is :
 - since it's purely logical, it's not very important and each solution is still valid from
all perspectives, so leave the PWM functions like this and push new PWMs in the same way
 - The next functions should behave like solution 1, or solution 3 if better

Neil
