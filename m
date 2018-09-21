From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:15 +0530
Subject: [RFC PATCH 00/40] Cleanup pci-keystone.c and Add AM654 PCIe Support
Message-ID: <20180921102155.22839-1-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PCIe RC support for TI's AM654 SoC. The PCIe controller in AM654
uses Synopsys core revision 4.90a and uses the same TI wrapper as used
in keystone2 with certain modification. Hence AM654 will use the same
pci wrapper driver pci-keystone.c

The initial support for AM654 was merged recently [1]

[1] -> https://lore.kernel.org/lkml/20180626162615.19194-1-nm at ti.com/

Patch series includes the following
 *) Merge pci-keystone-dw.c into pci-keystone.c so that we have single
    file for PCIe keystone driver.
 *) Cleanup the pci-keystone driver. In certain cases the DT binding is
    also modified since PCIe in keystone has never worked in mainline
    due to lack of PHY support.
 *) Included the PHY driver here for completeness (though the driver
    might go via linux-phy tree)
 *) Included the device tree patches here. Once this series is reviewed
    it'll be sent to be merged via Tony's tree.
 *) Patch to fix ATU identification for designware version >= 4.80 in
    designware core is also included here.

TODO:
 *) Add Endpoint Support for AM654
 *) Send a patch to fix the MRRS after the correct value is identified.

Once this series is reviewed I'll split the series and send to
corresponding subsytem Maintainers after removing RFC in subject.

Thanks
Kishon

Benoit Parrot (1):
  arm64: dts: k3-am6: Add Main System Control Module node

Kishon Vijay Abraham I (39):
  PCI: keystone: Use quirk to limit MRRS for K2G
  PCI: keystone: Use quirk to set MRRS for PCI host bridge
  PCI: keystone: Move dw_pcie_setup_rc out of ks_pcie_establish_link()
  PCI: keystone: Do not initiate link training multiple times
  PCI: keystone: Remove unused argument from ks_dw_pcie_host_init()
  PCI: keystone: Add start_link/stop_link dw_pcie_ops
  PCI: keystone: Merge pci-keystone-dw.c and pci-keystone.c
  PCI: keystone: Cleanup MSI/legacy interrupt configuration and handling
  PCI: keystone: Remove redundant platform_set_drvdata
  PCI: keystone: Use uniform function naming convention
  dt-bindings: PCI: keystone: Add bindings to get device control module
  PCI: keystone: Use syscon APIs to get device id from control module
  dt-bindings: PCI: keystone: Add "reg-names" binding information
  PCI: keystone: Use platform_get_resource_byname to get memory
    resources
  PCI: keystone: Cleanup PHY handling
  PCI: keystone: Invoke pm_runtime APIs to enable clock
  PCI: keystone: Cleanup configuration space access
  PCI: keystone: Get number of OB windows from DT and cleanup MEM space
    configuration
  PCI: keystone: Cleanup set_dbi_mode and get_dbi_mode
  PCI: keystone: Cleanup ks_pcie_link_up()
  PCI: keystone: Add debug error message for all errors
  PCI: keystone: Reorder header file in alphabetical order
  PCI: keystone: Cleanup macros defined in pci-keystone.c
  PCI: keystone: Move initializations to appropriate places
  dt-bindings: PCI: Add dt-binding to configure PCIe mode
  PCI: keystone: Explicitly set the PCIe mode
  dt-bindings: PCI: Document "atu" reg-names
  PCI: dwc: Fix ATU identification for designware version >= 4.80
  PCI: keystone: Prevent ARM32 specific code to be compiled for ARM64
  dt-bindings: PCI: Add PCI RC dt binding documentation for AM654
  PCI: keystone: Add support for PCIe in AM654x Platforms
  phy: core: Invoke pm_runtime_get_*/pm_runtime_put_* before invoking
    reset callback
  dt-bindings: phy: ti: Add dt binding documentation for SERDES in
    AM654x SoC
  phy: ti: Add a new SERDES driver for TI's AM654x SoC
  ARM: dts: keystone-k2e: Use the updated binding to describe PCIe in
    k2e
  arm64: dts: k3-am6: Add "socionext,synquacer-pre-its" property to
    gic_its
  arm64: dts: k3-am6: Add mux-controller dt node required for muxing
    SERDES
  arm64: dts: k3-am6: Add SERDES DT node
  arm64: dts: k3-am6: Add Root Complex PCIe dt node

 .../bindings/pci/designware-pcie.txt          |    7 +-
 .../devicetree/bindings/pci/pci-keystone.txt  |   17 +-
 .../devicetree/bindings/phy/ti-phy.txt        |   77 ++
 MAINTAINERS                                   |    2 +-
 arch/arm/boot/dts/keystone-k2e.dtsi           |   15 +-
 arch/arm/boot/dts/keystone.dtsi               |   18 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  142 +++
 arch/arm64/boot/dts/ti/k3-am65.dtsi           |    1 +
 drivers/pci/controller/dwc/Kconfig            |    2 +-
 drivers/pci/controller/dwc/Makefile           |    2 +-
 drivers/pci/controller/dwc/pci-keystone-dw.c  |  484 --------
 drivers/pci/controller/dwc/pci-keystone.c     | 1059 +++++++++++++----
 drivers/pci/controller/dwc/pci-keystone.h     |   57 -
 .../pci/controller/dwc/pcie-designware-host.c |   16 -
 drivers/pci/controller/dwc/pcie-designware.c  |   50 +-
 drivers/pci/controller/dwc/pcie-designware.h  |   13 +-
 drivers/phy/phy-core.c                        |    6 +
 drivers/phy/ti/Kconfig                        |   11 +
 drivers/phy/ti/Makefile                       |    1 +
 drivers/phy/ti/phy-am654-serdes.c             |  513 ++++++++
 include/dt-bindings/phy/phy-am654-serdes.h    |   13 +
 21 files changed, 1690 insertions(+), 816 deletions(-)
 delete mode 100644 drivers/pci/controller/dwc/pci-keystone-dw.c
 delete mode 100644 drivers/pci/controller/dwc/pci-keystone.h
 create mode 100644 drivers/phy/ti/phy-am654-serdes.c
 create mode 100644 include/dt-bindings/phy/phy-am654-serdes.h

-- 
2.17.1
