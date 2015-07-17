From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 17 Jul 2015 12:00:16 +0100
Subject: [PATCH 3/5] arm64, pci: Allow RC drivers to supply
 pcibios_add_device() implementation.
In-Reply-To: <55A7E334.3030101@caviumnetworks.com>
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
 <1436979285-8177-4-git-send-email-ddaney.cavm@gmail.com>
 <20150716090426.GA17097@red-moon>
 <55A7E334.3030101@caviumnetworks.com>
Message-ID: <20150717110016.GB19067@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Thu, Jul 16, 2015 at 06:00:36PM +0100, David Daney wrote:
> On 07/16/2015 02:04 AM, Lorenzo Pieralisi wrote:
> > Hi David,
> >
> > On Wed, Jul 15, 2015 at 05:54:43PM +0100, David Daney wrote:
> >> From: David Daney <david.daney@cavium.com>
> >>
> [...]
> >> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> >> index 4095379..3356023 100644
> >> --- a/arch/arm64/kernel/pci.c
> >> +++ b/arch/arm64/kernel/pci.c
> >> @@ -38,11 +38,21 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> >>   	return res->start;
> >>   }
> >>
> >> +static int (*pcibios_add_device_impl)(struct pci_dev *);
> >> +
> >> +void set_pcibios_add_device(int (*arg)(struct pci_dev *))
> >> +{
> >> +	pcibios_add_device_impl = arg;
> >> +}
> >> +
> >>   /*
> >>    * Try to assign the IRQ number from DT when adding a new device
> >>    */
> >>   int pcibios_add_device(struct pci_dev *dev)
> >>   {
> >> +	if (pcibios_add_device_impl)
> >> +		return pcibios_add_device_impl(dev);
> >
> > I am totally against this (and to be honest by reading the other
> > patches I failed to understand why you even need it), see above.
> >
> 
> It is because ...
> 
> 
> > Thanks,
> > Lorenzo
> >
> >> +
> >>   	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> 
> 
>   ... this is total crap.  But I didn't want to break existing systems.

That's a good aim, but you are still failing to explain the issue properly
I am afraid.

> The PCI RC drivers need a way to configure the legacy virtual-wire 
> interrupts, because the existing code doesn't do it.

Can I ask you please to explain the issue a bit more clearly (and why
the OF API does not work for you ?)

Thank you !
Lorenzo
