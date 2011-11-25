From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 25 Nov 2011 14:51:06 +0100
Subject: [PATCH 1/3] ARM: at91/aic: add device tree support for AIC
In-Reply-To: <20111124222601.GA28582@gallagher>
References: <167b5ccfc31d9637186c5201cd83cb62df81fc0f.1322171620.git.nicolas.ferre@atmel.com>
 <20111124222601.GA28582@gallagher>
Message-ID: <20111125135106.GN15531@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:26 Thu 24 Nov     , Jamie Iles wrote:
> Hi Nicolas,
> 
> On Thu, Nov 24, 2011 at 10:56:27PM +0100, Nicolas Ferre wrote:
> > Ioremap registers from DT specification and adding
> > of a simple irq domain for AIC interrupts.
> > 
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > ---
> 
> Apologies if I've missed it somewhere but I think this needs to be 
> documented in Documentation/devicetree.
> 
> [...]
> > diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
> > index be6b639..80783b0 100644
> > --- a/arch/arm/mach-at91/irq.c
> > +++ b/arch/arm/mach-at91/irq.c
> > @@ -24,6 +24,8 @@
> >  #include <linux/module.h>
> >  #include <linux/mm.h>
> >  #include <linux/types.h>
> > +#include <linux/of_address.h>
> > +#include <linux/irqdomain.h>
> >  
> >  #include <mach/hardware.h>
> >  #include <asm/irq.h>
> > @@ -34,6 +36,7 @@
> >  #include <asm/mach/map.h>
> >  
> >  void __iomem *at91_aic_base;
> > +static struct irq_domain at91_aic_domain;
> >  
> >  static void at91_aic_mask_irq(struct irq_data *d)
> >  {
> > @@ -127,14 +130,44 @@ static struct irq_chip at91_aic_chip = {
> >  	.irq_set_wake	= at91_aic_set_wake,
> >  };
> >  
> > +#if defined(CONFIG_OF)
> > +static struct of_device_id aic_ids[]  = {
> > +	{ .compatible = "atmel,at91rm9200-aic" },
> > +	{ /*sentinel*/ }
> > +};
> > +
> > +static int __init at91_aic_of_init(void)
> > +{
> > +	struct device_node *np;
> > +
> > +	np = of_find_matching_node(NULL, aic_ids);
> > +	if (np == NULL)
> > +		return -ENODEV;
> > +
> > +	at91_aic_base = of_iomap(np, 0);
> > +	at91_aic_domain.of_node = np;
> 
> I think this needs to be:
> 
> 	at91_aic_domain.of_node = of_node_get(np);
> 
> to keep the reference count.
> 
> > +	/* Keep refcount of the node */
> > +
> > +	return 0;
> > +}
> > +#else
> > +static int __init at91_aic_of_init(void)
> > +{
> > +	return -ENOSYS;
> > +}
> > +#endif
> 
> I think it's preferred if you use of_irq_init() here as it can handle 
> the ordering of IRQ controllers.  There are GIC and VIC bindings in 
> -next that use this and provide a way for non-DT platforms to still use 
> the drivers.
which is the case here as if the of_init fail we failback to the non-dt init

and this IP is AT91 only

Best Regards,
J.
> 
> >  /*
> >   * Initialize the AIC interrupt controller.
> >   */
> >  void __init at91_aic_init(unsigned int priority[NR_AIC_IRQS])
> >  {
> >  	unsigned int i;
> > +	int ret;
> >  
> > -	at91_aic_base = ioremap(AT91_AIC, 512);
> > +	ret = at91_aic_of_init();
> > +	if (ret < 0)
> > +		at91_aic_base = ioremap(AT91_AIC, 512);
> >  
> >  	if (!at91_aic_base)
> >  		panic("Impossible to ioremap AT91_AIC\n");
> > @@ -169,4 +202,10 @@ void __init at91_aic_init(unsigned int priority[NR_AIC_IRQS])
> >  	/* Disable and clear all interrupts initially */
> >  	at91_aic_write(AT91_AIC_IDCR, 0xFFFFFFFF);
> >  	at91_aic_write(AT91_AIC_ICCR, 0xFFFFFFFF);
> > +
> > +	/* Add irq domain for AIC */
> > +	at91_aic_domain.irq_base = at91_aic_domain.hwirq_base = 0;
> > +	at91_aic_domain.nr_irq = NR_AIC_IRQS;
> > +	at91_aic_domain.ops = &irq_domain_simple_ops;
> 
> irq_domain_simple_ops is only exported when CONFIG_OF_IRQ=y, so this 
> probably won't work for !CONFIG_USE_OF.
so we need to use 
	if (IS_BUILT_IN(CONFIG_USE_OF)) {
	}


Best Regards,
J.
