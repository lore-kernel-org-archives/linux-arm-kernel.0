From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 25 Nov 2016 11:40:35 +0000
Subject: [PATCH V7 2/3] ACPI: Add support for ResourceSource/IRQ domain
 mapping
In-Reply-To: <20161124161548.GA11766@red-moon>
References: <1479074375-2629-1-git-send-email-agustinv@codeaurora.org>
 <1479074375-2629-3-git-send-email-agustinv@codeaurora.org>
 <20161124161548.GA11766@red-moon>
Message-ID: <20161125114035.GA13739@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Agustin,

On Thu, Nov 24, 2016 at 04:15:48PM +0000, Lorenzo Pieralisi wrote:

[...]

> > @@ -448,6 +449,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
> >  {
> >  	struct acpi_resource_irq *irq;
> >  	struct acpi_resource_extended_irq *ext_irq;
> > +	struct fwnode_handle *src;
> >  
> >  	switch (ares->type) {
> >  	case ACPI_RESOURCE_TYPE_IRQ:
> > @@ -460,7 +462,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
> >  			acpi_dev_irqresource_disabled(res, 0);
> >  			return false;
> >  		}
> > -		acpi_dev_get_irqresource(res, irq->interrupts[index],
> > +		acpi_dev_get_irqresource(res, irq->interrupts[index], NULL,
> >  					 irq->triggering, irq->polarity,
> >  					 irq->sharable, true);
> >  		break;
> > @@ -470,7 +472,8 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
> >  			acpi_dev_irqresource_disabled(res, 0);
> >  			return false;
> >  		}
> > -		acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
> > +		src = acpi_get_irq_source_fwhandle(&ext_irq->resource_source);
> 
> Is there a reason why we need to do the domain look-up here ?
> 
> I would like to understand if, by reshuffling the code (and by returning
> the resource_source to the calling code - somehow), it would be possible
> to just mirror what the OF code does in of_irq_get(), namely:
> 
> (1) parse the irq entry -> of_irq_parse_one()
> (2) look the domain up -> irq_find_host()
> (3) create the mapping -> irq_create_of_mapping()
> 
> You wrote the code already, I think it is just a matter of shuffling
> it around (well, minus returning the resource_source to the caller
> which is phandle equivalent in DT).
> 
> You abstracted away (2) and (3) behind acpi_register_irq(), that
> on anything than does not use ACPI_GENERIC_GSI is just glue code
> to acpi_register_gsi().
> 
> Also, it is not a question on this patch but I ask it here because it
> is related. On ACPI you are doing the reverse of what is done in
> DT in platform_get_irq():
> 
> - get the resources already parsed -> platform_get_resource()
> - if they are disabled -> acpi_irq_get()
> 
> and I think the ordering is tied to my question above because
> you carry out the domain look up in acpi_dev_resource_interrupt()
> so that if for any reason it fails the corresponding resource
> is disabled so that we try to get it again through acpi_irq_get().
> 
> I suspect you did it this way to make sure:
> 
> a) keep the current ACPI IRQ parsing interface changes to a mininum
> b) avoid changing the behaviour on x86/ia64; in particular, calling
>    acpi_register_gsi() for the _same_ mapping (an IRQ that was already
>    registered at device creation resource parsing) multiple times can
>    trigger issues on x86/ia64
> 
> I think that's a reasonable approach but I wanted to get these
> clarifications, I do not think you are far from getting this
> done but since it is a significant change I think it is worth
> discussing the points I raised above because I think the DT code
> sequence in of_irq_get() (1-2-3 above) is cleaner from an IRQ
> layer perspective (instead of having the domain look-up buried
> inside the ACPI IRQ resource parsing API).

I had another look and to achieve the above one way of doing that is to
implement acpi_irq_get() only for ACPI_GENERIC_GSI and stub it out for
!ACPI_GENERIC_GSI (ie return an error code so that on !ACPI_GENERIC_GSI
we would fall back to current solution for ACPI). Within acpi_irq_get()
you can easily carry out the same steps (1->2->3) above in ACPI you have
the code already there I think it is easy to change the
acpi_irq_get_cb() interface to return a filled in struct irq_fwspec and
the interface would become identical to of_irq_get() that is an
advantage to maintain it from an IRQ maintainership perspective I think,
that's my opinion.

There is still a nagging snag though. When platform devices are
created, core ACPI code parse the resources through:

acpi_dev_get_resources()

and we _have_ to have way to avoid initializing IRQ resources that
have a dependency (ie there is a resource_source pointer that is valid
in their descriptors) that's easy to do if we think that's the right
thing to do and can hardly break current code (which ignores the
resource_source altogether).

It is an important difference with DT probing, where the IRQ
resources are only created if the domain reference (ie interrupt
controller phandle) is satisfied at of_device_alloc() time
(see of_device_alloc()).

Thoughts ? Please let me know, the code to implement what I say
is already in these patches, it is just a matter of reshuffling it.

Thanks !
Lorenzo
