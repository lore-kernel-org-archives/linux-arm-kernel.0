From: robherring2@gmail.com (Rob Herring)
Date: Fri,  6 Jul 2012 13:40:25 -0500
Subject: [PATCH 00/15] PCI io.h cleanups
Message-ID: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

I've finally gotten back to this after several months. This is the 2nd
part of mach/io.h removals. This series removes io.h on platforms with
PCI by creating a fixed virtual I/O mapping and a common __io() macro.

As several platforms have 2 1MB I/O windows, I've changed the fixed
mapping to 2MB (vs. 1MB in the prior posting) and allow platforms to
control the size. This also allows using a single 1MB section mapping
rather than 4KB pages.

I've only tested versatilepb under qemu, so any testing is appreciated.
iop3xx and mv78xx0 have some risk of breaking as the PCI bus addresses
are moved to 0 from matching the cpu host bus addesss.

Rob

Arnd Bergmann (1):
  iop13xx: use more regular PCI I/O space handling

Rob Herring (14):
  ARM: Add fixed PCI i/o mapping
  ARM: versatile: use fixed PCI i/o mapping
  ARM: tegra: use fixed PCI i/o mapping
  ARM: integrator: use fixed PCI i/o mapping
  ARM: shark: use fixed PCI i/o mapping
  ARM: footbridge: use fixed PCI i/o mapping
  ARM: dove: use fixed PCI i/o mapping
  ARM: kirkwood: use fixed PCI i/o mapping
  ARM: orion5x: use fixed PCI i/o mapping
  ARM: iop13xx: use fixed PCI i/o mapping
  ARM: mv78xx0: use fixed pci i/o mapping
  i2c: iop3xx: clean-up trailing whitespace
  i2c: iop3xx: use standard gpiolib functions
  ARM: iop3xx: use fixed PCI i/o mapping

 Documentation/arm/memory.txt                       |    3 +
 arch/arm/Kconfig                                   |   13 +--
 arch/arm/include/asm/hardware/iop3xx.h             |   12 +-
 arch/arm/include/asm/io.h                          |    5 +
 arch/arm/include/asm/mach/pci.h                    |   18 +++
 arch/arm/kernel/bios32.c                           |   20 ++++
 arch/arm/mach-dove/common.c                        |   15 +--
 arch/arm/mach-dove/include/mach/dove.h             |    2 -
 arch/arm/mach-dove/include/mach/io.h               |   19 ---
 arch/arm/mach-dove/pcie.c                          |    9 +-
 arch/arm/mach-footbridge/common.c                  |   10 +-
 .../arm/mach-footbridge/include/mach/debug-macro.S |    3 +-
 arch/arm/mach-footbridge/include/mach/io.h         |   12 +-
 arch/arm/mach-integrator/include/mach/io.h         |   33 ------
 arch/arm/mach-integrator/include/mach/platform.h   |    4 +
 arch/arm/mach-integrator/integrator_ap.c           |    9 +-
 arch/arm/mach-iop13xx/include/mach/io.h            |   28 -----
 arch/arm/mach-iop13xx/include/mach/iop13xx.h       |   14 +--
 arch/arm/mach-iop13xx/io.c                         |   27 -----
 arch/arm/mach-iop13xx/pci.c                        |   12 +-
 arch/arm/mach-iop13xx/setup.c                      |   17 ++-
 arch/arm/mach-iop32x/include/mach/io.h             |   19 ---
 arch/arm/mach-iop33x/include/mach/io.h             |   19 ---
 arch/arm/mach-kirkwood/common.c                    |   17 ++-
 arch/arm/mach-kirkwood/include/mach/io.h           |   24 ----
 arch/arm/mach-kirkwood/include/mach/kirkwood.h     |    2 -
 arch/arm/mach-mv78xx0/addr-map.c                   |    1 +
 arch/arm/mach-mv78xx0/common.c                     |   18 ++-
 arch/arm/mach-mv78xx0/include/mach/io.h            |   24 ----
 arch/arm/mach-mv78xx0/include/mach/mv78xx0.h       |   22 ++--
 arch/arm/mach-mv78xx0/pcie.c                       |   28 +----
 arch/arm/mach-orion5x/common.c                     |   16 +--
 arch/arm/mach-orion5x/include/mach/io.h            |   22 ----
 arch/arm/mach-orion5x/include/mach/orion5x.h       |   14 +--
 arch/arm/mach-shark/core.c                         |   14 +--
 arch/arm/mach-shark/include/mach/debug-macro.S     |    7 +-
 arch/arm/mach-shark/include/mach/entry-macro.S     |    3 +-
 arch/arm/mach-shark/include/mach/io.h              |   18 ---
 arch/arm/mach-tegra/include/mach/io.h              |   46 --------
 arch/arm/mach-tegra/include/mach/iomap.h           |    3 +
 arch/arm/mach-tegra/io.c                           |    2 +
 arch/arm/mach-tegra/pcie.c                         |   43 +------
 arch/arm/mach-versatile/core.c                     |    7 +-
 arch/arm/mach-versatile/include/mach/hardware.h    |    1 -
 arch/arm/mach-versatile/include/mach/io.h          |   27 -----
 arch/arm/mach-versatile/pci.c                      |    1 -
 arch/arm/plat-iop/pci.c                            |    4 +-
 arch/arm/plat-iop/setup.c                          |    7 +-
 drivers/i2c/busses/i2c-iop3xx.c                    |  121 ++++++++++----------
 49 files changed, 219 insertions(+), 596 deletions(-)
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
