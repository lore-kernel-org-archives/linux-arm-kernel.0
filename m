From: carlo@caione.org (Carlo Caione)
Date: Thu, 26 Nov 2015 18:56:08 +0100
Subject: [linux-meson] Re: [PATCH v2 3/5] pinctrl: meson: enable GPIO IRQs
In-Reply-To: <20151126162722.1146b220@arm.com>
References: <1448273816-11290-1-git-send-email-carlo@caione.org>
 <1448273816-11290-4-git-send-email-carlo@caione.org>
 <20151124082801.09139a93@arm.com>
 <CAOQ7t2ZUAefL2xuEzAwoQWi3tpu7N7y6krMv1UUzaBT4BYZv4A@mail.gmail.com>
 <20151126162722.1146b220@arm.com>
Message-ID: <CAOQ7t2YLC8NBr33LhONQ01eCBs7b2OSeNhoBorR70nXi2MXc_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 5:27 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Tue, 24 Nov 2015 10:04:50 +0100
> Carlo Caione <carlo@caione.org> wrote:
>
>> On Tue, Nov 24, 2015 at 9:28 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> > On Mon, 23 Nov 2015 11:16:54 +0100
>> > Carlo Caione <carlo@caione.org> wrote:
>> >
>> >> From: Carlo Caione <carlo@endlessm.com>
>> >>
>> >> On Meson8 and Meson8b SoCs there are 8 independent filtered GPIO
>> >> interrupt modules that can be programmed to use any of the GPIOs in the
>> >> chip as an interrupt source.
>> >>
>> >> For each GPIO IRQ we have:
>> >>
>> >> GPIOs --> [mux]--> [polarity]--> [filter]--> [edge select]--> GIC
>> >>
>> >> The eight GPIO interrupts respond to mask/unmask/clear/etc.. just like
>> >> any other interrupt in the chip. The difference for the GPIO interrupts
>> >> is that they can be filtered and conditioned.
>> >>
>> >> This patch adds support for the external GPIOs interrupts and enables
>> >> them for Meson8 and Meson8b SoCs.
>> >>
>> >> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>> >> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
>> >>
>> >> ---
>> >
>> > [...]
>> >
>> >> +     for (i = 0; i < pc->num_gic_irqs; i++) {
>> >> +             struct of_phandle_args oirq;
>> >> +
>> >> +             of_irq_parse_one(node, i, &oirq);
>> >> +             irq_of_phandle_args_to_fwspec(&oirq, &pc->gic_irqs[i]);
>> >> +
>> >> +             pc->irq_map[i] = IRQ_FREE;
>> >> +     }
>> >
>> > The whole thing feels weird. Why do you need to keep a set of fwspecs?
>>
>> We only have 8 IRQs on the GIC side that we can use for the GPIOs. The
>> set of fwspec is used to track these IRQs.
>> At probe time we read from the DTS how many and which IRQs are
>> reserved on the GIC for the GPIOs. Every time a GPIO IRQ is installed,
>> we use one of these IRQ lines.
>
> That doesn't answer my question. Having the raw IRQ numbers, why not.
> Storing a whole fwspec (16 u32 + 1 int + 1 pointer) seems completely
> overkill.

Oh, you were referring to the type used. Agree, since we are moving
away (read below) from the DTS, probably using fwspecs is just on
overkill.
The only thing I'm not really fond of is to use a bitmap since I'm not
really sure that the interrupt space is a contiguous range for all the
Amlogic / Meson SoCs. Probably the most sensible way is using
something like TI did for 'ti,irqs-reserved' that is an array of IRQs.

>> > All you need is a range of interrupts that would be conveniently
>> > represented by a bitmap (assuming your interrupts space is a mostly
>> > contiguous range).
>>
>> I could do that but it feels to me like we end up hiding from the DTS
>> some information that naturally should be in there: a pinctrl device
>> that is using 8 interrupt lines of its interrupt controller. IMO this
>> is not a special case that requires some special treatment.
>
> Well, it is also arguable that these interrupts are not the pinctrl's,
> but those of the device that actually uses them (or we'd be describing
> interrupts in all interrupt controller bindings, which doesn't make any
> sense).

Ok, I see you point

> See for example the TI crossbar, which has similar functionalities. I'm
> not going to take a hard line here, but the argument you have so far
> doesn't seem to hold much water for me. Or there is something obvious
> that I have missed, which is entirely possible.

I hope things will be a bit clearer in v3.

Thanks,

-- 
Carlo Caione
