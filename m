From: robherring2@gmail.com (Rob Herring)
Date: Tue, 30 Dec 2014 13:28:29 -0600
Subject: [PATCH 0/9] ARM Versatile multi-platform support
Message-ID: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

This series converts ARM Versatile platform to multi-platform. I started 
this some time ago and some pieces were already merged. The primary 
piece remaining is converting the PCI host to DT which I was waiting for 
the common PCI DT parsing to get settled. Now that that is in place as 
well as a few other pieces are in place like multi-platform fixes for 
CLCD, we can fully convert Versatile to DT and multi-platform.

There's still a few things that need DT support which can be done 
later:
- MMC card detect and write protect. Should be able to use VExpress 
  support
- Reboot support. Should be able to re-use Realview reboot code.
- flash phys-map support. Binding exists, but specifically Vpp control 
  is needed.
- CLCD support. Not sure where this is at.

This has been tested on QEMU. A previous version was tested on 
Versatile/AB by Linus Walleij. Linus reported a problem with the 
display panel detection. Investigation on h/w is needed still as I have 
not been able to identify the issue by inspection and the display 
detection seems to work correctly on QEMU.

Linus had also mentioned to me that QEMU users may have some issue with 
removing non-DT code as the work flow has to change somewhat. Copying 
Peter Maydell here for comment (and there's rumors he may have actual PB 
h/w with PCI as well).

This series is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git versatile-multiplatform

Rob

Rob Herring (9):
  dt/bindings: add versatile PCI binding
  dts: versatile: add PCI controller binding
  ARM: versatile: add DT based PCI detection
  pci: add DT based ARM Versatile PCI host driver
  dts: versatile: add sysregs nodes
  ARM: versatile: switch to DT only booting and remove legacy code
  ARM: versatile: move mach includes into mach directory
  ARM: versatile: convert to multi-platform
  ARM: versatile: consolidate code to single file

 .../devicetree/bindings/pci/versatile.txt          |  59 ++
 arch/arm/Kconfig                                   |  17 -
 arch/arm/boot/dts/versatile-ab.dts                 |  23 +
 arch/arm/boot/dts/versatile-pb.dts                 |  37 +
 arch/arm/mach-versatile/Kconfig                    |  39 +-
 arch/arm/mach-versatile/Makefile                   |   6 +-
 arch/arm/mach-versatile/Makefile.boot              |   4 -
 arch/arm/mach-versatile/core.c                     | 845 ---------------------
 arch/arm/mach-versatile/core.h                     |  46 --
 arch/arm/mach-versatile/include/mach/clkdev.h      |  16 -
 arch/arm/mach-versatile/include/mach/hardware.h    |  38 -
 arch/arm/mach-versatile/include/mach/irqs.h        | 134 ----
 arch/arm/mach-versatile/include/mach/uncompress.h  |  45 --
 arch/arm/mach-versatile/pci.c                      | 368 ---------
 .../mach-versatile/{include/mach => }/platform.h   | 179 +----
 arch/arm/mach-versatile/versatile_ab.c             |  44 --
 arch/arm/mach-versatile/versatile_dt.c             | 338 ++++++++-
 arch/arm/mach-versatile/versatile_pb.c             |  91 ---
 drivers/clk/versatile/Kconfig                      |   3 +-
 drivers/pci/host/Kconfig                           |   4 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-versatile.c                   | 305 ++++++++
 22 files changed, 784 insertions(+), 1858 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/versatile.txt
 delete mode 100644 arch/arm/mach-versatile/Makefile.boot
 delete mode 100644 arch/arm/mach-versatile/core.c
 delete mode 100644 arch/arm/mach-versatile/core.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-versatile/pci.c
 rename arch/arm/mach-versatile/{include/mach => }/platform.h (54%)
 delete mode 100644 arch/arm/mach-versatile/versatile_ab.c
 delete mode 100644 arch/arm/mach-versatile/versatile_pb.c
 create mode 100644 drivers/pci/host/pci-versatile.c

-- 
2.1.0
