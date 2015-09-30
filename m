From: bharatku@xilinx.com (bharat kumar gogada)
Date: Wed, 30 Sep 2015 13:26:15 +0000 (UTC)
Subject: Need information on Microblaze/ARM PCIe
Message-ID: <loom.20150930T152450-636@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are trying to write a generic PCIE root port driver which works both on
zynq (ARM 32 architecture) and Microblaze architecture, since both use same
PCIE Hardware IP. So we started exploring microblaze pci architecture. Zynq
driver is already present at drivers/pci/host/pcie-xilinx.c

Microblaze pci mainly relies on arch/microblaze/pci/pci-common.c this file.
In this file "static int __init pcibios_init(void)" is the main function
which does most of the work, before that we need to allocate struct
pci_controller and fill in the required device node and resource details.

Problem is if we use platform_driver for registration, the "pcibios_init" of
microblaze will get invoked before this driver probe is called since it is
exported as " subsys_initcall(pcibios_init) " and by that time it doesn't
have information of struct pci_controller. (We are using some #ifdef
according to archticture) 

So, in order to avoid above problem and remove dependency on "pcibios_init",
we tried directly invoking the following functions, without registering to
hw_pci in probe:
of_pci_get_host_bridge_resources, pci_create_root_bus, pci_scan_child_bus,
pci_assign_unassigned_bus_resources, pci_bus_add_devices.

But then also its not successful since pci subsystem itself is invoking some
methods from this file(pci-common.c), and some methods take information from
struct pci_controller. 

So I need some inputs what are other possible ways I could try to make
generic driver.
