From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Sep 2015 15:55:27 +0200
Subject: Need information on Microblaze/ARM PCIe
In-Reply-To: <loom.20150930T152450-636@post.gmane.org>
References: <loom.20150930T152450-636@post.gmane.org>
Message-ID: <1564493.rNY8FKFBZT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 September 2015 13:26:15 bharat kumar gogada wrote:
> We are trying to write a generic PCIE root port driver which works both on
> zynq (ARM 32 architecture) and Microblaze architecture, since both use same
> PCIE Hardware IP. So we started exploring microblaze pci architecture. Zynq
> driver is already present at drivers/pci/host/pcie-xilinx.c
> 
> Microblaze pci mainly relies on arch/microblaze/pci/pci-common.c this file.
> In this file "static int __init pcibios_init(void)" is the main function
> which does most of the work, before that we need to allocate struct
> pci_controller and fill in the required device node and resource details.
> 
> Problem is if we use platform_driver for registration, the "pcibios_init" of
> microblaze will get invoked before this driver probe is called since it is
> exported as " subsys_initcall(pcibios_init) " and by that time it doesn't
> have information of struct pci_controller. (We are using some #ifdef
> according to archticture) 
> 
> So, in order to avoid above problem and remove dependency on "pcibios_init",
> we tried directly invoking the following functions, without registering to
> hw_pci in probe:
> of_pci_get_host_bridge_resources, pci_create_root_bus, pci_scan_child_bus,
> pci_assign_unassigned_bus_resources, pci_bus_add_devices.
> 
> But then also its not successful since pci subsystem itself is invoking some
> methods from this file(pci-common.c), and some methods take information from
> struct pci_controller. 
> 
> So I need some inputs what are other possible ways I could try to make
> generic driver.

You are looking at different ways of structuring the PCI code. PowerPC had
a rather elaborate method for their servers, and this is what got copied
into microblaze. ARM had a completely different way of doing this that
had a bit less complexity but had it in different places. For ARM64, we
managed to do away with most of the architecture specific code and instead
generalized the common drivers/pci layer to do more of that. Drivers can
now be shared between ARM32 and ARM64 with very few differences.

What I'd recommend doing here is to try ripping out most of the PCI code
from microblaze (or putting it under and Kconfig symbol initially) and using
the same code that ARM64 uses. Start with a copy of
drivers/pci/host/pci-host-generic.c for your PCI hardware and add all hardware
specific code that you need to get it to work with that.

For the start, ignore all I/O space setup, that should simplify things a
lot and can be added in the second step.

	Arnd
