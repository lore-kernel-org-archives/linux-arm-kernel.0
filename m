From: andrew.murray@arm.com (Andrew Murray)
Date: Tue, 29 Jan 2013 15:08:03 +0000
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130129150201.GA24101@avionic-0098.mockup.avionic-design.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130129132204.GA23886@arm.com> <20130129144522.44ed7373@skate>
 <20130129140522.GA24310@arm.com>
 <20130129142015.GA23640@avionic-0098.mockup.avionic-design.de>
 <20130129152937.53ec9a9b@skate>
 <20130129150201.GA24101@avionic-0098.mockup.avionic-design.de>
Message-ID: <20130129150803.GA29817@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 03:02:01PM +0000, Thierry Reding wrote:
> On Tue, Jan 29, 2013 at 03:29:37PM +0100, Thomas Petazzoni wrote:
> > Dear Thierry Reding,
> > 
> > On Tue, 29 Jan 2013 15:20:15 +0100, Thierry Reding wrote:
> > 
> > > If at all possible I think the right thing to do is reuse the generic
> > > pcibios_get_phb_of_node() implementation. On Tegra this turned out to
> > > require a minimal change to the DT bindings of the root port nodes to
> > > make sure they provide the correct address in the reg property.
> > 
> > Could you detail the change that was needed? The DT bindings I use for
> > the Marvell PCIe driver are very, very similar to the ones you use for
> > Tegra, since I basically inspired my entire DT binding on your work.
> > And still, I think of_irq_map_pci() wasn't working for me.
> 
> Now that I think about it, there were a few more changes needed.
> For one, the reg property of the root port nodes need to be in the
> format specified by the PCI DT binding. That is, 3 cells for the
> address and 2 cells for the size.
> 
> So I end up with something like this:
> 
> 	pcie-controller {
> 		...
> 
> 		ranges = <0x00000800 0 0x80000000 0x80000000 0 0x00001000 /* port 0 registers */
> 			  0x00001000 0 0x80001000 0x80001000 0 0x00001000 /* port 1 registers */
> 			  ...>;
> 
> 		pci at 1,0 {
> 			reg = <0x000800 0 0x80000000 0 0x1000>;
> 			...
> 		};
> 
> 		pci at 2,0 {
> 			reg = <0x001000 0 0x80001000 0 0x1000>;
> 			...
> 		};
> 	};
> 
> So what happens here is that for each root port (pci at 1,0 and pci at 2,0),
> the reg property is translated into the parent address space via the
> pcie-controller's ranges property. pci at 1,0 gets the memory region
> 0x80000000-0x80000fff and pci at 2,0 gets 0x80001000-0x80001fff. (These are
> actually windows through which the configuration space of the root ports
> is accessed.)
> 
> At the same time this reg property maps both devices into the PCI
> address space at addresses 0:01.0 and 0:02.0 respectively.
> 
> The second change is that you can't rely on ARM's default implementation
> of the bus scan operation, which calls pci_scan_root_bus(), passing in a
> NULL as the struct device which acts as the bus' parent. So on Tegra I
> added a custom implementation which calls pci_create_root_bus(), passing
> in the struct device of the PCI host bridge, whose .of_node field will
> be set to the pcie-controller node above. Incidentally this also fixed
> another issue where the PCI core and ARM's pci_common_init() both
> eventually end up calling pci_bus_add_devices(). I don't remember the
> exact symptoms but I think this was causing resource conflicts during
> the second enumeration or so.
> 
> Because a proper struct device with the correct .of_node field is passed
> into pci_create_root_bus(), the generic pcibios_get_phb_of_node() will
> know how to find it by looking at bus->bridge->parent->of_node. After
> that the generic matching code will search the bridge (pcie-controller)
> node's children and relate them to the struct pci_dev by devfn. This is
> done in pci_set_of_node() defined in drivers/pci/of.c, which calls
> of_pci_find_child_device() from drivers/of/of_pci.c.
> 
> This is quite convoluted, but I hope it helps.

Thanks this is very helpful. I will see if this lets me avoid implementing
pcibios_get_phb_of_node.

Thanks,

Andrew Murray
