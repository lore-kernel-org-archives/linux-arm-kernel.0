From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 4 Jun 2015 10:45:38 +0200
Subject: [PATCH 1/2] pinctrl: meson: Enable GPIO IRQs
In-Reply-To: <CAOQ7t2bnAewvjE9D4+Cdw5QGUapi5LnYhG-eN+phi1=tVVVUYQ@mail.gmail.com>
References: <1432551641-3256-1-git-send-email-carlo@caione.org>
 <1432551641-3256-2-git-send-email-carlo@caione.org>
 <CACRpkdYCxnf3nUz+jTSu4qw1_nXKkc+_TioZTxW7LpP_dX-MRg@mail.gmail.com>
 <CAOQ7t2bnAewvjE9D4+Cdw5QGUapi5LnYhG-eN+phi1=tVVVUYQ@mail.gmail.com>
Message-ID: <CACRpkdb9z9Cb69Y=J40pn5zKj4q6dzN9qNNMKXHh_snvO6pD0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 2, 2015 at 11:33 AM, Carlo Caione <carlo@caione.org> wrote:
> On Mon, Jun 1, 2015 at 4:30 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> Yeah. Also this is probably the first pinctrl driver using the
> hierarchy IRQ domain so there is still some piece missing with a lot
> of trial and error.

I actually want to augment all the GPIOLIB_IRQCHIP-using drivers
to use hierarchical IRQ domain, as they are all essentially cascaded
IRQ controllers.

The problem I face is getting the irqdomain of the parent. Simple
in the device tree case, but need to support all cases, so
I may have to look into adding some function that retrieves the
irqdomain for a Linux irq number or descriptor.

>> This is not looking good. Nominally you should use the irqdomain to
>> translate hwirq to Linux IRQ.
>>
>> Normally this is just
>>
>> line = irq_find_mapping(domain, hwirq);
>
> The problem I see with using irq_find_mapping() here is that at this
> point we do not have yet the mapping hwirq->(v)irq. Other drivers (not
> using the hierarchical IRQ domain) use irq_create_mapping() to create
> the mapping in the .to_irq() hook

Any other drivers doing irq_create_mapping() in .to_irq() are old
buggy as they do not support orthogonal gpio/irqchip
coexistance. Look at recent drivers.

> and IIUC for hierarchical domains we
> cannot use irq_create_mapping().

OK that is a problem I may not understand correctly ...
yeah it is referring to the parent IRQ rather than translating,
OK then I guess. Have to look at the code again in v2.

> The point here seems to be that to allocate the IRQs on the GIC we
> need to call the .alloc() of the struct irq_domain_ops. This is not
> usually called by irq_create_mapping() but we need to use
> irq_domain_alloc_irqs(). In irq_create_of_mapping() for example we
> deal with hierarchical domains and IRQs defined in the DTS using
> directly irq_domain_alloc_irqs() as I did in the following lines of
> code.

OK I kind of get it.

I now have a few GPIO drivers using parent IRQs, and they
should all use the hierarchy feature I guess. I'm thinking
about whether we can centralize stuff to gpiolib but maybe
not :/

> So when the GPIO IRQ is defined in the DTS everything works fine since
> irq_create_of_mapping() takes care of everything. The problem is when
> the GPIO IRQ is requested directly from the code or from another
> subsystem (i.e. MMC) since this request goes through .to_irq().

Yeah I get it. I think. Just a bit confused still.

>>> +       ret = meson_get_bank(domain, pin, &bank);
>>> +       if (ret)
>>> +               return -ENXIO;
>>> +
>>> +       irq_data.args_count = 2;
>>> +       irq_data.args[0] = pin;
>>> +       virq = irq_domain_alloc_irqs(pc->irq_domain, 1, NUMA_NO_NODE, &irq_data);
>>
>> This is wrong. You have to alloc the irqs either
>>
>> (A) when the driver is probed, looping over all IRQs.
>>   Then pair with free():in the IRQs in the remove()
>>   call.
>>
>> or
>>
>> (B) in one of the irqchip functions like .irq_request_resources()
>>   then pair with freeing the IRQs in .irq_release_resources().
>
> Correct me if I'm wrong but in my experiments the
> .irq_request_resources() seems to be called after the .to_irq()
> hook.

Hmmm OK... keep that part here then.

>>> +       struct meson_pinctrl *pc = domain->host_data;
>>> +       struct of_phandle_args *irq_data = arg;
>>> +       struct of_phandle_args gic_data;
>>> +       irq_hw_number_t hwirq;
>>> +       int index, ret, i;
>>> +
>>> +       if (irq_data->args_count != 2)
>>> +               return -EINVAL;
>>> +
>>> +       hwirq = irq_data->args[0];
>>> +       dev_dbg(pc->dev, "%s virq %d, nr %d, hwirq %lu\n",
>>> +               __func__, virq, nr_irqs, hwirq);
>>> +
>>> +       for (i = 0; i < nr_irqs; i++) {
>>> +               index = meson_map_gic_irq(domain, hwirq + i);
>>> +               if (index < 0)
>>> +                       return index;
>>> +
>>> +               irq_domain_set_hwirq_and_chip(domain, virq + i,
>>> +                                             hwirq + i,
>>> +                                             &meson_irq_chip,
>>> +                                             pc);
>>> +
>>> +               gic_data = pc->gic_irqs[index];
>>> +               ret = irq_domain_alloc_irqs_parent(domain, virq + i, nr_irqs,
>>> +                                                  &gic_data);
>>> +       }
>>
>> OK... hm quite complex.
>
> Fortunately also quite standard for hierarchical IRQ domains.

Thinking about trying to centralize this for all GPIO chips...

>>> +{
>>> +       struct meson_pinctrl *pc = domain->host_data;
>>> +       struct irq_data *irq_data;
>>> +       int index, i;
>>> +
>>> +       spin_lock(&pc->lock);
>>> +       for (i = 0; i < nr_irqs; i++) {
>>> +               irq_data = irq_domain_get_irq_data(domain, virq + i);
>>> +               index = meson_get_gic_irq(pc, irq_data->hwirq);
>>> +               if (index < 0)
>>> +                       continue;
>>> +               pc->irq_map[index] = IRQ_FREE;
>>
>> Don't you need to call irq_dispose_mapping() for all
>> IRQs here? Or is the irq_domain_free_irqs_paren()
>> taking care of this?
>
> Yes. irq_domain_free_irqs_parent() takes care of everything.

OK.

Yours,
Linus Walleij
