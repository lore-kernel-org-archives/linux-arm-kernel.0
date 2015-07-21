From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Jul 2015 14:03:32 +0100
Subject: [PATCH 5/5] irqchip: GIC: Switch ACPI support to stacked domains
In-Reply-To: <20150721123408.GA5352@xora-yoga13.xora.org.uk>
References: <1437473280-11431-1-git-send-email-marc.zyngier@arm.com>
 <1437473280-11431-6-git-send-email-marc.zyngier@arm.com>
 <20150721123408.GA5352@xora-yoga13.xora.org.uk>
Message-ID: <20150721140332.0684e5f5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Jul 2015 13:34:08 +0100
Graeme Gregory <graeme@xora.org.uk> wrote:

> On Tue, Jul 21, 2015 at 11:08:00AM +0100, Marc Zyngier wrote:
> > Now that the basic ACPI GSI code is irq domain aware, make sure
> > that the ACPI support in the GIC doesn't pointlessly deviate from
> > the DT path.
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  drivers/irqchip/irq-gic.c       | 17 ++++++-----------
> >  include/linux/irqchip/arm-gic.h |  2 +-
> >  2 files changed, 7 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> > index b41ccf5..f5d365d 100644
> > --- a/drivers/irqchip/irq-gic.c
> > +++ b/drivers/irqchip/irq-gic.c
> > @@ -813,8 +813,6 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
> >  {
> >  	unsigned long ret = 0;
> >  
> > -	if (irq_domain_get_of_node(d) != controller)
> > -		return -EINVAL;
> This change seems to have nothing to do with the description.

It has everything to do with making this function usable in the context
of ACPI ;-).

This is another ugly aspect of the irqdomain part, where "controller"
is actually the device_node extracted from of_phandle_args. This will
actually be the domain_token, and this comparison would fail with ACPI.
I may add another patch for that.

On DT, this is actually pretty useless, as we're always registering the
GIC domain with its device_node, so this is really guaranteed to match.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
