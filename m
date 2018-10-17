From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 17 Oct 2018 13:10:53 +0530
Subject: [PATCH v2 00/21] PCI: Cleanup pci-keystone driver
Message-ID: <20181017074114.28239-1-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCIe controller in AM654 uses Synopsys core revision 4.90a and uses
the same TI wrapper as used in keystone2 with certain modification.
Hence AM654 will use the same pci wrapper driver pci-keystone.c

In preparation for adding AM654 support, cleanup pci-keystone driver
here.

Most of the cleanups here are trivial with major modification being
merging pci-keystone-dw.c and pci-keystone.c

Cleaning-up irq handling in the RFC series is dropped here as it has
few comments to be addressed.

Changes from v1:
*) remove phy_reset in the cleanup PHY handling patch. It will be sent
   while adding AM654 support
*) Add a separate patch for using ERR_IRQ_STATUS instead of
   ERR_IRQ_STATUS_RAW
*) Split outbound window configuration into two patches. One which
   gets the number of outbound windows from DT and the other cleansup
   outbound window configuration.

Kishon Vijay Abraham I (21):
  PCI: keystone: Use quirk to limit MRRS for K2G
  PCI: keystone: Use quirk to set MRRS for PCI host bridge
  PCI: keystone: Move dw_pcie_setup_rc out of ks_pcie_establish_link()
  PCI: keystone: Do not initiate link training multiple times
  PCI: keystone: Remove unused argument from ks_dw_pcie_host_init()
  PCI: keystone: Merge pci-keystone-dw.c and pci-keystone.c
  PCI: keystone: Remove redundant platform_set_drvdata
  PCI: keystone: Use uniform function naming convention
  dt-bindings: PCI: keystone: Add bindings to get device control module
  PCI: keystone: Use syscon APIs to get device id from control module
  PCI: keystone: Cleanup PHY handling
  PCI: keystone: Invoke pm_runtime APIs to enable clock
  PCI: keystone: Cleanup configuration space access
  PCI: keystone: Get number of outbound windows from DT
  PCI: keystone: Cleanup outbound window configuration
  PCI: keystone: Cleanup set_dbi_mode and get_dbi_mode
  PCI: keystone: Cleanup ks_pcie_link_up()
  PCI: keystone: Use ERR_IRQ_STATUS instead of ERR_IRQ_STATUS_RAW to get
    interrupt status
  PCI: keystone: Add debug error message for all errors
  PCI: keystone: Reorder header file in alphabetical order
  PCI: keystone: Cleanup macros defined in pci-keystone.c

 .../devicetree/bindings/pci/pci-keystone.txt  |   3 +
 MAINTAINERS                                   |   2 +-
 drivers/pci/controller/dwc/Makefile           |   2 +-
 drivers/pci/controller/dwc/pci-keystone-dw.c  | 484 -----------
 drivers/pci/controller/dwc/pci-keystone.c     | 788 +++++++++++++++---
 drivers/pci/controller/dwc/pci-keystone.h     |  57 --
 drivers/pci/controller/dwc/pcie-designware.h  |   4 +
 7 files changed, 686 insertions(+), 654 deletions(-)
 delete mode 100644 drivers/pci/controller/dwc/pci-keystone-dw.c
 delete mode 100644 drivers/pci/controller/dwc/pci-keystone.h

-- 
2.17.1
