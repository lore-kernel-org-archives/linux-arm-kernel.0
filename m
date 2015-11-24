From: carlo@caione.org (Carlo Caione)
Date: Tue, 24 Nov 2015 10:04:50 +0100
Subject: [linux-meson] Re: [PATCH v2 3/5] pinctrl: meson: enable GPIO IRQs
In-Reply-To: <20151124082801.09139a93@arm.com>
References: <1448273816-11290-1-git-send-email-carlo@caione.org>
 <1448273816-11290-4-git-send-email-carlo@caione.org>
 <20151124082801.09139a93@arm.com>
Message-ID: <CAOQ7t2ZUAefL2xuEzAwoQWi3tpu7N7y6krMv1UUzaBT4BYZv4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 9:28 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Mon, 23 Nov 2015 11:16:54 +0100
> Carlo Caione <carlo@caione.org> wrote:
>
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> On Meson8 and Meson8b SoCs there are 8 independent filtered GPIO
>> interrupt modules that can be programmed to use any of the GPIOs in the
>> chip as an interrupt source.
>>
>> For each GPIO IRQ we have:
>>
>> GPIOs --> [mux]--> [polarity]--> [filter]--> [edge select]--> GIC
>>
>> The eight GPIO interrupts respond to mask/unmask/clear/etc.. just like
>> any other interrupt in the chip. The difference for the GPIO interrupts
>> is that they can be filtered and conditioned.
>>
>> This patch adds support for the external GPIOs interrupts and enables
>> them for Meson8 and Meson8b SoCs.
>>
>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
>>
>> ---
>
> [...]
>
>> +     for (i = 0; i < pc->num_gic_irqs; i++) {
>> +             struct of_phandle_args oirq;
>> +
>> +             of_irq_parse_one(node, i, &oirq);
>> +             irq_of_phandle_args_to_fwspec(&oirq, &pc->gic_irqs[i]);
>> +
>> +             pc->irq_map[i] = IRQ_FREE;
>> +     }
>
> The whole thing feels weird. Why do you need to keep a set of fwspecs?

We only have 8 IRQs on the GIC side that we can use for the GPIOs. The
set of fwspec is used to track these IRQs.
At probe time we read from the DTS how many and which IRQs are
reserved on the GIC for the GPIOs. Every time a GPIO IRQ is installed,
we use one of these IRQ lines.

> All you need is a range of interrupts that would be conveniently
> represented by a bitmap (assuming your interrupts space is a mostly
> contiguous range).

I could do that but it feels to me like we end up hiding from the DTS
some information that naturally should be in there: a pinctrl device
that is using 8 interrupt lines of its interrupt controller. IMO this
is not a special case that requires some special treatment.

> Overall, this patch is quite hard to review. Can you please split the
> GPIO management from the irqchip side?

Sure. Fix in v2.

Thanks for the review,

-- 
Carlo Caione
