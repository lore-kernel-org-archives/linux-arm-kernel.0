From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 1 Dec 2011 14:11:12 +0000
Subject: [PATCH 2/2] gpio/tegra: Dynamically allocate IRQ base, and
 support DT
In-Reply-To: <4ED78461.40006@gmail.com>
References: <1322700336-26866-1-git-send-email-swarren@nvidia.com>
 <1322700336-26866-2-git-send-email-swarren@nvidia.com>
 <4ED78461.40006@gmail.com>
Message-ID: <20111201141112.GG4556@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2011 at 07:42:57AM -0600, Rob Herring wrote:
> On 11/30/2011 06:45 PM, Stephen Warren wrote:
> > Enhance  the driver to dynamically allocate the base IRQ number, and
> > create an IRQ domain for itself. The use of an IRQ domain ensures that
> > any device tree node interrupts properties are correctly parsed.
> > 
> > Fix the DT binding documentation to describe interrupt-related properties,
> > and the contents of "child" node interrupts property.
> > 
> > Update tegra20.dtsi to specify the required interrupt-related properties.
> > 
> > Finally, remove the definition of TEGRA_GPIO_TO_IRQ; this macro no longer
> > gives correct results since the IRQ numbers for GPIOs are dynamically
> > allocated.
> > 
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
[...]
> >  static int tegra_gpio_irq_set_type(struct irq_data *d, unsigned int type)
> >  {
> > -	int gpio = d->irq - INT_GPIO_BASE;
> > +	int gpio = d->hwirq;
> >  	struct tegra_gpio_bank *bank = irq_data_get_irq_chip_data(d);
> >  	int port = GPIO_PORT(gpio);
> >  	int lvl_type;
> > @@ -343,6 +345,22 @@ static int __devinit tegra_gpio_probe(struct platform_device *pdev)
> >  	int i;
> >  	int j;
> >  
> > +	irq_domain.irq_base = irq_alloc_descs(-1, 0, TEGRA_NR_GPIOS, 0);
> > +	if (irq_domain.irq_base < 0) {
> > +		dev_err(&pdev->dev, "Couldn't allocate IRQ numbers\n");
> > +		return -ENODEV;
> > +	}
> > +	irq_domain.nr_irq = TEGRA_NR_GPIOS;
> > +	irq_domain.ops = &irq_domain_ops;
> 
> Why don't you just use irq_domain_simple_ops?

This would need the patch I posted earlier 
(https://lkml.org/lkml/2011/12/1/109) so they can work for the 
!CONFIG_OF case ;-)

Jamie
