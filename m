From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 18 Jun 2015 08:52:08 +0100
Subject: [PATCH] Re: Linkstation Mini and __machine_arch_type problem,
 not booting since 3.8
In-Reply-To: <1434593555.13334.14.camel@dolka.fr>
References: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>	
 <1434446447.4785.7.camel@dolka.fr> <1434593555.13334.14.camel@dolka.fr>
Message-ID: <558278A8.2050406@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin,

On 18/06/15 03:12, Benjamin Cama wrote:
> Hi again (feeling lonely),

[...]

> And I did it. And I stumbled upon commit
> a71b092a9c68685a270ebdde7b5986ba8787e575 ?ARM: Convert handle_IRQ to
> use __handle_domain_irq? (author Cc'ed). The new function
> __handle_domain_irq (in kernel/irq/irqdesc.c, which comes just two
> commits before, with 76ba59f8366f2d9282cb5bda9de75b4b68cbe55f) is
> subtly different from the one it replaces, handle_IRQ, as it checks if
> the irq is not 0 as well as checking for an upper bound. Removing the
> check for 0 makes my machine work again! But honestly, I do not know if
> a zero irq is legit, so I hope some more knowledgeable people will tell
> me if this is OK.
> 
> -- >8 --
> Subject: [PATCH] Make __handle_domain_irq accept IRQ 0
> 
> The same as handle_IRQ did before.
> 
> Signed-off-by: Benjamin Cama <benoar@dolka.fr>
> ---
>  kernel/irq/irqdesc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index a1782f8..bfbeeb6 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -365,7 +365,7 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
>          * Some hardware gives randomly wrong interrupts.  Rather
>          * than crashing, do something sensible.
>          */
> -       if (unlikely(!irq || irq >= nr_irqs)) {
> +       if (unlikely(irq >= nr_irqs)) {
>                 ack_bad_irq(irq);
>                 ret = -EINVAL;
>         } else {
> 

Unfortunately, this is the wrong thing to do. IRQ0 is invalid, has been
for a very long time, and actually represents the lack of interrupt.

The way you can address this is by making sure your favourite platform
does not use IRQ0 at all, which is done by not assuming that Linux IRQ
number (which is always completely virtual) is the same as the number
designating the actual HW interrupt line.

For example, have a look at 18f3aec (ARM: 8230/1: sa1100: shift IRQs by
one) for an example of such a (very simple) conversion. You'll need to
tweak irq.c too.

Other commits for sa1100 will hopefully convince you to switch to irq
domains altogether. This will greatly facilitate a possible further
transition to DT if you wish to do so.

Looking forward to reviewing your patches,

	M.
-- 
Jazz is not dead. It just smells funny...
