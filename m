From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 21 May 2015 16:39:25 +0200 (CEST)
Subject: [PATCH 03/11] irqchip / GIC: Add GIC version support in ACPI MADT
In-Reply-To: <555DE98A.2000909@linaro.org>
References: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org>
 <1431953961-22706-4-git-send-email-hanjun.guo@linaro.org>
 <alpine.DEB.2.11.1505202157190.4225@nanos> <555DE98A.2000909@linaro.org>
Message-ID: <alpine.DEB.2.11.1505211632180.31710@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 May 2015, Hanjun Guo wrote:
> On 2015?05?21? 04:02, Thomas Gleixner wrote:
> > On Mon, 18 May 2015, Hanjun Guo wrote:
> > > diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> > > index 65d6b93..855ead9 100644
> > > --- a/drivers/acpi/irq.c
> > > +++ b/drivers/acpi/irq.c
> > > @@ -32,6 +32,9 @@ void __init acpi_irqchip_init(void)
> > >   	if (acpi_disabled)
> > >   		return;
> > > 
> > > +	if (acpi_gic_version_init())
> > > +		return;
> > 
> > This looks just wrong. acpi_irqchip_init() is a generic ACPI function
> > and now you stick a GIC specific callback into it?
> 
> For now, acpi_irqchip_init() just introduced for GIC init, not for
> APIC init for x86, and I don't see the usage in the near future.
> 
> > 
> > What calls acpi_irqchip_init?
> 
> I renamed it as acpi_irq_init() in the later patch, which
> is called in irqchip_init() in drivers/irqchip/irqchip.c
> to init irqchip when DT is not available.

Neither of those names is a good choice as they suggest that this is a
generic acpi mechanism while in fact it is a GIC specific ACPI
extension. And its therefor wrong to put that code into drivers/acpi.

It belongs into drivers/irqchip/gic-acpi.c or some other descriptive
name.

Thanks,

	tglx
