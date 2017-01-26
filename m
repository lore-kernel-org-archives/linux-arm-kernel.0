From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 26 Jan 2017 13:48:14 +0000
Subject: [PATCH V11 2/3] ACPI: Add support for ResourceSource/IRQ domain
 mapping
In-Reply-To: <6275442.KC3JtHKUN3@aspire.rjw.lan>
References: <1484879660-1960-1-git-send-email-agustinv@codeaurora.org>
 <CAHp75VeYxfuMuaZCMk+MYdxLTs7cCa6j6M7Ot3XnwMmeHP7kBA@mail.gmail.com>
 <20170126101521.GA10324@red-moon>
 <6275442.KC3JtHKUN3@aspire.rjw.lan>
Message-ID: <20170126134814.GA1194@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 11:43:43AM +0100, Rafael J. Wysocki wrote:
> On Thursday, January 26, 2017 10:15:21 AM Lorenzo Pieralisi wrote:
> > On Thu, Jan 26, 2017 at 03:01:18AM +0200, Andy Shevchenko wrote:
> > > On Fri, Jan 20, 2017 at 4:34 AM, Agustin Vega-Frias
> > > <agustinv@codeaurora.org> wrote:
> > > > ACPI extended IRQ resources may contain a ResourceSource to specify
> > > > an alternate interrupt controller. Introduce acpi_irq_get and use it
> > > > to implement ResourceSource/IRQ domain mapping.
> > > >
> > > > The new API is similar to of_irq_get and allows re-initialization
> > > > of a platform resource from the ACPI extended IRQ resource, and
> > > > provides proper behavior for probe deferral when the domain is not
> > > > yet present when called.
> > > 
> > > > +static struct fwnode_handle *
> > > > +acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source)
> > > > +{
> > > > +       struct fwnode_handle *result = NULL;
> > > > +       struct acpi_device *device;
> > > > +       struct acpi_hardware_id *hwid;
> > > > +       struct acpi_device_id *devid;
> > > > +       acpi_handle handle;
> > > > +       acpi_status status;
> > > > +
> > > > +       if (!source->string_length)
> > > > +               return acpi_gsi_domain_id;
> > > > +
> > > > +       status = acpi_get_handle(NULL, source->string_ptr, &handle);
> > > > +       if (WARN_ON(ACPI_FAILURE(status)))
> > > > +               return NULL;
> > > > +
> > > > +       device = acpi_bus_get_acpi_device(handle);
> > > > +       if (WARN_ON(!device))
> > > > +               return NULL;
> > > > +
> > > 
> > > > +       list_for_each_entry(hwid, &device->pnp.ids, list) {
> > > 
> > > > +               for (devid = &__dsdt_irqchip_acpi_probe_table;
> > > > +                    devid < &__dsdt_irqchip_acpi_probe_table_end; devid++) {
> > > > +                       if (devid->id && !strcmp(devid->id, hwid->id)) {
> > > > +                               result = &device->fwnode;
> > > > +                               break;
> > > > +                       }
> > > > +               }
> > > 
> > > Looks like a candidate for linker table API. (I recommend to Cc Luis
> > > for this part)
> > 
> > This linker table entry scheme is just an optimization and should
> > not gate the series.
> > 
> > > > +       }
> > > 
> > > > +/**
> > > > + * acpi_irq_parse_one_match - Handle a matching IRQ resource.
> > > > + * @fwnode: matching fwnode
> > > > + * @hwirq: hardware IRQ number
> > > > + * @triggering: triggering attributes of hwirq
> > > > + * @polarity: polarity attributes of hwirq
> > > > + * @polarity: polarity attributes of hwirq
> > > > + * @shareable: shareable attributes of hwirq
> > > > + * @ctx: acpi_irq_parse_one_ctx updated by this function
> > > > + *
> > > > + * Description:
> > > > + * Handle a matching IRQ resource by populating the given ctx with
> > > > + * the information passed.
> > > > + */
> > > > +static inline void acpi_irq_parse_one_match(struct fwnode_handle *fwnode,
> > > > +                                           u32 hwirq, u8 triggering,
> > > > +                                           u8 polarity, u8 shareable,
> > > > +                                           struct acpi_irq_parse_one_ctx *ctx)
> > > > +{
> > > 
> > > > +       if (!fwnode)
> > > > +               return;
> > > 
> > > > +       ctx->rc = 0;
> > > 
> > > Perhaps ctx->rc = fwnode ? 0 : -EINVAL; ?
> > > 
> > > > +       *ctx->res_flags = acpi_dev_irq_flags(triggering, polarity, shareable);
> > > > +       ctx->fwspec->fwnode = fwnode;
> > > > +       ctx->fwspec->param[0] = hwirq;
> > > > +       ctx->fwspec->param[1] = acpi_dev_get_irq_type(triggering, polarity);
> > > > +       ctx->fwspec->param_count = 2;
> > > > +}
> > > 
> > > > +int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res)
> > > > +{
> > > > +       struct irq_fwspec fwspec;
> > > > +       struct irq_domain *domain;
> > > > +       unsigned long flags;
> > > > +       int rc;
> > > > +
> > > > +       rc = acpi_irq_parse_one(handle, index, &fwspec, &flags);
> > > > +       if (rc)
> > > > +               return rc;
> > > > +
> > > > +       domain = irq_find_matching_fwnode(fwspec.fwnode, DOMAIN_BUS_ANY);
> > > > +       if (!domain)
> > > > +               return -EPROBE_DEFER;
> > > > +
> > > > +       rc = irq_create_fwspec_mapping(&fwspec);
> > > > +       if (rc <= 0)
> > > 
> > > Is rc = 0 an error?
> > 
> > Yes.
> > 
> > > > +               return -EINVAL;
> > > > +
> > > > +       res->start = rc;
> > > > +       res->end = rc;
> > > > +       res->flags = flags;
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(acpi_irq_get);
> > > 
> > > > --- a/drivers/base/platform.c
> > > > +++ b/drivers/base/platform.c
> > > > @@ -102,6 +102,14 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
> > > 
> > > >         r = platform_get_resource(dev, IORESOURCE_IRQ, num);
> > > > +       if (r && r->flags & IORESOURCE_DISABLED && has_acpi_companion(&dev->dev)) {
> > > > +               int ret;
> > > > +
> > > > +               ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
> > > > +               if (ret)
> > > > +                       return ret;
> > > > +       }
> > > 
> > > > +#ifdef CONFIG_ACPI_GENERIC_GSI
> > > 
> > > #if IS_ENABLED()
> > > 
> > > > +int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res);
> > > > +#else
> > > > +static inline int acpi_irq_get(acpi_handle handle, unsigned int index,
> > > > +                              struct resource *res)
> > > 
> > > Perhaps
> > > 
> > > static inline
> > > int ...
> > 
> > It is late -rc5 and notwithstanding cosmetics changes, can we make
> > progress with this patch series or not please ?
> 
> Yes, we can.
> 
> I've just returned from travels and have not had the time to look at things in
> detail yet.
> 
> I sent a notice about my travel in advance specifically so people didn't expect
> me to respond while I was traveling, but obviously everybody simply ignored it
> and went ahead with their lives.  And then I get messages like this which
> doesn't make me happy at all.

I had to ask given that there are other series that depend on it and
that this code will eventually have to go via a tree that is not ACPI,
so that will require some coordination and it is getting late in the
cycle, that's all my message was meant for, apologies.

> I will start processing things shortly, but there is a backlog I need to work
> through and this one may not be the first item in it.

Ok no problems then, thank you !

Lorenzo
