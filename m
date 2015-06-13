From: carlo@caione.org (Carlo Caione)
Date: Sat, 13 Jun 2015 17:35:58 +0200
Subject: [PATCH 1/2] pinctrl: meson: Enable GPIO IRQs
In-Reply-To: <CACRpkdYCxnf3nUz+jTSu4qw1_nXKkc+_TioZTxW7LpP_dX-MRg@mail.gmail.com>
References: <1432551641-3256-1-git-send-email-carlo@caione.org>
 <1432551641-3256-2-git-send-email-carlo@caione.org>
 <CACRpkdYCxnf3nUz+jTSu4qw1_nXKkc+_TioZTxW7LpP_dX-MRg@mail.gmail.com>
Message-ID: <CAOQ7t2Z6svU4fi2N46ugDcVxtLwmfuOXJPLPhFom8LLqAenusw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 1, 2015 at 4:30 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, May 25, 2015 at 1:00 PM, Carlo Caione <carlo@caione.org> wrote:

Hey Linus,
I was starting to write the v2, but I still have a couple of (probably
silly) questions.

>> +       int ret;
>> +
>> +       pin = domain->data->pin_base + offset;
>
> This is not looking good. Nominally you should use the irqdomain to
> translate hwirq to Linux IRQ.
>
> Normally this is just
>
> line = irq_find_mapping(domain, hwirq);

Ok, it sounds reasonable but this implies that the mapping between the
virq and the hwirq in the outermost domain already exists when the
.to_irq hook is called, right? Also IIUC for hierarchical domains the
mapping should also exist on all the irq_domains in the hierarchy.

>> +       ret = meson_get_bank(domain, pin, &bank);
>> +       if (ret)
>> +               return -ENXIO;
>> +
>> +       irq_data.args_count = 2;
>> +       irq_data.args[0] = pin;
>> +       virq = irq_domain_alloc_irqs(pc->irq_domain, 1, NUMA_NO_NODE, &irq_data);
>
> This is wrong. You have to alloc the irqs either
>
> (A) when the driver is probed, looping over all IRQs.
>   Then pair with free():in the IRQs in the remove()
>   call.

This is not really clear to me. Are you suggesting that the mapping
between the hwirq and virq should be done at probe time so that we can
use irq_find_mapping later?
IIUC for the hierarchical domains the mapping creation should be
propagated to all the domains in cascade and this is usually done
using the .alloc hook of the irq_domain_ops and at probe time we do
not still have the hwirq to pass to the parent GIC. Any idea on how to
approach this problem?

Cheers,

-- 
Carlo Caione
