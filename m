From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 21 Nov 2014 02:46:06 +0100 (CET)
Subject: Removal of bus->msi assignment breaks MSI with stacked domains
In-Reply-To: <546E93DC.8010902@huawei.com>
References: <546E1771.4030201@arm.com> <546E93DC.8010902@huawei.com>
Message-ID: <alpine.DEB.2.11.1411210233250.6439@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Nov 2014, Yijing Wang wrote:
> On 2014/11/21 0:31, Marc Zyngier wrote:
> > Bjorn, Yijing,
> > 
> > I've just realized that patch c167caf8d174 (PCI/MSI: Remove useless
> > bus->msi assignment) completely breaks MSI on arm64 when using the new
> > MSI stacked domain:
> 
> Sorry, this is my first part to refactor MSI related code, now how
> to get pci msi_controller depends arch
> functions(pcibios_msi_controller() or arch_setup_msi_irq()), we are
> working on generic pci_host_bridge, after that, we could eventually
> eliminate MSI arch functions and find pci dev 's msi controller by
> pci_host_bridge->get_msi_controller().

The main question is why you think that pci_host_bridge is the proper
place to store that information.

On x86 we have DMAR units associated to a single device. Each DMAR
unit is a seperate MSI irq domain. 

Can you guarantee that the pci_host_bridge is the right point to
provide the association of the device to the irq domain?

So the real question is:

   What is the association level requirement to properly identify the
   irqdomain for a specific device on any given architecture with and
   without IOMMU, interrupt redirection etc.

To be honest: I don't know.

My gut feeling tells me that it's at the device level, but I really
leave that decision to the experts in that field.

Thanks,

	tglx
