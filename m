From: decui@microsoft.com (Dexuan Cui)
Date: Fri, 24 Feb 2017 11:16:03 +0000
Subject: [PATCH v1 0/3] PCI: Configure PCIe MPS settings
In-Reply-To: <20170210215959.GR29169@bhelgaas-glaptop.roam.corp.google.com>
References: <20170208224632.14351.89895.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170210215959.GR29169@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <MWHPR03MB26690F3B4C7E83596C35D377BF520@MWHPR03MB2669.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: devel [mailto:driverdev-devel.. at ...] On Behalf Of Bjorn Helgaas
> Sent: Saturday, February 11, 2017 06:00
> ...
> On Wed, Feb 08, 2017 at 04:49:22PM -0600, Bjorn Helgaas wrote:
> > The PCI core doesn't configure the PCIe MPS settings by itself.  Each
> > host bridge driver has to call pcie_bus_configure_settings() to make
> > this happen.
> >
> > Jon fixed this already for pcie-iproc.c.  I propose these similar
> > patches for other drivers.
> >
> > HV guys, I included you because create_root_hv_pci_bus() is one place
> > that calls pci_scan_child_bus() but does not call
> > pcie_bus_configure_settings().  I know you probably don't strictly
> > *need* to configure MPS settings in a paravirtual front-end, but the
> > PCI core does other device configuration in this path:
> >
> >   pci_scan_child_bus
> >     pci_scan_slot
> >       pci_scan_single_device
> >         pci_device_add
> >           pci_configure_device
> >           pci_init_capabilities
> >
> > and I would like to eventually migrate the MPS configuration into that
> > same path.  Since we do this other configuration for HV devices
> > already, I think pcie_bus_configure_settings() should also work (even
> > if it ends up not doing anything to real devices).
> >
> > It would make that eventual migration easier if all the
> > pci_scan_child_bus() callers had the same pattern of calling
> > pcie_bus_configure_settings().
> >
> > So would it make sense to make a similar patch for HV?  It looks easy
> > to add it to create_root_hv_pci_bus(), but I don't know exactly what
> > to do about pci_devices_present_work().

(I'm sorry for the really late response. I neglected the thread somehow...)

Hi Bjorn,
IMO we don't need to make any change to pci-hyperv.c: when a
PCIe device is passed through to a guest on Hyper-V, in the guest the
device only directly appears on a new root bus, and the new root bus
doesn't have any child bus, and the new root bus itself is actually only
a logical concept instead of a concrete device (i.e. it doesn't have its
own BDF at all).

So, in the path pci_scan_child_bus -> ... -> pci_device_add ->
pci_configure_device -> pci_configure_mps, we're sure
pci_upstream_bridge() is NULL, so pci_configure_mps does nothing.

And since the root bus has no child bus, we don't need to call
pcie_bus_configure_settings(child).

Then you may ask how the MPS is set.
I suppose the para-virtual PCI back-end driver on the host
should take care of this properly.

FWIW, after passing through a Mellanox VF to Linux guest, in the
guest I get this for the device by lspci:
        DevCap: MaxPayload 512 bytes
        DevCtl: MaxPayload 128 bytes, MaxReadReq 128 bytes

Thanks
-- Dexuan
