From: carlo@endlessm.com (Carlo Caione)
Date: Wed, 2 Dec 2015 12:37:49 +0100
Subject: [PATCH v3 4/6] pinctrl: meson: Enable GPIO IRQs
In-Reply-To: <565EB3D8.5070400@arm.com>
References: <1448987062-31225-1-git-send-email-carlo@caione.org>
 <1448987062-31225-5-git-send-email-carlo@caione.org>
 <565DF211.8000005@arm.com>
 <CAOQ7t2YN8Ey1vZO4yrn9SdbR7FzPNVY-HGRBZOctLgK1vHo9VA@mail.gmail.com>
 <565EB3D8.5070400@arm.com>
Message-ID: <CAL9uMOE1orp8zQABMOW0eFMuZ9XcGfLF1RLOwurEcN-csxfGtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 2, 2015 at 10:03 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 01/12/15 19:41, Carlo Caione wrote:
>> On Tue, Dec 1, 2015 at 8:16 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> On 01/12/15 16:24, Carlo Caione wrote:
>>>> From: Carlo Caione <carlo@endlessm.com>

[...]

>> In v2 I had the set of fwspec to track number and trigger type of the
>> IRQ, so it was straightforward. With this patch I have moved away from
>> that solution (as you suggested) and I'm using the 'amlogic,irqs-gpio'
>> parameter to track down the IRQ numbers (but not the trigger type).
>> It's the same solution we have in drivers/irqchip/irq-crossbar.c where
>> the trigger type is hardcoded in allocate_gic_irq().
>> If I need to save both the IRQ and the trigger type at this point I
>> wonder if it's better to go back to the set of fwspec or convert the
>> fwspec to of_phandle_args and save that.
>
> No. This should come from the interrupt specifier you are getting from
> the device. You should never make up that information.
>
> Your amlogic,irqs-gpio property gives you a list of downstream
> interrupts. The device connected to your pinctrl HW provides you with
> the upstream interrupt number (which you will map to one of your
> downstream IRQ) and crucially the trigger type. Please look at how the
> TI cross bar works (again).

Ok, this definitely makes sense and I'm going to fix it in the next
revision, thanks for the explanation. Still I fail to see how the TI
cross bar driver is actually doing what you are suggesting here. If
I'm correctly reading the code here
http://lxr.free-electrons.com/source/drivers/irqchip/irq-crossbar.c#L101
the driver is hardcoding the trigger type for the downstream IRQ to be
passed to the GIC code. But probably I'm missing something obvious.

>>>> +static int meson_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
>>>> +{
>>>> +     struct meson_domain *domain = to_meson_domain(chip);
>>>> +     struct meson_pinctrl *pc = domain->pinctrl;
>>>> +     struct meson_bank *bank;
>>>> +     struct irq_fwspec irq_data;
>>>> +     unsigned int hwirq, irq;
>>>> +
>>>> +     hwirq = domain->data->pin_base + offset;
>>>> +
>>>> +     if (meson_get_bank(domain, hwirq, &bank))
>>>> +             return -ENXIO;
>>>> +
>>>> +     irq_data.param_count = 2;
>>>> +     irq_data.param[0] = hwirq;
>>>> +
>>>> +     /* dummy. It will be changed later in meson_irq_set_type */
>>>> +     irq_data.param[1] = IRQ_TYPE_EDGE_RISING;
>>>
>>> Blah. Worse than I though... How do you end-up here? Why can't you
>>> obtain the corresponding of_phandle_args instead of making things up?
>>
>> because I do not have a of_phandle. This is basically the .to_irq hook
>> of the gpio_chip. This code is being called programmatically from the
>> gpiolib. No DTS/OF involved here.
>>
>>> This looks mad. Do you really need this?
>>
>> Well, I'm open to any suggestion on how improve this mess.
>
> The question to answer is: in what circumstances do you have to convert
> a GPIO into an IRQ at runtime? The only case should be "when you
> discover a device having an interrupt pointing to your pinctrl". And in
> this case, you have all the information to reconfigure the HW and assign
> the interrupt.
>
> I really don't get why you want or need to involve gpiolib in this.

Again probably I'm missing something (and Linus probably could help
here) but the only place I see the .to_irq hook (that is
meson_gpio_to_irq() in the driver code) being called is from
gpiod_to_irq() function in the gpiolib code.

One practical case in which that code path is involved is when (for
example) I have something like 'cd-gpios = <&gpio GPIOX 0>;' for the
card detection IRQ in the MMC node and in this case I fail to see an
easy way to get the trigger type without touching the MMC / gpiolib
code (any idea?).
This function is not called at all when in the DTS I explicitly have
the interrupt specifier defined using the 'interrupts = <...>'
property and in that case I have all the information I need to map the
downstream IRQ.

Thanks,

-- 
Carlo Caione
