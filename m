From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jul 2012 21:03:56 -0500
Subject: [PATCH v2 00/15] PCI io.h clean-up
Message-ID: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This is the 2nd part of mach/io.h removals. This series removes io.h on
platforms with PCI by creating a fixed virtual I/O mapping and a common
__io() macro.

This version has changed a bit to accommodate Tegra converting its PCIe
host to a platform driver. Now the virtual space is only reserved during
early boot before .map_io() is called. The mapping is not created until
calling pci_ioremap_io which can be done at any point after vmalloc is
initialized.

I've gone back to fixed 64K windows for each PCI bus. This allows
removing all the i/o resource setup from the individually platforms and
placing it within the common ARM PCI code.

I've only tested versatilepb under qemu (with the model hacked up to
actually enable i/o space), so any testing is appreciated. iop3xx and
mv78xx0 have some risk of breaking as the PCI bus addresses are moved
to 0 from matching the cpu host bus addesss.

This is available from my git tree:

git://sources.calxeda.com/kernel/linux.git io-cleanup-pci

Rob

Arnd Bergmann (1):
  iop13xx: use more regular PCI I/O space handling

Rob Herring (14):
  ARM: Add fixed PCI i/o mapping
  ARM: move PCI i/o resource setup into common code
  ARM: versatile: use fixed PCI i/o mapping
  ARM: tegra: use fixed PCI i/o mapping
  ARM: integrator: use fixed PCI i/o mapping
  ARM: integrator: remove trailing whitespace on pci_v3.c
  ARM: shark: use fixed PCI i/o mapping
  ARM: footbridge: use fixed PCI i/o mapping
  ARM: dove: use fixed PCI i/o mapping
  ARM: kirkwood: use fixed PCI i/o mapping
  ARM: orion5x: use fixed PCI i/o mapping
  ARM: iop13xx: use fixed PCI i/o mapping
  ARM: mv78xx0: use fixed pci i/o mapping
  ARM: iop3xx: use fixed PCI i/o mapping

 Documentation/arm/memory.txt                       |    3 +
 arch/arm/Kconfig                                   |   13 +--
 arch/arm/include/asm/hardware/iop3xx.h             |   12 +--
 arch/arm/include/asm/io.h                          |    8 ++
 arch/arm/include/asm/mach/map.h                    |    7 ++
 arch/arm/include/asm/mach/pci.h                    |   18 ++++
 arch/arm/kernel/bios32.c                           |   42 +++++++-
 arch/arm/mach-dove/common.c                        |   10 --
 arch/arm/mach-dove/include/mach/dove.h             |    8 +-
 arch/arm/mach-dove/include/mach/io.h               |   19 ----
 arch/arm/mach-dove/pcie.c                          |   23 +---
 arch/arm/mach-footbridge/common.c                  |    8 +-
 arch/arm/mach-footbridge/dc21285.c                 |   16 +--
 .../arm/mach-footbridge/include/mach/debug-macro.S |    3 +-
 arch/arm/mach-footbridge/include/mach/io.h         |   12 +--
 arch/arm/mach-integrator/include/mach/io.h         |   33 ------
 arch/arm/mach-integrator/include/mach/platform.h   |    4 +
 arch/arm/mach-integrator/integrator_ap.c           |    7 +-
 arch/arm/mach-integrator/pci_v3.c                  |   49 ++++-----
 arch/arm/mach-iop13xx/include/mach/io.h            |   28 -----
 arch/arm/mach-iop13xx/include/mach/iop13xx.h       |   27 +----
 arch/arm/mach-iop13xx/io.c                         |   27 -----
 arch/arm/mach-iop13xx/pci.c                        |   37 +++----
 arch/arm/mach-iop13xx/setup.c                      |   10 --
 arch/arm/mach-iop32x/include/mach/io.h             |   19 ----
 arch/arm/mach-iop33x/include/mach/io.h             |   19 ----
 arch/arm/mach-kirkwood/common.c                    |   10 --
 arch/arm/mach-kirkwood/include/mach/io.h           |   24 -----
 arch/arm/mach-kirkwood/include/mach/kirkwood.h     |    8 +-
 arch/arm/mach-kirkwood/pcie.c                      |   22 +---
 arch/arm/mach-mv78xx0/addr-map.c                   |    3 +-
 arch/arm/mach-mv78xx0/common.c                     |    5 -
 arch/arm/mach-mv78xx0/include/mach/io.h            |   24 -----
 arch/arm/mach-mv78xx0/include/mach/mv78xx0.h       |   21 ++--
 arch/arm/mach-mv78xx0/pcie.c                       |  110 ++++++--------------
 arch/arm/mach-orion5x/common.c                     |   10 --
 arch/arm/mach-orion5x/include/mach/io.h            |   22 ----
 arch/arm/mach-orion5x/include/mach/orion5x.h       |   20 ++--
 arch/arm/mach-orion5x/pci.c                        |   56 ++++------
 arch/arm/mach-shark/core.c                         |   18 ----
 arch/arm/mach-shark/include/mach/debug-macro.S     |    7 +-
 arch/arm/mach-shark/include/mach/entry-macro.S     |    3 +-
 arch/arm/mach-shark/include/mach/io.h              |   18 ----
 arch/arm/mach-shark/pci.c                          |    5 +
 arch/arm/mach-tegra/include/mach/io.h              |   46 --------
 arch/arm/mach-tegra/include/mach/iomap.h           |    3 +
 arch/arm/mach-tegra/pcie.c                         |   95 ++++-------------
 arch/arm/mach-versatile/core.c                     |    5 -
 arch/arm/mach-versatile/include/mach/hardware.h    |    1 -
 arch/arm/mach-versatile/include/mach/io.h          |   27 -----
 arch/arm/mach-versatile/pci.c                      |   22 +---
 arch/arm/mm/ioremap.c                              |   14 +++
 arch/arm/mm/mmu.c                                  |   25 +++--
 arch/arm/plat-iop/pci.c                            |   25 ++---
 arch/arm/plat-iop/setup.c                          |    5 -
 55 files changed, 293 insertions(+), 823 deletions(-)
 delete mode 100644 arch/arm/mach-dove/include/mach/io.h
 delete mode 100644 arch/arm/mach-integrator/include/mach/io.h
 delete mode 100644 arch/arm/mach-iop13xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-iop32x/include/mach/io.h
 delete mode 100644 arch/arm/mach-iop33x/include/mach/io.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/io.h
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/io.h
 delete mode 100644 arch/arm/mach-orion5x/include/mach/io.h
 delete mode 100644 arch/arm/mach-shark/include/mach/io.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/io.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/io.h

-- 
1.7.9.5
