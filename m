From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 10 Aug 2015 17:04:13 -0500
Subject: [PATCH v5 9/9] PCI: xgene: Use pci_scan_root_bus_msi()
In-Reply-To: <55C37C92.1020509@arm.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150804215457.9189.27595.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <55C37C92.1020509@arm.com>
Message-ID: <20150810220413.GA13982@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Thu, Aug 06, 2015 at 04:26:10PM +0100, Marc Zyngier wrote:
> On 04/08/15 22:54, Bjorn Helgaas wrote:
> > Previously there was no way to specify the MSI controller when creating a
> > new PCI root bus, so we had to create the bus, set its MSI controller, then
> > scan the bus.  With the new pci_scan_root_bus_msi() interface, we can
> > specify the MSI controller up front and get rid of that intermediate step.
> > 
> > Look up the MSI controller first, then use pci_scan_root_bus_msi() to
> > create and scan the root PCI bus.
> 
> I'm wondering about these XGene patches.
> 
> With the code that is queued for v4.3 in tip/irq/core, the X-Gene MSI
> driver doesn't export a struct msi_controller anymore, and entirely
> relies on IRQ domains to identify to be matched with the actual PCI driver.
> 
> Do you intend this as a cleanup until everything lands in mainline? At
> that point, we'd be able to remove all traces of struct msi_controller
> from this driver.

I haven't been following the IRQ domain stuff or tip/irq/core, so I
really don't know how this relates to that.  I took a look, and I see
8d63bc7beaee ("PCI/MSI: pci-xgene-msi: Get rid of struct
msi_controller"), which removes an msi_controller pointer from
pci-xgene-msi.c, but I don't see any pci-xgene.c changes in
tip/irq/core.

Are you saying that xgene_pcie_msi_enable() will go away eventually?
And the OF "msi-parent" lookup will go away, or at least be moved
elsewhere?  We currently have:

  xgene_pcie_probe_bridge(...)
  {
    ...
    bus = pci_create_root_bus(...);
    xgene_pcie_msi_enable(...);
    pci_scan_child_bus(bus);
    ...
  }

I'd like to get rid of that arch-specific MSI enable stuff because
then we can use a higher level interface, e.g., pci_scan_root_bus(),
and make the X-Gene code slightly simpler.

> Alternatively, we could ask tglx to add an extra patch to the existing
> queue in order to clean up pci-xgene.c (nuking the whole
> xgene_pcie_msi_enable function).

Ah, I guess you *are* saying that xgene_pcie_msi_enable() will go away
eventually.  I don't know how to do that, but apparently you do, so
I'll just drop these X-Gene-related patches for now.

Bjorn
