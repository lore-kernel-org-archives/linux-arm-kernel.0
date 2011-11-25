From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 25 Nov 2011 15:28:17 +0000
Subject: [PATCH 1/3] ARM: at91/aic: add device tree support for AIC
In-Reply-To: <20111125135106.GN15531@game.jcrosoft.org>
References: <167b5ccfc31d9637186c5201cd83cb62df81fc0f.1322171620.git.nicolas.ferre@atmel.com>
 <20111124222601.GA28582@gallagher>
 <20111125135106.GN15531@game.jcrosoft.org>
Message-ID: <20111125152817.GA8866@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2011 at 02:51:06PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 22:26 Thu 24 Nov     , Jamie Iles wrote:
> > Hi Nicolas,
> > On Thu, Nov 24, 2011 at 10:56:27PM +0100, Nicolas Ferre wrote:
[...]
> > > +#if defined(CONFIG_OF)
> > > +static struct of_device_id aic_ids[]  = {
> > > +	{ .compatible = "atmel,at91rm9200-aic" },
> > > +	{ /*sentinel*/ }
> > > +};
> > > +
> > > +static int __init at91_aic_of_init(void)
> > > +{
> > > +	struct device_node *np;
> > > +
> > > +	np = of_find_matching_node(NULL, aic_ids);
> > > +	if (np == NULL)
> > > +		return -ENODEV;
> > > +
> > > +	at91_aic_base = of_iomap(np, 0);
> > > +	at91_aic_domain.of_node = np;
> > 
> > I think this needs to be:
> > 
> > 	at91_aic_domain.of_node = of_node_get(np);
> > 
> > to keep the reference count.
> > 
> > > +	/* Keep refcount of the node */
> > > +
> > > +	return 0;
> > > +}
> > > +#else
> > > +static int __init at91_aic_of_init(void)
> > > +{
> > > +	return -ENOSYS;
> > > +}
> > > +#endif
> > 
> > I think it's preferred if you use of_irq_init() here as it can handle 
> > the ordering of IRQ controllers.  There are GIC and VIC bindings in 
> > -next that use this and provide a way for non-DT platforms to still use 
> > the drivers.
> which is the case here as if the of_init fail we failback to the non-dt init
> 
> and this IP is AT91 only

Right, but it's not using the of_irq_init() interface which is the 
standard way of registering interrupt controllers and will correctly 
dependencies for you.

So if you could have something like:

void __init __at91_aic_init(unsigned int priority[NR_AIC_IRQS],
			    void __iomem *regs,
			    struct device_node *np)
{
	/*
	 * Do all of the writes to the AIC itself and configure 
	 * the IRQ domain.
	 */
}

void __init at91_aic_init(unsigned int priority[NR_AIC_IRQS])
{
	void __iomem *base = ioremap(AT91_AIC, 512);

	__at91_aic_init(priority, base, NULL);
}

int __init at91_aic_of_init(struct device_node *node,
			    struct device_node *parent)
{
	void __iomem *regs = of_iomap(node, 0);

	/*
	 * Get priorities from the DT.  If this was an array of cells 
	 * then that should be okay.
	 */
	__at91_aic_init(dt_priorities, regs, node);
}

Then the DT based board initialisation can do:

static const struct of_device_id at91_irq_of_match[] __initconst = {
	{ .compatible = "atmel,at91-aic", .data = at91_aic_of_init },
	{}
};

static void __init at91_of_irq_init(void)
{
	of_irq_init(at91_of_irq_init);
}

Which is consistent with other platforms.  However this does require 
that the priorities are encoded in the device-tree, but I guess that's a 
good thing anyway isn't it?

Jamie
