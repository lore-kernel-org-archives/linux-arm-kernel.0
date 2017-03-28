From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 28 Mar 2017 16:19:06 +0200
Subject: [PATCH v2 5/7] pinctrl: aramda-37xx: Add irqchip support
In-Reply-To: <CACRpkdY0DzMGiRTWeS23iCY3Vja9dnXJVaMqOnhJRpBLowfYTA@mail.gmail.com>
 (Linus Walleij's message of "Tue, 28 Mar 2017 15:04:39 +0200")
References: <cover.26288667a039bc9f8e62dec2fd6342ded4014d12.1490120798.git-series.gregory.clement@free-electrons.com>
 <0e60fccd7913b83ee53d2921ce8f297927e8b6f3.1490120798.git-series.gregory.clement@free-electrons.com>
 <CACRpkdYv6WDWM60dRMaYfEt50M8N-yLYk2TRguNi78aQtt6X9A@mail.gmail.com>
 <87vaqtadry.fsf@free-electrons.com>
 <CACRpkdY0DzMGiRTWeS23iCY3Vja9dnXJVaMqOnhJRpBLowfYTA@mail.gmail.com>
Message-ID: <87mvc5a3hh.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
 
 On mar., mars 28 2017, Linus Walleij <linus.walleij@linaro.org> wrote:

> On Tue, Mar 28, 2017 at 12:36 PM, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>>  On lun., mars 27 2017, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>>>> +                       u32 virq = irq_linear_revmap(d, hwirq +
>>>> +                                                    i * GPIO_PER_REG);
>>>
>>> Use irq_find_mapping() instead please.
>>
>> As we are in the interrupt handler I chose to use this function because
>> according to its documentation: "This is a fast path alternative to
>> irq_find_mapping() that can be called directly by irq controller code to
>> save a handful of instructions".
>>
>> The only restriction is "It is always safe to call, but won't find irqs
>> mapped using the radix tree.". So I think that for this driver it is
>> okay.
>
> So you are relying on the core code in gpiolib to select a linear
> map. That is implicit semantics, and either all drivers using
> GPIOLIB_IRQCHIP should be changed to irq_linear_revmap()
> or all stay with irq_find_mapping().
>
> In this case, I doubt it that you are actually so timing critical that
> it matters. Please use irq_find_mapping().

OK

>>>> +       ret = gpiochip_irqchip_add(gc, irqchip, 0,
>>>> +                                  handle_level_irq, IRQ_TYPE_NONE);
>>>
>>> If you also set up the handler in .set_type() you can assign
>>> handle_bad_irq() here and let .set_type set the right handler
>>> as e.g. drivers/gpio/gpio-pl061.c.
>>
>> Well the hardware can only manage the edge trigger, so there is no
>> benefit to modify it each time we want to change the kind of edge we
>> want (raising or falling). But your comment make me realized that I used
>> the wrong one, I will move to handle_edge_irq in the v4.
>
> Ooops, yeah handle_edge_irq() is what calls the ACK callback.
>
>>>> +       for (i = 0; i < nrirqs; i++) {
>>>> +               struct irq_data *d = irq_get_irq_data(gc->irq_base + i);
>>>> +
>>>> +               d->mask = 1 << (i % GPIO_PER_REG);
>>>> +       }
>>>
>>> What is this? It looks like a big hack. At least put in a fat
>>> comment about what is going on and why.
>>
>> I can reuse a part of the commit log here: "The only unusual "feature"
>> is that many interrupts are connected to the parent interrupt
>> controller. But we do not take advantage of this and use the chained irq
>> with all of them."
>
> What you're doing is mocking around with core irqchip semantics.
> Is ->mask really supposed to be played around with from the outsid
> like this?

According to the documentation mask is a "precomputed bitmask for
accessing the chip registers" and it is exactly the way it is used in
this driver.

Moreover, currently ->mask is only used by the generic irqchip framework
and not by the core of the irqchip subsystem. So the mask initialization
is not done from the oustide but at the same level as the generic
irqchip which is not used here.


> Anyways: BIT(i % GPIO_PER_REG) is nicer.

OK

>
>>>> +       for (i = 0; i < nr_irq_parent; i++) {
>>>> +               int irq = irq_of_parse_and_map(np, i);
>>>
>>> I think gpiochip_irqchip_add() will do this for you already,
>>> as it calls irq_create_mapping() for all offsets which will call
>>> irq_of_parse_and_map() am I right?
>>
>> After reading the code, it doesn't seem it is the case. At least there
>> is no irq_of_parse_and_map() call from gpiochip_irqchip_add(). And waht
>> we need here is to associate each IRQ to the same GPIO handler.
>>
>> I can still try without this line to confirm it.
>
> It has irq_create_mapping(gpiochip->irqdomain, offset); that get
> called for every IRQ, and that will eventually call irq_of_parse_and_map()
> if the IRQs are defined in the device tree. (IIRC)

When I followed the functions called I never find a call to
irq_of_parse_and_map(), the closer things related to device tree I found
was:
"virq = irq_domain_alloc_descs(-1, 1, hwirq, of_node_to_nid(of_node),
NULL);"
http://elixir.free-electrons.com/source/kernel/irq/irqdomain.c?v=4.11-rc4#L507

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
