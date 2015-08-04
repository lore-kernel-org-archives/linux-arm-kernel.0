From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 04 Aug 2015 16:53:48 -0500
Subject: [PATCH v5 0/9] ARM: PCI: kill pcibios_msi_controller()
Message-ID: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first 5 patches here are essentially the same as Lorenzo's v4 posting
at
http://lkml.kernel.org/1438169598-24490-1-git-send-email-lorenzo.pieralisi at arm.com

I added some at the end to fix what look like some X-Gene bugs to me, and
to make X-Gene use pci_scan_root_bus_msi() like the other drivers that use
msi_controller.

v4->v5 changes:
- Declare pci_scan_root_bus_msi() in drivers/pci/pci.h instead of
  include/linux/pci.h.  I like the idea, but I hope we can replace this and
  other "scan_root_bus" interfaces with a single, more-generic interface,
  so I'd rather not expose this one widely.
- Split "kill pcibios_msi_controller" into several patches.  My intent was
  to make it easier to review; I don't think I made any actual code
  changes.  I did drop Marc's ack because I fiddled with stuff enough
  that I wasn't comfortable keeping it.
- I added of_node_put() after of_parse_phandle() in MVEBU and X-Gene.
  I'm not an OF guy, so tell me if this is the wrong thing.
- I changed a couple X-Gene OF "msi-parent" things to match (I think) what
  MVEBU does.  Again, tell me if I got this wrong.
- I used pci_scan_root_bus_msi() in X-Gene to follow what Lorenzo already
  did in DesignWare and Xilinx.

---

Lorenzo Pieralisi (5):
      ARM/PCI: Replace panic with WARN messages on failures
      PCI: Add pci_scan_root_bus_msi()
      ARM/PCI, designware, xilinx: Use pci_scan_root_bus_msi()
      ARM/PCI: Remove msi_controller from struct pci_sys_data
      PCI/MSI: Remove unused pcibios_msi_controller() hook

Bjorn Helgaas (4):
      PCI: Drop references acquired by of_parse_phandle()
      PCI: xgene: Set msi_controller->dev to platform_device, not pci_bus
      PCI: xgene: Look for OF "msi-parent" in host controller, not root bus
      PCI: xgene: Use pci_scan_root_bus_msi()


 arch/arm/include/asm/mach/pci.h    |    5 -----
 arch/arm/kernel/bios32.c           |   27 +++++++++------------------
 drivers/pci/host/pci-mvebu.c       |    1 +
 drivers/pci/host/pci-xgene.c       |   26 +++++++++++++-------------
 drivers/pci/host/pcie-designware.c |    6 +++---
 drivers/pci/host/pcie-xilinx.c     |    5 ++---
 drivers/pci/msi.c                  |   17 +----------------
 drivers/pci/pci.h                  |    5 +++++
 drivers/pci/probe.c                |   14 ++++++++++++--
 9 files changed, 46 insertions(+), 60 deletions(-)
