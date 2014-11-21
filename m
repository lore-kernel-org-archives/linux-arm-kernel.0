From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Nov 2014 10:52:37 +0000
Subject: IRQ #0 broken on ARM
In-Reply-To: <CALT56yPs-SSssff1waj81CRQfER4ZKKR=B1jOXVL-aBChicSjg@mail.gmail.com>
 (Dmitry Eremin-Solenikov's message of "Fri, 21 Nov 2014 10:31:05
 +0000")
References: <CALT56yPs-SSssff1waj81CRQfER4ZKKR=B1jOXVL-aBChicSjg@mail.gmail.com>
Message-ID: <87zjbk966i.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21 2014 at 10:31:05 am GMT, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
> Hello,
>
> After the commit a71b092a9c68685a270ebdde7b5986ba8787e575
> (ARM: Convert handle_IRQ to use __handle_domain_irq) IRQ #0 is broken
> on ARM. It is a valid IRQ and it is quite imporant (on sa1100 it's a GPIO0).

Well, this is a valid IRQ number if you're not using irq domains. I may
be a bit pedantic here, but I thing this is an important distinction.

> The worst thing is that the CPU will be stuck busy-looping around this
> IRQ w/o printing anything to the console or masking the irq. How
> should we cope with that? I'd like to propose to either revert the
> offending commit or to add the following patch.

Well, said commit fixes a rather important bug, so I suggest we keep
around. Now, as for your suggestion:

> -- 
> With best wishes
> Dmitry
>
> From e87f86497b796ed55fff644bbc75bf1890941829 Mon Sep 17 00:00:00 2001
> From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Date: Fri, 21 Nov 2014 13:27:11 +0300
> Subject: [PATCH] genirq: handle IRQ 0 in __handle_domain_irq
>
> __handle_domain_irq() function will ignore (well, report as bad) the IRQ
> number 0. On some platforms IRQ0 is bad IRQ. On others it is not. And
> while platforms are still in the process of converging to not using
> IRQ number 0 as a valid IRQ, I'd like to propose to use IRQ0 as a valid
> one in __handle_domain_irq().
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  kernel/irq/irqdesc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index a1782f8..bfbeeb6 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -365,7 +365,7 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
>  	 * Some hardware gives randomly wrong interrupts.  Rather
>  	 * than crashing, do something sensible.
>  	 */
> -	if (unlikely(!irq || irq >= nr_irqs)) {
> +	if (unlikely(irq >= nr_irqs)) {
>  		ack_bad_irq(irq);
>  		ret = -EINVAL;
>  	} else {

As I mentioned above, IRQ0 is not valid when using irq domains. As an
alternative, how about this:

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index a1782f8..9f5bc92 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -365,7 +365,7 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
 	 * Some hardware gives randomly wrong interrupts.  Rather
 	 * than crashing, do something sensible.
 	 */
-	if (unlikely(!irq || irq >= nr_irqs)) {
+	if (unlikely((lookup && !irq) || irq >= nr_irqs)) {
 		ack_bad_irq(irq);
 		ret = -EINVAL;
 	} else {

I don't have a platform to test this on, but maybe you could give it a
go and let me know if that helps?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
