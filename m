From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 5 Jan 2012 11:02:18 -0700
Subject: [PATCH v4 1/6] ARM: at91/aic: add irq domain and device tree
 support
In-Reply-To: <4F05CF48.5050007@atmel.com>
References: <1323976568-20244-1-git-send-email-nicolas.ferre@atmel.com>
 <85d531b5686e5eff623bed9618f802198409905f.1323975517.git.nicolas.ferre@atmel.com>
 <20120104194059.GY15503@ponder.secretlab.ca>
 <4F05CF48.5050007@atmel.com>
Message-ID: <20120105180218.GC22653@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 05:26:48PM +0100, Nicolas Ferre wrote:
> Hi Grant,
> 
> Thanks for your review.
> 
> Some answer following...
> 
> On 01/04/2012 08:40 PM, Grant Likely :
> 
> [..]
> 
> >> --- a/arch/arm/mach-at91/irq.c
> >> +++ b/arch/arm/mach-at91/irq.c
> >> @@ -24,6 +24,10 @@
> >>  #include <linux/module.h>
> >>  #include <linux/mm.h>
> >>  #include <linux/types.h>
> >> +#include <linux/of_address.h>
> >> +#include <linux/of_irq.h>
> >> +#include <linux/irqdomain.h>
> >> +#include <linux/err.h>
> >>  
> >>  #include <mach/hardware.h>
> >>  #include <asm/irq.h>
> >> @@ -34,22 +38,28 @@
> >>  #include <asm/mach/map.h>
> >>  
> >>  void __iomem *at91_aic_base;
> >> +static struct irq_domain at91_aic_domain;
> >> +
> >> +static inline unsigned int aic_irq(struct irq_data *d)
> >> +{
> >> +	return d->hwirq;
> >> +}
> > 
> > This is a useless macro.  Drop it.
> 
> Ok. That was overkill ;-)
> 
> [..]
> 
> >> @@ -90,13 +100,13 @@ static u32 backups;
> >>  
> >>  static int at91_aic_set_wake(struct irq_data *d, unsigned value)
> >>  {
> >> -	if (unlikely(d->irq >= 32))
> >> +	if (unlikely(aic_irq(d) >= at91_aic_domain.nr_irq))
> > I don't think you need to derefernce the irq_domain.nr_irq here.  Just
> > keep the test for >= 32.
> 
> Well I would like to keep it referring to this value as we may increase
> the number of irq handled by this controller in the future...
> 
> [..]
> 
> >> +#if defined(CONFIG_OF)
> >> +static int __init __at91_aic_of_init(struct device_node *node,
> >> +				     struct device_node *parent)
> >> +{
> >> +	at91_aic_base = of_iomap(node, 0);
> >> +	at91_aic_domain.of_node = of_node_get(node);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct of_device_id aic_ids[] __initconst = {
> >> +	{ .compatible = "atmel,at91rm9200-aic", .data = __at91_aic_of_init },
> >> +	{ /*sentinel*/ }
> >> +};
> >> +
> >> +static void __init at91_aic_of_init(void)
> >> +{
> >> +	of_irq_init(aic_ids);
> >> +}
> >> +#else
> >> +static void __init at91_aic_of_init(void) {}
> >> +#endif
> >> +
> >>  /*
> >>   * Initialize the AIC interrupt controller.
> >>   */
> >>  void __init at91_aic_init(unsigned int priority[NR_AIC_IRQS])
> >>  {
> >>  	unsigned int i;
> >> +	int hwirq, irq;
> >>  
> >> -	at91_aic_base = ioremap(AT91_AIC, 512);
> >> +	if(of_have_populated_dt())
> >> +		at91_aic_of_init();
> >> +	else
> >> +		at91_aic_base = ioremap(AT91_AIC, 512);
> >>  
> >>  	if (!at91_aic_base)
> >> -		panic("Impossible to ioremap AT91_AIC\n");
> >> +		panic("Unable to ioremap AIC registers\n");
> >> +
> >> +	/* Add irq domain for AIC */
> >> +	at91_aic_domain.nr_irq = NR_AIC_IRQS;
> >> +	at91_aic_domain.irq_base = irq_alloc_descs(-1, AIC_BASE_IRQ,
> >> +						at91_aic_domain.nr_irq, 0);
> >> +	if (IS_ERR_VALUE(at91_aic_domain.irq_base)) {
> >> +		WARN(1, "Cannot allocate irq_descs, assuming pre-allocated\n");
> >> +		at91_aic_domain.irq_base = AIC_BASE_IRQ;
> >> +	}
> >> +	at91_aic_domain.ops = &irq_domain_simple_ops;
> >> +	irq_domain_add(&at91_aic_domain);
> > 
> > Nothing special is being done with the irq domain.  Please use
> > irq_domain_add_simple().  It will make things easier for the next
> > round of irq_domain patches that I'm getting ready to post.
> 
> Fair enough, but I have one question: how do I specify "nr_irq" in the
> domain created by irq_domain_add_simple()? Maybe it is not needed?

Fix the irq_domain_add_simple() helper to accept a nr_irq parameter.  :-)

g.
