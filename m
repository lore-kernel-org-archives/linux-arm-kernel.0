From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Tue,  6 Oct 2015 09:56:05 +0200
Subject: [PATCH v5 0/3] PCI: st: provide support for dw pcie
Message-ID: <1444118168-13086-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is based on v4.3-rc3 and is based on 
[PATCH v9 0/6] PCI: hisi: Add PCIe host support for HiSilicon SoC Hip05
patchset from Zhou Wang (to disable IO support)

Changes in v5:
 - Move wait after link training completes
 - Minor fixes in devitree binding
 - Merge  'PCI: st: Provide support for the sti PCIe controller' and
 'MAINTAINERS: Add pci-st.c to ARCH/STI architecture' patches.

Changes in v4:
 - Remove pci: designware: remove my pci_common_init_dev() patch and
	use [PATCH v8 3/6] PCI: designware: Add ARM64 support instead.
	This patch is a good solution for me to disable IO support.
 - add __init to st_pcie_probe() and use module_init() instead
	device_initcall() to prevent the probe function from being
	deferred and to prevent module unloading.

Changes in v3:
 - Remove power management functions (was not fully tested)
 - Remove configuration space range from dt binding
 - Remove pci_common_init_dev() call in pcie-designware.c to avoid 
   default IO space declaration. 

Changes in v2:
 - comestic corrections in device tree binding
 - add pci-st.c into MAINTAINERS
 - remove st_pcie_ops structure to avoid another level of indirection
 - remove nasty busy-loop
 - remove useless test using virt_to_phys()
 - move disable io support into dw-pcie driver

I don't change the st_pcie_abort_handler() function because abort handling
is masked during boot.


This patch-set introduces a STMicroelectronics PCIe controller.
It's based on designware PCIe driver.

Gabriel Fernandez (3):
  ARM: STi: Kconfig update for PCIe support
  PCI: st: Add Device Tree bindings for sti pcie
  PCI: st: Provide support for the sti PCIe controller

 Documentation/devicetree/bindings/pci/st-pcie.txt |  56 +++
 MAINTAINERS                                       |   1 +
 arch/arm/mach-sti/Kconfig                         |   2 +
 drivers/pci/host/Kconfig                          |   9 +
 drivers/pci/host/Makefile                         |   1 +
 drivers/pci/host/pci-st.c                         | 587 ++++++++++++++++++++++
 6 files changed, 656 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/st-pcie.txt
 create mode 100644 drivers/pci/host/pci-st.c

-- 
1.9.1
