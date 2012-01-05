From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 5 Jan 2012 10:56:03 -0700
Subject: [PATCH 5/6] gpio: tegra: Dynamically allocate IRQ base, and
 support DT
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17761F16C2@HQMAIL01.nvidia.com>
References: <1325702378-20863-1-git-send-email-swarren@nvidia.com>
 <1325702378-20863-5-git-send-email-swarren@nvidia.com>
 <20120105072306.GA3980@avionic-0098.mockup.avionic-design.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F16C2@HQMAIL01.nvidia.com>
Message-ID: <20120105175603.GA22653@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 09:47:44AM -0800, Stephen Warren wrote:
> Thierry Reding wrote at Thursday, January 05, 2012 12:23 AM:
> > * Stephen Warren wrote:
> > > @@ -343,6 +344,16 @@ static int __devinit tegra_gpio_probe(struct platform_device *pdev)
> > >  	int i;
> > >  	int j;
> > >
> > > +	irq_domain.irq_base = irq_alloc_descs(-1, 0, TEGRA_NR_GPIOS, 0);
> > > +	if (irq_domain.irq_base < 0) {
> > > +		dev_err(&pdev->dev, "Couldn't allocate IRQ numbers\n");
> > > +		return -ENODEV;
> > > +	}
> > > +	irq_domain.nr_irq = TEGRA_NR_GPIOS;
> > > +	irq_domain.ops = &irq_domain_simple_ops;
> > > +	irq_domain.of_node = pdev->dev.of_node;
> > > +	irq_domain_add(&irq_domain);
> > 
> > I was wondering: except for setting the nr_irq field this is pretty much what
> > irq_domain_add_simple() does. While I get that you need access to the domain
> > later on and cannot use the helper, I'm still wondering why the nr_irq field
> > is not initialized by irq_domain_add_simple().
> 
> I'm not completely sure, but I think irq_domain_add_simple() was initially
> added as a transition measure; it looks like all the current users are for
> a single top-level interrupt controller where the Linux IRQ numbers are
> used directly in the .dts files. Once you add other interrupt controllers
> into the mix, the API as-is starts to make less sense.
> 
> > I have a driver for a GPIO/IRQ expander that does exactly the same and was
> > always wondering why the irq_data.hwirq field isn't properly setup, and
> > irq_domain.nr_irq being 0 seems to be exactly the reason. So am I supposed to
> > not use irq_domain_add_simple() in this case or should we rather update the
> > helper to take a nr_irq parameter that can be used to initialize the nr_irq
> > field?
> 
> I think updating the helper like that makes sense, and also have it return
> the IRQ domain object. Grant, do you agree?

Update the helper.

g.
