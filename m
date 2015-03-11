From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Wed, 11 Mar 2015 15:12:40 +0100
Subject: [PATCH v4 0/9] PCI: MMCONFIG clean up
Message-ID: <1426083169-8698-1-git-send-email-tomasz.nowicki@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MCFG ACPI table and PCI ECAM standard have no arch dependencies so it can be
used across all architectures. Currently MMCONFIG related code resides in
arch/x86 directories. This patch set is going to isolate non-architecture
specific code and make it accessible for all architectures.

v3 -> v4 changes:
- bug fixes after kbuild test robot report
    - add asm/io.h header for ecam.c
    - rename mmcfg -> ecam for drivers/xen/pci.c and arch/x86/pci/numachip.c
- rework Kconfig logic

v2 -> v3 changes:
- rebase patch set v2 to v4.0-rc1

v1 -> v2 changes:
- use generic readb/readw etc. accessors instead of AMD Fam10h workaround
- separate ACPI and ECAM code
- improve ECAM code naming

Tomasz Nowicki (9):
  x86, pci: Clean up comment about buggy MMIO config space access for
    AMD Fam10h CPUs.
  x86, pci: Abstract PCI config accessors and use AMD Fam10h workaround
    exclusively.
  x86, pci: Reorder logic of pci_mmconfig_insert() function
  x86, pci, acpi: Move arch-agnostic MMCONFIG (aka ECAM) and ACPI code
    out of arch/x86/ directory
  pci, acpi, mcfg: Provide generic implementation of MCFG code
    initialization.
  x86, pci: mmconfig_{32,64}.c code refactoring - remove code
    duplication.
  x86, pci, ecam: mmconfig_64.c becomes default implementation for ECAM
    driver.
  pci, acpi, mcfg: Share ACPI PCI config space accessors.
  pci, ecam: Improve naming for ecam.c content and areas where it is
    used.

 arch/x86/Kconfig               |   4 +
 arch/x86/include/asm/pci_x86.h |  34 +---
 arch/x86/pci/Makefile          |   5 +-
 arch/x86/pci/acpi.c            |   3 +-
 arch/x86/pci/mmconfig-shared.c | 346 +++++++++++----------------------------
 arch/x86/pci/mmconfig_32.c     |  47 ++----
 arch/x86/pci/mmconfig_64.c     | 153 ------------------
 arch/x86/pci/numachip.c        |  29 +---
 drivers/acpi/Makefile          |   1 +
 drivers/acpi/mcfg.c            | 121 ++++++++++++++
 drivers/pci/Kconfig            |  10 ++
 drivers/pci/Makefile           |   5 +
 drivers/pci/ecam.c             | 358 +++++++++++++++++++++++++++++++++++++++++
 drivers/xen/pci.c              |   7 +-
 include/linux/ecam.h           |  56 +++++++
 15 files changed, 679 insertions(+), 500 deletions(-)
 delete mode 100644 arch/x86/pci/mmconfig_64.c
 create mode 100644 drivers/acpi/mcfg.c
 create mode 100644 drivers/pci/ecam.c
 create mode 100644 include/linux/ecam.h

-- 
1.9.1
