From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 19 Jan 2017 12:36:08 +0000
Subject: [PATCH V10 2/3] ACPI: Add support for ResourceSource/IRQ domain
 mapping
In-Reply-To: <CAHp75Vem=mCOGVoOpCJFYHcO17mJ9gexsQxa0Pjf4Lbt3hibRA@mail.gmail.com>
References: <1484766276-9668-1-git-send-email-agustinv@codeaurora.org>
 <CAHp75Vem=mCOGVoOpCJFYHcO17mJ9gexsQxa0Pjf4Lbt3hibRA@mail.gmail.com>
Message-ID: <20170119123608.GA3431@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 09:45:56PM +0200, Andy Shevchenko wrote:

[...]

> > +/**
> > + * acpi_irq_get - Look for the ACPI IRQ resource with the given index and
> > + *                use it to initialize the given Linux IRQ resource.
> > + * @handle ACPI device handle
> > + * @index  ACPI IRQ resource index to lookup
> > + * @res    Linux IRQ resource to initialize
> 
> Ah, you missed colons after field names:
> * @field1:
> 
> > + *
> > + * Return:
> 
> Next line:  0 on success
> 
> > + *         -EINVAL if an error occurs
> > + *         -EPROBE_DEFER if the IRQ lookup/conversion failed
> > + */
> > +int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res)
> > +{
> 
> > +       int rc;
> 
> Put this last in the definition block.
> 
> > +       struct irq_fwspec fwspec;
> > +       struct irq_domain *domain;
> > +       unsigned long flags;
> > +
> > +       rc = acpi_irq_parse_one(handle, index, &fwspec, &flags);
> > +       if (rc)
> > +               return rc;
> > +
> > +       domain = irq_find_matching_fwnode(fwspec.fwnode, DOMAIN_BUS_ANY);
> > +       if (!domain)
> > +               return -EPROBE_DEFER;
> 
> Hmm... Could it be other issues here?

That's a good point. Here probing should be deferred only if we know a
driver capable of handling fwspec.fwnode will have a chance to be
probed/initialized eventually right (which basically means it is
compiled in the kernel and we hope it will probed successfully) ? I am
not sure there is an easy way to detect that in ACPI at the moment, I
suspect it is time we added a linker section (or augment the existing
one used for irqchip early MADT parsing - IRQCHIP_ACPI_DECLARE) for this
purpose I do not see any other option (apart from leaving devices in the
deferred probe list if a driver for the irqchip represented by
fwspec.fwnode is not present in the kernel, which is a bit sloppy, or
resorting to checking Kconfig entries to detect compile time enabled
irqchip drivers).

> > +
> > +       rc = irq_create_fwspec_mapping(&fwspec);
> > +       if (rc <= 0)
> > +               return -EINVAL;
> > +
> 
> > +       res->start = rc;
> > +       res->end = rc;
> > +       res->flags = flags;
> 
> Perhaps struct resource *r should be a parameter to acpi_irq_parse_one().

Yeah but then you would end up with flags initialized in
acpi_irq_parse_one() and the other resource params (ie start, end) here,
I do not think it is nicer.

Thanks,
Lorenzo

> 
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_irq_get);
> > +
> > +/**
> >   * acpi_set_irq_model - Setup the GSI irqdomain information
> >   * @model: the value assigned to acpi_irq_model
> >   * @fwnode: the irq_domain identifier for mapping and looking up
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index c4af003..61423d2 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -102,6 +102,14 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
> >         }
> >
> >         r = platform_get_resource(dev, IORESOURCE_IRQ, num);
> > +       if (r && r->flags & IORESOURCE_DISABLED && ACPI_COMPANION(&dev->dev)) {
> 
> has_acpi_companion() ?
> 
> > +               int ret;
> > +
> > +               ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
> > +               if (ret)
> > +                       return ret;
> > +       }
> 
> > @@ -1450,4 +1458,3 @@ void __init early_platform_cleanup(void)
> >                 memset(&pd->dev.devres_head, 0, sizeof(pd->dev.devres_head));
> >         }
> >  }
> > -
> 
> It doesn't belong here.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
