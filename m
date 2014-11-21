From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 21 Nov 2014 15:01:17 +0400
Subject: IRQ #0 broken on ARM
In-Reply-To: <87zjbk966i.fsf@approximate.cambridge.arm.com>
References: <CALT56yPs-SSssff1waj81CRQfER4ZKKR=B1jOXVL-aBChicSjg@mail.gmail.com>
 <87zjbk966i.fsf@approximate.cambridge.arm.com>
Message-ID: <CALT56yNnYGGtgb6e6=2O2jJaP1v2rwYVVK4Rtr-6vc0JzWca5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-21 13:52 GMT+03:00 Marc Zyngier <marc.zyngier@arm.com>:
> On Fri, Nov 21 2014 at 10:31:05 am GMT, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
>> Hello,
>>
>> After the commit a71b092a9c68685a270ebdde7b5986ba8787e575
>> (ARM: Convert handle_IRQ to use __handle_domain_irq) IRQ #0 is broken
>> on ARM. It is a valid IRQ and it is quite imporant (on sa1100 it's a GPIO0).
>
> Well, this is a valid IRQ number if you're not using irq domains. I may
> be a bit pedantic here, but I thing this is an important distinction.
>
>> The worst thing is that the CPU will be stuck busy-looping around this
>> IRQ w/o printing anything to the console or masking the irq. How
>> should we cope with that? I'd like to propose to either revert the
>> offending commit or to add the following patch.
>
> Well, said commit fixes a rather important bug, so I suggest we keep
> around. Now, as for your suggestion:

>From the commit message it was not clear, that there was a bug fixed
(it talks only about code duplication).

[skipped]

> As I mentioned above, IRQ0 is not valid when using irq domains. As an
> alternative, how about this:
>
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index a1782f8..9f5bc92 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -365,7 +365,7 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
>          * Some hardware gives randomly wrong interrupts.  Rather
>          * than crashing, do something sensible.
>          */
> -       if (unlikely(!irq || irq >= nr_irqs)) {
> +       if (unlikely((lookup && !irq) || irq >= nr_irqs)) {
>                 ack_bad_irq(irq);
>                 ret = -EINVAL;
>         } else {
>
> I don't have a platform to test this on, but maybe you could give it a
> go and let me know if that helps?

It helps in my case. Thank you. Please add me to Cc if you submit
this patch.

-- 
With best wishes
Dmitry
