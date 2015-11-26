From: carlo@caione.org (Carlo Caione)
Date: Thu, 26 Nov 2015 17:09:55 +0100
Subject: [linux-meson] Re: [PATCH v2 3/5] pinctrl: meson: enable GPIO IRQs
In-Reply-To: <CAOQ7t2ZUAefL2xuEzAwoQWi3tpu7N7y6krMv1UUzaBT4BYZv4A@mail.gmail.com>
References: <1448273816-11290-1-git-send-email-carlo@caione.org>
 <1448273816-11290-4-git-send-email-carlo@caione.org>
 <20151124082801.09139a93@arm.com>
 <CAOQ7t2ZUAefL2xuEzAwoQWi3tpu7N7y6krMv1UUzaBT4BYZv4A@mail.gmail.com>
Message-ID: <CAOQ7t2YAseprbT29uQX-aKJcEm-b-Dy=jBW8a+Z2kWDyQskNeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 10:04 AM, Carlo Caione <carlo@caione.org> wrote:
> On Tue, Nov 24, 2015 at 9:28 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:

>> [...]
>>
>>> +     for (i = 0; i < pc->num_gic_irqs; i++) {
>>> +             struct of_phandle_args oirq;
>>> +
>>> +             of_irq_parse_one(node, i, &oirq);
>>> +             irq_of_phandle_args_to_fwspec(&oirq, &pc->gic_irqs[i]);
>>> +
>>> +             pc->irq_map[i] = IRQ_FREE;
>>> +     }
>>
>> The whole thing feels weird. Why do you need to keep a set of fwspecs?
>
> We only have 8 IRQs on the GIC side that we can use for the GPIOs. The
> set of fwspec is used to track these IRQs.
> At probe time we read from the DTS how many and which IRQs are
> reserved on the GIC for the GPIOs. Every time a GPIO IRQ is installed,
> we use one of these IRQ lines.
>
>> All you need is a range of interrupts that would be conveniently
>> represented by a bitmap (assuming your interrupts space is a mostly
>> contiguous range).
>
> I could do that but it feels to me like we end up hiding from the DTS
> some information that naturally should be in there: a pinctrl device
> that is using 8 interrupt lines of its interrupt controller. IMO this
> is not a special case that requires some special treatment.

Marc,
What's your opinion on this? So I can start cooking v3

Thanks,

-- 
Carlo Caione
