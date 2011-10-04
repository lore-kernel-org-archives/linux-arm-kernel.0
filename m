From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 4 Oct 2011 17:39:53 -0600
Subject: [PATCH 1/3] irq: support domains with non-zero hwirq base
In-Reply-To: <1317410880-24828-2-git-send-email-robherring2@gmail.com>
References: <1317410880-24828-1-git-send-email-robherring2@gmail.com>
	<1317410880-24828-2-git-send-email-robherring2@gmail.com>
Message-ID: <20111004233953.GE3009@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 02:27:58PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Interrupt controllers can have non-zero starting value for h/w irq numbers.
> Adding support in irq_domain allows the domain hwirq numbering to match
> the interrupt controllers' numbering.
> 
> As this makes looping over irqs for a domain more complicated, add loop
> iterators to iterate over all hwirqs and irqs for a domain.
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  include/linux/irqdomain.h |   16 +++++++++++++++-
>  kernel/irq/irqdomain.c    |   12 ++++++------
>  2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 3ad553e..c0026b6 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -47,6 +47,7 @@ struct irq_domain_ops {
>   *            of the irq_domain is responsible for allocating the array of
>   *            irq_desc structures.
>   * @nr_irq: Number of irqs managed by the irq domain
> + * @hwirq_base: Starting number for hwirqs managed by the irq domain
>   * @ops: pointer to irq_domain methods
>   * @priv: private data pointer for use by owner.  Not touched by irq_domain
>   *        core code.
> @@ -57,6 +58,7 @@ struct irq_domain {
>  	struct list_head list;
>  	unsigned int irq_base;
>  	unsigned int nr_irq;
> +	unsigned int hwirq_base;
>  	const struct irq_domain_ops *ops;
>  	void *priv;
>  	struct device_node *of_node;
> @@ -72,9 +74,21 @@ struct irq_domain {
>  static inline unsigned int irq_domain_to_irq(struct irq_domain *d,
>  					     unsigned long hwirq)
>  {
> -	return d->ops->to_irq ? d->ops->to_irq(d, hwirq) : d->irq_base + hwirq;
> +	if (d->ops->to_irq)
> +		return d->ops->to_irq(d, hwirq);
> +	if (hwirq < d->hwirq_base)
> +		return NO_IRQ;

NO_IRQ is probably not available on x86.  Also, if this condition
is hit then something is definitely wrong.  You should WARN() and
return 0.

Otherwise looks good and you can add my a-b:

Acked-by: Grant Likely <grant.likely@secretlab.ca>
