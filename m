From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 21 Jun 2014 19:51:08 -0400
Subject: [PATCH v3 1/7] genirq: generic chip: export
 irq_map_generic_chip function
In-Reply-To: <1403276487-8792-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1403276487-8792-1-git-send-email-boris.brezillon@free-electrons.com>
 <1403276487-8792-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140621235108.GJ21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 05:01:21PM +0200, Boris BREZILLON wrote:
> Export the generic irq map function in order to provide irq_domain ops with
> generic mapping and specific of xlate function (needed by the new atmel
> AIC driver).
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  include/linux/irq.h       | 2 ++
>  kernel/irq/generic-chip.c | 5 +++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index 0d998d8..62af592 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -771,6 +771,8 @@ void irq_gc_eoi(struct irq_data *d);
>  int irq_gc_set_wake(struct irq_data *d, unsigned int on);
>  
>  /* Setup functions for irq_chip_generic */
> +int irq_map_generic_chip(struct irq_domain *d, unsigned int virq,
> +			 irq_hw_number_t hw_irq);
>  struct irq_chip_generic *
>  irq_alloc_generic_chip(const char *name, int nr_ct, unsigned int irq_base,
>  		       void __iomem *reg_base, irq_flow_handler_t handler);
> diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
> index 452d6f2..cf80e7b 100644
> --- a/kernel/irq/generic-chip.c
> +++ b/kernel/irq/generic-chip.c
> @@ -341,8 +341,8 @@ static struct lock_class_key irq_nested_lock_class;
>  /*
>   * irq_map_generic_chip - Map a generic chip for an irq domain
>   */
> -static int irq_map_generic_chip(struct irq_domain *d, unsigned int virq,
> -				irq_hw_number_t hw_irq)
> +int irq_map_generic_chip(struct irq_domain *d, unsigned int virq,
> +			 irq_hw_number_t hw_irq)
>  {
>  	struct irq_data *data = irq_get_irq_data(virq);
>  	struct irq_domain_chip_generic *dgc = d->gc;
> @@ -394,6 +394,7 @@ static int irq_map_generic_chip(struct irq_domain *d, unsigned int virq,
>  	irq_modify_status(virq, dgc->irq_flags_to_clear, dgc->irq_flags_to_set);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(irq_map_generic_chip);
>  
>  struct irq_domain_ops irq_generic_chip_ops = {
>  	.map	= irq_map_generic_chip,

Why can't you use irq_generic_chip_ops.map in your code and avoid this
patch entirely?

thx,

Jason.
