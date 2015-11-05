From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Thu, 5 Nov 2015 08:25:50 +0000
Subject: [PATCH RFC 7/7] irqchip: [Example] dummy wired interrupt/MSI
 bridge driver
In-Reply-To: <5639C9F9.2010704@arm.com>
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
 <1444923568-17413-8-git-send-email-marc.zyngier@arm.com>
 <5639BB10.1090108@huawei.com> <5639C9F9.2010704@arm.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1629D8DD@lhreml503-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc

> -----Original Message-----
> From: linux-pci-owner at vger.kernel.org [mailto:linux-pci-owner at vger.kernel.org]
> On Behalf Of Marc Zyngier
> Sent: 04 November 2015 09:04
> To: majun (F); Thomas Gleixner; Jiang Liu; Jason Cooper
> Cc: linux-arm-kernel at lists.infradead.org; linux-pci at vger.kernel.org; linux-
> kernel at vger.kernel.org
> Subject: Re: [PATCH RFC 7/7] irqchip: [Example] dummy wired interrupt/MSI
> bridge driver
> 
> On 04/11/15 08:00, majun (F) wrote:
> > Hi Marc:
> >
> > ? 2015/10/15 23:39, Marc Zyngier ??:
> >> In order to demonstrate how to put together a wire/MSI bridge,
> >> add a dummy driver that doesn't do anything at all, except
> >> for allocating interrupts.
> >>
> >> It comes together with an even more stupid client driver that
> >> allocates an interrupt and dump the hierarchy of that interrupt.
> >>
> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >> ---
> > [...]
> >> +
> >> +static int msichip_domain_alloc(struct irq_domain *domain, unsigned int
> virq,
> >> +				   unsigned int nr_irqs, void *arg)
> >> +{
> >> +	int i, err;
> >> +	irq_hw_number_t hwirq;
> >> +	unsigned int type;
> >> +	struct irq_fwspec *fwspec = arg;
> >> +	void *data;
> >> +
> >> +	err = msichip_domain_translate(domain, fwspec, &hwirq, &type);
> >> +	if (err)
> >> +		return err;
> >> +
> >
> > .translate function already called once in  irq_domain_translate(),
> > I think we don't need call this fucntion one more time here.
> 
> if you don't translate it here, how do you obtain the hwirq that you
> have to pass to irq_domain_set_hwirq_and_chip just below?
> 
> >> +	err = platform_msi_domain_alloc(domain, virq, nr_irqs);
> >> +	if (err)
> >> +		return err;
> >> +
> >> +	data = platform_msi_get_host_data(domain);
> >> +	for (i = 0; i < nr_irqs; i++)
> >> +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> >> +					      &msichip_chip, data);
> >> +
> >> +	return 0;
> >> +}
> >> +
> > [...]
> >> +
> >> +static struct platform_driver msichip_driver = {
> >> +	.driver = {
> >> +		.name		= "msichip",
> >> +		.of_match_table	= msichip_of_match,
> >> +	},
> >> +	.probe			= msichip_probe,
> >> +};
> >> +/* Do not define this as an irqchip */
> >> +module_platform_driver(msichip_driver);
> >> +
> >> +
> >
> > I think,for a interrupt controller, msichip driver initialization maybe is
> too late
> > for some devices which connect to this irqchip if we use
> module_platform_driver.
> 
> That's a consequence of this design. This is why I insisted on the fact
> that this is currently avoided by using deferred probe in drivers, and

Mmm using te deferred probe would mean to rework all the drivers of the
potential devices connected to mbi-gen...would that be sustainable/acceptable?

> that it should be solved by having a probe order. Either way, this is
> not something that we can solve at that level (see the multiple proposal
> for this on the various lists).

Could you point me to the relevant discussions for this...?

Thanks

Gab

> 
> > So, how about use the arch_initcall to register the msichip driver?
> 
> You're only pushing the problem one level up. And you'll realize that
> this is not enough for some random driver. This is not sustainable, and
> must be addressed properly.
> 
> Thanks,
> 
> 	M.
> --
> Jazz is not dead. It just smells funny...
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
