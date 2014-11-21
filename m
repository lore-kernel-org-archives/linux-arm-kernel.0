From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 21 Nov 2014 09:46:11 +0100
Subject: Removal of bus->msi assignment breaks MSI with stacked domains
In-Reply-To: <546E9DF0.5010002@huawei.com>
References: <546E1771.4030201@arm.com> <546E93DC.8010902@huawei.com>
 <alpine.DEB.2.11.1411210233250.6439@nanos> <546E9DF0.5010002@huawei.com>
Message-ID: <1416559571.2423.1.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 21.11.2014, 10:05 +0800 schrieb Yijing Wang:
> On 2014/11/21 9:46, Thomas Gleixner wrote:
> > On Fri, 21 Nov 2014, Yijing Wang wrote:
> >> On 2014/11/21 0:31, Marc Zyngier wrote:
> >>> Bjorn, Yijing,
> >>>
> >>> I've just realized that patch c167caf8d174 (PCI/MSI: Remove useless
> >>> bus->msi assignment) completely breaks MSI on arm64 when using the new
> >>> MSI stacked domain:
> >>
> >> Sorry, this is my first part to refactor MSI related code, now how
> >> to get pci msi_controller depends arch
> >> functions(pcibios_msi_controller() or arch_setup_msi_irq()), we are
> >> working on generic pci_host_bridge, after that, we could eventually
> >> eliminate MSI arch functions and find pci dev 's msi controller by
> >> pci_host_bridge->get_msi_controller().
> > 
> > The main question is why you think that pci_host_bridge is the proper
> > place to store that information.
> > 
> > On x86 we have DMAR units associated to a single device. Each DMAR
> > unit is a seperate MSI irq domain. 
> > 
> > Can you guarantee that the pci_host_bridge is the right point to
> > provide the association of the device to the irq domain?
> > 
> > So the real question is:
> > 
> >    What is the association level requirement to properly identify the
> >    irqdomain for a specific device on any given architecture with and
> >    without IOMMU, interrupt redirection etc.
> > 
> > To be honest: I don't know.
> > 
> > My gut feeling tells me that it's at the device level, but I really
> > leave that decision to the experts in that field.
> 
> I choose the pci_host_bridge to place the .get_msi_ctrl() ops, because
> I think how to associate pci_dev and msi_controller is platform specific,
> and we could initialize pci_host_bridge in platform pci host drivers to
> avoid call platform specific functions when we scan or setup a pci device.
> 
I'm in favor of having the irqdomain attached to struct device even.
Please keep in mind that going forward PCI will not be the only bus
using MSI. Also having it attached to the device allows you to find the
the domain by just walking up the chain of parent devices until you find
one with an attached domain. A host bridge isn't different in that
regard from any other device. This should work for all platforms AFAICS.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
