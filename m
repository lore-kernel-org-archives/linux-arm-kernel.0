From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 08 Feb 2017 16:49:22 -0600
Subject: [PATCH v1 0/3] PCI: Configure PCIe MPS settings
Message-ID: <20170208224632.14351.89895.stgit@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Some of you will get this twice because Gmail and I aren't getting along
today; sorry]

The PCI core doesn't configure the PCIe MPS settings by itself.  Each
host bridge driver has to call pcie_bus_configure_settings() to make
this happen.

Jon fixed this already for pcie-iproc.c.  I propose these similar
patches for other drivers.

HV guys, I included you because create_root_hv_pci_bus() is one place
that calls pci_scan_child_bus() but does not call
pcie_bus_configure_settings().  I know you probably don't strictly
*need* to configure MPS settings in a paravirtual front-end, but the
PCI core does other device configuration in this path:

  pci_scan_child_bus
    pci_scan_slot
      pci_scan_single_device
        pci_device_add
          pci_configure_device
          pci_init_capabilities

and I would like to eventually migrate the MPS configuration into that
same path.  Since we do this other configuration for HV devices
already, I think pcie_bus_configure_settings() should also work (even
if it ends up not doing anything to real devices).

It would make that eventual migration easier if all the
pci_scan_child_bus() callers had the same pattern of calling
pcie_bus_configure_settings().

So would it make sense to make a similar patch for HV?  It looks easy
to add it to create_root_hv_pci_bus(), but I don't know exactly what
to do about pci_devices_present_work().

---

Bjorn Helgaas (3):
      PCI: xilinx: Configure PCIe MPS settings
      PCI: versatile: Configure PCIe MPS settings
      PCI: xgene: Configure PCIe MPS settings


 drivers/pci/host/pci-versatile.c |    4 +++-
 drivers/pci/host/pci-xgene.c     |    4 +++-
 drivers/pci/host/pcie-xilinx.c   |    4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)
