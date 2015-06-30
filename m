From: gg@slimlogic.co.uk (Graeme Gregory)
Date: Tue, 30 Jun 2015 16:07:19 +0100
Subject: [PATCH v2 6/9] irqchip / gic: Add stacked irqdomain support for
 ACPI based GICv2 init
In-Reply-To: <559288CA.40605@arm.com>
References: <1434703572-26221-1-git-send-email-hanjun.guo@linaro.org>
 <1434703572-26221-7-git-send-email-hanjun.guo@linaro.org>
 <20150622172014.GB26129@red-moon> <5589772A.8070708@linaro.org>
 <20150623173845.GC31466@red-moon> <558E1DEE.3090900@linaro.org>
 <55910440.8070702@arm.com> <559282A0.8090601@linaro.org>
 <559288CA.40605@arm.com>
Message-ID: <20150630150719.GC12142@xora-haswell.xora.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 30, 2015 at 01:17:14PM +0100, Marc Zyngier wrote:
> On 30/06/15 12:50, Hanjun Guo wrote:
> > Hi Marc,
> > 
> > On 06/29/2015 04:39 PM, Marc Zyngier wrote:
> >> On 27/06/15 04:52, Hanjun Guo wrote:
> >>> On 06/24/2015 01:38 AM, Lorenzo Pieralisi wrote:
> >>>> On Tue, Jun 23, 2015 at 04:11:38PM +0100, Hanjun Guo wrote:
> > [...]
> >>>>
> >>>>>>>     	for (i = 0; i < nr_irqs; i++)
> >>>>>>>     		gic_irq_domain_map(domain, virq + i, hwirq + i);
> >>>>>>> @@ -945,11 +952,11 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
> >>>>>>>     		gic_irqs = 1020;
> >>>>>>>     	gic->gic_irqs = gic_irqs;
> >>>>>>>
> >>>>>>> -	if (node) {		/* DT case */
> >>>>>>> +	if (node || !acpi_disabled) {		/* DT or ACPI case */
> >>>>>>>     		gic->domain = irq_domain_add_linear(node, gic_irqs,
> >>>>>>>     						    &gic_irq_domain_hierarchy_ops,
> >>>>>>>     						    gic);
> >>>>
> >>>> I think this is a bit more worrying, I mean passing a NULL node pointer to
> >>>> the irqdomain layer which basically means you are booting out of ACPI
> >>>
> >>> I'm little confused here, would you mind explaining more for your
> >>> worrying? To me, node pointer is optional and it's ok for ACPI
> >>> case.
> >>>
> >>>> (for you, if that's true for the irq_domain_add_linear implementation
> >>>> that's another story), the node pointer should be optional but you
> >>>> need feedback from IRQ layer maintainers here.
> >>>
> >>> Sure.
> >>
> >> Frankly, I'd really like to see ACPI using the "node" parameter for
> >> something useful. This would save having to cache pointers all over the
> >> place, will make find_irq_host() work as expected... etc.
> >>
> >> See the comment at the top of linux/irqdomain.h :
> >>
> >> "... This code could thus be used on other architectures by replacing
> >> those two by some sort of arch-specific void * "token" used to identify
> >> interrupt controllers."
> > 
> > To init GIC in ACPI, we can only use the table entry pointer as
> > the token, but the ACPI static tables are early mem/io remapped
> > memory at boot stage, and it will be not available after boot,
> > also we need muti types of MADT enties to init GIC (GICC and GICD
> > for GICv2, GICC or GICR and GICD for GICv3), not as DT, just
> > one single node to include all the information needed to init
> > the GIC.
> 
> A single pointer would be enough, you don't need all of them.
> 
> > We use ACPI handle for devices as node for DT when the namespace
> > is available, but that's pretty late in the boot stage which GIC,
> > SMP and timers were already initialized, so ACPI handle can not
> > use as the token too.
> > 
> > I see multi places just pass NULL as the pointer directly for
> > irq_domain_add_linear() which works fine, and for ACPI, we tested
> > this patch and also it works.
> 
> Yes it works. But you're reinventing the wheel by keeping references
> outside of the normal framework, which is simply going to make the code
> more difficult to maintain in the long run.
> 
> Putting NULL as the device_node parameter really means "this is a domain
> I don't need to look up later". In your case, you will have to lookup
> that domain, all the time. You're just doing it in your own little
> corner, which is what bothers me.
> 
Hanjun, I think it should be possible that instead of looking up the
domains in our own bit of code. We can instead use a ptr to the
appropriate information as the token instead.

I don't think we have to replicate the behaviour of node, in the DT
case, but just do what is sensible for ACPI in this case.

Graeme
