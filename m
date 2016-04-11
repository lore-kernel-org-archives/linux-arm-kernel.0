From: jchandra@broadcom.com (Jayachandran C)
Date: Tue, 12 Apr 2016 04:15:03 +0530
Subject: [PATCH v2 0/4] ACPI based PCI host driver with generic ECAM
Message-ID: <1460414707-19153-1-git-send-email-jchandra@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is v2 of the patchset for the ACPI PCI controller driver based on
the earlier discussion[1].

This patchset unifies the pci-host-generic ECAM code and the ACPI PCI
ECAM code much further so that both the implementations can use the
same structure (struct pci_config_window) as ->sysdata.

The patchset should also make it easier to share platform quirks between
DT and ACPI PCI controller drivers using struct pci_generic_ecam_ops.

Short description of the patches in the patchset:
 - fixup arm64 PCI code so that it can use the generic ACPI PCI driver.
 - implement pci/drivers/ecam.[ch] which will replace
   drivers/pci/host/pci-host-common.h API for ECAM access and will be
   shared by ACPI and DT.
 - Update users of the pci-host-common API to the ecam API
 - implement a simple PCI ACPI host. I have not used the pci_mmcfg_list
   or the region definitions from x86, but have used a much simpler
   approach here.

This should apply cleanly on top of the current 4.6 tree or the pci
next tree, and can be reviewed as a patchset. The full set of changes
for arm64 includes other fixes, that series is available at
https://github.com/jchandra-brcm/linux branch arm64-acpi-pci-v2

This has been tested on qemu with OVMF for the ACPI part and with
device tree for pci-host-generic code. Further testing and reviews
are welcome.

Thanks,
JC.

[1] https://lkml.org/lkml/2016/3/3/921

Jayachandran C (4):
  arm64: Prepare to use generic ACPI PCI implementation
  PCI: Provide common functions for ECAM mapping
  PCI: generic, thunder: update to use generic ECAM API
  ACPI: PCI: Add generic PCI host controller

 arch/arm64/Kconfig                  |   3 +
 arch/arm64/kernel/pci.c             |   7 +-
 drivers/acpi/Kconfig                |   9 ++
 drivers/acpi/Makefile               |   1 +
 drivers/acpi/pci_gen_host.c         | 258 ++++++++++++++++++++++++++++++++++++
 drivers/pci/Kconfig                 |   3 +
 drivers/pci/Makefile                |   2 +
 drivers/pci/ecam.c                  | 130 ++++++++++++++++++
 drivers/pci/ecam.h                  |  63 +++++++++
 drivers/pci/host/Kconfig            |   1 +
 drivers/pci/host/pci-host-common.c  | 121 ++++++++---------
 drivers/pci/host/pci-host-common.h  |  47 -------
 drivers/pci/host/pci-host-generic.c |  50 ++-----
 drivers/pci/host/pci-thunder-ecam.c |  37 +-----
 drivers/pci/host/pci-thunder-pem.c  |  53 +++-----
 15 files changed, 560 insertions(+), 225 deletions(-)
 create mode 100644 drivers/acpi/pci_gen_host.c
 create mode 100644 drivers/pci/ecam.c
 create mode 100644 drivers/pci/ecam.h
 delete mode 100644 drivers/pci/host/pci-host-common.h

-- 
1.9.1
