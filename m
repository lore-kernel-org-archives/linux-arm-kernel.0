From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 17 Jun 2015 10:26:36 +0200
Subject: [PATCH 1/2] pinctrl: meson: Enable GPIO IRQs
In-Reply-To: <CAOQ7t2Z6svU4fi2N46ugDcVxtLwmfuOXJPLPhFom8LLqAenusw@mail.gmail.com>
References: <1432551641-3256-1-git-send-email-carlo@caione.org>
 <1432551641-3256-2-git-send-email-carlo@caione.org>
 <CACRpkdYCxnf3nUz+jTSu4qw1_nXKkc+_TioZTxW7LpP_dX-MRg@mail.gmail.com>
 <CAOQ7t2Z6svU4fi2N46ugDcVxtLwmfuOXJPLPhFom8LLqAenusw@mail.gmail.com>
Message-ID: <CACRpkdZ4kB=LQac4vY1tWZo0ESBmWY0Ba0yUei3cV8XnpVZ03A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 13, 2015 at 5:35 PM, Carlo Caione <carlo@caione.org> wrote:
> On Mon, Jun 1, 2015 at 4:30 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Mon, May 25, 2015 at 1:00 PM, Carlo Caione <carlo@caione.org> wrote:
>
> Hey Linus,
> I was starting to write the v2, but I still have a couple of (probably
> silly) questions.
>
>>> +       int ret;
>>> +
>>> +       pin = domain->data->pin_base + offset;
>>
>> This is not looking good. Nominally you should use the irqdomain to
>> translate hwirq to Linux IRQ.
>>
>> Normally this is just
>>
>> line = irq_find_mapping(domain, hwirq);
>
> Ok, it sounds reasonable but this implies that the mapping between the
> virq and the hwirq in the outermost domain already exists when the
> .to_irq hook is called, right? Also IIUC for hierarchical domains the
> mapping should also exist on all the irq_domains in the hierarchy.

I guess, I am no expert in the hierarchical domains, sadly.

The point is that it should be possible to request an IRQ
from the irqchip side without having to have called .to_irq()
on the GPIO first.

>> (A) when the driver is probed, looping over all IRQs.
>>   Then pair with free():in the IRQs in the remove()
>>   call.
>
> This is not really clear to me. Are you suggesting that the mapping
> between the hwirq and virq should be done at probe time so that we can
> use irq_find_mapping later?

Yes.

> IIUC for the hierarchical domains the mapping creation should be
> propagated to all the domains in cascade and this is usually done
> using the .alloc hook of the irq_domain_ops and at probe time we do
> not still have the hwirq to pass to the parent GIC. Any idea on how to
> approach this problem?

I guess it needs to be done in some other hook on the
irqchip in that case. Just not in .to_irq() on the gpiochip.

Yours,
Linus Walleij
