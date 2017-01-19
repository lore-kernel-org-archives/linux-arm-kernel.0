From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Thu, 19 Jan 2017 11:14:34 -0500
Subject: [PATCH V10 2/3] ACPI: Add support for ResourceSource/IRQ domain
 mapping
In-Reply-To: <20170119123608.GA3431@red-moon>
References: <1484766276-9668-1-git-send-email-agustinv@codeaurora.org>
 <CAHp75Vem=mCOGVoOpCJFYHcO17mJ9gexsQxa0Pjf4Lbt3hibRA@mail.gmail.com>
 <20170119123608.GA3431@red-moon>
Message-ID: <cb200409ff636b220a89b1ee8aa1a599@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-01-19 07:36, Lorenzo Pieralisi wrote:
> On Wed, Jan 18, 2017 at 09:45:56PM +0200, Andy Shevchenko wrote:
> 
> [...]
> 
>> > +/**
>> > + * acpi_irq_get - Look for the ACPI IRQ resource with the given index and
>> > + *                use it to initialize the given Linux IRQ resource.
>> > + * @handle ACPI device handle
>> > + * @index  ACPI IRQ resource index to lookup
>> > + * @res    Linux IRQ resource to initialize
>> 
>> Ah, you missed colons after field names:
>> * @field1:
>> 
>> > + *
>> > + * Return:
>> 
>> Next line:  0 on success
>> 
>> > + *         -EINVAL if an error occurs
>> > + *         -EPROBE_DEFER if the IRQ lookup/conversion failed
>> > + */
>> > +int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res)
>> > +{
>> 
>> > +       int rc;
>> 
>> Put this last in the definition block.
>> 
>> > +       struct irq_fwspec fwspec;
>> > +       struct irq_domain *domain;
>> > +       unsigned long flags;
>> > +
>> > +       rc = acpi_irq_parse_one(handle, index, &fwspec, &flags);
>> > +       if (rc)
>> > +               return rc;
>> > +
>> > +       domain = irq_find_matching_fwnode(fwspec.fwnode, DOMAIN_BUS_ANY);
>> > +       if (!domain)
>> > +               return -EPROBE_DEFER;
>> 
>> Hmm... Could it be other issues here?
> 
> That's a good point. Here probing should be deferred only if we know a
> driver capable of handling fwspec.fwnode will have a chance to be
> probed/initialized eventually right (which basically means it is
> compiled in the kernel and we hope it will probed successfully) ? I am
> not sure there is an easy way to detect that in ACPI at the moment, I
> suspect it is time we added a linker section (or augment the existing
> one used for irqchip early MADT parsing - IRQCHIP_ACPI_DECLARE) for 
> this
> purpose I do not see any other option (apart from leaving devices in 
> the
> deferred probe list if a driver for the irqchip represented by
> fwspec.fwnode is not present in the kernel, which is a bit sloppy, or
> resorting to checking Kconfig entries to detect compile time enabled
> irqchip drivers).

I'll add the linker section suggested by Lorenzo for the extra check.
We can do that check in acpi_get_irq_source_fwhandle and make the lookup
fail if the device is not listed in the table.

That way we can keep this check as-is.

Thoughts?

> 
>> > +
>> > +       rc = irq_create_fwspec_mapping(&fwspec);
>> > +       if (rc <= 0)
>> > +               return -EINVAL;
>> > +
>> 
>> > +       res->start = rc;
>> > +       res->end = rc;
>> > +       res->flags = flags;
>> 
>> Perhaps struct resource *r should be a parameter to 
>> acpi_irq_parse_one().
> 
> Yeah but then you would end up with flags initialized in
> acpi_irq_parse_one() and the other resource params (ie start, end) 
> here,
> I do not think it is nicer.

The reason this took this form is that we are trying to get some 
symmetry
with what of_irq_get does.

Thanks,
Agustin

> 
> Thanks,
> Lorenzo
> 
> [...]
> 
>> 
>> With Best Regards,
>> Andy Shevchenko

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
