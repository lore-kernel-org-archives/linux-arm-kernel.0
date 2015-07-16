From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Jul 2015 10:07:02 +0200
Subject: [PATCH 1/2] pinctrl: meson: Enable GPIO IRQs
In-Reply-To: <CAOQ7t2af5=E_U_v5YmN6qN6q9NRp4ZQwoaUyD7sr5nsF8aSr1w@mail.gmail.com>
References: <1432551641-3256-1-git-send-email-carlo@caione.org>
 <1432551641-3256-2-git-send-email-carlo@caione.org>
 <CACRpkdYCxnf3nUz+jTSu4qw1_nXKkc+_TioZTxW7LpP_dX-MRg@mail.gmail.com>
 <CAOQ7t2Z6svU4fi2N46ugDcVxtLwmfuOXJPLPhFom8LLqAenusw@mail.gmail.com>
 <CACRpkdZ4kB=LQac4vY1tWZo0ESBmWY0Ba0yUei3cV8XnpVZ03A@mail.gmail.com>
 <CAOQ7t2af5=E_U_v5YmN6qN6q9NRp4ZQwoaUyD7sr5nsF8aSr1w@mail.gmail.com>
Message-ID: <CACRpkdYPuHYA8rOc7PX-nqSB7DA6p7ifw8EAobpDjrmsO8Tmyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 7:33 PM, Carlo Caione <carlo@caione.org> wrote:
> On Wed, Jun 17, 2015 at 10:26 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>> On Sat, Jun 13, 2015 at 5:35 PM, Carlo Caione <carlo@caione.org> wrote:
>>> On Mon, Jun 1, 2015 at 4:30 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> ...
>>> Ok, it sounds reasonable but this implies that the mapping between the
>>> virq and the hwirq in the outermost domain already exists when the
>>> .to_irq hook is called, right? Also IIUC for hierarchical domains the
>>> mapping should also exist on all the irq_domains in the hierarchy.
>>
>> I guess, I am no expert in the hierarchical domains, sadly.
>>
>> The point is that it should be possible to request an IRQ
>> from the irqchip side without having to have called .to_irq()
>> on the GPIO first.
>
> Ok. Let me rephrase that to be sure we are on the same track. It
> should be possible to request an IRQ without having to have called
> .to_irq() on the GPIO first to allocate the IRQ descriptor.
> Ok but when is this the case? If our IRQ line is in the DT, then
> irq_create_of_mapping() takes care of allocating the descriptor. Now,
> the only other case I know of is for MMC/slot-gpio. In this case
> mmc_gpiod_request_cd_irq() only calls .to_irq() before requesting the
> IRQ so there is the occasion to allocate the IRQ descriptor (that's
> why probably a lot of drivers allocate the irq descriptor in there
> using irq_create_mapping()).

I just want to be convinced that code does not rely on .to_irq() being
called to request IRQs from the irqchip side. As long as you can convince
me that this is the case I'm OK.

>>> IIUC for the hierarchical domains the mapping creation should be
>>> propagated to all the domains in cascade and this is usually done
>>> using the .alloc hook of the irq_domain_ops and at probe time we do
>>> not still have the hwirq to pass to the parent GIC. Any idea on how to
>>> approach this problem?
>>
>> I guess it needs to be done in some other hook on the
>> irqchip in that case. Just not in .to_irq() on the gpiochip.
>
> You mentioned .irq_request_resources(), but isn't it called too late
> for IRQ allocation?

Maybe yeah. I feel a bit lost here :(

It would be nice to have a Reviewed-by from some IRQ people on
this.

Yours,
Linus Walleij
