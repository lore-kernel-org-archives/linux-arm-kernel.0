From: tn@semihalf.com (Tomasz Nowicki)
Date: Tue, 31 May 2016 13:19:37 +0200
Subject: [PATCH V5 0/7] Introduce ACPI world to ITS irqchip
Message-ID: <1464693584-22343-1-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patches can be found:
https://github.com/semihalf-nowicki-tomasz/linux.git (its-acpi-v5)

Since this series depends on pending ARM64 ACPI PCI support, please pull:
https://github.com/semihalf-nowicki-tomasz/linux.git (its-pci-acpi-v5)
The its-pci-acpi-v5 git branch contains submitted patches along with
the useful PCI patches from the test point of view.

Series has been tested on Cavium ThunderX server.

v4 -> v5
- rebased against v4.7-rc1
- drop generic layer and call IORT functions directly
- improve resource abstraction and string formatting

v3 -> v4
- rebased against v4.5
- add ACPI support for IRQ domain handling on a per-device basis
- reorder domain setup step
- improve error handling
- code style improvements

v2 -> v3
- rebased on top of 4.4
- fixes and improvements for redistributor init via GICC structures
- fixes as per kbuild reports

v1 -> v2
- rebased on top of 4.4-rc4
- use pci_msi_domain_get_msi_rid for requester ID to device ID translation


Tomasz Nowicki (7):
  ARM64, ACPI, PCI: I/O Remapping Table (IORT) initial support.
  acpi, pci: Setup MSI domain on a per-devices basis.
  irqchip, GICv3, ITS: Cleanup for ITS domain initialization.
  irqchip, GICv3, ITS: Refator ITS DT init code to prepare for ACPI.
  irqchip, gicv3, its: Probe ITS in the ACPI way.
  its, pci, msi: Factor out code that might be reused for ACPI.
  acpi, gicv3, its: Use MADT ITS subtable to do PCI/MSI domain
    initialization.

 drivers/acpi/Kconfig                     |   3 +
 drivers/acpi/Makefile                    |   1 +
 drivers/acpi/iort.c                      | 344 +++++++++++++++++++++++++++++++
 drivers/irqchip/Kconfig                  |   1 +
 drivers/irqchip/irq-gic-v3-its-pci-msi.c |  84 ++++++--
 drivers/irqchip/irq-gic-v3-its.c         | 184 ++++++++++++-----
 drivers/irqchip/irq-gic-v3.c             |   7 +-
 drivers/pci/msi.c                        |  11 +-
 include/linux/iort.h                     |  38 ++++
 include/linux/irqchip/arm-gic-v3.h       |   4 +-
 10 files changed, 600 insertions(+), 77 deletions(-)
 create mode 100644 drivers/acpi/iort.c
 create mode 100644 include/linux/iort.h

-- 
1.9.1
