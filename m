From: kys@microsoft.com (KY Srinivasan)
Date: Thu, 9 Feb 2017 00:32:10 +0000
Subject: [PATCH v1 0/3] PCI: Configure PCIe MPS settings
In-Reply-To: <20170208224632.14351.89895.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170208224632.14351.89895.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <DM5PR03MB249088D49C65C8E8FB3419FDA0450@DM5PR03MB2490.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas at kernel.org]
> Sent: Wednesday, February 8, 2017 2:49 PM
> To: linux-pci at vger.kernel.org
> Cc: Rob Herring <robh@kernel.org>; Haiyang Zhang
> <haiyangz@microsoft.com>; Michal Simek <michal.simek@xilinx.com>; Jon
> Mason <jon.mason@broadcom.com>; Ray Jui <ray.jui@broadcom.com>;
> S?ren Brinkmann <soren.brinkmann@xilinx.com>;
> devel at linuxdriverproject.org; KY Srinivasan <kys@microsoft.com>; linux-
> arm-kernel at lists.infradead.org; Tanmay Inamdar <tinamdar@apm.com>
> Subject: [PATCH v1 0/3] PCI: Configure PCIe MPS settings
> 
> [Some of you will get this twice because Gmail and I aren't getting along
> today; sorry]
> 
> The PCI core doesn't configure the PCIe MPS settings by itself.  Each
> host bridge driver has to call pcie_bus_configure_settings() to make
> this happen.
> 
> Jon fixed this already for pcie-iproc.c.  I propose these similar
> patches for other drivers.
> 
> HV guys, I included you because create_root_hv_pci_bus() is one place
> that calls pci_scan_child_bus() but does not call
> pcie_bus_configure_settings().  I know you probably don't strictly
> *need* to configure MPS settings in a paravirtual front-end, but the
> PCI core does other device configuration in this path:
> 
>   pci_scan_child_bus
>     pci_scan_slot
>       pci_scan_single_device
>         pci_device_add
>           pci_configure_device
>           pci_init_capabilities
> 
> and I would like to eventually migrate the MPS configuration into that
> same path.  Since we do this other configuration for HV devices
> already, I think pcie_bus_configure_settings() should also work (even
> if it ends up not doing anything to real devices).
> 
> It would make that eventual migration easier if all the
> pci_scan_child_bus() callers had the same pattern of calling
> pcie_bus_configure_settings().
> 
> So would it make sense to make a similar patch for HV?  It looks easy
> to add it to create_root_hv_pci_bus(), but I don't know exactly what
> to do about pci_devices_present_work().

Bjorn,

We will take a look.

K. Y
> 
> ---
> 
> Bjorn Helgaas (3):
>       PCI: xilinx: Configure PCIe MPS settings
>       PCI: versatile: Configure PCIe MPS settings
>       PCI: xgene: Configure PCIe MPS settings
> 
> 
>  drivers/pci/host/pci-versatile.c |    4 +++-
>  drivers/pci/host/pci-xgene.c     |    4 +++-
>  drivers/pci/host/pcie-xilinx.c   |    4 +++-
>  3 files changed, 9 insertions(+), 3 deletions(-)
