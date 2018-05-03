From: Gilles.Buloz@kontron.com (Gilles Buloz)
Date: Thu, 3 May 2018 12:40:27 +0000
Subject: LS1043A : "synchronous abort" at boot due to PCI config read
In-Reply-To: <20180502172341.GA123831@bhelgaas-glaptop.roam.corp.google.com>
References: <CAKv+Gu_v4V8DUa6f4WxvjZHoJbbqT0mKpOwYVmaLaE20CB3U_g@mail.gmail.com>
 <5AE317AB.4020404@kontron.com>
 <20180427165627.GA8199@bhelgaas-glaptop.roam.corp.google.com>
 <5AE6D7E2.9030506@kontron.com> <5AE71BF4.2010200@kontron.com>
 <20180430170447.GA95643@bhelgaas-glaptop.roam.corp.google.com>
 <5AE75809.30701@kontron.com> <5AE9B5BB.2080003@kontron.com>
 <20180502132501.GE11698@bhelgaas-glaptop.roam.corp.google.com>
 <5AE9C1AB.8020403@kontron.com>
 <20180502172341.GA123831@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <5AEB033A.4060407@kontron.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subject:    [PATCH] For exception at PCI probe due to bridge reporting UR

Even if a device supports extended config access, no such access must be
done to this device If there's a bridge not supporting that in the path
to this device. Doing such access with UR reporting enabled on the root
bridge leads to an exception.

This is the case on a LS1043A CPU (NXP QorIQ Layerscape) platform with
the following bus topology :
  LS1043 PCIe root
    -> PEX8112 PCIe-to-PCI bridge (not supporting ext cfg on PCI side)
      -> PMC slot connector (for legacy PMC modules)
With a PMC module topology as follows :
  PMC connector
    -> PCI-to-PCIe bridge
      -> PCIe switch (4 ports)
        -> 4 PCIe devices (one on each port)
In this case all devices behind the PEX8112 are supporting extended config
access but this is prohibited by the PEX8112. Without this patch, an
exception (synchronous abort) occurs in pci_cfg_space_size_ext().

This patch checks the parent bridge of each allocated child bus to know if
extended config access is supported on the child bus, and sets a flag in
child->bus_flags if not supported. This  flag is inherited by all children
buses of this child bus and then is checked to avoid this unsupported
accesses to every device on these buses.

Thanks

=====================
Gilles BULOZ
Senior software engineer
Kontron France
=====================


Signed-off-by: Gilles Buloz <gilles.buloz@kontron.com>

--- linux-4.17-rc1/include/linux/pci.h.orig	2018-04-16 01:24:20.000000000 +0000
+++ linux-4.17-rc1/include/linux/pci.h	2018-05-03 09:53:03.270000000 +0000
@@ -217,6 +217,7 @@ enum pci_bus_flags {
  	PCI_BUS_FLAGS_NO_MSI	= (__force pci_bus_flags_t) 1,
  	PCI_BUS_FLAGS_NO_MMRBC	= (__force pci_bus_flags_t) 2,
  	PCI_BUS_FLAGS_NO_AERSID	= (__force pci_bus_flags_t) 4,
+	PCI_BUS_FLAGS_NO_EXTCFG	= (__force pci_bus_flags_t) 8,
  };
  
  /* Values from Link Status register, PCIe r3.1, sec 7.8.8 */
--- linux-4.17-rc1/drivers/pci/probe.c.orig	2018-05-03 09:45:21.110000000 +0000
+++ linux-4.17-rc1/drivers/pci/probe.c	2018-05-03 09:46:50.550000000 +0000
@@ -882,6 +882,24 @@ free:
  	return err;
  }
  
+static bool pci_bridge_child_bus_ext_cfg_accessible(struct pci_dev *bridge)
+{
+	int pos;
+	u32 status;
+
+	if (pci_is_pcie(bridge) &&
+	    (pci_pcie_type(bridge) != PCI_EXP_TYPE_PCIE_BRIDGE) &&
+	    (pci_pcie_type(bridge) != PCI_EXP_TYPE_PCI_BRIDGE))
+		return true;
+
+	/* PCI/PCI, or PCIe/PCI (forward), or PCI/PCIe (reverse) bridge */
+	pos = pci_find_capability(bridge, PCI_CAP_ID_PCIX);
+	if (pos)
+		pci_read_config_dword(bridge, pos + PCI_X_STATUS, &status);
+
+	return pos && (status & (PCI_X_STATUS_266MHZ | PCI_X_STATUS_533MHZ));
+}
+
  static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
  					   struct pci_dev *bridge, int busnr)
  {
@@ -930,6 +948,20 @@ static struct pci_bus *pci_alloc_child_b
  	}
  	bridge->subordinate = child;
  
+	/*
+	 * if bus_flags inherited from parent bus do not already report lack of
+	 * extended config space support, check if supported by child bus by
+	 * checking its parent bridge
+	 */
+	if (child->bus_flags & PCI_BUS_FLAGS_NO_EXTCFG) {
+		pci_info(child, "extended config space not accessible due to parent bus\n");
+	} else {
+		if (!pci_bridge_child_bus_ext_cfg_accessible(bridge)) {
+			child->bus_flags |= PCI_BUS_FLAGS_NO_EXTCFG;
+			pci_info(child, "extended config space not accessible due to parent bridge\n");
+		}
+	}
+
  add_dev:
  	pci_set_bus_msi_domain(child);
  	ret = device_register(&child->dev);
@@ -1393,6 +1425,9 @@ int pci_cfg_space_size(struct pci_dev *d
  	u32 status;
  	u16 class;
  
+	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_EXTCFG)
+		return PCI_CFG_SPACE_SIZE;
+
  	class = dev->class >> 8;
  	if (class == PCI_CLASS_BRIDGE_HOST)
  		return pci_cfg_space_size_ext(dev);
